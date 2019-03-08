using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class LeaderMeetingMissionChangeModifyDetail : BasePage
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
            get { return Request.QueryString["smid"]; }
        }

        protected string smtype
        {
            get { return Request.QueryString["smtype"]; }
        }

        protected string subtype
        {
            get { return Request.QueryString["subtype"]; }
        }

        #endregion

        #region 变量

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
        protected string reason { get; set; }
        protected string targetid { get; set; }
        protected string itemid { get; set; }


        protected int page { get; set; }
        protected bool isParentTargetItem { get; set; }

        protected string changeId { get; set; }

        private SmMainEntity smMainEntity { get; set; }
        private SmTargetItemChangeEntity smTargetItemChangeEntity { get; set; }

        /// <summary>
        /// 是否结束。
        /// </summary>
        protected bool IsJS { get; set; }

        /// <summary>
        /// 是否历史记录。
        /// </summary>
        protected bool IsHistory { get; set; }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            SetInitValue();
            SetPageInt();
            if (!IsPostBack)
            {
                LoadDetail();
            }
        }

        //设置初始值。
        private void SetInitValue()
        {
            smMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smid });
            smTargetItemChangeEntity =
                SuperviseMissionBodyBiz.GetSmTargetItemChangeEntity(new SmTargetItemChangeEntity { ChangeId = smid });
            isParentTargetItem = string.IsNullOrEmpty(smTargetItemChangeEntity.ParentTargetItemId) ? true : false;
            targetid = smTargetItemChangeEntity.TargetId;
            itemid = smTargetItemChangeEntity.ItemId;
            changeId = smTargetItemChangeEntity.ChangeId;
            IsHistory = false;
            if (smMainEntity.MissionStatus.Equals("JS"))
            {
                IsJS = true;
            }
            else
            {
                IsJS = false;
            }
        }

        //获取详情数据在页面展示
        private void LoadDetail()
        {
            //1.获取主表数据
            LoadSmMain();
            if (page == 2 && isParentTargetItem && !IsJS)
            {
                //延期措施
                LoadSmTarget(Repeater1);
                LoadSmTarget(Repeater2);
            }
            else if (page == 2 && !isParentTargetItem && !IsJS)
            {
                //延期子措施
                LoadSmTarget(Repeater15);
                LoadSmTarget(Repeater16);

            }
            else if (page == 2 && isParentTargetItem && IsJS)
            {
                //延期措施(结束)
                LoadSmTargetItemChangeHistoryList(Repeater11, null, smTargetItemChangeEntity.ChangeId, null);
                var changeId = GetChangeIdInHistory();
                if (!string.IsNullOrEmpty(changeId))
                {
                    IsHistory = true;
                    LoadSmTargetItemChangeHistoryList(Repeater12, null, changeId, null);
                }
                else
                {
                    LoadSmTarget(Repeater13);
                }
            }
            else if (page == 2 && !isParentTargetItem && IsJS)
            {
                //延期子措施（结束）
                var changeId = GetChangeIdInHistory();
                if (!string.IsNullOrEmpty(changeId))
                {
                    IsHistory = true;
                    LoadSmTarget(Repeater18);
                }
                else
                {
                    LoadSmTarget(Repeater14);
                }
                LoadSmTarget(Repeater17);
            }
            else if (page == 3 && isParentTargetItem)
            {
                //中止措施
                LoadSmTarget(Repeater3);
            }
            else if (page == 3 && !isParentTargetItem)
            {
                //中止子措施
                LoadSmTarget(Repeater4);
            }
            else if (page == 4 && isParentTargetItem)
            {
                //办结措施
                LoadSmTarget(Repeater5);
            }
            else if (page == 4 && !isParentTargetItem)
            {
                //办结子措施
                LoadSmTarget(Repeater6);
            }
            else if (page == 5 && isParentTargetItem && !IsJS)
            {
                //调整措施
                LoadSmTarget(Repeater7);//调整前
                LoadSmTargetTzh(Repeater8);//调整后
            }
            else if (page == 5 && !isParentTargetItem && !IsJS)
            {
                //调整子措施
                LoadSmTarget(Repeater9);
                LoadSmTarget(Repeater10);
            }
            else if (page == 5 && isParentTargetItem && IsJS)
            {
                //调整措施（结束）
                LoadSmTargetItemChangeHistoryList(Repeater19, null, smTargetItemChangeEntity.ChangeId, null);
                var changeId = GetChangeIdInHistory();
                if (!string.IsNullOrEmpty(changeId))
                {
                    IsHistory = true;
                    LoadSmTargetItemChangeHistoryList(Repeater20, null, changeId, null);
                }
                else
                {
                    LoadSmTarget(Repeater21);
                }
            }
            else if (page == 5 && !isParentTargetItem && IsJS)
            {
                //调整子措施（结束）
                var changeId = GetChangeIdInHistory();
                if (!string.IsNullOrEmpty(changeId))
                {
                    IsHistory = true;
                    LoadSmTarget(Repeater24);
                }
                else
                {
                    LoadSmTarget(Repeater23);
                }
                LoadSmTarget(Repeater22);
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
                            page = 2;
                            break;
                        }
                    case "ZZ":
                        {
                            //中止
                            page = 3;
                            break;
                        }
                    case "BJ":
                        {
                            //办结
                            page = 4;
                            break;
                        }
                    case "TZ":
                        {
                            //调整
                            page = 5;
                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private string GetChangeIdInHistory()
        {
            List<SmTargetItemChangeHistoryEntity> smTargetItemChangeHistoryEntityList =
                SuperviseMissionBodyBiz.GetSmTargetItemChangeHistoryEntityList(new SmTargetItemChangeHistoryEntity
                {
                    ItemId = smTargetItemChangeEntity.ItemId,
                    TargetId = smTargetItemChangeEntity.TargetId,
                    SubType = smTargetItemChangeEntity.ChangeType
                }).OrderBy(a => a.HistoryId).ToList();

            //判断集合最后一条历史记录是否是当前用户浏览的记录。
            if (!smTargetItemChangeHistoryEntityList[smTargetItemChangeHistoryEntityList.Count - 1].ChangeId
                .Equals(smTargetItemChangeEntity.ChangeId))
            {
                //获取当前历史记录的下一条。
                bool next = false;
                foreach (var entity in smTargetItemChangeHistoryEntityList)
                {
                    if (next)
                    {
                        return entity.ChangeId;
                    }

                    if (entity.ChangeId.Equals(smTargetItemChangeEntity.ChangeId))
                    {
                        next = true;
                    }
                }
            }

            return null;
        }

        private void LoadSmTargetItemChangeHistoryList(Repeater rp, string parentTargetItemId, string changeId, string itemId)
        {
            try
            {
                SmTargetItemChangeHistoryEntity codition = new SmTargetItemChangeHistoryEntity()
                {
                    ChangeId = changeId,
                    ParentTargetItemId = parentTargetItemId,
                    SubType = smTargetItemChangeEntity.ChangeType
                };
                if (!string.IsNullOrEmpty(itemId))
                {
                    codition.ItemId = itemId;
                }

                List<SmTargetItemChangeHistoryEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemChangeHistoryEntityList(codition);
                rp.DataSource = entitys;
                rp.DataBind();
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
                SmLeaderMeetingMissionEntity codition = new SmLeaderMeetingMissionEntity()
                {
                    LmmId = smTargetItemChangeEntity.TargetId
                };
                List<SmLeaderMeetingMissionEntity> entitys = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(codition);
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
                SmTargetItemChangeEntity codition = new SmTargetItemChangeEntity()
                {
                    ChangeId = smid
                };
                List<SmTargetItemChangeEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntityList(codition);
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
                    SmId = smTargetItemChangeEntity.SourceSmId,
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

                SmTargetItemChangeEntity itmeChange = new SmTargetItemChangeEntity()
                {
                    ChangeId = smid
                };
                SmTargetItemChangeEntity itemChangeEntity = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntity(itmeChange);
                reason = itemChangeEntity.Reason;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #region 中止措施
        protected void Repeater3_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater3_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ItemId = smTargetItemChangeEntity.ParentTargetItemId,
                    ParentTargetItemId = null
                };
                LoadSmTargetItem(condition, rep);
            }
        }
        protected void Repeater3_1_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater3_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ParentTargetItemId = entity.ItemId
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        #endregion

        #region 中止子措施

        protected void Repeater4_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater4_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ItemId = smTargetItemChangeEntity.ParentTargetItemId
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater4_1_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater4_1_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ItemId = smTargetItemChangeEntity.ItemId,
                    ParentTargetItemId = smTargetItemChangeEntity.ParentTargetItemId
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        #endregion

        #region 延期措施
        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater1_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ItemId = smTargetItemChangeEntity.ItemId,
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
                    ItemId = smTargetItemChangeEntity.ItemId,
                    ActivityFlag = 1,
                    ParentTargetItemId = null,
                };
                GetYQParentTargetItemChange(condition, rep);
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

        protected void Repeater11_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater11_1") as Repeater;
                SmTargetItemChangeHistoryEntity entity = e.Item.DataItem as SmTargetItemChangeHistoryEntity;
                LoadSmTargetItemChangeHistoryList(rep, entity.ItemId, smTargetItemChangeEntity.ChangeId, null);
            }
        }

        protected void Repeater19_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater19_1") as Repeater;
                SmTargetItemChangeHistoryEntity entity = e.Item.DataItem as SmTargetItemChangeHistoryEntity;
                LoadSmTargetItemChangeHistoryList(rep, entity.ItemId, smTargetItemChangeEntity.ChangeId, null);
            }
        }

        //延期子措施
        protected void Repeater15_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater15_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ItemId = smTargetItemChangeEntity.ParentTargetItemId,
                    ActivityFlag = 1,
                    ParentTargetItemId = null
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater15_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater15_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ItemId = smTargetItemChangeEntity.ItemId,
                    ParentTargetItemId = smTargetItemChangeEntity.ParentTargetItemId
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater16_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater16_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    ItemId = smTargetItemChangeEntity.ItemId
                };
                LoadYQSonSmTargetItemsBySon(condition, rep);
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

        protected void Repeater18_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater18_1_1") as Repeater;
                var changeId = GetChangeIdInHistory();
                LoadSmTargetItemChangeHistoryList(rep, smTargetItemChangeEntity.ParentTargetItemId, changeId, smTargetItemChangeEntity.ItemId);
            }
        }

        protected void Repeater17_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater17_1_1") as Repeater;
                LoadSmTargetItemChangeHistoryList(rep, smTargetItemChangeEntity.ParentTargetItemId, smTargetItemChangeEntity.ChangeId, smTargetItemChangeEntity.ItemId);
            }
        }

        #endregion


        /// <summary>
        /// 获取延期父措施的变更值。
        /// </summary>
        /// <param name="entitys">父措施集合。</param>
        /// <returns>设置完变更集的列表。</returns>
        private void GetYQParentTargetItemChange(SmTargetItemEntity condition, Repeater rp)
        {
            List<SmTargetItemEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);

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
            rp.DataSource = entitys;
            rp.DataBind();
        }

        private void LoadYQSonSmTargetItemsByParent(SmTargetItemEntity condition, Repeater rep)
        {
            List<SmTargetItemEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
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
            rep.DataSource = entitys;
            rep.DataBind();
        }

        #region 措施调整
        protected void Repeater8_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater8_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ItemId = smTargetItemChangeEntity.ItemId,
                    ParentTargetItemId = null
                };
                LoadTZParentSmTargetItemTzh(condition, rep);
            }
        }

        protected void Repeater8_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater8_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1
                };
                LoadTZParentSmTargetItemTzhzcc(condition, rep);
            }
        }
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
                    ItemId = smTargetItemChangeEntity.ItemId
                };
                LoadTZSonSmTargetItemsBySon(condition, rep);
            }
        }

        #endregion

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

        //调整后子措施
        private void LoadTZParentSmTargetItemTzhzcc(SmTargetItemEntity condition, Repeater rp)
        {
            try
            {
                List<SmTargetItemEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
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
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        //调整后措施
        private void LoadTZParentSmTargetItemTzh(SmTargetItemEntity condition, Repeater rp)
        {
            try
            {
                List<SmTargetItemEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
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
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //调整后目标
        private void LoadSmTargetTzh(Repeater rp)
        {
            try
            {
                SmLeaderMeetingMissionEntity codition = new SmLeaderMeetingMissionEntity()
                {
                    LmmId = smTargetItemChangeEntity.TargetId
                };
                List<SmLeaderMeetingMissionEntity> entitys = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(codition);

                if (!string.IsNullOrEmpty(smTargetItemChangeEntity.MainDeptId))
                {
                    entitys[0].DeptId = smTargetItemChangeEntity.MainDeptId;
                }

                if (!string.IsNullOrEmpty(smTargetItemChangeEntity.MainDeptName))
                {
                    entitys[0].DeptName = smTargetItemChangeEntity.MainDeptName;
                }
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
                var entitys = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadSmTargetItemChange(SmTargetItemChangeEntity condition, Repeater rp)
        {
            try
            {
                var entitys = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntityList(condition);
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
    }
}