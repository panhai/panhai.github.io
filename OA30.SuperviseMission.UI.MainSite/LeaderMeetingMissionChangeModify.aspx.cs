using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class LeaderMeetingMissionChangeModify : BasePage
    {
        protected override void OnPreInit(EventArgs e)
        {
            //判断是否收到CSRF攻击
            if (this.IsPostBack && OA30.Common.Security.CSRFTools.IsAttackByCSRF(this.Request.UrlReferrer, this.Request.Url))
            {
                throw new OA30.Common.Exception.UIExceptions.IsCSRFException(OA30.Common.Exception.UIExceptions.UIExceptionDescriptionCollection.CSRF);
            }

            base.OnPreInit(e);
        }

        #region 应用层的实例

        private AppRCObjectActivatorV2 _objActivator = new AppRCObjectActivatorV2();

        private ISuperviseMissionBody _SuperviseMissionBodyBiz;
        private ISuperviseMissionBody SuperviseMissionBodyBiz
        {
            get
            {
                if (_SuperviseMissionBodyBiz == null)
                {
                    _SuperviseMissionBodyBiz = _objActivator.CreateObject<ISuperviseMissionBody>();
                }
                return _SuperviseMissionBodyBiz;
            }
        }

        #endregion

        #region URL变量
        protected string smid
        {
            get
            {
                return Request.QueryString["smid"];
            }
        }

        protected string targetid
        {
            get
            {
                return Request.QueryString["targetid"];
            }
        }

        protected string itemid
        {
            get
            {
                return Request.QueryString["itemid"];
            }
        }

        protected string parentTargetItemId
        {
            get
            {
                var parentTargetItemId = Request.QueryString["parentTargetItemId"];
                return parentTargetItemId == "" ? null : parentTargetItemId;
            }
        }

        protected string subtype { get; set; }
        #endregion

        public int page
        {
            get
            {
                return int.Parse(Request.QueryString["page"]);
            }
        }

        /// <summary>
        /// 格式化日期时间格式。
        /// </summary>
        /// <param name="dt">日期时间实例。</param>
        /// <returns>返回格式化yyyy-MM-dd的字符串形式。</returns>
        public string FormatDateTime(string dt)
        {
            if (String.IsNullOrEmpty(dt)) return "";
            return Convert.ToDateTime(dt).ToString("yyyy-MM-dd");
        }

        public bool isParentTargetItem { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            SmTargetItemEntity condition = new SmTargetItemEntity()
            {
                ItemId = itemid,
                ParentTargetItemId = parentTargetItemId == "" ? null : parentTargetItemId
            };
            SmTargetItemEntity smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(condition);
            SmMainEntity smMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity
            {
                SmId = smTargetItemEntity.SmId
            });
            SmFlowWaitingEntity smFlowWaitingEntity =
                SuperviseMissionBodyBiz.GetSmFlowWaitingEntity(new SmFlowWaitingEntity { SmId = smTargetItemEntity.SmId });
            if (!smTargetItemEntity.Status.Equals("0"))
            {
                Response.Write("<script language='javascript'>alert(\"本措施已经提交了变更申请，请勿重复操作\");</script>");
                Response.Write("<script language=javascript>history.go(-1);</script>");
            }
            else if (smMainEntity.MissionStatus == "JS")
            {
                Response.Write("<script language='javascript'>alert(\"原单流程以结束，该措施无法进行变更申请。\");</script>");
                Response.Write("<script language=javascript>history.go(-1);</script>");
            }
            //只有在步骤在办公厅目标确认之后（不包含办公厅目标确认）或者任务状态为任务推进中之后，才允许进行变更申请
            else if (smMainEntity.MissionStatus != "TJ" && smMainEntity.MissionStatus != "BJ")
            {
                if (smFlowWaitingEntity.StepId == "BGTMBQR"
                    || smFlowWaitingEntity.StepId == "GDLSP"
                    || smFlowWaitingEntity.StepId == "ZBDWMBFJ")
                {
                    Response.Write("<script language='javascript'>alert(\"该措施没有权限进行变更申请。\");</script>");
                    Response.Write("<script language=javascript>history.go(-1);</script>");
                }
            }
            else if (string.IsNullOrEmpty(parentTargetItemId))
            {
                //检查措施下面是否存在其他子措施的变更
                if (ExistChangeTargetItem(itemid))
                {
                    Response.Write("<script language='javascript'>alert(\"该措施下面的子措施正在进行调整/延期变更，无法对该措施进行办结/中止操作\");</script>");
                    Response.Write("<script language=javascript>history.go(-1);</script>");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        LoadDelayModifyEnd();
                    }
                }
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadDelayModifyEnd();
                }
            }
        }

        private bool ExistChangeTargetItem(string parentTargetItemId)
        {
            var sonTargetItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(new SmTargetItemEntity
            {
                ParentTargetItemId = parentTargetItemId
            });

            return sonTargetItemList.Exists(n => n.Status.Equals("1") || n.Status.Equals("3"));
        }

        private void LoadDelayModifyEnd()
        {
            //1.获取主表详情
            LoadSmMain();
            //2.设置isParentTargetItem，true为措施，false为子措施
            setIsParentTargetItem();

            //延期措施
            if (page == 2 && isParentTargetItem)
            {
                subtype = "YQ";
                LoadSmTarget(Repeater3);
            }

            //延期子措施
            if (page == 2 && !isParentTargetItem)
            {
                subtype = "YQ";
                LoadSmTarget(Repeater2);
            }

            //中止措施
            if (page == 3 && isParentTargetItem)
            {
                subtype = "ZZ";
                LoadSmTarget(Repeater4);
            }

            //中止子措施
            if (page == 3 && !isParentTargetItem)
            {
                subtype = "ZZ";
                LoadSmTarget(Repeater1);
            }

            //办结措施
            if (page == 4 && isParentTargetItem)
            {
                subtype = "BJ";
                LoadSmTarget(Repeater5);
            }

            //办结子措施
            if (page == 4 && !isParentTargetItem)
            {
                subtype = "BJ";
                LoadSmTarget(Repeater6);
            }

            //调整措施
            if (page == 5 && isParentTargetItem)
            {
                subtype = "TZ";
                LoadSmTarget(Repeater8);
            }

            //调整子措施
            if (page == 5 && !isParentTargetItem)
            {
                subtype = "TZ";
                LoadSmTarget(Repeater7);
            }
        }

        private void LoadSmTarget(Repeater rp)
        {
            try
            {
                SmLeaderMeetingMissionEntity condition = new SmLeaderMeetingMissionEntity()
                {
                    LmmId = targetid,
                    ActivityFlag = 1
                };
                List<SmLeaderMeetingMissionEntity> entitys = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(condition);
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void setIsParentTargetItem()
        {
            SmTargetItemEntity condition = new SmTargetItemEntity()
            {
                ItemId = itemid,
                ParentTargetItemId = parentTargetItemId
            };

            SmTargetItemEntity smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(condition);
            if (string.IsNullOrEmpty(smTargetItemEntity.ParentTargetItemId))
            {
                isParentTargetItem = true;
            }
            else
            {
                isParentTargetItem = false;
            }
        }

        #region 延期

        protected void Repeater3_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater3_3") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ItemId = itemid,
                    ParentTargetItemId = null
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater3_3_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater3_3_3") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ParentTargetItemId = entity.ItemId
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater2_2") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity smTargetItemParentEntity = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ItemId = parentTargetItemId,
                    ParentTargetItemId = null
                };
                LoadSmTargetItem(smTargetItemParentEntity, rep);
            }
        }

        protected void Repeater2_2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater2_2_2") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    ItemId = itemid,
                    ParentTargetItemId = parentTargetItemId,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        #endregion

        private void LoadSmTargetItem(SmTargetItemEntity condition, Repeater rp)
        {
            try
            {
                List<SmTargetItemEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadSmMain()
        {
            try
            {
                SmMainEntity condition = new SmMainEntity()
                {
                    SmId = smid,
                    ActivityFlag = 1
                };
                SmMainEntity entity = SuperviseMissionBodyBiz.GetSmMainEntity(condition);
                LbSpNum.Text = string.Format("{0}【{1}】{2}号", entity.SpNumberName, entity.SpNumberYear, entity.SpNumberCode);
                LbSmId.Text = entity.SmId;
                LbTaskContent.Text = entity.TaskContent;
                LbMainDept.Text = entity.MainDeptName;
                LbAssDept.Text = entity.AssistDeptName;
                LabelStartTime.Text = entity.StartTime.ToString();
                LabelFinishTime.Text = entity.DeadLineTime.ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private string FomatKeyValueString(string spName, string spId)
        {
            try
            {
                if (string.IsNullOrEmpty(spName) || string.IsNullOrEmpty(spId))
                    return "";
                string[] names = spName.Split(';');
                string[] ids = spId.Split(';');
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < ids.Length; i++)
                {
                    string str = string.Format("{0}（{1}）；", names[i], ids[i]);
                    sb.Append(str);
                }
                return sb.ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}