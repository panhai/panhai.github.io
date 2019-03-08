using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class LeaderMeetingMissionDetail : BasePage
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

        #endregion

        #region 变量

        protected int page
        {
            get; set;
        }

        protected string LbHeader
        {
            get
            {
                string str = "未知任务类型";
                if (smtype == "LD")
                {
                    str = "领导行政例会督查任务";
                }
                return str;
            }
        }

        /// <summary>
        /// 当前用户是否为领导
        /// </summary>
        protected bool IsLeader
        {

            get; set;
        }

        #endregion

        #region 页面加载方法

        protected void Page_Load(object sender, EventArgs e)
        {
            SetPageInt();
            if (!IsPostBack)
            {
                LoadDetail();
                IsLeader = SuperviseMissionBodyBiz.CheckUserIsLeader(CurrentUserInfo.Employee_ID);
            }
        }

        #endregion

        #region 页面引用的方法

        /// <summary>
        /// 日期格式化
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        protected string DateFormat(DateTime? date)
        {
            try
            {
                if (string.IsNullOrEmpty(date.ToString()) || Convert.ToDateTime(null) == date)
                {
                    return "";
                }

                return Convert.ToDateTime(date).ToString("yyyy-MM-dd");
            }
            catch
            {
                return date.ToString();
            }
        }

        /// <summary>
        /// 是否显示变更记录按钮。
        /// </summary>
        /// <param name="itemId">措施Id。</param>
        /// <returns>校验结果。（true：显示）</returns>
        public bool ShowChangeRecordBtn(string itemId)
        {
            var changeEntity = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntity(new SmTargetItemChangeEntity
                { SourceSmId = smid, ItemId = itemId });
            if (changeEntity != null)
            {
                var changeSmEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity
                {
                    SmId = changeEntity.ChangeId
                });
                if (changeSmEntity != null)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// 完成进度格式化
        /// </summary>
        /// <param name="finishPercent"></param>
        /// <returns></returns>
        protected string FinishPercentFormat(object finishPercent)
        {
            if (finishPercent == null || finishPercent.ToString() == "")
            {
                return "";
            }

            return finishPercent + "%";
        }

        /// <summary>
        /// 判断主办单位是否属于当前待办
        /// </summary>
        /// <param name="deptId"></param>
        /// <returns></returns>
        protected bool IsCurrentMainDept(string deptId)
        {
            try
            {
                //获取当前待办
                var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smid, FlowId = Convert.ToInt32(flowid) });
                if (flowWaitingEntity != null)
                {
                    if (deptId == flowWaitingEntity.FlowDeptId)
                    {
                        return true;
                    }
                }
            }
            catch
            {
            }
            return false;
        }

        /// <summary>
        /// 检查是否所有子项均已提交反馈
        /// 责任处室措施反馈、主办单位任务反馈、办公厅任务反馈
        /// </summary>
        /// <param name="type">1:责任处室措施反馈|2:主办单位任务反馈|3:办公厅任务反馈</param>
        /// <param name="id"></param>
        /// <returns></returns>
        protected bool IsAllFeedback(int type, string id)
        {
            try
            {
                //获取当前步骤的待办列表
                var waitingFlowList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = smid });
                if (waitingFlowList == null || !waitingFlowList.Any())
                {
                    return false;
                }

                #region 责任处室措施反馈检查
                if (type == 1)
                {
                    //获取子措施集合
                    var itemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(id);
                    if (itemList != null && itemList.Any())
                    {
                        var tempList = waitingFlowList.Where(m => !string.IsNullOrEmpty(m.TargetItemId) && m.StepId == "ZRCSCSFK" && m.UserId == CurrentUserInfo.Employee_ID
                                                           && m.TargetId == itemList.FirstOrDefault().TargetId).ToList().Select(m => m.TargetItemId).Distinct();
                        return tempList.Count() == itemList.Count;
                    }
                }
                #endregion

                #region 主办单位任务反馈检查
                else if (type == 2)
                {
                    //获取措施集合
                    var itemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByTargetId(id, false);
                    if (itemList != null && itemList.Any())
                    {
                        var tempList = waitingFlowList.Where(m => !string.IsNullOrEmpty(m.TargetItemId) && m.StepId == "ZBDWRWFK" && m.UserId == CurrentUserInfo.Employee_ID
                                                            && m.TargetId == itemList.FirstOrDefault().TargetId).ToList().Select(m => m.TargetItemId).Distinct();
                        return tempList.Count() == itemList.Count;
                    }
                }
                #endregion

                #region 办公厅任务反馈检查
                else if (type == 3)
                {
                    //获取主办单位集合
                    var leaderMeetingMissionList = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(new SmLeaderMeetingMissionEntity() { ActivityFlag = 1, SmId = smid });
                    if (leaderMeetingMissionList != null && leaderMeetingMissionList.Any())
                    {
                        var tempList = waitingFlowList.Where(m => !string.IsNullOrEmpty(m.TargetId) && m.StepId == "BGTRWFK" && m.UserId == CurrentUserInfo.Employee_ID).ToList().Select(m => m.TargetId).Distinct();
                        return tempList.Count() == leaderMeetingMissionList.Count;
                    }
                }
                #endregion
            }
            catch
            {

            }
            return false;
        }

        #region 主办单位、措施和子措施绑定输出的序列号

        private int _IndexForMainDept = 0;
        /// <summary>
        /// 主办单位的序列号
        /// </summary>
        /// <returns></returns>
        protected string GetIndexForMainDept()
        {
            _IndexForMainDept++;
            return _IndexForMainDept.ToString();
        }

        /// <summary>
        /// 当前措施的主办单位记录ID
        /// </summary>
        private string _CurrentLmmId = "";
        private int _IndexForItem = 0;
        /// <summary>
        /// 措施的序列号
        /// </summary>
        /// <returns></returns>
        protected string GetIndexForItem(string LmmId)
        {
            if (string.IsNullOrEmpty(_CurrentLmmId))
            {
                _CurrentLmmId = LmmId;

            }
            else if (LmmId != _CurrentLmmId)
            {
                //新的年度下的措施重新计算序列号
                _CurrentLmmId = LmmId;
                _IndexForItem = 0;
            }

            _IndexForItem++;
            return _IndexForItem.ToString();
        }

        /// <summary>
        /// 当前子措施的措施ID
        /// </summary>
        private string _CurrentItemId = "";
        private int _IndexForSubItem = 0;
        /// <summary>
        /// 子措施的序列号
        /// </summary>
        /// <returns></returns>
        protected string GetIndexForSubItem(string ItemId)
        {
            if (string.IsNullOrEmpty(_CurrentItemId))
            {
                _CurrentItemId = ItemId;

            }
            else if (ItemId != _CurrentItemId)
            {
                //新的措施下子措施重新计算序列号
                _CurrentItemId = ItemId;
                _IndexForSubItem = 0;
            }
            _IndexForSubItem++;
            return _IndexForSubItem.ToString();
        }

        #endregion

        /// <summary>
        /// 获取主办单位最近意见
        /// </summary>
        /// <param name="targetId">主办单位ID</param>
        /// <returns></returns>
        protected string GetRecentOpinionByTargetId(string targetId)
        {
            string opinion = "";
            try
            {
                if (string.IsNullOrEmpty(targetId))
                {
                    return opinion;
                }

                //主办单位ID不为空，取主办单位最新意见信息
                var leaderMeetingEntity = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity() { ActivityFlag = 1, LmmId = targetId });
                if (leaderMeetingEntity == null)
                {
                    return opinion;
                }
                SmFlowFinishEntity flowdFinishEntity = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.TargetId == targetId && e.Opinion != null && e.Opinion != "" && e.ActivityFlag == 1 &&
                e.FlowDeptId == leaderMeetingEntity.DeptId && (e.TargetItemId == null || e.TargetItemId == "")).OrderByDescending(e => e.FinishTime).FirstOrDefault();
                if (flowdFinishEntity != null)
                {
                    //最新反馈意见不显示用户名称
                    //opinion = Convert.ToDateTime(flowdFinishEntity.FinishTime).ToString("yyyy-MM-dd") + " " + flowdFinishEntity.UserName + ":" + flowdFinishEntity.Opinion;
                    opinion = Convert.ToDateTime(flowdFinishEntity.FinishTime).ToString("yyyy-MM-dd") + ":" + flowdFinishEntity.Opinion;
                }
            }
            catch
            {
            }
            return opinion;
        }

        /// <summary>
        /// 获取措施/子措施最近的意见
        /// </summary>
        /// <param name="itemId"></param>
        /// <returns></returns>
        protected string GetRecentOpinionByItemId(string itemId)
        {
            string opinion = "";
            try
            {
                if (string.IsNullOrEmpty(itemId))
                {
                    return opinion;
                }

                SmFlowFinishEntity flowdFinishEntity = null;
                var targetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(itemId);
                if (targetItemEntity == null) return "";

                // 如果ParentTargetItemId为null此ItemId为父措施，否则为子措施。
                if (targetItemEntity.ParentTargetItemId == null)
                {
                    // 父措施取责任处室为条件。
                    flowdFinishEntity = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.TargetItemId == itemId && (e.Opinion != null && e.Opinion != "") && e.FlowDeptId == targetItemEntity.DutyDeptId && e.ActivityFlag == 1).OrderByDescending(e => e.FinishTime).FirstOrDefault();
                }
                else
                {
                    // 子措施条件为责任人。
                    flowdFinishEntity = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.TargetItemId == itemId && (e.Opinion != null && e.Opinion != "") && e.UserId == targetItemEntity.ExcutorId && e.ActivityFlag == 1).OrderByDescending(e => e.FinishTime).FirstOrDefault();
                }

                if (flowdFinishEntity != null)
                {
                    //最新反馈意见不显示用户名称
                    //opinion = Convert.ToDateTime(flowdFinishEntity.FinishTime).ToString("yyyy-MM-dd") + " " + flowdFinishEntity.UserName + ":" + flowdFinishEntity.Opinion;
                    opinion = Convert.ToDateTime(flowdFinishEntity.FinishTime).ToString("yyyy-MM-dd") + ":" + flowdFinishEntity.Opinion;
                }
            }
            catch
            {
            }
            return opinion;
        }

        /// <summary>
        /// 判断是不是已办。
        /// </summary>
        /// <returns></returns>
        public bool IsYiBan()
        {
            return !string.IsNullOrEmpty(flowid) && !string.IsNullOrEmpty(smid);
        }

        #endregion

        #region 私有方法

        /// <summary>
        /// 获取详情数据在页面展示
        /// </summary>
        private void LoadDetail()
        {
            //1.获取主表数据
            LoadSmMain();
            //2.获取子表数据
            switch (page)
            {
                case 1:
                    {
                        LoadSmLeaderMeeting(Repeater1, true);
                        break;
                    }
                case 7:
                    {
                        LoadSmLeaderMeeting(Repeater7, false);
                        break;
                    }
                case 8:
                    {
                        LoadSmLeaderMeeting(Repeater8, false);
                        break;
                    }
                case 9:
                    {
                        LoadSmLeaderMeeting(Repeater9, true);
                        break;
                    }
                case 10:
                    {
                        LoadSmLeaderMeeting(Repeater10, true);
                        break;
                    }
                case 11:
                    {
                        LoadSmLeaderMeeting(Repeater11, true);
                        break;
                    }
                case 12:
                    {
                        LoadSmLeaderMeeting(Repeater12, true);
                        break;
                    }
                case 13:
                    {
                        LoadSmLeaderMeeting(Repeater13, true);
                        break;
                    }
                case 14:
                    {
                        LoadSmLeaderMeeting(Repeater14, true);
                        break;
                    }
                case 15:
                    {
                        LoadSmLeaderMeeting(Repeater15);
                        break;
                    }
                case 17:
                    {
                        LoadSmLeaderMeeting(Repeater17, true);
                        break;
                    }
                case 18:
                    {
                        LoadSmLeaderMeeting(Repeater17, true);
                        break;
                    }
                default: break;
            }
        }

        /// <summary>
        /// 加载任务主表数据
        /// </summary>
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
                lblSpNum.Text = string.Format("{0}【{1}】{2}号", entity.SpNumberName, entity.SpNumberYear, entity.SpNumberCode);
                lblSmId.Text = entity.SmId;
                lblTaskContent.Text = entity.TaskContent;
                lblMainDept.Text = entity.MainDeptName;
                lblAssDept.Text = entity.AssistDeptName;
                lblStartTime.Text = Convert.ToDateTime(entity.StartTime).ToString("yyyy-MM-dd");
                //lblDeadLineTime.Text = entity.DeadLineTime == null ? "" : Convert.ToDateTime(entity.DeadLineTime).ToString("yyyy-MM-dd");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 根据步骤设置page索引
        /// </summary>
        private void SetPageInt()
        {
            try
            {
                switch (stepid)
                {
                    case "TXWCSJ":
                        {
                            //主办单位填写完成时间
                            page = 3; break;
                        }
                    case "GDLSP":
                        {
                            //固定流审批
                            page = 4; break;
                        }
                    case "BGTQR":
                        {
                            //办公厅确认
                            page = 5; break;
                        }
                    case "ZBDWRWTJ":
                        {
                            //主办单位任务推进
                            page = 6; break;
                        }
                    case "RWFK":
                        {
                            //任务反馈
                            page = 7; break;
                        }
                    case "CSFJ":
                        {
                            //措施分解
                            page = 8; break;
                        }
                    case "BGTSP":
                        {
                            //办公厅审批
                            page = 2; break;
                        }
                    case "ZRCSCLCS":
                        {
                            //责任处室处理措施
                            page = 9; break;
                        }
                    case "CSFK":
                        {
                            //措施反馈
                            page = 10; break;
                        }
                    case "ZRCSFJZCS":
                        {
                            //责任处室分解子措施
                            page = 11; break;
                        }
                    case "ZCSFK":
                        {
                            //子措施反馈
                            page = 12; break;
                        }
                    case "ZRCSCSFK":
                        {
                            //责任处室措施反馈
                            page = 13; break;
                        }
                    case "ZBDWRWFK":
                        {
                            //主办单位任务反馈
                            page = 14; break;
                        }
                    case "BGTRWFK":
                        {
                            //办公厅任务反馈
                            page = 15; break;
                        }
                    case "NG":
                        {
                            //办公厅审核退回拟稿
                            page = 16; break;
                        }
                    case "BMSH":
                        {
                            //部门审核
                            page = 17; break;
                        }
                    case "BMSP":
                        {
                            //部门审批
                            page = 17; break;
                        }
                    case "MSCL":
                        {
                            //秘书处理
                            page = 18; break;
                        }
                    default:
                        {
                            //默认只返回只可以查看的页面
                            page = 1;
                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 加载子表数据
        /// </summary>
        /// <param name="rp"></param>
        /// <param name="isAll">是否加载所有主办单位</param>
        private void LoadSmLeaderMeeting(Repeater rp, bool isAll)
        {
            try
            {

                SmLeaderMeetingMissionEntity condition = new SmLeaderMeetingMissionEntity()
                {
                    SmId = smid,
                    ActivityFlag = 1
                };
                List<SmLeaderMeetingMissionEntity> list = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(condition);
                if (!isAll)
                {
                    //加载非当前主办单位的集合
                    //根据flowId获取当前待办
                    var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smid, FlowId = int.Parse(flowid) });
                    if (flowWaitingEntity != null)
                    {
                        list = list.Where(m => m.DeptId != flowWaitingEntity.FlowDeptId).ToList();
                    }
                }
                rp.DataSource = list;
                rp.DataBind();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 加载措施数据
        /// </summary>
        /// <param name="condition"></param>
        /// <param name="rp"></param>
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

        /// <summary>
        /// 加载措施/子措施数据
        /// </summary>
        /// <param name="list"></param>
        /// <param name="rp"></param>
        private void LoadSmTargetItem(List<SmTargetItemEntity> list, Repeater rp)
        {
            try
            {
                rp.DataSource = list;
                rp.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 加载子表数据（包括主办单位的待办信息）
        /// </summary>
        /// <param name="rp"></param>
        private void LoadSmLeaderMeeting(Repeater rp)
        {
            try
            {
                //获取当前步骤待办列表信息
                var flowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = smid });
                flowWaitingList = flowWaitingList.Where(m => m.StepId == "BGTRWFK").ToList();

                //获取主办单位信息
                SmLeaderMeetingMissionEntity condition = new SmLeaderMeetingMissionEntity()
                {
                    SmId = smid,
                    ActivityFlag = 1
                };
                List<SmLeaderMeetingMissionEntity> list = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(condition);

                BindLeaderMeetingMainDeptList(list, rp, flowWaitingList);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 绑定主办单位信息
        /// </summary>
        /// <param name="list"></param>
        /// <param name="rp"></param>
        /// <param name="smFlowWaitingList"></param>
        private void BindLeaderMeetingMainDeptList(List<SmLeaderMeetingMissionEntity> list, Repeater rp, List<SmFlowItemBaseEntity> smFlowWaitingList)
        {
            List<LeaderMeetingMainDeptResponeEntity> listForBind = new List<LeaderMeetingMainDeptResponeEntity>();
            LeaderMeetingMainDeptResponeEntity tempEntity = null;

            foreach (var item in list)
            {
                tempEntity = new LeaderMeetingMainDeptResponeEntity();
                tempEntity.LmmId = item.LmmId;
                tempEntity.DeptName = item.DeptName;
                tempEntity.DeadLineTime = item.DeadLineTime;
                tempEntity.FinishPercent = item.FinishPercent;

                //获取主办单位对应的流程ID
                if (smFlowWaitingList != null)
                {
                    //拟稿单位多个秘书的情况，只筛选当前用户对应的待办
                    var smFlowWaitingEntity = smFlowWaitingList.Where(m => m.TargetId == item.LmmId && m.UserId == CurrentUserInfo.Employee_ID).FirstOrDefault();
                    if (smFlowWaitingEntity != null)
                    {
                        tempEntity.FlowId = smFlowWaitingEntity.FlowId.ToString();
                    }
                }

                listForBind.Add(tempEntity);
            }

            rp.DataSource = listForBind;
            rp.DataBind();
        }

        #endregion

        #region Repeater控件绑定方法

        /// <summary>
        /// 任务反馈步骤绑定措施
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater7_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                Repeater rep = e.Item.FindControl("Repeater7_1") as Repeater;
                SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;

                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ParentTargetItemId = null,
                    TargetId = entity.LmmId
                };

                LoadSmTargetItem(condition, rep);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 任务反馈步骤绑定子措施
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater7_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater rep = e.Item.FindControl("Repeater7_1_1") as Repeater;
                    SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;

                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        ActivityFlag = 1,
                        ParentTargetItemId = entity.ItemId,
                        TargetId = entity.TargetId
                    };

                    LoadSmTargetItem(condition, rep);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 责任处室处理措施步骤绑定措施信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater9_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    Repeater rep = e.Item.FindControl("Repeater9_1") as Repeater;
                    SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;
                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        TargetId = entity.LmmId,
                        ActivityFlag = 1,
                        SmId = smid,
                        ParentTargetItemId = null,
                    };
                    LoadSmTargetItem(condition, rep);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 措施反馈绑定措施信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater10_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    Repeater repCanOperate = e.Item.FindControl("Repeater10_1") as Repeater;
                    Repeater repOnlyView = e.Item.FindControl("Repeater10_2") as Repeater;
                    SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;

                    //1.获取当前任务的待办列表
                    var smFlowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = entity.SmId });
                    //2.获取当前步骤和主办单位的待办
                    smFlowWaitingList = smFlowWaitingList.Where(m => m.StepId == "CSFK" && m.FinishTime == null && m.TargetId == entity.LmmId).ToList();
                    //3.获取当前待办对应的责任处室ID
                    var tempWaitingEntity = smFlowWaitingList.Where(m => m.UserId == CurrentUserInfo.Employee_ID).FirstOrDefault();
                    var dutyDeptId = tempWaitingEntity == null ? "" : tempWaitingEntity.FlowDeptId;

                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        TargetId = entity.LmmId,
                        ActivityFlag = 1,
                        SmId = smid,
                        ParentTargetItemId = null
                    };

                    //4.获取当前主办单位的措施集合
                    var list = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);

                    if (list != null)
                    {
                        //可进行反馈的措施集合
                        var listForCanOperate = list.Where(m => m.DutyDeptId == dutyDeptId).ToList();
                        BindSmTargetItemForPage10(listForCanOperate, repCanOperate, smFlowWaitingList);
                        //展示的措施集合
                        var listForOnlyView = list.Where(m => m.DutyDeptId != dutyDeptId).ToList();
                        BindSmTargetItemForPage10(listForOnlyView, repOnlyView, null);
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 绑定措施反馈页面数据
        /// </summary>
        /// <param name="list"></param>
        /// <param name="rp"></param>
        /// <param name="smFlowWaitingList"></param>
        private void BindSmTargetItemForPage10(List<SmTargetItemEntity> list, Repeater rp, List<SmFlowItemBaseEntity> smFlowWaitingList)
        {
            var listForBind = new List<MeasureResponseEntity>();
            MeasureResponseEntity tempEntity = null;
            int index = 0;

            foreach (var item in list)
            {
                tempEntity = new MeasureResponseEntity();
                tempEntity.AssistDeptName = item.AssistDeptName;
                tempEntity.DutyDeptName = item.DutyDeptName;
                tempEntity.ItemId = item.ItemId;
                tempEntity.ItemName = item.ItemName;
                tempEntity.DeadLineTime = item.DeadLineTime;
                tempEntity.FinshPercent = item.FinshPercent;
                tempEntity.TargetId = item.TargetId;//此处的TargetId对应的是主办单位的子表ID
                tempEntity.MeasureDetailIdIndex = "Deatil" + item.ItemId + "_" + index;
                tempEntity.MeasureOperateIdIndex = "Operate" + item.ItemId + "_" + index;

                //获取措施对应的流程ID和意见
                if (smFlowWaitingList != null)
                {
                    //主办单位多个秘书情况，筛选当前用户对应的待办
                    var smFlowWaitingEntity = smFlowWaitingList.Where(m => m.TargetItemId == item.ItemId && m.UserId == CurrentUserInfo.Employee_ID).FirstOrDefault();
                    if (smFlowWaitingEntity != null)
                    {
                        tempEntity.Opinion = smFlowWaitingEntity.Opinion;
                        tempEntity.FlowId = smFlowWaitingEntity.FlowId.ToString();
                    }
                }

                index++;
                listForBind.Add(tempEntity);
            }

            rp.DataSource = listForBind;
            rp.DataBind();
        }

        /// <summary>
        /// 责任处室分解子措施的措施绑定
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater11_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater repCanOperate = e.Item.FindControl("Repeater11_1") as Repeater;
                Repeater repOnlyView = e.Item.FindControl("Repeater11_2") as Repeater;
                SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;
                try
                {
                    //根据当前flowid获取责任处室ID
                    var flowid = int.Parse(Request.QueryString["flowid"]);
                    var SmFlowItem = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity() { SmId = entity.SmId, FlowId = flowid });
                    var targetItemEntityList = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(new SmTargetItemEntity() { TargetId = entity.LmmId, ActivityFlag = 1, SmId = smid, ParentTargetItemId = null });
                    var listForCanOperate = new List<SmTargetItemEntity>();
                    //当前待办的主办单位才输出可分解的措施
                    if (SmFlowItem.TargetId == entity.LmmId)
                    {
                        //绑定可分解子措施的措施集合
                        listForCanOperate = targetItemEntityList.Where(m => m.DutyDeptId == SmFlowItem.FlowDeptId).ToList();
                        LoadSmTargetItem(listForCanOperate, repCanOperate);
                    }
                    //绑定不可分解子措施的措施
                    var listForOnlyView = targetItemEntityList.Except(listForCanOperate).ToList();
                    LoadSmTargetItem(listForOnlyView, repOnlyView);

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 子措施反馈绑定措施集合
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater12_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater rep = e.Item.FindControl("Repeater12_1") as Repeater;
                    SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;

                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        TargetId = entity.LmmId,
                        ActivityFlag = 1,
                        SmId = smid,
                        ParentTargetItemId = null,
                    };
                    LoadSmTargetItem(condition, rep);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 子措施反馈绑定子措施集合
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater12_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater repCanOperate = e.Item.FindControl("Repeater12_1_1") as Repeater;
                    Repeater repOnlyView = e.Item.FindControl("Repeater12_1_2") as Repeater;
                    SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;

                    //1.获取当前措施的所有子措施集合
                    var subItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(entity.ItemId);
                    if (subItemList != null && subItemList.Any())
                    {
                        //2.获取当前任务的待办列表
                        var smFlowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = entity.SmId });
                        //3.获取当前步骤和主办单位的待办
                        smFlowWaitingList = smFlowWaitingList.Where(m => m.StepId == "ZCSFK" && m.FinishTime == null && m.TargetId == entity.TargetId).ToList();
                        //4.获取在待办中的子措施ID集合
                        var itemIds = smFlowWaitingList.Select(m => m.TargetItemId).ToArray();

                        //绑定需进行反馈的子措施
                        var listForCanOperate = subItemList.Where(m => m.ExcutorId == CurrentUserInfo.Employee_ID && itemIds.Contains(m.ItemId)).ToList();
                        BindSubItem(listForCanOperate, repCanOperate, smFlowWaitingList);

                        //绑定只允许查看的子措施
                        var listForOnlyView = subItemList.Except(listForCanOperate).ToList();
                        BindSubItem(listForOnlyView, repOnlyView, smFlowWaitingList);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 子措施反馈--子措施集合的绑定
        /// 责任处室措施反馈--子措施集合的绑定
        /// </summary>
        /// <param name="list"></param>
        /// <param name="rp"></param>
        /// <param name="smFlowWaitingList"></param>
        private void BindSubItem(List<SmTargetItemEntity> list, Repeater rp, List<SmFlowItemBaseEntity> smFlowWaitingList)
        {
            var listForBind = new List<SubMeasureResponseEntity>();
            SubMeasureResponseEntity tempEntity = null;
            int index = 0;

            foreach (var item in list)
            {
                tempEntity = new SubMeasureResponseEntity();
                tempEntity.AssistDeptName = item.AssistDeptName;
                tempEntity.ItemId = item.ItemId;
                tempEntity.ItemName = item.ItemName;
                tempEntity.DeadLineTime = item.DeadLineTime;
                tempEntity.ExcutorName = item.ExcutorName;
                tempEntity.FinshPercent = item.FinshPercent;
                tempEntity.TargetId = item.TargetId;
                tempEntity.ParentTargetItemId = item.ParentTargetItemId;
                tempEntity.SubMeasureDetailIdIndex = "Detail" + item.ItemId + "_" + index;
                tempEntity.SubMeasureOperateIdIndex = "Operate" + item.ItemId + "_" + index;

                //获取措施对应的流程ID和意见
                if (smFlowWaitingList != null)
                {
                    //责任处室多个秘书情况，只筛选当前用户对应的待办
                    var smFlowWaitingEntity = smFlowWaitingList.Where(m => m.TargetItemId == item.ItemId && m.UserId == CurrentUserInfo.Employee_ID).FirstOrDefault();
                    if (smFlowWaitingEntity != null)
                    {
                        tempEntity.FlowId = smFlowWaitingEntity.FlowId.ToString();
                    }
                }

                index++;
                listForBind.Add(tempEntity);
            }

            rp.DataSource = listForBind;
            rp.DataBind();
        }

        /// <summary>
        /// 责任处室措施反馈绑定措施集合
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater13_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater repCanOperate = e.Item.FindControl("Repeater13_1") as Repeater;
                    Repeater repOnlyView = e.Item.FindControl("Repeater13_2") as Repeater;

                    //获取当前待办对应的责任处室
                    var currentFlowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smid, FlowId = Convert.ToInt32(flowid) });
                    var dutyDeptId = currentFlowWaitingEntity == null ? "" : currentFlowWaitingEntity.FlowDeptId;

                    if (!string.IsNullOrEmpty(dutyDeptId))
                    {
                        SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;

                        //获取当前待办处于"责任处室措施反馈"的措施
                        var flowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = smid });
                        var currentStepWaitingList = flowWaitingList.Where(m => m.StepId == "ZRCSCSFK" && m.FinishTime == null && m.TargetId == entity.LmmId).ToList();
                        var subItemIds = currentStepWaitingList.Select(m => m.TargetItemId).ToArray();  //待办列表中，子措施ID集合
                        var allItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByTargetId(entity.LmmId, true);//当前主办单位下的所有措施和子措施集合
                        var subItemList = allItemList.Where(m => subItemIds.Contains(m.ItemId)).ToList();   //当前主办单位的子措施集合
                        var itemIds = subItemList.Select(m => m.ParentTargetItemId);    //获取子措施集合的措施ID集合

                        SmTargetItemEntity condition = new SmTargetItemEntity()
                        {
                            TargetId = entity.LmmId,
                            ActivityFlag = 1,
                            SmId = smid,
                            ParentTargetItemId = null
                        };
                        //获取主办单位的措施集合
                        var list = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
                        if (list != null && list.Any())
                        {
                            //当前责任处室的措施，保证当前责任处室已经收到对应措施下的子措施提交审核的待办
                            var listForOperate = list.Where(m => m.DutyDeptId == dutyDeptId && itemIds.Contains(m.ItemId)).ToList();
                            LoadSmTargetItem(listForOperate, repCanOperate);

                            //非当前责任处室的措施
                            var listForView = list.Except(listForOperate).ToList();
                            LoadSmTargetItem(listForView, repOnlyView);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 责任处室措施反馈--可发送的措施绑定子措施集合
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater13_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater rep = e.Item.FindControl("Repeater13_1_1") as Repeater;
                    SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;

                    //1.获取当前措施的所有子措施集合
                    var subItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(entity.ItemId);
                    if (subItemList != null && subItemList.Any())
                    {
                        //2.获取当前任务的待办列表
                        var smFlowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = entity.SmId });
                        //3.获取当前步骤和主办单位的待办
                        smFlowWaitingList = smFlowWaitingList.Where(m => m.StepId == "ZRCSCSFK" && m.FinishTime == null && m.TargetId == entity.TargetId).ToList();

                        BindSubItem(subItemList, rep, smFlowWaitingList);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 责任处室措施反馈--不可发送的措施绑定子措施集合
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater13_2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater rep = e.Item.FindControl("Repeater13_2_1") as Repeater;
                    SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;

                    //1.获取当前措施的所有子措施集合
                    var subItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(entity.ItemId);
                    if (subItemList != null && subItemList.Any())
                    {
                        //2.获取当前任务的待办列表
                        var smFlowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = entity.SmId });
                        //3.获取当前步骤和主办单位的待办
                        smFlowWaitingList = smFlowWaitingList.Where(m => m.StepId == "ZRCSCSFK" && m.FinishTime == null && m.TargetId == entity.TargetId).ToList();

                        BindSubItem(subItemList, rep, smFlowWaitingList);
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 主办单位任务反馈绑定措施
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater14_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater repCanOperate = e.Item.FindControl("Repeater14_1") as Repeater;
                    Repeater repOnlyView = e.Item.FindControl("Repeater14_2") as Repeater;
                    SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;

                    //获取当前主办单位的措施待办信息
                    var flowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = smid });
                    if (flowWaitingList != null && flowWaitingList.Any())
                    {
                        //获取当前步骤主办单位的待办信息
                        flowWaitingList = flowWaitingList.Where(m => m.TargetId == entity.LmmId && m.FlowDeptId == entity.DeptId && m.StepId == "ZBDWRWFK").ToList();
                    }
                    //获取当前待办信息
                    var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smid, FlowId = Convert.ToInt32(flowid) });
                    if (flowWaitingEntity != null)
                    {
                        //获取当前主办单位措施集合
                        var itemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(new SmTargetItemEntity() { SmId = smid, TargetId = entity.LmmId, ParentTargetItemId = null });
                        //当前待办的主办单位
                        if (entity.LmmId == flowWaitingEntity.TargetId && entity.DeptId == flowWaitingEntity.FlowDeptId)
                        {
                            //绑定当前待办主办单位的措施集合
                            BindSmTargetItemForPage10(itemList, repCanOperate, flowWaitingList);
                        }
                        else
                        {
                            //绑定非当前待办主办单位的措施集合
                            BindSmTargetItemForPage10(itemList, repOnlyView, flowWaitingList);
                        }
                    }

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 主办单位任务反馈绑定子措施
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater14_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater rep = e.Item.FindControl("Repeater14_1_1") as Repeater;
                    SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;

                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        ActivityFlag = 1,
                        ParentTargetItemId = entity.ItemId,
                        TargetId = entity.TargetId
                    };

                    LoadSmTargetItem(condition, rep);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 主办单位任务反馈绑定子措施
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater14_2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater rep = e.Item.FindControl("Repeater14_2_1") as Repeater;
                    SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;

                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        ActivityFlag = 1,
                        ParentTargetItemId = entity.ItemId,
                        TargetId = entity.TargetId
                    };

                    LoadSmTargetItem(condition, rep);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 办公厅任务反馈绑定措施
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater15_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater rep = e.Item.FindControl("Repeater15_1") as Repeater;
                    SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;

                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        ActivityFlag = 1,
                        ParentTargetItemId = null,
                        TargetId = entity.LmmId
                    };

                    LoadSmTargetItem(condition, rep);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 办公厅任务反馈绑定子措施
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater15_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                Repeater rep = e.Item.FindControl("Repeater15_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;

                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    ParentTargetItemId = entity.ItemId,
                    TargetId = entity.TargetId
                };

                LoadSmTargetItem(condition, rep);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 部门审批/部门审核绑定措施
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater17_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater rep = e.Item.FindControl("Repeater17_1") as Repeater;
                    SmLeaderMeetingMissionEntity entity = e.Item.DataItem as SmLeaderMeetingMissionEntity;

                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        ActivityFlag = 1,
                        ParentTargetItemId = null,
                        TargetId = entity.LmmId
                    };

                    LoadSmTargetItem(condition, rep);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        /// <summary>
        /// 部门审批/部门审核绑定子措施集合
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Repeater17_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                try
                {
                    Repeater rep = e.Item.FindControl("Repeater17_1_1") as Repeater;
                    SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;

                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        ActivityFlag = 1,
                        ParentTargetItemId = entity.ItemId,
                        TargetId = entity.TargetId
                    };

                    LoadSmTargetItem(condition, rep);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        #endregion
        
    }
}