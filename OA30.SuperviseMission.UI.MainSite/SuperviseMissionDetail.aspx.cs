using OA30.Common.Entity;
using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Entity.MissionBase;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.WebSiteInfo;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class SuperviseMissionDetail : BasePage
    {
        private ISuperviseMissionBasicData _BasicDataBiz;
        private ISuperviseMissionBasicData BasicDataBiz
        {
            get
            {
                if (_BasicDataBiz == null)
                {
                    AppRCObjectActivatorV2 ob = new AppRCObjectActivatorV2();
                    _BasicDataBiz = ob.CreateObject<ISuperviseMissionBasicData>();
                }
                return _BasicDataBiz;
            }
        }

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
        public int page
        {
            get; set;
        }
        private int[] _postfixOfTargetAndItems = { 0, 0, 0 };
        public uint TaskFinishPercent = 0;    // 任务进度。
        public string LastTaskOpinion = "";   // 任务反馈意见。
        #endregion

        #region 页面公共方法。
        /// <summary>
        /// 获取最近目标意见。
        /// </summary>
        /// <param name="targetId">目标Id。</param>
        /// <returns>返回最近目标意见。</returns>
        protected string GetLastOpinionByTargetId(string targetId)
        {
            if (String.IsNullOrEmpty(targetId)) return "";
            string lastOpinion = "";
            SmFlowFinishEntity ff = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.TargetId == targetId && e.Opinion != null && e.Opinion != ""&&(e.StepId== "ZBDWMBFK"||(e.StepId== "CSFK"&&(e.TargetItemId==""||e.TargetItemId==null)))).OrderByDescending(e => e.FlowId).FirstOrDefault();

            if (ff != null)
            {
                lastOpinion = Convert.ToDateTime(ff.FinishTime).ToString("yyyy-MM-dd")+":" + ff.Opinion;
            }

            return lastOpinion;
        }

        /// <summary>
        /// 获取最近措施意见。
        /// </summary>
        /// <param name="itemId">措施Id。</param>
        /// <param name="pageIndex">页面索引。</param>
        /// <returns>返回措施最近的意见。</returns>
        protected string GetLastOpinionByItemId(string itemId, int pageIndex)
        {
            if (String.IsNullOrEmpty(itemId)) return "";
            SmTargetItemEntity targetItem = SuperviseMissionBodyBiz.GetSmTargetItemEntity(itemId);
            if (targetItem == null) return "";

            pageIndex=pageIndex & 0x7FFFFFFF;
            // 获取已办的流程数据源。
            ICollection<SmFlowFinishEntity> finishSource=SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.TargetItemId == itemId).OrderByDescending(e => e.FlowId).ToList();
            // 获取待办的流程数据源。
            ICollection<SmFlowWaitingEntity> waitingSource = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.TargetItemId == itemId && e.AllowFlag == 1).OrderByDescending(e => e.FlowId).ToList();
            // 获取退回的流程数据源。
            ICollection<int?> backSource = finishSource.Where(e => e.AllowFlag == 0).Select(s => s.FlowIdPrev).ToList();
            ICollection<int?> backFlowIds = new List<int?>(backSource);
            foreach (int? item in backSource)
            {
                // 【责任处室措施推进】和【主办单位目标推进】需要特殊处理。
                var preStep =finishSource.Where(e => e.FlowId == item).FirstOrDefault();
                if (null != preStep)
                {
                    // 如果上一个步骤是【责任处室措施推进】或【主办单位目标推进】则表示已退回到初始状态。
                    if (finishSource.Where(e=>e.FlowId==preStep.FlowIdPrev&&(e.StepId== "ZRCSCSTJ"||e.StepId== "ZBDWMBTJ")).Count() >= 1)
                    {
                        backFlowIds.Add(preStep.FlowIdPrev);
                    }
                }
            }
            // 自由流不存在反馈措施/子措施的步骤。
            HashSet<String> notInStep = new HashSet<string>(new string[] { "BMSH", "BMSP", "MSCL" });
            // 自由流存在反馈措施/子措施的步骤。
            HashSet<String> inStep = new HashSet<string>(new string[] { "ZRCSCSTJ", "ZRDWCSFK", "CSFK","ZRCSCSFK", "ZCSFK" });
            SmFlowWaitingEntity fw = null;
            SmFlowFinishEntity ff = null;
            string lastOpinion = "";

            switch (pageIndex)
            {
                case 1:
                case 3:
                case 8:
                case 9:
                    foreach (var item in finishSource)
                    {
                        // 过滤掉退回的流程和指定步骤的意见。
                        if (!backFlowIds.Contains(Convert.ToInt32(item.FlowId))&& !String.IsNullOrEmpty(item.Opinion)&&item.AllowFlag == 1&&!notInStep.Contains(item.StepId)&&inStep.Contains(item.StepId))
                        {
                            ff = item;
                            break;
                        }
                    }
                    break;
                //case 13: 
                //case 14:
                case 15:
                //case 16:
                case 18:
                    // 措施/子措施不要取BMSH,BMSP,MSCL。
                    foreach (var item in waitingSource)
                    {
                        if (!String.IsNullOrEmpty(item.Opinion)&& !notInStep.Contains(item.StepId))
                        {
                            fw = item;
                            break;
                        }
                    }
                    break;
                case 10:
                    foreach (var item in waitingSource)
                    {
                        if (!String.IsNullOrEmpty(item.Opinion) && !notInStep.Contains(item.StepId) && item.StepId == "ZCSFK")
                        {
                            fw = item;
                            break;
                        }
                    }
                    break;
                case 11:
                    foreach (var item in waitingSource)
                    {
                        if (!String.IsNullOrEmpty(item.Opinion) && !notInStep.Contains(item.StepId) && (item.StepId == "CSFK" || item.StepId == "ZBDWMBTJ"))
                        {
                            fw = item;
                            break;
                        }
                    }

                    if (fw == null)
                    {
                        foreach (var item in finishSource)
                        {
                            if (!String.IsNullOrEmpty(item.Opinion) && item.AllowFlag == 1 && !notInStep.Contains(item.StepId) && (item.StepId == "CSFK" || item.StepId == "ZBDWMBTJ"))
                            {
                                ff = item;
                                break;
                            }
                        }
                    }
                    break;
                case 17:
                    foreach (var item in waitingSource)
                    {
                        if (!String.IsNullOrEmpty(item.Opinion) && !notInStep.Contains(item.StepId) && (item.StepId == "ZRDWCSFK" || item.StepId == "ZRCSCSTJ"))
                        {
                            fw = item;
                            break;
                        }
                    }

                    if (fw == null)
                    {
                        foreach (var item in finishSource)
                        {
                            if (!String.IsNullOrEmpty(item.Opinion) && item.AllowFlag == 1 && !notInStep.Contains(item.StepId) && (item.StepId == "ZRDWCSFK" || item.StepId == "ZRCSCSTJ"))
                            {
                                ff = item;
                                break;
                            }
                        }
                    }
                    break;
                default:
                    break;
            }

            if (fw != null)
            {
                lastOpinion = Convert.ToDateTime(fw.ReceiveTime).ToString("yyyy-MM-dd") +":" + fw.Opinion;
            }

            if (ff != null)
            {
                lastOpinion = Convert.ToDateTime(ff.FinishTime).ToString("yyyy-MM-dd") +":" + ff.Opinion;
            }

            return lastOpinion;
        }

        /// <summary>
        /// 获取最近部门审核/审批意见。
        /// </summary>
        /// <param name="itemId">子措施Id。</param>
        /// <returns></returns>
        public string GetLastAuditingOpinionByItemId(string itemId)
        {
            if (String.IsNullOrEmpty(itemId)) return "";
            string lastOpinion = "";
            SmFlowFinishEntity ff = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.TargetItemId == itemId && e.Opinion != null && e.Opinion != "" && (e.StepId == "BMSH" ||e.StepId == "BMSP"||e.StepId=="GSLDSH"||e.StepId=="GSLDSP")).OrderByDescending(e => e.FlowId).FirstOrDefault();

            if (ff != null)
            {
                lastOpinion = Convert.ToDateTime(ff.FinishTime).ToString("yyyy-MM-dd") + ":" + ff.Opinion;
            }

            return lastOpinion;
        }

        /// <summary>
        /// 获取指定目标Id是否是当前用户所在部门创建的或是否拥有该部门的角色。
        /// </summary>
        /// <param name="targetId">目标Id。</param>
        /// <returns>返回指定目标Id是否是当前用户所在部门创建的或是否拥有该部门的角色。</returns>
        protected bool IsSameDeptByTargetId(string targetId)
        {
            // 获取当前用户的流程部门Id(应该是指二级部门Id)。
            //string curUserFlowDeptId=SuperviseMissionWorkFlow.GetFlowDeptIdByDeptId(CurrentUserInfo.Dept_ID);
            var targetBean = SuperviseMissionBodyBiz.GetSmTargetEntity(new SmTargetEntity() { TargetId = targetId });
            // CreatorDeptId是创建人部门ID(可能保存的是三级部门ID)，MainDeptId是主办单位ID(保存是它的二级部门ID)。
            if (targetBean != null && (targetBean.CreatorDeptId == CurrentUserInfo.Dept_ID || targetBean.CreatorDeptId.StartsWith(CurrentUserInfo.Dept_ID))) return true;

            return false;
        }

        /// <summary>
        /// 获取指定措施Id是否是当前用户所在部门创建的或是否拥有该部门的角色。
        /// </summary>
        /// <param name="targetId">措施Id。</param>
        /// <returns>返回指定措施Id是否是当前用户所在部门创建的或是否拥有该部门的角色。</returns>
        protected bool IsSameDeptByItemId(string itemId)
        {
            var targetBean = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity() { ItemId = itemId });
            IEnumerable<SmBasicDataDeptRoleDefinitionEntity> roles = BasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                new SmBasicDataDeptRoleDefinitionEntity
                {
                    MemberId = CurrentUserInfo.Employee_ID,
                    RoleId = "MS"
                });

            if (roles == null || roles.Count() == 0) return false;
            if (null == targetBean) return false;

            foreach (var item in roles)
            {
                //if (targetBean.DutyDeptId == item.DeptId
                //    || targetBean.DutyDeptId.StartsWith(CurrentUserInfo.Dept_ID)
                //    || targetBean.DutyDeptId.StartsWith(item.DeptId))
                //    return true;
                if (targetBean.DutyDeptId == item.DeptId)
                    return true;
            }

            return false;
        }
        /// <summary>
        /// 获取当前用户是否拥有指定目标Id的主办单位的权限。
        /// </summary>
        /// <param name="targetId">目标Id。</param>
        /// <returns>返回是否拥有指定目标Id的主办单位的权限。</returns>
        protected bool IsMainDept(string targetId)
        {
            if (String.IsNullOrEmpty(targetId)) return false;
            // 先获取当前用户的部门角色信息。
            IEnumerable<SmBasicDataDeptRoleDefinitionEntity> roles = BasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity
                    {
                        MemberId = CurrentUserInfo.Employee_ID,
                        RoleId = "MS"
                    }
            );

            if (roles == null || roles.Count() == 0) return false;
            SmTargetEntity targetBean = SuperviseMissionBodyBiz.GetSmTargetEntity(new SmTargetEntity() { TargetId = targetId });
            if (targetBean == null) return false;
            foreach (var item in roles)
            {
                // 判断当前用户是否拥有该目标的主办单位的权限。
                if (null != roles.FirstOrDefault(e => e.DeptId == targetBean.MainDeptId)) return true;
            }

            return false;
        }
        /// <summary>
        /// 获取当前用户是否拥有指定目标Id的主办单位的权限。
        /// </summary>
        /// <param name="smid">主表Id。</param>
        /// <returns>返回主表单是否已经结束。</returns>
        protected bool IsSmMainJS(string smid)
        {
            if (String.IsNullOrEmpty(smid)) return true;
            var smMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity
            {
                SmId = smid
            });

            if (smMainEntity != null && smMainEntity.MissionStatus.ToUpper() == "JS")
            {
                return true;
            }

            return false;
        }
        /// <summary>
        /// 获取当前用户是否拥有指定措施Id的责任处室的权限。
        /// </summary>
        /// <param name="itemId">措施Id。</param>
        /// <returns>返回是否拥有指定措施Id的责任处室的权限。</returns>
        protected bool IsDutyDept(string itemId)
        {
            if (String.IsNullOrEmpty(itemId)) return false;
            // 先获取当前用户的部门角色信息。
            IEnumerable<SmBasicDataDeptRoleDefinitionEntity> roles = BasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity
                    {
                        MemberId = CurrentUserInfo.Employee_ID,
                        RoleId = "MS"
                    }
            );

            if (roles == null || roles.Count() == 0) return false;
            SmTargetItemEntity itemBean = SuperviseMissionBodyBiz.GetSmTargetItemEntity(itemId);
            if (itemBean == null) return false;
            foreach (var item in roles)
            {
                // 判断当前用户是否拥有该目标的主办单位的权限。
                if (null != roles.FirstOrDefault(e => e.DeptId == itemBean.DutyDeptId)) return true;
            }

            return false;
        }

        /// <summary>
        /// 判断当前用户是否责任人。
        /// </summary>
        /// <param name="excutorId">子措施责任人Id。</param>
        /// <returns>是否责任人。</returns>
        protected bool IsExcutor(string excutorId)
        {
            if (CurrentUserInfo.Employee_ID.Equals(excutorId))
            {
                return true;
            }

            return false;
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

        /// <summary>
        /// 获取目标、父措施、子措施自增序号。
        /// </summary>
        /// <param name="index">0-目标，1-父措施，2-子措施。</param>
        /// <returns>返回对应的目标、父措施、子措施的自增序号。</returns>
        protected int GetPostfix(int index)
        {
            if (index < 0 || index >= _postfixOfTargetAndItems.Length) return 0;
            for (int i = index + 1; i < _postfixOfTargetAndItems.Length; i++) _postfixOfTargetAndItems[i] = 0;
            return ++_postfixOfTargetAndItems[index];
        }
        /// <summary>
        /// 获取指定措施Id的待办流程Id(默认步骤为ZRDWCSFK或ZRCSCSTJ)。
        /// </summary>
        /// <param name="itemId">措施Id。</param>
        /// <returns>返回当前用户指定的措施Id在待办的流程Id。</returns>
        protected virtual string GetWaitingFlowIdByItemId(string itemId)
        {
            // 说明：如果没有在待办表找到对应的FlowId则此措施可能被处理，此时需要考虑禁用前台的"保存"按钮？
            if (String.IsNullOrEmpty(itemId)) return "";
            IEnumerable<SmFlowWaitingEntity> en = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.TargetItemId == itemId && e.ActivityFlag == 1 && e.UserId == CurrentUserInfo.Employee_ID && (e.StepId == "ZRDWCSFK" || e.StepId == "ZRCSCSTJ"));
            if (en != null && null != en.FirstOrDefault())
                return en.FirstOrDefault().FlowId.ToString();

            return "";
        }
        /// <summary>
        /// 获取指定措施Id和步骤的待办流程Id。
        /// </summary>
        /// <param name="itemId">措施Id。</param>
        /// <param name="stepId">步骤Id。</param>
        /// <returns>返回当前用户指定的措施Id和步骤在待办的流程Id。</returns>
        protected string GetWaitingFlowIdByItemId(string itemId, string stepId)
        {
            if (String.IsNullOrEmpty(itemId)) return "";
            IEnumerable<SmFlowWaitingEntity> en = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.TargetItemId == itemId && e.ActivityFlag == 1 && e.UserId == CurrentUserInfo.Employee_ID && e.StepId == stepId);
            if (en != null && null != en.FirstOrDefault())
                return en.FirstOrDefault().FlowId.ToString();

            return "";
        }
        /// <summary>
        /// 获取指定措施Id和步骤的待办流程Id(针对特殊流程，例如，CSFK和ZRDWCSFK是保留待办的)。
        /// </summary>
        /// <param name="itemId">措施Id。</param>
        /// <param name="stepId1">步骤1Id。</param>
        /// <param name="stepId2">步骤2Id。</param>
        /// <returns>返回当前用户指定的措施Id和步骤在待办的流程Id。</returns>
        protected string GetWaitingFlowIdByItemId(string itemId, string stepId1, string stepId2)
        {
            if (String.IsNullOrEmpty(itemId)) return "";
            IEnumerable<SmFlowWaitingEntity> en = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.TargetItemId == itemId && e.ActivityFlag == 1 && e.UserId == CurrentUserInfo.Employee_ID && (e.StepId == stepId1 || e.StepId == stepId2));
            if (en != null && null != en.FirstOrDefault())
                return en.FirstOrDefault().FlowId.ToString();
            return "";
        }
        /// <summary>
        /// 获取父措施的任意子措施的待办FlowId。
        /// </summary>
        /// <param name="parentItemId">父措施id</param>
        /// <returns></returns>
        protected string GetWaitingFlowIdByParentItemId(string parentItemId, int pageIndex)
        {
            // 先获取父措施下面的子措施。
            var childItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(parentItemId);
            string flowId = "";

            if (pageIndex == 9)
            {
                foreach (var item in childItems)
                {
                    var t = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == smid && e.ActivityFlag == 1 && e.StepId == "ZRCSCSFK" && e.TargetItemId == item.ItemId).FirstOrDefault();
                    if (t != null)
                    {
                        flowId = t.FlowId.ToString();
                        break;
                    }
                }
            }

            return flowId;
        }

        /// <summary>
        /// 获取指定目标Id和步骤的待办流程Id。
        /// </summary>
        /// <param name="itemId">目标Id。</param>
        /// <param name="stepId">步骤Id。</param>
        /// <returns>返回当前用户指定的目标Id和步骤在待办的流程Id。</returns>
        protected string GetWaitingFlowIdByTargetId(string targetId, string stepId)
        {
            if (String.IsNullOrEmpty(targetId)) return "";
            IEnumerable<SmFlowWaitingEntity> en = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.TargetId == targetId && e.ActivityFlag == 1 && e.UserId == CurrentUserInfo.Employee_ID && e.StepId == stepId);
            if (en != null && null != en.FirstOrDefault())
                return en.FirstOrDefault().FlowId.ToString();

            return "";
        }

        /// <summary>
        /// 获取指定措施在待办的完成进度。
        /// </summary>
        /// <param name="itemId">措施Id。</param>
        /// <returns>返回措施在待办的完成进度。</returns>
        protected string GetWaitingFinishPercentByItemId(string itemId)
        {
            if (String.IsNullOrEmpty(itemId)) return "";
            string retVal = "";
            // 首先从待办获取自己的完成进度。
            IEnumerable<SmFlowWaitingEntity> en = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.TargetItemId == itemId && e.ActivityFlag == 1 && e.FinishPercent > 0 && e.UserId == CurrentUserInfo.Employee_ID).OrderByDescending(e => e.FlowId);
            if (en != null && null != en.FirstOrDefault())
            {
                retVal = en.FirstOrDefault().FinishPercent.ToString();
            }
            else
            {
                // 如果待办没有，则取已办的完成进度。
                IEnumerable<SmFlowFinishEntity> en2 = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.TargetItemId == itemId && e.ActivityFlag == 1 && e.FinishPercent > 0).OrderByDescending(e => e.FlowId);
                if (en2 != null && null != en2.FirstOrDefault())
                    retVal = en2.FirstOrDefault().FinishPercent.ToString();
            }

            return String.IsNullOrEmpty(retVal) ? "" : retVal;
        }

        /// <summary>
        /// 指定父措施Id的子措施是否已全部反馈(【责任处室措施反馈】)。
        /// </summary>
        /// <param name="parentItemId"></param>
        /// <returns></returns>
        public bool IsSubmitAllChildItem(string parentItemId)
        {
            if (String.IsNullOrEmpty(parentItemId)) return false;

            List<SmTargetItemEntity> childItems=SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(parentItemId);
            if (childItems == null || childItems.Count == 0) return false;
            var source=SuperviseMissionBodyBiz.GetSmFlowWaitingList(e =>e.TargetId==childItems[0].TargetId && e.StepId == "ZRCSCSFK" && e.UserId == CurrentUserInfo.Employee_ID);

            if (source != null && source.Any())
            {
               var temp=source.ToList();
               return temp.Where(e => childItems.Any(p => p.ItemId == e.TargetItemId)).Count() == childItems.Count;
            }

            return false;
        }

        /// <summary>
        /// 指定目标Id的措施是否已全部反馈(【主办单位目标反馈】)。
        /// </summary>
        /// <param name="targetId"></param>
        /// <returns></returns>
        public bool IsSubmitAllItem(string targetId)
        {
            if (String.IsNullOrEmpty(targetId)) return false;

            List<SmTargetItemEntity> parentItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByTargetId(targetId, false);
            if (parentItems == null || parentItems.Count == 0) return false;
            var source = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.TargetId == parentItems[0].TargetId && e.StepId == "ZBDWMBFK"&&e.UserId==CurrentUserInfo.Employee_ID);

            if (source != null && source.Any())
            {
                var temp = source.ToList();
                return temp.Where(e => parentItems.Any(p => p.ItemId == e.TargetItemId)).Count() == parentItems.Count;
            }

            return false;
        }

        /// <summary>
        /// 查看当前smid的目标是否已全部反馈(【办公厅任务反馈】)。
        /// </summary>
        /// <returns></returns>
        public bool IsSubmitAllTarget()
        {
            if (String.IsNullOrEmpty(smid)) return false;
            List<SmTargetEntity> targets = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(smid);
            if (targets == null || targets.Count == 0) return false;
            var source = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == smid && e.StepId == "BGTRWFK" && e.UserId == CurrentUserInfo.Employee_ID);
            return source != null && source.Count() == targets.Count;
        }

        /// <summary>
        /// 判断是不是已办。
        /// </summary>
        /// <returns></returns>
        public bool IsYiBan()
        {
            return !String.IsNullOrEmpty(flowid) && !String.IsNullOrEmpty(smid);
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (flowid == "1" || stepid == "NG")
            {
                // 拟稿时未成功发起流程，现重定向到拟稿页面。
                Response.Redirect("NewYear.aspx?smtype=ND&PageType=NewPage");
                Response.End();
            }

            SetPageInt();
            if (!IsPostBack)
            {
                LoadDetail();
                int result = 0;
                if (int.TryParse(flowid, out result))
                {
                    try
                    {
                        SuperviseMissionWorkFlow.Read(smid, result);
                    }
                    catch { }
                }
            }
        }

        /// <summary>
        /// 设置StepId对应的Page。
        /// </summary>
        private void SetPageInt()
        {
            try
            {
                switch (stepid)
                {
                    case "BGTMBQR":
                        {
                            //办公厅目标确认
                            page = 2; break;
                        }
                    //case "BGTCL":
                    //    {
                    //        //办公厅处理
                    //        page = 3; break;
                    //    }
                    case "BGTRWFK":
                        {
                            // 办公厅任务反馈
                            page = 3;
                            break;
                        }
                    case "GDLSP":
                        {
                            //固定流审批
                            page = 4; break;
                        }
                    case "GDLSH":
                        {
                            //固定流审核
                            page = 4; break;
                        }
                    case "ZBDWMBFK":
                        {
                            //主办单位目标反馈
                            page = 8; break;
                        }
                    case "ZRCSCSFK":
                        {
                            // 责任处室措施反馈。
                            page = 9;
                            break;
                        }
                    //case "ZRCSSHZCS":
                    //    {
                    //        //责任处室审核子措施
                    //        page = 9;
                    //        break;
                    //    }
                    //case "ZCSCL":
                    //    {
                    //        //子措施处理
                    //        page = 10;
                    //        break;
                    //    }
                    case "ZCSFK":
                        {
                            //子措施反馈
                            page = 10;
                            break;
                        }
                    case "CSFK":
                        {
                            //措施反馈 直接向上反馈
                            page = 11;
                            break;
                        }
                    case "ZBDWMBFJ":
                        {
                            //主办单位目标分解 
                            page = 12;
                            break;
                        }
                    case "ZRCSFJZCS":
                        {
                            //责任处室分解子措施 
                            page = 13;
                            break;
                        }
                    case "ZBDWMBTJ":
                        {
                            page = 14;
                            break;
                        }
                    case "BMSH":// 部门审核。
                    case "BMSP":// 部门审批。
                        {
                            page = 15;
                            break;
                        }
                    case "ZRCSCSTJ":
                        {
                            // 责任处室措施推进。
                            page = 16;
                            break;
                        }
                    //case "ZRCSCSFK":
                    //    {
                    //        // 责任处室措施反馈。
                    //        page = 17;
                    //        break;
                    //    }
                    case "ZRDWCSFK":
                        {
                            // 责任单位措施反馈。
                            page = 17;
                            break;
                        }
                    case "MSCL":
                        {
                            // 秘书处理。
                            page = 18;
                            break;
                        }
                    case "GSLDSH":// 公司领导审核
                    case "GSLDSP":// 公司领导审批。
                        {
                            page = 19;
                            break;
                        }
                    default:
                        {
                            //默认返回只能查看的页面
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
        //获取详情数据在页面展示
        private void LoadDetail()
        {
            //1.获取主表详情
            LoadSmMain();
            //2.获取目标表信息
            switch (page)
            {
                case 1:
                    {
                        LoadSmTarget(Repeater1);
                        break;
                    }
                case 2:
                    {
                        //LoadSmTarget(Repeater2);
                        BindTargetWithPage2(Repeater2);
                        break;
                    }
                case 3:
                    {
                        LoadSmTarget(Repeater3);
                        break;
                    }
                case 4:
                    {
                        LoadSmTarget(Repeater4);
                        break;
                    }
                case 8:
                    {
                        LoadSmTarget(Repeater8);
                        break;
                    }
                case 9:
                    {
                        LoadSmTarget(Repeater9);
                        break;
                    }
                case 10:
                    {
                        LoadSmTarget(Repeater10);
                        break;
                    }
                case 11:
                    {
                        LoadSmTarget(Repeater11);
                        break;
                    }
                case 13:
                    {
                        LoadSmTarget(Repeater13);
                        break;
                    }
                case 14:
                    {
                        LoadSmTarget(Repeater14);
                        break;
                    }
                case 15:
                    {
                        LoadSmTarget(Repeater15);
                        break;
                    }
                case 16:
                    {
                        LoadSmTarget(Repeater16);
                        break;
                    }
                case 17:
                    {
                        LoadSmTarget(Repeater17);
                        break;
                    }
                case 18:
                    {
                        LoadSmTarget(Repeater18);
                        break;
                    }
                case 19:
                    {
                        LoadSmTarget(Repeater19);
                        break;
                    }
                default: break;
            }

        }

        #region 年度目标、措施和子措施绑定输出的序列号

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

        #region 子措施处理相关

        /// <summary>
        /// 绑定page10页面的措施与子措施
        /// </summary>
        /// <param name="list">子措施。</param>
        /// <param name="rp">子措施Repeater控件。</param>
        /// <param name="smFlowFinishList">已办表。</param>
        /// <param name="smFlowWaitingList">待办表。</param>
        private void BindSmTargetItemForPage10(List<SmTargetItemEntity> list, Repeater rp, List<SmFlowItemBaseEntity> smFlowFinishList, List<SmFlowItemBaseEntity> smFlowWaitingList)
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
                tempEntity.Opinion = GetLastOpinionByItemId(item.ItemId, 10);
                var fw = smFlowWaitingList.Where(e => e.TargetItemId == item.ItemId && e.StepId == "ZCSFK");

                if (fw != null)
                {
                    var temp = fw.FirstOrDefault();
                    if (null != temp) tempEntity.FlowId = temp.FlowId.ToString();
                }

                index++;
                listForBind.Add(tempEntity);
            }

            rp.DataSource = listForBind;
            rp.DataBind();
        }

        #endregion

        #region 措施反馈相关

        protected void Repeater11_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater11_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                var list = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
                //获取待办列表
                var SmFlowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = entity.SmId });
                BindSmTargetItemForPage11(list, rep, SmFlowWaitingList);
            }
        }

        /// <summary>
        /// 绑定page11页面的措施
        /// </summary>
        /// <param name="list"></param>
        /// <param name="rp"></param>
        /// <param name="flowWaitingList"></param>
        private void BindSmTargetItemForPage11(List<SmTargetItemEntity> list, Repeater rp, List<SmFlowItemBaseEntity> flowWaitingList)
        {
            var listForBind = new List<MeasureResponseEntity>();
            MeasureResponseEntity tempEntity = null;

            int index = 0;

            foreach (var item in list)
            {
                tempEntity = new MeasureResponseEntity();
                tempEntity.AssistDeptName = item.AssistDeptName;
                tempEntity.ItemId = item.ItemId;
                tempEntity.ItemName = item.ItemName;
                tempEntity.DeadLineTime = item.DeadLineTime;
                tempEntity.ExcutorName = item.ExcutorName;
                tempEntity.TargetId = item.TargetId;
                tempEntity.DutyDeptName = item.DutyDeptName;
                tempEntity.MeasureDetailIdIndex = "Detail" + item.ItemId + "_" + index;

                string temp = GetWaitingFinishPercentByItemId(Convert.ToString(item.ItemId));
                if (String.IsNullOrEmpty(temp)) tempEntity.FinshPercent = null;
                else tempEntity.FinshPercent = Convert.ToInt32(temp);
                tempEntity.Opinion = GetLastOpinionByItemId(item.ItemId, 11);
                tempEntity.FlowId = GetWaitingFlowIdByItemId(item.ItemId, "ZBDWMBTJ", "CSFK");
                index++;
                listForBind.Add(tempEntity);
            }

            rp.DataSource = listForBind;
            rp.DataBind();
        }

        #endregion

        #region 责任处室分解子措施相关

        protected void Repeater13_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater13_1") as Repeater;
                Repeater repOnlyView = e.Item.FindControl("Repeater13_2") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                try
                {
                    //根据当前flowid获取责任处室ID
                    var flowid = int.Parse(Request.QueryString["flowid"]);
                    var SmFlowItem = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity() { SmId = entity.SmId, FlowId = flowid });
                    SmTargetItemEntity condition = new SmTargetItemEntity()
                    {
                        TargetId = entity.TargetId,
                        ActivityFlag = 1,
                        SmId = smid,
                        DutyDeptId = SmFlowItem.FlowDeptId,
                        ParentTargetItemId = null,
                    };
                    //绑定可分解子措施的措施集合
                    LoadSmTargetItem(condition, rep);

                    #region 绑定不可分解子措施的措施

                    var tempList = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(new SmTargetItemEntity() { TargetId = entity.TargetId, ActivityFlag = 1, SmId = smid, ParentTargetItemId = null, });
                    if (tempList.Any())
                    {
                        var listForOnlyView = tempList.Where(m => m.DutyDeptId != SmFlowItem.FlowDeptId).ToList();
                        repOnlyView.DataSource = listForOnlyView;
                        repOnlyView.DataBind();
                    }

                    #endregion
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        protected void Repeater13_2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater13_2_2") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    SmId = smid
                };
                LoadSmTargetItem(condition, rep);
            }
        }
        #endregion

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
                if (null == entity) return;
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
                //throw ex;
            }
        }

        private void LoadSmTarget(Repeater rp)
        {
            try
            {
                SmTargetEntity condition = new SmTargetEntity()
                {
                    SmId = smid,
                    ActivityFlag = 1
                };
                List<SmTargetEntity> entitys = SuperviseMissionBodyBiz.GetSmTargetEntityList(condition);
                rp.DataSource = entitys;
                rp.DataBind();

                if (page == 19)
                {
                   TaskFinishPercent=Convert.ToUInt32(SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smid }).FinshPercent);
                   var ff=SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId == smid && e.StepId == "BGTRWFK" && e.Opinion != null && e.Opinion != "" && e.AllowFlag == 1).FirstOrDefault();
                   if (null != ff) LastTaskOpinion = ff.Opinion; 
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 绑定年度目标只适用于“办公厅目标确认”步骤。
        /// </summary>
        /// <param name="repeater"></param>
        private void BindTargetWithPage2(Repeater repeater)
        {
            try
            {
                // 1)获取指定smid的年度目标。
                List<SmTargetEntity> targets = SuperviseMissionBodyBiz.GetSmTargetEntityList(new SmTargetEntity() { SmId = smid, ActivityFlag = 1 });
                ICollection<SmTargetEntity> source = null;
                // 2)获取BGTMBQR步骤的待办。
                var fw = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == smid && e.StepId == "BGTMBQR");
                if (targets != null && fw != null)
                {
                    source = new List<SmTargetEntity>();
                    foreach (var item in targets)
                    {
                        // 只添加固定流审批通过的目标。
                        var t = fw.Where(e => e.FlowDeptIdPrev == item.MainDeptId);
                        if (t != null && t.Any()) source.Add(item);
                    }
                }
                repeater.DataSource = source;
                repeater.DataBind();
            }
            catch (Exception ex)
            {
                //throw ex;
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

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater1_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
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
                    ActivityFlag = 1,
                    SmId = smid
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
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
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
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    SmId = smid
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater3_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater3_3") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
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
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    SmId = smid
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater4_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater4_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater8_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater8_8") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater8_8_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater8_8_8") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    SmId = smid
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater9_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater9_9") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater9_9_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater9_9_9") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    SmId = smid
                };
                LoadSmTargetItem(condition, rep);
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
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater10_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    Repeater repCanOperate = e.Item.FindControl("Repeater10_1_1") as Repeater;
                    Repeater repOnlyView = e.Item.FindControl("Repeater10_1_2") as Repeater;
                    SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;

                    //绑定可操作的子措施
                    SmTargetItemEntity conditionCanOperate = new SmTargetItemEntity()
                    {
                        ParentTargetItemId = entity.ItemId,
                        ActivityFlag = 1,
                        SmId = smid,
                        ExcutorId = CurrentUserInfo.Employee_ID
                    };
                    List<SmTargetItemEntity> listForCanOperate = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(conditionCanOperate);
                    //获取待办列表
                    var SmFlowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = entity.SmId, TargetId = entity.TargetId });
                    //获取已办列表
                    var SmFlowFinishList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowFinishEntity() { SmId = entity.SmId, TargetId = entity.TargetId });
                    try
                    {
                        BindSmTargetItemForPage10(listForCanOperate, repCanOperate, SmFlowFinishList, SmFlowWaitingList);
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }


                    try
                    {
                        //绑定只允许查看的子措施
                        var tempList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(entity.ItemId);
                        if (tempList.Any())
                        {
                            var listForOnlyView = tempList.Where(m => m.ExcutorId != CurrentUserInfo.Employee_ID).ToList();

                            BindSmTargetItemForPage10(listForOnlyView, repOnlyView, SmFlowFinishList, SmFlowWaitingList);
                        }
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void Repeater14_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater14_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater15_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater15_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
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
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    SmId = smid
                };

                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater16_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater16_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater17_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater17_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater18_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater18_1") as Repeater;
                SmTargetEntity entity = e.Item.DataItem as SmTargetEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    TargetId = entity.TargetId,
                    ActivityFlag = 1,
                    SmId = smid,
                    ParentTargetItemId = null,
                };
                LoadSmTargetItem(condition, rep);
            }
        }

        protected void Repeater18_1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rep = e.Item.FindControl("Repeater18_1_1") as Repeater;
                SmTargetItemEntity entity = e.Item.DataItem as SmTargetItemEntity;
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ParentTargetItemId = entity.ItemId,
                    ActivityFlag = 1,
                    SmId = smid
                };

                LoadSmTargetItem(condition, rep);
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
    }
}