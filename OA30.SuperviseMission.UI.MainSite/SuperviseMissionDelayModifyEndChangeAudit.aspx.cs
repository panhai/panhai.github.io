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
    public partial class SuperviseMissionDelayModifyEndDetail : BasePage
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

        private ISuperviseMissionWorkFlow _SuperviseMissionWorkFlow;
        private ISuperviseMissionWorkFlow SuperviseMissionWorkFlow
        {
            get
            {
                if (_SuperviseMissionWorkFlow == null)
                {
                    _SuperviseMissionWorkFlow = _objActivator.CreateObject<ISuperviseMissionWorkFlow>();
                }
                return _SuperviseMissionWorkFlow;
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
        protected string flowid
        {
            get
            {
                return Request.QueryString["flowid"];
            }
        }
        protected string smtype
        {
            get
            {
                return Request.QueryString["smtype"];
            }
        }
        protected string stepid
        {
            get
            {
                return Request.QueryString["stepid"];
            }
        }
        protected string subtype
        {
            get
            {
                return Request.QueryString["subtype"];
            }
        }

        protected string reason
        {
            get; set;
        }

        protected string changeId { get; set; }

        private string sourceid { get; set; }
        protected string targetid { get; set; }
        protected string itemid { get; set; }
        private string parenttargetitemid { get; set; }
        #endregion
        #region 变量
        public int page { get; set; }

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

        protected bool isParentTargetItem { get; set; }
        private SmTargetItemChangeEntity smTargetItemChangeEntity { get; set; }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            SetPageInt();
            if (!IsPostBack)
            {
                LoadDetail();
            }
        }

        protected string EncodeSpecialCode(string html)
        {
            return OA30.Common.Security.XSSDetectTool.EncodeSpecialCode(html);
        }

        private void LoadDetail()
        {
            SetDefaultValue();
            LoadSmMain();
        }

        private void SetDefaultValue()
        {
            SmTargetItemChangeEntity changeCondition = new SmTargetItemChangeEntity
            {
                ChangeId = smid
            };
            SmTargetItemChangeEntity changeEntity = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntity(changeCondition);
            sourceid = changeEntity.SourceSmId;
            targetid = changeEntity.TargetId;
            itemid = changeEntity.ItemId;
            parenttargetitemid = changeEntity.ParentTargetItemId;
            reason = changeEntity.Reason;
            changeId = changeEntity.ChangeId;
            smTargetItemChangeEntity = changeEntity;
            if (string.IsNullOrEmpty(parenttargetitemid))
            {
                isParentTargetItem = true;
            }
            else
            {
                isParentTargetItem = false;
            }

            SetPageValue();
        }

        private void SetPageValue()
        {
            if (page == 2 && isParentTargetItem)
            {
                //延期措施
                LoadSmTarget(Repeater1);
                LoadSmTarget(Repeater2);
            }
            else if (page == 2 && !isParentTargetItem)
            {
                //延期子措施
                LoadSmTarget(Repeater3);
                LoadSmTarget(Repeater4);
            }
            else if (page == 3 && isParentTargetItem)
            {
                //中止措施
                LoadSmTarget(Repeater5);
            }
            else if (page == 3 && !isParentTargetItem)
            {
                //中止子措施
                LoadSmTarget(Repeater6);
            }
            else if (page == 4 && isParentTargetItem)
            {
                //办结措施
                LoadSmTarget(Repeater7);
            }
            else if (page == 4 && !isParentTargetItem)
            {
                //办结子措施
                LoadSmTarget(Repeater8);
            }
            else if (page == 5 && isParentTargetItem)
            {
                //调整措施
                LoadSmTarget(Repeater9);
                LoadTZSmTarget(Repeater10);
            }
            else if (page == 5 && !isParentTargetItem)
            {
                //调整子措施
                LoadSmTarget(Repeater11);
                LoadSmTarget(Repeater12);
            }
        }

        private void LoadSmMain()
        {
            try
            {
                SmMainEntity condition = new SmMainEntity()
                {
                    SmId = sourceid,
                    ActivityFlag = 1
                };
                SmMainEntity entity = SuperviseMissionBodyBiz.GetSmMainEntity(condition);
                LbSpNum.Text = string.Format("{0}【{1}】{2}号", entity.SpNumberName, entity.SpNumberYear, entity.SpNumberCode);
                LbSmId.Text = entity.SmId;
                LbTaskContent.Text = entity.TaskContent;
                LbMainLeader.Text = FomatKeyValueString(entity.MainLeaderName, entity.MainLeaderId);
                LbAssLeader.Text = FomatKeyValueString(entity.AssistLeaderName, entity.AssistLeaderId);
                LbMainDept.Text = entity.MainDeptName;
                LbAssDept.Text = entity.AssistDeptName;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadSmTarget(Repeater rp)
        {
            try
            {

                SmTargetEntity condition = new SmTargetEntity()
                {
                    TargetId = targetid,
                    ActivityFlag = 1
                };
                List<SmTargetEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetEntityList(condition);
                rp.DataSource = entitys;
                rp.DataBind();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

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


        private void LoadSmTargetItemChange(Repeater rp)
        {
            try
            {

                SmTargetItemChangeEntity condition = new SmTargetItemChangeEntity()
                {
                    ChangeId = smid
                };
                List<SmTargetItemChangeEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntityList(condition);
                rp.DataSource = entitys;
                rp.DataBind();

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

        private void SetPageInt()
        {
            try
            {
                switch (subtype)
                {
                    case "YQ":
                        {
                            //延期
                            page = 2; break;
                        }
                    case "ZZ":
                        {
                            //中止
                            page = 3; break;
                        }
                    case "BJ":
                        {
                            //办结
                            page = 4; break;
                        }
                    case "TZ":
                        {
                            //调整
                            page = 5; break;
                        }
                    default:
                        {
                            //测试的时候使用  //生产的时候 注释掉 不然有安全问题
                            page = int.Parse(Request.QueryString["page"]);
                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private int _IndexForTarget = 0;
        /// <summary>
        /// 年度目标的序列号
        /// </summary>
        /// <returns></returns>
        protected string GetIndexForTarget()
        {
            _IndexForTarget++;
            return _IndexForTarget.ToString();
        }

        /// <summary>
        /// 当前措施的年度目标ID
        /// </summary>
        private string _CurrentTargetId = "";
        private int _IndexForTargetItem = 0;
        /// <summary>
        /// 措施的序列号
        /// </summary>
        /// <returns></returns>
        protected string GetIndexForTargetItem(string TargetId)
        {
            if (string.IsNullOrEmpty(_CurrentTargetId))
            {
                _CurrentTargetId = TargetId;

            }
            else if (TargetId != _CurrentTargetId)
            {
                //新的年度下的措施重新计算序列号
                _CurrentTargetId = TargetId;
                _IndexForTargetItem = 0;
            }

            _IndexForTargetItem++;
            return _IndexForTargetItem.ToString();
        }


        #region 调整措施数据绑定

        private void LoadTZSmTarget(Repeater rp)
        {
            try
            {
                SmTargetEntity condition = new SmTargetEntity()
                {
                    TargetId = targetid,
                    ActivityFlag = 1
                };
                List<SmTargetEntity> entitys = GetTZParentTargetChangeValue(SuperviseMissionBodyBiz.GetSmTargetEntityList(condition));
                rp.DataSource = entitys;
                rp.DataBind();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void Repeater10_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater10_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1
                };
                LoadTZSonSmTargetItemsByParent(condition, rep);
            }
        }

        protected void Repeater10_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater10_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ItemId = itemid,
                    ActivityFlag = 1,
                    ParentTargetItemId = null,
                };
                LoadTZParentSmTargetItem(condition, rep);
            }
        }

        private void LoadTZSonSmTargetItemsByParent(SmTargetItemEntity condition, Repeater rp)
        {
            try
            {
                List<SmTargetItemEntity> entitys = GetTZSonTargetItemChangeValue(SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition));
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private List<SmTargetItemEntity> GetTZSonTargetItemChangeValue(List<SmTargetItemEntity> entitys)
        {
            if (entitys != null && entitys.Count > 0)
            {
                foreach (var entity in entitys)
                {
                    var sonSmTargetItemChangeEntity = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntity(new SmTargetItemChangeEntity
                    {
                        ItemId = entity.ItemId,
                        ParentTargetItemId = entity.ParentTargetItemId,
                        Status = "0"
                    });

                    //如果有这条变更，并且这条变更存在于待办(如果变更存在于待办中，证明此变更是自己另外有一份变更申请的，所以这里需要判断)。
                    if (sonSmTargetItemChangeEntity != null && !SuperviseMissionBodyBiz.ExistSmFlowWaitingEntity(sonSmTargetItemChangeEntity.ChangeId))
                    {
                        if (!string.IsNullOrEmpty(sonSmTargetItemChangeEntity.ItemName))
                        {
                            entity.ItemName = sonSmTargetItemChangeEntity.ItemName;
                        }

                        if (!string.IsNullOrEmpty(sonSmTargetItemChangeEntity.AssistDeptId))
                        {
                            entity.AssistDeptId = sonSmTargetItemChangeEntity.AssistDeptId;
                        }

                        if (!string.IsNullOrEmpty(sonSmTargetItemChangeEntity.AssistDeptName))
                        {
                            entity.AssistDeptName = sonSmTargetItemChangeEntity.AssistDeptName;
                        }

                        if (!string.IsNullOrEmpty(sonSmTargetItemChangeEntity.ExcutorId))
                        {
                            entity.ExcutorId = sonSmTargetItemChangeEntity.ExcutorId;
                        }

                        if (!string.IsNullOrEmpty(sonSmTargetItemChangeEntity.ExcutorName))
                        {
                            entity.ExcutorName = sonSmTargetItemChangeEntity.ExcutorName;
                        }
                    }
                }
            }

            return entitys;
        }

        private void LoadTZParentSmTargetItem(SmTargetItemEntity condition, Repeater rp)
        {
            try
            {
                List<SmTargetItemEntity> entitys = GetTZParentTargetItemChangeValue(SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition));
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private List<SmTargetEntity> GetTZParentTargetChangeValue(List<SmTargetEntity> entitys)
        {
            if (!string.IsNullOrEmpty(smTargetItemChangeEntity.TargetName))
            {
                entitys[0].TargetName = smTargetItemChangeEntity.TargetName;
            }

            if (!string.IsNullOrEmpty(smTargetItemChangeEntity.MainDeptId))
            {
                entitys[0].MainDeptId = smTargetItemChangeEntity.MainDeptId;
            }

            if (!string.IsNullOrEmpty(smTargetItemChangeEntity.MainDeptName))
            {
                entitys[0].MainDeptName = smTargetItemChangeEntity.MainDeptName;
            }

            return entitys;
        }

        private List<SmTargetItemEntity> GetTZParentTargetItemChangeValue(List<SmTargetItemEntity> entitys)
        {
            if (!string.IsNullOrEmpty(smTargetItemChangeEntity.AssistDeptId))
            {
                entitys[0].AssistDeptId = smTargetItemChangeEntity.AssistDeptId;
            }

            if (!string.IsNullOrEmpty(smTargetItemChangeEntity.AssistDeptName))
            {
                entitys[0].AssistDeptName = smTargetItemChangeEntity.AssistDeptName;
            }

            if (!string.IsNullOrEmpty(smTargetItemChangeEntity.DutyDeptId))
            {
                entitys[0].DutyDeptId = smTargetItemChangeEntity.DutyDeptId;
            }

            if (!string.IsNullOrEmpty(smTargetItemChangeEntity.DutyDeptName))
            {
                entitys[0].DutyDeptName = smTargetItemChangeEntity.DutyDeptName;
            }

            if (!string.IsNullOrEmpty(smTargetItemChangeEntity.ItemName))
            {
                entitys[0].ItemName = smTargetItemChangeEntity.ItemName;
            }

            return entitys;
        }

        #endregion

        #region 调整子措施数据绑定

        protected void Repeater12_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater12_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    ItemId = itemid
                };
                LoadTZSonSmTargetItemsBySon(condition, rep);
            }
        }

        private void LoadTZSonSmTargetItemsBySon(SmTargetItemEntity condition, Repeater rp)
        {
            try
            {
                List<SmTargetItemEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
                if (!string.IsNullOrEmpty(smTargetItemChangeEntity.AssistDeptId) && !string.IsNullOrEmpty(smTargetItemChangeEntity.AssistDeptName))
                {
                    entitys[0].AssistDeptName = smTargetItemChangeEntity.AssistDeptName;
                    entitys[0].AssistDeptId = smTargetItemChangeEntity.AssistDeptId;
                }

                if (!string.IsNullOrEmpty(smTargetItemChangeEntity.ItemName))
                {
                    entitys[0].ItemName = smTargetItemChangeEntity.ItemName;
                }

                if (!string.IsNullOrEmpty(smTargetItemChangeEntity.ExcutorId) && !string.IsNullOrEmpty(smTargetItemChangeEntity.ExcutorName))
                {
                    entitys[0].ExcutorId = smTargetItemChangeEntity.ExcutorId;
                    entitys[0].ExcutorName = smTargetItemChangeEntity.ExcutorName;
                }

                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region 延期措施数据绑定

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater1_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ItemId = itemid,
                    ActivityFlag = 1,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater1_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater1_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater2_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ItemId = itemid,
                    ActivityFlag = 1,
                    ParentTargetItemId = null,
                };
                LoadYQParentSmTargetItem(condition, rep);
            }
        }

        protected void Repeater2_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater2_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1
                };
                LoadYQSonSmTargetItemsByParent(condition, rep);
            }
        }

        private void LoadYQParentSmTargetItem(SmTargetItemEntity condition, Repeater rp)
        {
            try
            {
                List<SmTargetItemEntity> entitys = GetYQParentTargetItemChangeValue(SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition));
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadYQSonSmTargetItemsByParent(SmTargetItemEntity condition, Repeater rp)
        {
            try
            {
                List<SmTargetItemEntity> entitys = GetYQSonTargetItemChangeValue(SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition));
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadYQSonSmTargetItemsBySon(SmTargetItemEntity condition, Repeater rp)
        {
            try
            {
                List<SmTargetItemEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
                entitys[0].DeadLineTime = smTargetItemChangeEntity.LateTime;
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 获取延期父措施的变更值。
        /// </summary>
        /// <param name="entitys">父措施集合。</param>
        /// <returns>设置完变更集的列表。</returns>
        private List<SmTargetItemEntity> GetYQParentTargetItemChangeValue(List<SmTargetItemEntity> entitys)
        {
            if (entitys != null && entitys.Count > 0)
            {
                foreach (var entity in entitys)
                {
                    var newDeadLineTime =
                        SuperviseMissionBodyBiz.GetSmTargetItemChangeEntity(new SmTargetItemChangeEntity
                        {
                            ChangeId = smid
                        }).LateTime;
                    entity.DeadLineTime = newDeadLineTime;
                }
            }

            return entitys;
        }

        private List<SmTargetItemEntity> GetYQSonTargetItemChangeValue(List<SmTargetItemEntity> entitys)
        {
            if (entitys != null && entitys.Count > 0)
            {
                foreach (var entity in entitys)
                {
                    var sonSmTargetItemChangeEntity = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntity(new SmTargetItemChangeEntity
                    {
                        ItemId = entity.ItemId,
                        ParentTargetItemId = entity.ParentTargetItemId,
                        Status = "0"
                    });

                    //如果有这条变更，并且这条变更存在于待办(如果变更存在于待办中，证明此变更是自己另外有一份变更申请的，所以这里需要判断)。
                    if (sonSmTargetItemChangeEntity != null && !SuperviseMissionBodyBiz.ExistSmFlowWaitingEntity(sonSmTargetItemChangeEntity.ChangeId) && sonSmTargetItemChangeEntity.LateTime != null)
                    {
                        entity.DeadLineTime = sonSmTargetItemChangeEntity.LateTime;
                    }
                }
            }

            return entitys;
        }

        #endregion

        #region 延期子措施数据绑定

        protected void Repeater3_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater3_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ItemId = parenttargetitemid,
                    ActivityFlag = 1,
                    ParentTargetItemId = null
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater3_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater3_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ItemId = itemid,
                    ParentTargetItemId = parenttargetitemid
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater4_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater4_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    ItemId = itemid
                };
                LoadYQSonSmTargetItemsBySon(condition, rep);
            }
        }

        #endregion

    }
}