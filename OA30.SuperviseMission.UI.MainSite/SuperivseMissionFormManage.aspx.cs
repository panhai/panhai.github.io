using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.Common.Entity.MissionBase;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class SuperivseMissionFormManage : BasePage
    {
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
        private int[] _postfixOfTargetAndItems = { 0, 0, 0 };
        private string _smId = string.Empty;
        public List<SmFlowItemBaseEntity> smFlowItemBaseEntitys = new List<SmFlowItemBaseEntity>() { };
        public List<SmFlowFinishAndWaitingEntity> smFlowFinishAndWaitingEntityList = new List<SmFlowFinishAndWaitingEntity>();
        public List<SmBasicDataOpinionTypeEntity> smBasicDataOpinionTypeEntitys = new List<SmBasicDataOpinionTypeEntity>() { };
        private int _dataIndex;
        protected int DataIndex
        {
            get
            {
                _dataIndex += 1;
                return _dataIndex;
            }
        }

        public object SMBasicDataBiz { get; private set; }

        #region 主表公开属性。
        protected String SmId = "";
        protected String SpNumberDeptId = "";// 督查编号的DeptId。
        protected String SpNumberName = "";  // 督查编号。
        protected String SpNumberYear = "";  // 督查年号。
        protected String SpNumberCode = "";  // 督查流水号。
        protected String TaskContent = "";
        protected String MainLeader = "";
        protected String AssLeader = "";

        protected String MainLeaderIds = "";      // 主管领导员工号(用分号隔开,下同)。
        protected String MainLeaderNames = "";    // 主管领导员工姓名。

        protected String AssLeaderIds = "";       // 协管领导员工号。
        protected String AssLeaderNames = "";     // 协管领导员工姓名。

        protected String MainDeptIds = "";        // 任务的主办单位部门Id。
        protected String MainDeptNames = "";      // 任务的主办单位部门名称。

        protected String AssistDeptIds = "";      // 任务的协办单位部门Id。
        protected String AssistDeptNames = "";    // 任务的协办单位部门名称。
        protected DateTime? StartTime;

        public FormType _formType;
        /// <summary>
        /// 表单类型。
        /// </summary>
        public FormType FormType
        {
            get
            {
                FormType formType = _formType;
                return ((0 != formType) ? formType : FormType.Ld);
            }
            set
            {
                if (_formType != value)
                {
                    switch (value)
                    {
                        case FormType.Ld:
                        case FormType.Nd:
                            _formType = value;
                            break;
                        default:
                            throw new NotSupportedException(value.ToString());
                    }
                }
            }
        }
        #endregion

        #region 页面辅助变量。
        protected bool HaveResult = false;     // 有数据时显示面板。
        protected bool NotHaveResult = false;  // 没有数据时隐藏面板。
        protected bool IsNdType =false;        // 表单是年度时显示tab1。
        protected bool IsLdType =false;        // 表单是领导时显示tab5。
        #endregion

        protected override void OnPreInit(EventArgs e)
        {
            //判断是否收到CSRF攻击
            if (this.IsPostBack && OA30.Common.Security.CSRFTools.IsAttackByCSRF(this.Request.UrlReferrer, this.Request.Url))
            {
                throw new OA30.Common.Exception.UIExceptions.IsCSRFException(OA30.Common.Exception.UIExceptions.UIExceptionDescriptionCollection.CSRF);
            }

            base.OnPreInit(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            _smId = txtSMID.Value.Trim();
            if (!String.IsNullOrEmpty(_smId))
            {
                SetFormType(_smId);
                _dataIndex = 1;// 初始值为1是因为主任务已使用了1(即详情那里是data-index=1)。
                LoadSmMain();
                switch (FormType)// 根据表单类型来显示或隐藏年度或领导的tab。
                {
                    case FormType.Nd:
                        IsNdType = true;
                        IsLdType = false;
                        LoadSmTarget(rptTarget);
                        break;
                    case FormType.Ld:
                        IsLdType = true;
                        IsNdType = false;
                        LoadLdTarget(rptLdTarget);
                        break;
                    default:
                        break;
                }
                
                LoadSmModifyInfo();
                LoadSmFlowFinishAndWaiting();
                LoadSmDataOpinionTypeEntity();
                litResult.Text = AttachmentHtmlGenerator(_smId);
            }
        }

        /// <summary>
        /// 设置指定smid的类型。
        /// </summary>
        /// <param name="smId"></param>
        private void SetFormType(string smId)
        {
            if (String.IsNullOrEmpty(smId)) return;
            var mainBean=SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId, ActivityFlag = 1 });
            if (mainBean == null|| String.IsNullOrEmpty(mainBean.SmType)) return;
            if (mainBean.SmType.Trim().ToLower().Equals("ld")) FormType = FormType.Ld;
            if (mainBean.SmType.Trim().ToLower().Equals("nd")) FormType = FormType.Nd;
        }
        private void LoadSmDataOpinionTypeEntity()
        {
            try
            {
                smBasicDataOpinionTypeEntitys = SuperviseMissionBodyBiz.GetSmDataOpinionTypeEntity();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadSmModifyInfo()
        {
            try
            {
                smFlowItemBaseEntitys = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowItemBaseEntity() { SmId = _smId });
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadSmFlowFinishAndWaiting()
        {
            try
            {
                List<SmFlowWaitingEntity> smFlowWaitingEntitys = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == _smId).ToList();
                List<SmFlowFinishEntity> smFlowFinishEntitys = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId == _smId).ToList();
                List<SmFlowFinishAndWaitingEntity> smFlowFinishAndWaitingEntitys = new List<SmFlowFinishAndWaitingEntity>();
                if (smFlowWaitingEntitys != null && smFlowWaitingEntitys.Count > 0)
                {
                    foreach (var smFlowWaitingEntity in smFlowWaitingEntitys)
                    {
                        var smFlowFinishAndWaitingEntity = new SmFlowFinishAndWaitingEntity
                        {
                            FlowId = smFlowWaitingEntity.FlowId,
                            SmFlowWaitingEntity = smFlowWaitingEntity
                        };
                        smFlowFinishAndWaitingEntitys.Add(smFlowFinishAndWaitingEntity);
                    }
                }

                if (smFlowFinishEntitys != null && smFlowFinishEntitys.Count > 0)
                {
                    foreach (var smFlowFinishEntity in smFlowFinishEntitys)
                    {
                        var smFlowFinishAndWaitingEntity = new SmFlowFinishAndWaitingEntity
                        {
                            FlowId = smFlowFinishEntity.FlowId,
                            SmFlowFinishEntity = smFlowFinishEntity
                        };
                        smFlowFinishAndWaitingEntitys.Add(smFlowFinishAndWaitingEntity);
                    }
                }

                smFlowFinishAndWaitingEntityList = smFlowFinishAndWaitingEntitys.OrderBy(n => n.FlowId).ToList();
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
                    SmId = _smId,
                    ActivityFlag = 1
                };

                SmMainEntity entity = SuperviseMissionBodyBiz.GetSmMainEntity(condition);

                if (entity == null)
                {
                    NotHaveResult = true;
                    HaveResult = false;
                    return;
                }

                SmId = entity.SmId;
                SpNumberDeptId = SuperviseMissionWorkFlow.GetFlowDeptIdByDeptId(CurrentUserInfo.Dept_ID);
                SpNumberName = entity.SpNumberName;
                SpNumberYear = entity.SpNumberYear;
                SpNumberCode = entity.SpNumberCode.ToString();
                TaskContent = entity.TaskContent;
                MainLeader = FormatKeyValueString(entity.MainLeaderName, entity.MainLeaderId);
                AssLeader = FormatKeyValueString(entity.AssistLeaderName, entity.AssistLeaderId);
                MainLeaderIds = entity.MainLeaderId;
                MainLeaderNames = entity.MainLeaderName;
                AssLeaderIds = entity.AssistLeaderId;
                AssLeaderNames = entity.AssistLeaderName;
                MainDeptIds = entity.MainDeptId;
                MainDeptNames = entity.MainDeptName;
                AssistDeptNames = entity.AssistDeptName;
                AssistDeptIds = entity.AssistDeptId;
                StartTime = entity.StartTime;

                NotHaveResult = false;
                HaveResult = true;
            }
            catch (Exception ex) { }
        }

        private string FormatKeyValueString(string spName, string spId)
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

        private void LoadSmTarget(Repeater rp)
        {
            try
            {
                SmTargetEntity condition = new SmTargetEntity()
                {
                    SmId = _smId,
                    ActivityFlag = 1
                };
                List<SmTargetEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetEntityList(condition);
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
            }
        }
        private void LoadLdTarget(Repeater rp)
        {
            try
            {
                SmLeaderMeetingMissionEntity condition = new SmLeaderMeetingMissionEntity()
                {
                    SmId = _smId,
                    ActivityFlag = 1
                };
                List<SmLeaderMeetingMissionEntity> entitys = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(condition);
                rp.DataSource = entitys;
                rp.DataBind();
            }
            catch (Exception ex)
            {
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
            }
        }

        protected void rptTarget_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("rptItem") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = _smId,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void rptItem_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("rptItem_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    SmId = _smId
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void rptLdTarget_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("rptLdItem") as Repeater;
                SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.LmmId,
                    ActivityFlag = 1,
                    SmId = _smId,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void rptLdItem_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("rptLdItem_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    SmId = _smId
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected int GetPostfix(int index)
        {
            if (index < 0 || index >= _postfixOfTargetAndItems.Length) return 0;
            for (int i = index + 1; i < _postfixOfTargetAndItems.Length; i++) _postfixOfTargetAndItems[i] = 0;
            return ++_postfixOfTargetAndItems[index];
        }

        public string AttachmentHtmlGenerator(string smId)
        {
            string table = @"<table class='table'>";
            string thead = @"<thead>
                            <tr>
                                <th>目标</th>
                                <th>措施</th>
                                <th>措施附件</th>
                                <th>子措施</th>
                                <th>子措施附件</th>
                            </tr>
                          </thead>";
            string tbody = @"<tbody>";
            StringBuilder contentBuffer = new StringBuilder(1024);
            // 获取指定SMID的目标。
            IEnumerable<SmTargetEntity> targets = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(smId);
            foreach (SmTargetEntity target in targets)
            {
                // 获取指定TargetId的措施和子措施。
                IEnumerable<SmTargetItemEntity> targetItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByTargetId(target.TargetId, true);
                if (targetItems == null) continue;
                // 筛选措施。
                IList<SmTargetItemEntity> parentItems = targetItems.Where(e => String.IsNullOrEmpty(e.ParentTargetItemId)).ToList();
                if (parentItems == null || parentItems.Count() == 0) continue;
                // 筛选子措施。
                IList<SmTargetItemEntity> childItems = targetItems.Where(e => e.ParentTargetItemId != null).ToList();
                int rsTarget = 0; // 目标的rowspan默认取获取子措施的总数+没有子措施的措施的数量。
                foreach (var item in parentItems)
                {
                    var temp = targetItems.Where(e => e.ParentTargetItemId == item.ItemId);
                    if (temp == null || temp.Count() == 0) rsTarget += 1;
                    else rsTarget += temp.Count();
                }
                rsTarget = rsTarget <= 0 ? parentItems.Count() : rsTarget; // 如果不存在子措施时则取措施的总数。
                // 获取第1个措施的子措施。
                childItems = targetItems.Where(e => e.ParentTargetItemId == parentItems[0].ItemId).ToList();
                int rsItem = childItems == null ? 1 : childItems.Count();// 获取第1个措施的子措施条数。
                rsItem = rsItem <= 0 ? 1 : rsItem;

                #region 第1个措施。
                contentBuffer.Append("<tr>");
                contentBuffer.Append(string.Format("<td rowspan='{0}'>{1}</td>", rsTarget, target.TargetName));     // 目标。
                contentBuffer.Append(string.Format("<td rowspan='{0}'>{1}</td>", rsItem, parentItems[0].ItemName)); // 措施。
                contentBuffer.Append(string.Format("<td rowspan='{0}'>", rsItem)); // 措施附件。
                contentBuffer.Append("<ul class='list-unstyled fli'>");
                IEnumerable<SmAttachmentEntity> attachments = SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity() { SmId = parentItems[0].ItemId, Activity = "1" });// 获取措施的附件。
                foreach (var attachment in attachments)
                {
                    contentBuffer.Append("<li>");
                    contentBuffer.Append(String.Format("<span class='iconfont icon-sv-reduce' data-itemid='{0}' data-attachmentid='{1}'></span>{2}", parentItems[0].ItemId, attachment.AttachmentId, attachment.AttachmentName));
                    contentBuffer.Append("</li>");
                }
                contentBuffer.Append("<li class='last'>");
                contentBuffer.Append("<span class='iconfont icon-sv-add'></span>添加附件");
                contentBuffer.Append(String.Format("<input type='file' name='upload' multiple='multiple' data-itemid='{0}' value=''/ >", parentItems[0].ItemId));
                contentBuffer.Append("</li>");
                contentBuffer.Append("</ul>");
                contentBuffer.Append("</td>");

                // 第1个子措施。
                if (childItems.Count > 0)
                {
                    contentBuffer.Append("<td>" + childItems[0].ItemName + "</td>");// 子措施。                                         
                    contentBuffer.Append("<td>");// 子措施附件。
                    contentBuffer.Append("<ul class='list-unstyled fli'>");
                    attachments = SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity() { SmId = childItems[0].ItemId, Activity = "1" });// 获取子措施的附件。
                    foreach (var attachment in attachments)
                    {
                        contentBuffer.Append("<li>");
                        contentBuffer.Append(String.Format("<span class='iconfont icon-sv-reduce' data-itemid='{0}' data-attachmentid='{1}'></span>{2}", childItems[0].ItemId, attachment.AttachmentId, attachment.AttachmentName));
                        contentBuffer.Append("</li>");
                    }
                    contentBuffer.Append("<li class='last'>");
                    contentBuffer.Append("<span class='iconfont icon-sv-add'></span>添加附件");
                    contentBuffer.Append(String.Format("<input type='file' name='upload' multiple='multiple' data-itemid='{0}' value=''/>", childItems[0].ItemId));
                    contentBuffer.Append("</li>");
                    contentBuffer.Append("</ul>");
                    contentBuffer.Append("</td>");
                }
                else
                {
                    // 当没有子措施时为保持对齐也需要2个td。
                    contentBuffer.Append("<td></td>");
                    contentBuffer.Append("<td></td>");
                }

                contentBuffer.Append("</tr>");
                #endregion

                #region 第1个措施的第2个(含)子措施。
                for (int i = 1; i < childItems.Count; i++)
                {
                    contentBuffer.Append("<tr>");
                    contentBuffer.Append("<td>" + childItems[i].ItemName + "</td>");// 子措施。
                    // 获取子措施的附件。
                    contentBuffer.Append("<td>");
                    contentBuffer.Append("<ul class='list-unstyled fli'>");
                    attachments = SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity() { SmId = childItems[i].ItemId, Activity = "1" });
                    foreach (var attachment in attachments)
                    {
                        contentBuffer.Append("<li>");
                        contentBuffer.Append(String.Format("<span class='iconfont icon-sv-reduce' data-itemid='{0}' data-attachmentid='{1}'></span>{2}", childItems[i].ItemId, attachment.AttachmentId, attachment.AttachmentName));
                        contentBuffer.Append("</li>");
                    }
                    contentBuffer.Append("<li class='last'>");
                    contentBuffer.Append("<span class='iconfont icon-sv-add'></span>添加附件");
                    contentBuffer.Append(String.Format("<input type='file' name='upload' multiple='multiple' data-itemid='{0}' value=''/>", childItems[i].ItemId));
                    contentBuffer.Append("</li>");
                    contentBuffer.Append("</ul>");
                    contentBuffer.Append("</td>");
                    contentBuffer.Append("</tr>");
                }
                #endregion

                #region 第i个措施。
                for (int i = 1; i < parentItems.Count; i++)
                {
                    // 获取第i个措施的子措施。
                    childItems = targetItems.Where(e => e.ParentTargetItemId == parentItems[i].ItemId).ToList();
                    rsItem = childItems == null ? 1 : childItems.Count();// 获取第i个措施的子措施数。
                    rsItem = rsItem <= 0 ? 1 : rsItem;
                    contentBuffer.Append("<tr>");
                    contentBuffer.Append(string.Format("<td rowspan='{0}'>{1}</td>", rsItem, parentItems[i].ItemName)); // 措施。
                    contentBuffer.Append(string.Format("<td rowspan='{0}'>", rsItem)); // 措施附件。
                    contentBuffer.Append("<ul class='list-unstyled fli'>");
                    attachments = SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity() { SmId = parentItems[i].ItemId, Activity = "1" });// 获取措施的附件。
                    foreach (var attachment in attachments)
                    {
                        contentBuffer.Append("<li>");
                        contentBuffer.Append(String.Format("<span class='iconfont icon-sv-reduce' data-itemid='{0}' data-attachmentid='{1}'></span>{2}", parentItems[i].ItemId, attachment.AttachmentId, attachment.AttachmentName));
                        contentBuffer.Append("</li>");
                    }
                    contentBuffer.Append("<li class='last'>");
                    contentBuffer.Append("<span class='iconfont icon-sv-add'></span>添加附件");
                    contentBuffer.Append(String.Format("<input type='file' name='upload' multiple='multiple' data-itemid='{0}' value=''/>", parentItems[i].ItemId));
                    contentBuffer.Append("</li>");
                    contentBuffer.Append("</ul>");
                    contentBuffer.Append("</td>");

                    // 第1个子措施。
                    if (childItems.Count > 0)
                    {
                        contentBuffer.Append("<td>" + childItems[0].ItemName + "</td>");// 子措施。                                 
                        contentBuffer.Append("<td>");// 子措施附件。
                        contentBuffer.Append("<ul class='list-unstyled fli'>");
                        attachments = SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity() { SmId = childItems[0].ItemId, Activity = "1" }); // 获取子措施的附件。
                        foreach (var attachment in attachments)
                        {
                            contentBuffer.Append("<li>");
                            contentBuffer.Append(String.Format("<span class='iconfont icon-sv-reduce' data-itemid='{0}' data-attachmentid='{1}'></span>{2}", childItems[0].ItemId, attachment.AttachmentId, attachment.AttachmentName));
                            contentBuffer.Append("</li>");
                        }
                        contentBuffer.Append("<li class='last'>");
                        contentBuffer.Append("<span class='iconfont icon-sv-add'></span>添加附件");
                        contentBuffer.Append(String.Format("<input type='file' name='upload' multiple='multiple' data-itemid='{0}' value=''/>", childItems[0].ItemId));
                        contentBuffer.Append("</li>");
                        contentBuffer.Append("</ul>");
                        contentBuffer.Append("</td>");
                    }
                    else
                    {
                        // 当没有子措施时为保持对齐也需要2个td。
                        contentBuffer.Append("<td></td>");
                        contentBuffer.Append("<td></td>");
                    }
                    contentBuffer.Append("</tr>");

                    #region 第i个措施的第2个(含)子措施。
                    for (int j = 1; j < childItems.Count; j++)
                    {
                        contentBuffer.Append("<tr>");
                        contentBuffer.Append("<td>" + childItems[j].ItemName + "</td>");// 子措施。                                    
                        contentBuffer.Append("<td>");// 子措施附件。
                        contentBuffer.Append("<ul class='list-unstyled fli'>");
                        attachments = SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity() { SmId = childItems[j].ItemId, Activity = "1" });// 获取子措施的附件。
                        foreach (var attachment in attachments)
                        {
                            contentBuffer.Append("<li>");
                            contentBuffer.Append(String.Format("<span class='iconfont icon-sv-reduce' data-itemid='{0}' data-attachmentid='{1}'></span>{2}", childItems[j].ItemId, attachment.AttachmentId, attachment.AttachmentName));
                            contentBuffer.Append("</li>");
                        }
                        contentBuffer.Append("<li class='last'>");
                        contentBuffer.Append("<span class='iconfont icon-sv-add'></span>添加附件");
                        contentBuffer.Append(String.Format("<input type='file' name='upload' multiple='multiple' data-itemid='{0}' value=''/>", childItems[j].ItemId));
                        contentBuffer.Append("</li>");
                        contentBuffer.Append("</ul>");
                        contentBuffer.Append("</td>");
                        contentBuffer.Append("</tr>");
                    }
                    #endregion
                }
                #endregion
            }

            return table + thead + tbody + contentBuffer.ToString() + "</tbody></table>";
        }
    }

    #region 表单类型。
    public enum FormType
    {
        Nd = 0x1,
        Ld = 0x2,
    }
    #endregion
}