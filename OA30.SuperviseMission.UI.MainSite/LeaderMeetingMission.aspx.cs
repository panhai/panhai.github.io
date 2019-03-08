using System;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System.Web.Services;
using OA30.SuperviseMission.UI.CommonComponents;
using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.Common.Entity.MissionBase;
using OA30.SuperviseMission.Common.Entity.Mission.Enum;
using System.Collections.Generic;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class LeaderMeetingMission : BasePage
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

        #region 属性
        private AppRCObjectActivatorV2 objCreator = new AppRCObjectActivatorV2();

        private ISuperviseMissionBasicData _SMBasicDataBiz = null;
        private ISuperviseMissionBasicData SMBasicDataBiz
        {
            get
            {
                if (_SMBasicDataBiz == null)
                {
                    _SMBasicDataBiz = objCreator.CreateObject<ISuperviseMissionBasicData>();
                }
                return _SMBasicDataBiz;
            }
        }

        private ISuperviseMissionWorkFlow _SMWorkFlow = null;
        private ISuperviseMissionWorkFlow SMWorkFlow
        {
            get
            {
                if (_SMWorkFlow == null)
                {
                    _SMWorkFlow = objCreator.CreateObject<ISuperviseMissionWorkFlow>();
                }
                return _SMWorkFlow;
            }
        }


        private ISuperviseMissionBody _SuperviseMissionBodyBiz;
        private ISuperviseMissionBody SuperviseMissionBodyBiz
        {
            get
            {
                if (_SuperviseMissionBodyBiz == null)
                {
                    _SuperviseMissionBodyBiz = objCreator.CreateObject<ISuperviseMissionBody>();
                }
                return _SuperviseMissionBodyBiz;
            }
        }
        #endregion

        #region 变量

        private string SmType
        {
            get
            {
                string smType = Request.QueryString["smtype"];
                if (string.IsNullOrEmpty(smType))
                {
                    throw new Exception("smType关键参数不能为空");
                }
                return smType;
            }
        }

        protected string LbHeader
        {
            get
            {
                string str = "未知任务类型";
                if (SmType == "LD")
                {
                    str = "新建领导行政例会督查任务";
                }
                return str;
            }
        }

        #endregion

        #region 日志

        private void AddBasicDataErrorLog(string content)
        {
            UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
            {
                Content = content,
                ErrorType = (int?)ErrorTypeEnumEntity.UI,
                ErrorTypeName = ErrorTypeEnumEntity.UI.ToString(),
                LayerName = LayerTypeEnumEntity.UI.ToString(),
                LayerType = (int?)LayerTypeEnumEntity.UI,
                ModuleName = ModuleTypeEnumEntity.BasicData.ToString(),
                ModuleType = (int?)ModuleTypeEnumEntity.BasicData,
                OpreateTime = DateTime.Now,
                OpreatorDeptId = CurrentUserInfo.Dept_ID,
                OpreatorDeptName = CurrentUserInfo.Dept_Name,
                OpreatorId = CurrentUserInfo.Employee_ID,
                OpreatorIp = CurrentUserInfo.IP,
                OpreatorName = CurrentUserInfo.Name
            });
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtSave_Click(object sender, EventArgs e)
        {
            //var leaderMeetingMissionListJson = leaderMeetingMissionList.Value;
            //var leaderMeetingMissions = JsonHelper.JonsToList<LeaderMeetingMissionViewModel>(leaderMeetingMissionListJson);
            //if (leaderMeetingMissions.Count > 0)
            //{
            //    if (!CheckInput(leaderMeetingMissions))
            //    {
            //        return;
            //    }

            //    foreach (var leaderMeetingMission in leaderMeetingMissions)
            //    {
            //        try
            //        {
            //            //根据客户端传递过来的数据获取SpNumber对象,并验证是否存在此对象。
            //            var smBasicDataSuperviseNumberEntity = new SmBasicDataSuperviseNumberEntity
            //            {
            //                Name = leaderMeetingMission.snName,
            //                Year = leaderMeetingMission.snYear,
            //                DeptId = leaderMeetingMission.snDeptId
            //            };
            //            var spNumber = SMBasicDataBiz.GetSuperviseNumberEntity(smBasicDataSuperviseNumberEntity);
            //            var code = SuperviseMissionBodyBiz.GetNewSuperviseNumber(smBasicDataSuperviseNumberEntity);
            //            SmMainEntity sme = new SmMainEntity();
            //            sme.SmId = "";
            //            sme.ActivityFlag = 1;
            //            sme.SmType = SmType;
            //            sme.Title = "这个不知道干嘛的" + DateTime.Now.ToString();
            //            //sme.WorkFlowId = "DEFAULT";
            //            sme.CreatorId = CurrentUserInfo.Employee_ID;
            //            sme.CreatorName = CurrentUserInfo.Name;
            //            sme.CreatorDeptId = CurrentUserInfo.Dept_ID;
            //            sme.CreatorDeptName = CurrentUserInfo.Dept_Name;
            //            sme.CreateTime = DateTime.Now;
            //            sme.SpNumberName = spNumber.Name;
            //            sme.SpNumberYear = spNumber.Year.ToString();
            //            sme.SpNumberCode = code;
            //            sme.TaskContent = leaderMeetingMission.snText.Trim();
            //            sme.MainLeaderId = "";
            //            sme.MainLeaderName = "";
            //            sme.MainDeptId = leaderMeetingMission.snCompanyIds;
            //            sme.MainDeptName = leaderMeetingMission.snCompany;
            //            sme.AssistDeptId = leaderMeetingMission.snOtherCompanyIds;
            //            sme.AssistDeptName = leaderMeetingMission.snOtherCompany;
            //            sme.DeadLineTime = leaderMeetingMission.snEndTime;
            //            sme.StartTime = leaderMeetingMission.snStartTime;
            //            SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
            //            sfwe.UserId = CurrentUserInfo.Employee_ID;
            //            sfwe.UserName = CurrentUserInfo.Name;
            //            sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
            //            sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
            //            sfwe.Opinion = "";
            //            sfwe.OpinionType = "4";
            //            sfwe.UserIdPrev = "";
            //            sfwe.UserNamePrev = "";
            //            sfwe.SmType = SmType;
            //            sfwe.AllowFlag = 1;
            //            //SMWorkFlow.SaveSmMainForFirstTime(sme, sfwe);
            //            SMWorkFlow.Send(sme, sfwe, new SmFlowWaitingEntity());
            //            AlertAndClosePage(this, "创建成功", true);
            //        }
            //        catch (Exception exception)
            //        {
            //            AddBasicDataErrorLog(exception.StackTrace);
            //            AlertAndClosePage(this, exception.Message, false);
            //        }
            //    }

            //}
            //else
            //{
            //    AlertAndClosePage(this, "请先添加至少一个任务", false);
            //}
        }

        /// <summary>
        /// 多个任务非空性检查
        /// </summary>
        /// <param name="leaderMeetingMissions"></param>
        /// <returns></returns>
        private bool CheckInput(List<LeaderMeetingMissionViewModel> leaderMeetingMissions)
        {
            #region 循环遍历，确保所有任务不存在空数据

            foreach (var leaderMeetingMission in leaderMeetingMissions)
            {
                if (string.IsNullOrEmpty(leaderMeetingMission.snCompany.Trim())
                        || string.IsNullOrEmpty(leaderMeetingMission.snCompanyIds.Trim())
                        || string.IsNullOrEmpty(leaderMeetingMission.snOtherCompany.Trim())
                        || string.IsNullOrEmpty(leaderMeetingMission.snOtherCompanyIds.Trim())
                        || string.IsNullOrEmpty(leaderMeetingMission.snDeptId.Trim())
                        || string.IsNullOrEmpty(leaderMeetingMission.snName.Trim())
                        || string.IsNullOrEmpty(leaderMeetingMission.snText.Trim())
                        || leaderMeetingMission.snEndTime == null
                        || leaderMeetingMission.snStartTime == null)
                {
                    string strMsg = leaderMeetingMission.snText + "里面含有空元素，请核对后再提交。";
                    AddBasicDataErrorLog(strMsg);
                    AlertAndClosePage(this, strMsg, false);
                    return false;
                }

                //根据客户端传递过来的数据获取SpNumber对象,并验证是否存在此对象。
                var smBasicDataSuperviseNumberEntity = new SmBasicDataSuperviseNumberEntity
                {
                    Name = leaderMeetingMission.snName,
                    Year = leaderMeetingMission.snYear,
                    DeptId = leaderMeetingMission.snDeptId
                };
                var spNumber = SMBasicDataBiz.GetSuperviseNumberEntity(smBasicDataSuperviseNumberEntity);
                if (spNumber == null)
                {
                    string strMsg = "无法查询到督查编号名为：" + leaderMeetingMission.snName + "年号为：" + leaderMeetingMission.snYear + "的数据";
                    AddBasicDataErrorLog(strMsg);
                    AlertAndClosePage(this, strMsg, false);
                    return false;
                }
            }

            return true;

            #endregion
        }
    }
}