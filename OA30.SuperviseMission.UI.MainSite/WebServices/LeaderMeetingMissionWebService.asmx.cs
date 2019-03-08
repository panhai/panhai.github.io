using OA30.Common.Entity;
using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Entity.Mission.Enum;
using OA30.SuperviseMission.Common.Entity.MissionBase;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.CommonComponents;
using OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys;
using OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys;
using OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace OA30.SuperviseMission.UI.MainSite.WebServices
{
    /// <summary>
    /// LeaderMeetingMissionWebService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class LeaderMeetingMissionWebService : BaseWebService
    {
        #region 变量

        /// <summary>
        /// 意见、退回理由最大输入长度
        /// </summary>
        private static int _OPINION_MAX_LENGTH = 1000;
        /// <summary>
        /// 任务反馈内容最大输入长度
        /// </summary>
        private static int _MISSION_FEEDBACK_MAX_LENGTH = 1000;
        /// <summary>
        /// 主办单位反馈内容最大输入长度
        /// </summary>
        private static int _HOST_DEPT_FEEDBACK_MAX_LENGTH = 1000;
        /// <summary>
        /// 措施反馈内容最大输入长度
        /// </summary>
        private static int _MEASURE_FEEDBACK_MAX_LENGTH = 500;
        /// <summary>
        /// 子措施反馈内容最大输入长度
        /// </summary>
        private static int _SUB_MEASURE_FEEDBACK_MAX_LENGTH = 100;

        #endregion

        #region 拟稿

        /// <summary>
        /// 领导行政例会督查任务保存拟稿数据
        /// </summary>
        /// <param name="leaderMeetingMissions"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SaveNGData(string smType, List<LeaderMeetingMissionRequestEntity> leaderMeetingMissions)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion
                if (leaderMeetingMissions != null && leaderMeetingMissions.Any())
                {
                    #region 循环遍历，确保所有任务不存在空数据

                    string strMsg = "";
                    bool flag = false;
                    foreach (var leaderMeetingMission in leaderMeetingMissions)
                    {
                        if (string.IsNullOrEmpty(leaderMeetingMission.snCompany.Trim())
                                || string.IsNullOrEmpty(leaderMeetingMission.snCompanyIds.Trim())
                                || string.IsNullOrEmpty(leaderMeetingMission.snDeptId.Trim())
                                || string.IsNullOrEmpty(leaderMeetingMission.snName.Trim())
                                || string.IsNullOrEmpty(leaderMeetingMission.snText.Trim())
                                || leaderMeetingMission.snStartTime == DateTime.Parse("0001/1/1"))
                        {
                            strMsg = "任务【" + leaderMeetingMission.snText + "】里面含有空元素，请核对后再提交。";
                            flag = true;
                            break;
                        }
                        if (leaderMeetingMission.snText.Length > 400)
                        {
                            strMsg = "任务【" + leaderMeetingMission.snText + "】内容最大长度不能超过400个字符。";
                            flag = true;
                            break;
                        }

                        if (leaderMeetingMission.snStartTime != DateTime.Parse("0001/1/1") && leaderMeetingMission.snEndTime != DateTime.Parse("0001/1/1"))
                        {
                            if (leaderMeetingMission.snStartTime >= leaderMeetingMission.snEndTime)
                            {
                                strMsg = "任务【" + leaderMeetingMission.snText + "】启动时间不能大于完成时间。";
                                flag = true;
                                break;
                            }
                        }

                        //根据客户端传递过来的数据获取SpNumber对象,并验证是否存在此对象。
                        var smBasicDataSuperviseNumberEntity = new SmBasicDataSuperviseNumberEntity
                        {
                            Name = leaderMeetingMission.snName.Trim(),
                            Year = leaderMeetingMission.snYear,
                            DeptId = leaderMeetingMission.snDeptId.Trim()
                        };
                        var spNumber = SMBasicDataBiz.GetSuperviseNumberEntity(smBasicDataSuperviseNumberEntity);
                        if (spNumber == null)
                        {
                            strMsg = "无法查询到督查编号名为：" + leaderMeetingMission.snName + "年号为：" + leaderMeetingMission.snYear + "的数据";
                            flag = true;
                            break;
                        }
                    }
                    if (flag)
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "0",
                            message = "保存失败：" + strMsg
                        };
                    }

                    #endregion

                    foreach (var leaderMeetingMission in leaderMeetingMissions)
                    {
                        //根据客户端传递过来的数据获取SpNumber对象,并验证是否存在此对象。
                        var smBasicDataSuperviseNumberEntity = new SmBasicDataSuperviseNumberEntity
                        {
                            Name = leaderMeetingMission.snName.Trim(),
                            Year = leaderMeetingMission.snYear,
                            DeptId = leaderMeetingMission.snDeptId.Trim()
                        };
                        var spNumber = SMBasicDataBiz.GetSuperviseNumberEntity(smBasicDataSuperviseNumberEntity);
                        var code = SuperviseMissionBodyBiz.GetNewSuperviseNumber(smBasicDataSuperviseNumberEntity);
                        SmMainEntity sme = new SmMainEntity();
                        sme.SmId = "";
                        sme.ActivityFlag = 1;
                        sme.SmType = smType;
                        sme.Title = "";
                        //sme.WorkFlowId = "DEFAULT";
                        sme.CreatorId = CurrentUserInfo.Employee_ID;
                        sme.CreatorName = CurrentUserInfo.Name;
                        sme.CreatorDeptId = CurrentUserInfo.Dept_ID;
                        sme.CreatorDeptName = CurrentUserInfo.Dept_Name;
                        sme.CreateTime = DateTime.Now;
                        sme.SpNumberName = spNumber.Name;
                        sme.SpNumberYear = spNumber.Year.ToString();
                        sme.SpNumberCode = code;
                        sme.TaskContent = leaderMeetingMission.snText.Trim();
                        sme.MainLeaderId = "";
                        sme.MainLeaderName = "";
                        sme.MainDeptId = leaderMeetingMission.snCompanyIds;
                        sme.MainDeptName = leaderMeetingMission.snCompany;
                        sme.AssistDeptId = leaderMeetingMission.snOtherCompanyIds;
                        sme.AssistDeptName = leaderMeetingMission.snOtherCompany;
                        if (leaderMeetingMission.snEndTime != DateTime.Parse("0001/1/1"))
                        {
                            sme.DeadLineTime = leaderMeetingMission.snEndTime;
                        }
                        sme.StartTime = leaderMeetingMission.snStartTime;

                        #region 构造子表集合对象

                        List<SmLeaderMeetingMissionEntity> leaderMeetingList = new List<SmLeaderMeetingMissionEntity>();
                        SmLeaderMeetingMissionEntity laderMeetingMissionEntity = null;
                        //这里确保前端请求的数据中主办单位的id和名称是一一对应关系
                        List<string> mainDeptIdList = sme.MainDeptId.Split(';').ToList();
                        List<string> mainDeptNameList = sme.MainDeptName.Split(';').ToList();
                        int index = 0;

                        foreach (var deptId in mainDeptIdList)
                        {
                            if (string.IsNullOrEmpty(deptId))
                            {
                                continue;
                            }

                            laderMeetingMissionEntity = new SmLeaderMeetingMissionEntity()
                            {
                                DeptId = deptId,
                                DeptName = mainDeptNameList[index],
                                StartTime = sme.StartTime,
                                DeadLineTime = sme.DeadLineTime,
                                CreateTime = sme.CreateTime,
                                CreatorId = sme.CreatorId,
                                CreatorName = sme.CreatorName,
                                CreatorDeptId = sme.CreatorDeptId,
                                CreatorDeptName = sme.CreatorDeptName,
                                ActivityFlag = 1
                            };
                            index++;

                            leaderMeetingList.Add(laderMeetingMissionEntity);
                        }

                        #endregion

                        SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                        sfwe.UserId = CurrentUserInfo.Employee_ID;
                        sfwe.UserName = CurrentUserInfo.Name;
                        sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                        sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                        sfwe.Opinion = "";
                        sfwe.OpinionType = "4";
                        sfwe.UserIdPrev = "";
                        sfwe.UserNamePrev = "";
                        sfwe.SmType = smType;
                        sfwe.AllowFlag = 1;

                        //判断办公厅是否已填写完成时间，走不同的固定流流程
                        //由引擎根据WorkFlowId值去选择正确的固定流流程
                        sme.WorkFlowId = sme.DeadLineTime == null ? "FIXEDLD1" : "FIXEDLD2";

                        SuperviseMissionWorkFlow.Send(sme, leaderMeetingList, sfwe, new SmFlowWaitingEntity());
                    }

                    return new SuperviseMissionResponse()
                    {
                        status = "1",
                        message = "创建成功"
                    };
                }
                else
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "请至少添加一个任务"
                    };
                }

            }
            catch (Exception ex)
            {
                WriteLog("保存出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "保存出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 获取任务详情

        /// <summary>
        /// 获取任务详情
        /// </summary>
        /// <param name="smId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetMissionDetail(string smId)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion
                if (!string.IsNullOrEmpty(smId))
                {
                    var entity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId });
                    if (entity != null)
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "1",
                            message = "获取详情成功",
                            data = JsonHelper.ToJson(entity)
                        };
                    }
                }

                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取详情失败"
                };
            }
            catch (Exception ex)
            {
                WriteLog("获取任务详情出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = "获取任务详情出错"
                };
            }
        }

        #endregion

        #region 获取主办单位相关

        /// <summary>
        /// 获取指定主办单位
        /// </summary>
        /// <param name="smId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetMainDeptDetail(string smId, int flowId)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                if (!string.IsNullOrEmpty(smId))
                {
                    //根据流程ID获取当前流程的部门ID
                    var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                    if (flowWaitingEntity != null)
                    {
                        var entity = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity() { SmId = smId, DeptId = flowWaitingEntity.FlowDeptId, ActivityFlag = 1 });
                        if (entity != null)
                        {
                            return new SuperviseMissionResponse()
                            {
                                status = "1",
                                message = "获取主办单位成功",
                                data = JsonHelper.ToJson(entity)
                            };
                        }
                    }
                    else
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "0",
                            message = "获取主办单位失败：无法获取当前待办信息"
                        };
                    }
                }

                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取主办单位失败：参数错误"
                };
            }
            catch (Exception ex)
            {
                WriteLog("获取主办单位出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = "获取主办单位出错"
                };
            }
        }

        /// <summary>
        /// 获取主办单位集合信息
        /// </summary>
        /// <param name="smId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetMainDeptListDetail(string smId)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                if (!string.IsNullOrEmpty(smId))
                {
                    var list = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(new SmLeaderMeetingMissionEntity() { SmId = smId, ActivityFlag = 1 });
                    if (list != null)
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "1",
                            message = "获取主办单位集合成功",
                            data = JsonHelper.ToJson(list)
                        };
                    }
                }

                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取主办单位集合失败：参数错误"
                };
            }
            catch (Exception ex)
            {
                WriteLog("获取主办单位集合出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = "获取主办单位集合出错"
                };
            }
        }

        #endregion

        #region 撤回

        /// <summary>
        /// 撤回。
        /// </summary>
        /// <param name="smId">任务Id。</param>
        /// <param name="flowId">流程Id。</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse RollBack(string smId, int flowId)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                SuperviseMissionWorkFlow.RollBack(smId, flowId);
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "撤回成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("撤回出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "撤回出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 办公厅审批

        /// <summary>
        /// 办公厅审批
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="allowFlag"></param>
        /// <param name="opinion"></param>
        /// <param name="opinionType"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage2(string smId, int flowId, int allowFlag, string opinion, string opinionType)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 容错检查

                if (string.IsNullOrEmpty(smId.Trim()))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "缺失文档ID"
                    };
                }
                if (!string.IsNullOrEmpty(opinion) && opinion.Trim().Length > _OPINION_MAX_LENGTH)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "审批意见最大长度不能超过" + _OPINION_MAX_LENGTH + "个字符"
                    };
                }

                #endregion

                //意见处理
                opinion = !string.IsNullOrEmpty(opinion.Trim()) ? opinion.Trim() : allowFlag == 1 ? "同意" : "不同意";

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = opinion;
                CurrentWatingEntity.OpinionType = opinionType;
                CurrentWatingEntity.AllowFlag = allowFlag;
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity());
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "操作成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("办公厅审批出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "保存出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 主办单位填写完成时间

        /// <summary>
        /// 主办单位填写完成时间
        /// </summary>
        /// <param name="smId"></param>
        ///  <param name="lmmId"></param>
        /// <param name="flowId"></param>
        /// <param name="deadLineTime"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage3(string smId, string lmmId, int flowId, string deadLineTime)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 容错检查

                string strMsg = "";
                bool flag = false;
                DateTime dt = DateTime.Now;

                if (!flag && string.IsNullOrEmpty(smId.Trim()))
                {
                    strMsg = "缺失文档ID";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(lmmId.Trim()))
                {
                    strMsg = "缺失子表ID";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(deadLineTime.Trim()))
                {
                    strMsg = "请先填写完成时间";
                    flag = true;
                }
                if (!flag && !DateTime.TryParse(deadLineTime.Trim(), out dt))
                {
                    strMsg = "请选择正确的完成时间";
                    flag = true;
                }

                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                var entity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId });

                if (entity != null)
                {
                    var DeadLineTime = Convert.ToDateTime(deadLineTime.Trim());
                    if (DeadLineTime <= Convert.ToDateTime(entity.StartTime))
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "0",
                            message = "完成时间不能小于启动时间"
                        };
                    }
                    //1.更新子表对象
                    var lmmEntity = new SmLeaderMeetingMissionEntity()
                    {
                        LmmId = lmmId.Trim(),
                        DeadLineTime = dt
                    };
                    SuperviseMissionBodyBiz.UpdateLeaderMeetingMissionEntity(lmmEntity);

                    //2.流转
                    SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                    CurrentWatingEntity.SmId = smId;
                    CurrentWatingEntity.FlowId = flowId;
                    CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                    CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                    CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                    CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                    CurrentWatingEntity.Opinion = "";
                    CurrentWatingEntity.OpinionType = "4";
                    CurrentWatingEntity.AllowFlag = 1;
                    SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity());


                    return new SuperviseMissionResponse()
                    {
                        status = "1",
                        message = "保存成功"
                    };
                }
                else
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "未找到对应的任务信息"
                    };
                }
            }
            catch (Exception ex)
            {
                WriteLog("主办单位填写完成时间保存出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "保存出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 根据步骤获取上一步骤的单位

        /// <summary>
        /// 根据步骤获取上一步骤的单位
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="step"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public PrevStepInformationForBgtmbqrResponse GetPrevStepInformationByStep(string smId, string step)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return new PrevStepInformationForBgtmbqrResponse() { data = NoLoginResponse.data, message = NoLoginResponse.message, status = NoLoginResponse.status };
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return new PrevStepInformationForBgtmbqrResponse() { data = UrlCheckResponse.data, message = UrlCheckResponse.message, status = UrlCheckResponse.status };
                }
                #endregion

                List<string> list = SuperviseMissionWorkFlow.GetPrevStepInformationByStep(smId, step);
                return new PrevStepInformationForBgtmbqrResponse()
                {
                    status = "1",
                    myData = list,
                    message = "成功"
                };

            }
            catch (Exception ex)
            {
                WriteLog("根据步骤获取上一步骤的单位时出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = ex.Message;
                }
                return new PrevStepInformationForBgtmbqrResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 固定流审批

        /// <summary>
        /// 固定流审批
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="allowFlag"></param>
        /// <param name="opinion"></param>
        /// <param name="opinionType"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage4(string smId, int flowId, int allowFlag, string opinion, string opinionType)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 容错检查

                if (string.IsNullOrEmpty(smId.Trim()))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "缺失文档ID"
                    };
                }
                if (!string.IsNullOrEmpty(opinion) && opinion.Trim().Length > _OPINION_MAX_LENGTH)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "审批意见最大长度不能超过" + _OPINION_MAX_LENGTH + "个字符"
                    };
                }

                #endregion

                //意见处理
                opinion = !string.IsNullOrEmpty(opinion.Trim()) ? opinion.Trim() : allowFlag == 1 ? "同意" : "不同意";

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = opinion;
                CurrentWatingEntity.OpinionType = opinionType;
                CurrentWatingEntity.AllowFlag = allowFlag;
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity());
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "操作成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("固定流审批出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "保存出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 办公厅确认

        /// <summary>
        /// 办公厅确认
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="remindType"></param>
        /// <param name="remindInterval"></param>
        /// <param name="allowFlag"></param>
        /// <param name="opinion"></param>
        /// <param name="opinionType"></param>
        /// <param name="flowids"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage5(string smId, int flowId, int remindType, int remindInterval, int allowFlag, string opinion, string opinionType, int[] flowids)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 容错检查

                string strMsg = "";
                bool flag = false;

                if (!flag && string.IsNullOrEmpty(smId.Trim()))
                {
                    strMsg = "缺失文档ID";
                    flag = true;
                }

                if (!flag && !CheckIsAllPass(smId, "BGTQR") && allowFlag == 1)
                {
                    strMsg = "请等待所有主办单位流程完成后再进行此操作";
                    flag = true;
                }

                if (!flag && flowids.Length < 1 && allowFlag == 0)
                {
                    strMsg = "请选择退回的主办单位";
                    flag = true;
                }
                if (!flag && !string.IsNullOrEmpty(opinion) && opinion.Trim().Length > _OPINION_MAX_LENGTH)
                {
                    strMsg = "审批意见最大长度不能超过" + _OPINION_MAX_LENGTH + "个字符";
                    flag = true;
                }

                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //意见处理
                opinion = !string.IsNullOrEmpty(opinion.Trim()) ? opinion.Trim() : allowFlag == 1 ? "同意" : "不同意";

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;

                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = opinion;
                CurrentWatingEntity.OpinionType = opinionType;
                CurrentWatingEntity.AllowFlag = allowFlag;

                //同意业务处理
                if (allowFlag == 1)
                {
                    SmMainEntity smMainEntity = new SmMainEntity()
                    {
                        SmId = smId,
                        RemindType = remindType,
                        RemindInterval = remindInterval
                    };
                    CurrentWatingEntity.FlowId = flowId;
                    SuperviseMissionWorkFlow.Send(smMainEntity, CurrentWatingEntity, new SmFlowWaitingEntity());
                }
                else
                {
                    //不同意

                    foreach (var tempid in flowids)
                    {
                        CurrentWatingEntity.FlowId = tempid;
                        CurrentWatingEntity.Opinion = opinion;
                        SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity());
                    }
                }

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("办公厅确认出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "保存出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 办公厅退回拟稿

        /// <summary>
        /// 办公厅退回拟稿的保存
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="leaderMeetingMission"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse EditMissionDetail(string smId, int flowId, LeaderMeetingMissionRequestEntity leaderMeetingMission)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                if (leaderMeetingMission != null)
                {
                    var oldEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId, ActivityFlag = 1 });
                    if (oldEntity != null)
                    {
                        #region 容错检查

                        string strMsg = "";
                        bool flag = false;
                        if (string.IsNullOrEmpty(leaderMeetingMission.snText))
                        {
                            strMsg = "任务内容不能为空";
                            flag = true;
                        }
                        if (!flag && string.IsNullOrEmpty(leaderMeetingMission.snName))
                        {
                            strMsg = "督查字不能为空";
                            flag = true;
                        }
                        if (!flag && string.IsNullOrEmpty(leaderMeetingMission.snCode))
                        {
                            strMsg = "编号不能为空";
                            flag = true;
                        }
                        if (!flag && (string.IsNullOrEmpty(leaderMeetingMission.snCompanyIds) || string.IsNullOrEmpty(leaderMeetingMission.snCompany)))
                        {
                            strMsg = "主办单位不能为空";
                            flag = true;
                        }
                        if (!flag && (string.IsNullOrEmpty(leaderMeetingMission.snOtherCompanyIds) || string.IsNullOrEmpty(leaderMeetingMission.snOtherCompany)))
                        {
                            strMsg = "协办单位不能为空";
                            flag = true;
                        }
                        if (!flag && leaderMeetingMission.snStartTime == DateTime.Parse("0001/1/1"))
                        {
                            strMsg = "启动时间不能为空";
                            flag = true;
                        }
                        if (!flag && leaderMeetingMission.snEndTime == DateTime.Parse("0001/1/1"))
                        {
                            strMsg = "完成时间不能为空";
                            flag = true;
                        }
                        if (!flag && leaderMeetingMission.snStartTime >= leaderMeetingMission.snEndTime)
                        {
                            strMsg = "启动时间不能大于完成时间";
                            flag = true;
                        }
                        if (flag)
                        {
                            return new SuperviseMissionResponse()
                            {
                                status = "0",
                                message = strMsg
                            };
                        }

                        #endregion

                        SmMainEntity sme = new SmMainEntity();
                        sme.SmId = smId;

                        #region 判断当前督查字号是否已改变

                        if (!(leaderMeetingMission.snName == oldEntity.SpNumberName && leaderMeetingMission.snYear.ToString() == oldEntity.SpNumberYear && leaderMeetingMission.snCode == oldEntity.SpNumberCode.ToString()))
                        {
                            //督查字号已更改，获取新的督查字号
                            var smBasicDataSuperviseNumberEntity = new SmBasicDataSuperviseNumberEntity
                            {
                                Name = leaderMeetingMission.snName.Trim(),
                                Year = leaderMeetingMission.snYear,
                                DeptId = leaderMeetingMission.snDeptId.Trim()
                            };
                            var spNumber = SMBasicDataBiz.GetSuperviseNumberEntity(smBasicDataSuperviseNumberEntity);
                            if (spNumber == null)
                            {
                                return new SuperviseMissionResponse()
                                {
                                    status = "0",
                                    message = "无法查询到督查编号名为：" + leaderMeetingMission.snName + "年号为：" + leaderMeetingMission.snYear + "的数据"
                                };
                            }
                            var code = SuperviseMissionBodyBiz.GetNewSuperviseNumber(smBasicDataSuperviseNumberEntity);
                            sme.SpNumberCode = code;
                            sme.SpNumberName = spNumber.Name;
                            sme.SpNumberYear = spNumber.Year.ToString();
                        }

                        #endregion

                        sme.TaskContent = leaderMeetingMission.snText.Trim();
                        sme.MainDeptId = leaderMeetingMission.snCompanyIds;
                        sme.MainDeptName = leaderMeetingMission.snCompany;
                        sme.AssistDeptId = leaderMeetingMission.snOtherCompanyIds;
                        sme.AssistDeptName = leaderMeetingMission.snOtherCompany;
                        sme.StartTime = leaderMeetingMission.snStartTime;
                        sme.DeadLineTime = leaderMeetingMission.snEndTime;

                        #region 删除原子表对象

                        var leaderMeetingMissionList = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(new SmLeaderMeetingMissionEntity() { SmId = smId, ActivityFlag = 1 });
                        foreach (var item in leaderMeetingMissionList)
                        {
                            SuperviseMissionBodyBiz.DeleteLeaderMeetingMissionEntity(item);
                        }

                        #endregion

                        #region 构造新的子表集合对象

                        List<SmLeaderMeetingMissionEntity> leaderMeetingList = new List<SmLeaderMeetingMissionEntity>();
                        SmLeaderMeetingMissionEntity laderMeetingMissionEntity = null;
                        //这里确保前端请求的数据中主办单位的id和名称是一一对应关系
                        List<string> mainDeptIdList = sme.MainDeptId.Split(';').ToList();
                        List<string> mainDeptNameList = sme.MainDeptName.Split(';').ToList();
                        int index = 0;

                        foreach (var deptId in mainDeptIdList)
                        {
                            if (string.IsNullOrEmpty(deptId))
                            {
                                continue;
                            }

                            laderMeetingMissionEntity = new SmLeaderMeetingMissionEntity()
                            {
                                //获取流水号
                                LmmId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber(),
                                SmId = smId,
                                DeptId = deptId,
                                DeptName = mainDeptNameList[index],
                                StartTime = sme.StartTime,
                                DeadLineTime = sme.DeadLineTime,
                                CreateTime = DateTime.Now,
                                CreatorId = CurrentUserInfo.Employee_ID,
                                CreatorName = CurrentUserInfo.Name,
                                CreatorDeptId = CurrentUserInfo.Dept_ID,
                                CreatorDeptName = CurrentUserInfo.Dept_Name,
                                ActivityFlag = 1
                            };
                            index++;

                            leaderMeetingList.Add(laderMeetingMissionEntity);
                            //插入数据
                            SuperviseMissionBodyBiz.InsertLeaderMeetingMissionEntity(laderMeetingMissionEntity);
                        }

                        #endregion

                        #region 更新主表对象

                        SuperviseMissionBodyBiz.UpdateSmMainEntity(sme);

                        #endregion

                        SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                        CurrentWatingEntity.SmId = smId;
                        CurrentWatingEntity.FlowId = flowId;
                        CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                        CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                        CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                        CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                        CurrentWatingEntity.Opinion = "";
                        CurrentWatingEntity.OpinionType = "4";//这个意见类型最后要传入
                        CurrentWatingEntity.AllowFlag = 1;
                        SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity());

                        return new SuperviseMissionResponse()
                        {
                            status = "1",
                            message = "保存成功"
                        };
                    }
                    else
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "0",
                            message = "无法获取当前任务信息"
                        };
                    }
                }
                else
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取提交的任务信息"
                    };
                }
            }
            catch (Exception ex)
            {
                WriteLog("拟稿保存编辑出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "保存编辑出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 判断是否所有主办单位已发送至指定步骤

        /// <summary>
        /// 是否所有主办单位已发送至指定步骤
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="step"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse IsAllPass(string smId, string step)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                bool isPassed = CheckIsAllPass(smId, step);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = isPassed ? "1" : "0",
                    message = "成功"
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = ex.Message
                };
            }
        }

        /// <summary>
        /// 判断是否所有主办单位已发送至指定步骤
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="step"></param>
        /// <returns></returns>
        private bool CheckIsAllPass(string smId, string step)
        {
            bool isPassed = false;
            //1.获取指定步骤的待办信息
            var flowWaitingList = SuperviseMissionBodyBiz.GetSmFlowWaitingList(m => m.SmId == smId && m.StepId == step).ToList();
            //2.获取子表信息（主办单位信息）
            var mainDeptList = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(new SmLeaderMeetingMissionEntity() { SmId = smId, ActivityFlag = 1 });

            if (flowWaitingList != null && flowWaitingList.Any() && mainDeptList != null && mainDeptList.Any())
            {
                //拟稿单位存在多秘书的情况,以flowDeptIdPrev作为筛选，并进行去重处理
                var flowDeptIdList = flowWaitingList.Select(m => m.FlowDeptIdPrev).Distinct().ToList();
                isPassed = flowDeptIdList.Count == mainDeptList.Count;
            }

            return isPassed;
        }

        #endregion

        #region 主办单位任务推进

        /// <summary>
        /// 主办单位任务推进往下发送
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="type">下一步骤：1--任务反馈|2--措施分解</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage6(string smId, int flowId, int type)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                var nextStepId = type == 1 ? "RWFK" : "CSFJ";
                var nextStepName = type == 1 ? "任务反馈" : "措施分解";
                var nextFlowId = "";

                //获取待办信息
                SmFlowWaitingEntity waitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                if (waitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前步骤信息"
                    };
                }

                //获取当前主办单位信息
                var mainDeptEntity = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity() { ActivityFlag = 1, SmId = smId, DeptId = waitingEntity.FlowDeptId });

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = "";
                CurrentWatingEntity.OpinionType = "4";//这个意见类型最后要传入
                CurrentWatingEntity.AllowFlag = 1;
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = nextStepId,
                    StepName = nextStepName,
                    FlowDeptId = waitingEntity.FlowDeptId,
                    TargetId = mainDeptEntity.LmmId
                });

                if ("CSFJ".Equals(nextStepId))
                {
                    //下一步是措施分解，发送成功，返回措施分解步骤页面的参数，直接进行页面跳转
                    //获取当前待办信息
                    var currentWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(
                        new SmFlowWaitingEntity()
                        {
                            SmId = smId
                        });

                    if (currentWaitingList != null && currentWaitingList.Any())
                    {
                        var currentWaitingEntity = currentWaitingList.Where(m => m.FlowIdPrev == flowId && m.FlowDeptId == waitingEntity.FlowDeptId
                                                && m.UserId == CurrentUserInfo.Employee_ID && m.TargetId == mainDeptEntity.LmmId).FirstOrDefault();
                        nextFlowId = currentWaitingEntity.FlowId.ToString();
                    }
                }
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = nextFlowId,
                    message = "操作成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("主办单位任务推进往下发送出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "发送出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 任务反馈

        /// <summary>
        /// 获取任务的反馈情况
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetLeaderMeetingMissionFeedbackDetail(string smId, int flowId)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                //获取待办信息
                var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId<SmFlowWaitingEntity>(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                //获取子表信息（当前主办单位）
                var mainDeptEntity = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity() { SmId = smId, ActivityFlag = 1, DeptId = flowWaitingEntity.FlowDeptId });
                if (flowWaitingEntity == null || mainDeptEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "获取任务的反馈情况失败"
                    };
                }
                else
                {
                    MissionFeedbackResponeseEntity entity = new MissionFeedbackResponeseEntity()
                    {
                        LmmId = mainDeptEntity.LmmId,
                        DeptName = mainDeptEntity.DeptName,
                        DeadLineTime = mainDeptEntity.DeadLineTime == null ? "" : Convert.ToDateTime(mainDeptEntity.DeadLineTime).ToString("yyyy-MM-dd"),
                        FinishPercent = mainDeptEntity.FinishPercent,
                        Opinion = flowWaitingEntity.Opinion
                    };
                    return new SuperviseMissionResponse()
                    {
                        status = "1",
                        data = JsonHelper.ToJson(entity),
                        message = "获取任务的反馈情况成功"
                    };
                }
            }
            catch (Exception ex)
            {
                WriteLog("获取任务的反馈情况出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = "获取任务的反馈情况出错"
                };
            }
        }

        /// <summary>
        /// 任务反馈进度
        /// </summary>
        /// <param name="smId">主表ID</param>
        /// <param name="lmmId">子表ID</param>
        /// <param name="flowId"></param>
        /// <param name="finishPercent"></param>
        /// <param name="opinion"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage7(string smId, string lmmId, int flowId, string finishPercent, string opinion)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 容错检查

                int intFinishPercent = 0;
                string strMsg = "";
                bool flag = false;

                if (!flag && string.IsNullOrEmpty(smId.Trim()))
                {
                    strMsg = "缺失文档ID";
                    flag = true;
                }

                if (!flag && string.IsNullOrEmpty(finishPercent.Trim()))
                {
                    strMsg = "请输入完成进度";
                    flag = true;
                }

                if (!flag && !int.TryParse(finishPercent.Trim(), out intFinishPercent))
                {
                    strMsg = "完成进度必须为整数";
                    flag = true;
                }

                if (!flag && (intFinishPercent < 0 || intFinishPercent > 100))
                {
                    strMsg = "完成进度需介于0~100之间";
                    flag = true;
                }

                if (!flag && string.IsNullOrEmpty(opinion.Trim()))
                {
                    strMsg = "最新反馈不允许为空";
                    flag = true;
                }
                if (!flag && opinion.Trim().Length > _HOST_DEPT_FEEDBACK_MAX_LENGTH)
                {
                    strMsg = "最新反馈最大长度不能超过" + _HOST_DEPT_FEEDBACK_MAX_LENGTH + "个字符";
                    flag = true;
                }

                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //0.获取拟稿部门ID
                SmFlowItemBaseEntity FlowEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity() { SmId = smId, FlowId = 1 });
                if (FlowEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "主表数据不存在或者已经被删除"
                    };
                }

                //1.更新子表完成进度
                SmLeaderMeetingMissionEntity lmmEntity = new SmLeaderMeetingMissionEntity() { LmmId = lmmId, FinishPercent = intFinishPercent, ActivityFlag = 1 };
                SuperviseMissionBodyBiz.UpdateLeaderMeetingMissionEntity(lmmEntity);

                //2.流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = opinion.Trim();
                CurrentWatingEntity.OpinionType = "7";//默认"反馈意见"意见类型
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FinishPercent = intFinishPercent;
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = "BGTRWFK",
                    StepName = "办公厅任务反馈",
                    FlowDeptId = FlowEntity.FlowDeptId
                });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "保存成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("保存任务反馈情况出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "保存任务反馈出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 措施分解

        /// <summary>
        /// 措施分解
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="lmmId"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage8(string smId, int flowId, string lmmId, List<LeaderMeetingMeasureRequestEntity> measureList)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 容错检查

                string strMsg = "";
                bool flag = false;

                if (string.IsNullOrEmpty(smId))
                {
                    strMsg = "缺失文档ID";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(lmmId))
                {
                    strMsg = "缺失子表ID";
                    flag = true;
                }
                if (!flag && (measureList == null || !measureList.Any()))
                {
                    strMsg = "请先添加措施";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //1.保存措施
                SmTargetItemEntity itemEntity = null;
                List<SmTargetItemEntity> smTargetItemList = new List<SmTargetItemEntity>();
                foreach (var measure in measureList)
                {
                    if (string.IsNullOrEmpty(measure.Name)) continue;
                    itemEntity = new SmTargetItemEntity();
                    itemEntity.ActivityFlag = 1;
                    itemEntity.AssistDeptId = measure.AssDeptIds;
                    itemEntity.AssistDeptName = measure.AssDeptNames;
                    itemEntity.CreateTime = DateTime.Now;
                    itemEntity.CreatorDeptId = CurrentUserInfo.Dept_ID;
                    itemEntity.CreatorDeptName = CurrentUserInfo.Dept_Name;
                    itemEntity.CreatorId = CurrentUserInfo.Employee_ID;
                    itemEntity.CreatorName = CurrentUserInfo.Name;
                    itemEntity.DeadLineTime = measure.DeadLineTime;
                    itemEntity.DutyDeptId = measure.DutyDeptId;
                    itemEntity.DutyDeptName = measure.DutyDeptName;
                    itemEntity.TargetId = lmmId;
                    itemEntity.SmId = smId;
                    itemEntity.ItemName = measure.Name;
                    itemEntity.ItemId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber();
                    itemEntity.Status = "0";

                    SuperviseMissionBodyBiz.InsertSmTargetItemEntity(itemEntity);
                    smTargetItemList.Add(itemEntity);
                }

                //2.流转
                //下一步流转部门的集合、措施的集合
                string flowDeptIds = string.Join(";", measureList.Select(m => m.DutyDeptId).ToArray());
                string targetIds = string.Join(";", smTargetItemList.Select(m => m.TargetId).ToArray());
                string targetItemIds = string.Join(";", smTargetItemList.Select(m => m.ItemId).ToArray());
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = "";
                CurrentWatingEntity.OpinionType = "4";//这个意见类型最后要传入
                CurrentWatingEntity.AllowFlag = 1;
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = "ZRCSCLCS",
                    StepName = "责任处室处理措施",
                    FlowDeptId = flowDeptIds,
                    TargetId = targetIds,
                    TargetItemId = targetItemIds
                });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "保存成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("措施分解时出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "保存出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 责任处室处理措施

        /// <summary>
        /// 责任处室处理措施
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="type">下一步骤：1--措施反馈|2--责任处室分解子措施</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage9(string smId, int flowId, int type)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                var nextStepId = type == 1 ? "CSFK" : "ZRCSFJZCS";
                var nextStepName = type == 1 ? "措施反馈" : "责任处室分解子措施";
                var nextFlowId = "";
                //TODO  解决多个相同责任处室发送的问题
                //获取待办信息
                SmFlowWaitingEntity waitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });

                if (waitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前步骤信息"
                    };
                }

                #region 处理多个待办同一责任处室的发送

                var flowDeptIds = "";
                var targetIds = "";
                var targetItemIds = "";
                var smFlowWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowWaitingEntity() { SmId = smId });
                if (smFlowWaitingList != null)
                {
                    smFlowWaitingList = smFlowWaitingList.FindAll(m => m.FlowDeptId == waitingEntity.FlowDeptId && m.StepId == waitingEntity.StepId && m.UserId == waitingEntity.UserId).ToList();
                    if (smFlowWaitingList != null && smFlowWaitingList.Any())
                    {
                        flowDeptIds = string.Join(";", smFlowWaitingList.Select(m => m.FlowDeptId).ToArray());
                        targetIds = string.Join(";", smFlowWaitingList.Select(m => m.TargetId).ToArray());
                        targetItemIds = string.Join(";", smFlowWaitingList.Select(m => m.TargetItemId).ToArray());
                    }
                }

                #endregion

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = "";
                CurrentWatingEntity.OpinionType = "4";//这个意见类型最后要传入
                CurrentWatingEntity.AllowFlag = 1;
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = nextStepId,
                    StepName = nextStepName,
                    FlowDeptId = flowDeptIds == "" ? waitingEntity.FlowDeptId : flowDeptIds,
                    TargetId = flowDeptIds == "" ? waitingEntity.TargetId : targetIds,
                    TargetItemId = flowDeptIds == "" ? waitingEntity.TargetItemId : targetItemIds
                });

                if ("ZRCSFJZCS".Equals(nextStepId))
                {
                    //下一步是责任处室分解子措施，发送成功，返回责任处室分解子措施步骤页面的参数，直接进行页面跳转
                    //获取当前待办信息
                    var currentWaitingList = SuperviseMissionWorkFlow.GetSmFlowItemList(
                        new SmFlowWaitingEntity()
                        {
                            SmId = smId
                        });

                    if (currentWaitingList != null && currentWaitingList.Any())
                    {
                        var currentWaitingEntity = currentWaitingList.Where(m => m.FlowIdPrev == flowId && m.FlowDeptId == waitingEntity.FlowDeptId
                                                && m.UserId == CurrentUserInfo.Employee_ID && m.TargetId == waitingEntity.TargetId && m.TargetItemId == waitingEntity.TargetItemId)
                                                .FirstOrDefault();
                        nextFlowId = currentWaitingEntity.FlowId.ToString();
                    }
                }

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data= nextFlowId,
                    message = "操作成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("责任处室处理措施发送出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "发送出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 措施反馈

        /// <summary>
        /// 措施的进度反馈
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage10(string smId, int flowid, Page10RequestEntity entity)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                int intFinishPercent = 0;
                if (!flag && string.IsNullOrEmpty(entity.FlowId.Trim()))
                {
                    strMsg = "参数错误：缺失措施流程ID";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.TargetId.Trim()))
                {
                    strMsg = "参数错误：缺失主办单位流水号";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.ItemId.Trim()))
                {
                    strMsg = "参数错误：缺失措施流水号";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.Finsh_Precent.Trim()))
                {
                    strMsg = "参数错误：完成进度不允许为空";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.Opinion.Trim()))
                {
                    strMsg = "参数错误：最新反馈不允许为空";
                    flag = true;
                }
                if (!flag && !int.TryParse(entity.Finsh_Precent.Trim(), out intFinishPercent))
                {
                    strMsg = "参数错误：完成进度必须为整数";
                    flag = true;
                }
                if (!flag && (intFinishPercent < 0 || intFinishPercent > 100))
                {
                    strMsg = "参数错误：完成进度需介于0~100之间";
                    flag = true;
                }
                if (!flag && entity.Opinion.Length > _MEASURE_FEEDBACK_MAX_LENGTH)
                {
                    strMsg = "参数错误：最新反馈最大长度不能超过"+ _MEASURE_FEEDBACK_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //1.获取当前待办信息
                var flowEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity() { SmId = smId, FlowId = Convert.ToInt32(entity.FlowId) });
                var leaderMeetingMissionEntity = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity() { LmmId = flowEntity.TargetId, ActivityFlag = 1 });
                if (leaderMeetingMissionEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "获取当前主办单位信息失败"
                    };
                }

                //2.更新措施完成进度
                SmTargetItemEntity itemEntity = new SmTargetItemEntity();
                itemEntity.ItemId = entity.ItemId;
                itemEntity.FinshPercent = intFinishPercent;
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(itemEntity);

                //3.流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = Convert.ToInt32(entity.FlowId);
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = entity.Opinion;
                CurrentWatingEntity.OpinionType = "7";//默认"反馈意见"意见类型
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FinishPercent = intFinishPercent;

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = "ZBDWRWFK",
                    StepName = "主办单位任务反馈",
                    FlowDeptId = leaderMeetingMissionEntity.DeptId
                });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "保存成功"
                };

            }
            catch (Exception ex)
            {
                WriteLog("措施的进度反馈发送出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "进度反馈保存出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 责任处室分解子措施

        /// <summary>
        /// 责任处室分解子措施
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <param name="subMeasures"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage11(string smId, int flowid, List<SubMeasureItem> subMeasures)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 容错检查

                bool flag = false;
                string strMsg = "";
                if (!flag && string.IsNullOrEmpty(smId))
                {
                    strMsg = "缺失文档ID";
                    flag = true;
                }
                if (!flag && flowid <= 0)
                {
                    strMsg = "非法参数";
                    flag = true;
                }
                if (!flag && !subMeasures.Any())
                {
                    strMsg = "请先添加子措施";
                    flag = true;
                }
                else
                {
                    //是否所有可分解的措施均已进行分解检查
                    //获取当前待办信息
                    var smFlowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowid });
                    if (smFlowWaitingEntity == null)
                    {
                        strMsg = "无法获取当前待办信息";
                        flag = true;
                    }
                    else
                    {
                        //获取可分解的措施对象集合
                        var targetItemEntityList = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(
                            new SmTargetItemEntity()
                            {
                                ActivityFlag = 1,
                                SmId = smId,
                                TargetId = smFlowWaitingEntity.TargetId,
                                DutyDeptId = smFlowWaitingEntity.FlowDeptId,
                                ParentTargetItemId = null
                            });
                        //请求数据中的子措施对应的措施ID对象
                        var measureIdList = subMeasures.Select(m => m.MeasureId).Distinct().ToList();
                        if (targetItemEntityList.Count != measureIdList.Count)
                        {
                            strMsg = "所有可分解的措施必须添加子措施";
                            flag = true;
                        }
                    }
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //1.保存子措施
                SmTargetItemEntity itemEntity = null;
                List<SmTargetItemEntity> smTargetItemList = new List<SmTargetItemEntity>();
                foreach (var item in subMeasures)
                {
                    itemEntity = new SmTargetItemEntity();
                    itemEntity.ItemId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber();
                    itemEntity.TargetId = item.TargetId;
                    itemEntity.SmId = smId;
                    itemEntity.ItemName = item.ItemName;
                    itemEntity.AssistDeptName = item.AssDeptName;
                    itemEntity.AssistDeptId = item.AssDeptId;
                    itemEntity.ExcutorName = item.DutyUserName;
                    itemEntity.ExcutorId = item.DutyUserId;
                    itemEntity.DeadLineTime = item.DeadLine;
                    itemEntity.CreateTime = DateTime.Now;
                    itemEntity.CreatorId = this.CurrentUserInfo.Employee_ID;
                    itemEntity.CreatorName = this.CurrentUserInfo.Name;
                    itemEntity.CreatorDeptId = this.CurrentUserInfo.Dept_ID;
                    itemEntity.CreatorDeptName = this.CurrentUserInfo.Dept_Name;
                    itemEntity.Status = "0";
                    itemEntity.ActivityFlag = 1;
                    itemEntity.ParentTargetItemId = item.MeasureId;
                    smTargetItemList.Add(itemEntity);
                    SuperviseMissionBodyBiz.InsertSmTargetItemEntity(itemEntity);
                }

                //2.流转
                //发送到下一步需要的责任人与相关信息
                var userIds = string.Join(";", smTargetItemList.Select(m => m.ExcutorId).ToArray());
                var userNames = string.Join(";", smTargetItemList.Select(m => m.ExcutorName).ToArray());
                var targetIds = string.Join(";", smTargetItemList.Select(m => m.TargetId).ToArray());
                var itemIds = string.Join(";", smTargetItemList.Select(m => m.ItemId).ToArray());

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowid;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = "";
                CurrentWatingEntity.OpinionType = "4";//这个意见类型最后要传入
                CurrentWatingEntity.AllowFlag = 1;
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = "ZCSFK",
                    StepName = "子措施反馈",
                    UserId = userIds,
                    UserName = userNames,
                    TargetId = targetIds,
                    TargetItemId = itemIds
                });
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "保存成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("责任处室分解子措施出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "分解子措施出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 子措施反馈

        /// <summary>
        /// 子措施的进度反馈
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage12(string smId, int flowid, Page10RequestEntity entity)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                int intFinishPercent = 0;
                if (!flag && string.IsNullOrEmpty(entity.FlowId.Trim()))
                {
                    strMsg = "参数错误：缺失措施流程ID";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.TargetId.Trim()))
                {
                    strMsg = "参数错误：缺失主办单位流水号";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.ItemId.Trim()))
                {
                    strMsg = "参数错误：缺失子措施流水号";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.Finsh_Precent.Trim()))
                {
                    strMsg = "参数错误：完成进度不允许为空";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.Opinion.Trim()))
                {
                    strMsg = "参数错误：最新反馈不允许为空";
                    flag = true;
                }
                if (!flag && !int.TryParse(entity.Finsh_Precent.Trim(), out intFinishPercent))
                {
                    strMsg = "参数错误：完成进度必须为整数";
                    flag = true;
                }
                if (!flag && (intFinishPercent < 0 || intFinishPercent > 100))
                {
                    strMsg = "参数错误：完成进度需介于0~100之间";
                    flag = true;
                }
                if (!flag && entity.Opinion.Length > _SUB_MEASURE_FEEDBACK_MAX_LENGTH)
                {
                    strMsg = "参数错误：最新反馈最大长度不能超过" + _SUB_MEASURE_FEEDBACK_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //1.获取当前待办信息
                var flowEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity() { SmId = smId, FlowId = Convert.ToInt32(entity.FlowId) });

                //2.更新子措施完成进度
                SmTargetItemEntity itemEntity = new SmTargetItemEntity();
                itemEntity.ItemId = entity.ItemId;
                itemEntity.FinshPercent = intFinishPercent;
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(itemEntity);

                //3.流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = Convert.ToInt32(entity.FlowId);
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = entity.Opinion;
                CurrentWatingEntity.OpinionType = "7";//默认"反馈意见"意见类型
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FinishPercent = intFinishPercent;

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = "ZRCSCSFK",
                    StepName = "责任处室措施反馈",
                    FlowDeptId = flowEntity.FlowDeptId
                });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "保存成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("子措施的进度反馈发送出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "进度反馈保存出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 责任处室措施反馈

        /// <summary>
        /// 责任处室措施反馈--退回
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="opinion"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendBackByZRCSCSFK(string smId, string flowId, string opinion)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                int intFlowId = 0;
                if (!flag && string.IsNullOrEmpty(smId))
                {
                    strMsg = "参数错误：缺失文档ID";
                    flag = true;
                }
                if (!flag && !int.TryParse(flowId, out intFlowId))
                {
                    strMsg = "参数错误：无法获取当前流程ID";
                    flag = true;
                }
                if (!flag && !string.IsNullOrEmpty(opinion) && opinion.Trim().Length > _OPINION_MAX_LENGTH)
                {
                    strMsg = "参数错误：退回理由最大长度不能超过" + _OPINION_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //获取当前待办信息
                var currentFlowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = intFlowId });
                if (currentFlowWaitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前待办信息"
                    };
                }
                //获取子措施信息
                var itemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(currentFlowWaitingEntity.TargetItemId);
                if (itemEntity == null || itemEntity.ActivityFlag != 1)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前子措施信息"
                    };
                }

                //流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = intFlowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = string.IsNullOrEmpty(opinion.Trim()) ? "不同意" : opinion.Trim();
                CurrentWatingEntity.OpinionType = "8";//默认"退回意见"意见类型
                CurrentWatingEntity.AllowFlag = 1;

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = "ZCSFK",
                    StepName = "子措施反馈",
                    UserId = itemEntity.ExcutorId,
                    UserName = itemEntity.ExcutorName,
                    TargetId = CurrentWatingEntity.TargetId,
                    TargetItemId = CurrentWatingEntity.TargetItemId
                });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "保存成功"
                };

            }
            catch (Exception ex)
            {
                WriteLog("责任处室措施反馈--退回时出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "退回出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        /// <summary>
        /// 责任处室措施反馈发送措施处理
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId">当前措施任意子措施的流程ID</param>
        /// <param name="entity"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage13(string smId, int flowId, FreeFlowSendRequestEntity entity)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                int intFinishPercent = 0;
                if (!flag && string.IsNullOrEmpty(entity.Percent.Trim()))
                {
                    strMsg = "参数错误：完成进度不允许为空";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.Opinion.Trim()))
                {
                    strMsg = "参数错误：反馈意见不允许为空";
                    flag = true;
                }
                if (!flag && !int.TryParse(entity.Percent, out intFinishPercent))
                {
                    strMsg = "参数错误：完成进度必须为整数";
                    flag = true;
                }
                if (!flag && (intFinishPercent < 0 | intFinishPercent > 100))
                {
                    strMsg = "参数错误：完成进度需介于0~100之间";
                    flag = true;
                }
                if (!flag && entity.Opinion.Length > _MEASURE_FEEDBACK_MAX_LENGTH)
                {
                    strMsg = "参数错误：反馈意见最大长度不能超过" + _MEASURE_FEEDBACK_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (!flag && entity.NextStep == null)
                {
                    strMsg = "请先选择下一步骤信息";
                    flag = true;
                }
                if (!flag && (string.IsNullOrEmpty(entity.NextStep.StepId) || string.IsNullOrEmpty(entity.NextStep.StepName)))
                {
                    strMsg = "请先选择下一步骤信息";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.NextStep.UserId))
                {
                    strMsg = "请先选择当前骤对应的处理部门/处理人信息";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //1.获取当前待办信息
                var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                if (flowWaitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前待办信息"
                    };
                }
                //2.获取子措施信息
                var itemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(flowWaitingEntity.TargetItemId);
                if (itemEntity == null || itemEntity.ActivityFlag != 1)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前子措施信息"
                    };
                }

                #region 3.获取新的待办

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.StepId = "ZRCSCSFK";
                CurrentWatingEntity.StepName = "责任处室措施反馈";
                CurrentWatingEntity.Opinion = entity.Opinion;
                CurrentWatingEntity.OpinionType = "7";//默认"反馈意见"意见类型
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FinishPercent = intFinishPercent;
                CurrentWatingEntity.TargetId = flowWaitingEntity.TargetId;
                CurrentWatingEntity.TargetItemId = itemEntity.ParentTargetItemId;   //结束当前措施的审核子措施的待办时，传入对应的措施ID

                var nextStepEntity = new SmSystemStepDefinitionEntity()
                {
                    StepId = entity.NextStep.StepId,
                    StepName = entity.NextStep.StepName
                };

                var newFlowWaitingEntity = SuperviseMissionWorkFlow.GenerateWaitingFlowItemForSpecailStep(CurrentWatingEntity, nextStepEntity);

                #endregion

                //4.更新措施
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(new SmTargetItemEntity()
                {
                    SmId = smId,
                    ItemId = itemEntity.ParentTargetItemId,
                    FinshPercent = intFinishPercent
                });

                //5.流转
                newFlowWaitingEntity.AllowFlag = 1;
                newFlowWaitingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                newFlowWaitingEntity.UserName = this.CurrentUserInfo.Name;
                newFlowWaitingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                newFlowWaitingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                newFlowWaitingEntity.FinishPercent = intFinishPercent;

                SmFlowWaitingEntity NextWatingEntity = new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = entity.NextStep.StepId,
                    StepName = entity.NextStep.StepName
                };
                if (entity.NextStep.RoleType == "1")
                {
                    //个人角色
                    NextWatingEntity.UserName = entity.NextStep.UserName;
                    NextWatingEntity.UserId = entity.NextStep.UserId;
                }
                else if (entity.NextStep.RoleType == "2")
                {
                    //部门角色
                    NextWatingEntity.FlowDeptId = entity.NextStep.UserId;
                }

                SuperviseMissionWorkFlow.Send(newFlowWaitingEntity, NextWatingEntity);


                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "发送成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("责任处室措施反馈发送措施处理出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "发送出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 主办单位任务反馈

        /// <summary>
        /// 主办单位任务反馈--退回
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="opinion"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendBackByZBDWRWFK(string smId, string flowId, string opinion)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                int intFlowId = 0;
                if (!flag && string.IsNullOrEmpty(smId))
                {
                    strMsg = "参数错误：缺失文档ID";
                    flag = true;
                }
                if (!flag && !int.TryParse(flowId, out intFlowId))
                {
                    strMsg = "参数错误：无法获取当前流程ID";
                    flag = true;
                }
                if (!flag && !string.IsNullOrEmpty(opinion) && opinion.Trim().Length > _OPINION_MAX_LENGTH)
                {
                    strMsg = "参数错误：退回理由最大长度不能超过" + _OPINION_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                #region 旧业务处理

                //获取主表信息
                var smMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId, ActivityFlag = 1 });

                //获取当前待办信息
                var currentFlowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = intFlowId });
                if (currentFlowWaitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前待办信息"
                    };
                }
                //获取措施信息
                var itemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(currentFlowWaitingEntity.TargetItemId);
                if (itemEntity == null || itemEntity.ActivityFlag != 1)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前措施信息"
                    };
                }

                #region 依据当前措施是否已分解子措施决定退回的步骤

                var prevStepId = "";    //上一步步骤ID
                var prevStepName = "";  //上一步步骤名称

                var subItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(itemEntity.ItemId);
                if (subItemList != null && subItemList.Any())
                {
                    //已分解子措施的
                    prevStepId = "ZRCSCSFK";
                    prevStepName = "责任处室措施反馈";
                }
                else
                {
                    //直接反馈的
                    prevStepId = "CSFK";
                    prevStepName = "措施反馈";
                }

                #endregion

                //流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = intFlowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = string.IsNullOrEmpty(opinion.Trim()) ? "不同意" : opinion.Trim();
                CurrentWatingEntity.OpinionType = "8";//默认"退回意见"意见类型
                CurrentWatingEntity.AllowFlag = 1;

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = prevStepId,
                    StepName = prevStepName,
                    FlowDeptId = itemEntity.DutyDeptId
                });

                #region 调用引擎接口，对退回进行特殊处理

                SmFlowFinishEntity tempCurrentFlowItem = new SmFlowFinishEntity();
                tempCurrentFlowItem.SmId = smId;
                tempCurrentFlowItem.FlowId = intFlowId;
                tempCurrentFlowItem.SmType = smMainEntity.SmType;
                tempCurrentFlowItem.UserId = CurrentUserInfo.Employee_ID;
                tempCurrentFlowItem.UserName = CurrentUserInfo.Name;
                tempCurrentFlowItem.UserDeptId = CurrentUserInfo.Dept_ID;
                tempCurrentFlowItem.UserDeptName = CurrentUserInfo.Dept_Name;

                SmFlowWaitingEntity tempNextFlowItem = new SmFlowWaitingEntity();
                tempNextFlowItem.FlowDeptId = itemEntity.DutyDeptId;
                tempNextFlowItem.StepId = prevStepId;

                SuperviseMissionWorkFlow.GenerateWaitingFlowItemForReturnBack(tempCurrentFlowItem, tempNextFlowItem, false);

                #endregion
                #endregion

                #region 新业务逻辑
                ////获取当前待办信息
                //var currentFlowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = intFlowId });
                //if (currentFlowWaitingEntity == null)
                //{
                //    return new SuperviseMissionResponse()
                //    {
                //        status = "0",
                //        message = "无法获取当前待办信息"
                //    };
                //}
                ////获取措施信息
                //var itemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(currentFlowWaitingEntity.TargetItemId);
                //if (itemEntity == null || itemEntity.ActivityFlag != 1)
                //{
                //    return new SuperviseMissionResponse()
                //    {
                //        status = "0",
                //        message = "无法获取当前措施信息"
                //    };
                //}

                //#region 依据当前措施是否已分解子措施决定退回的步骤

                //var prevStepId = "";        //上一步步骤ID
                //string[] prevTargetItemId;  //上一步步骤子措施ID集合（措施ID）
                //var subItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(itemEntity.ItemId);
                //if (subItemList != null && subItemList.Any())
                //{
                //    //已分解子措施的
                //    prevStepId = "ZRCSCSFK";
                //    prevTargetItemId = subItemList.Select(m => m.ItemId).ToArray();
                //}
                //else
                //{
                //    //直接反馈的
                //    prevStepId = "CSFK";
                //    prevTargetItemId = new string[] { itemEntity.ItemId };
                //}

                //#endregion

                //#region 根据已办流程信息，筛选正确的上一步流程ID

                //var flowFinishList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowFinishEntity() { SmId = smId, ActivityFlag = 1 });
                ////筛选上一步骤的已办集合
                //flowFinishList = flowFinishList.Where(m => m.StepId == prevStepId && m.TargetId == currentFlowWaitingEntity.TargetId &&
                //                    prevTargetItemId.Contains(m.TargetItemId) && m.FlowDeptId == itemEntity.DutyDeptId).ToList();
                ////按完成时间倒序排列，获取最近的数据
                //var flowFinishItem = flowFinishList.OrderByDescending(m => m.FinishTime).ToList().FirstOrDefault();
                //if (flowFinishItem == null)
                //{
                //    return new SuperviseMissionResponse()
                //    {
                //        status = "0",
                //        message = "无法获取上一步处理信息"
                //    };
                //}
                //var prevFlowId = Convert.ToInt32(flowFinishItem.FlowId);

                //#endregion

                //SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                //CurrentWatingEntity.SmId = smId;
                //CurrentWatingEntity.FlowId = intFlowId;
                //CurrentWatingEntity.FlowDeptId = currentFlowWaitingEntity.FlowDeptId;
                //CurrentWatingEntity.FlowDeptIdPrev = currentFlowWaitingEntity.FlowDeptIdPrev;
                //CurrentWatingEntity.FlowIdPrev = currentFlowWaitingEntity.FlowIdPrev;
                //CurrentWatingEntity.UserId = CurrentUserInfo.Employee_ID;
                //CurrentWatingEntity.UserName = CurrentUserInfo.Name;
                //CurrentWatingEntity.UserIdPrev = currentFlowWaitingEntity.UserIdPrev;
                //CurrentWatingEntity.UserNamePrev = currentFlowWaitingEntity.UserNamePrev;
                //CurrentWatingEntity.UserDeptId = CurrentUserInfo.Dept_ID;
                //CurrentWatingEntity.UserDeptName = CurrentUserInfo.Dept_Name;
                //CurrentWatingEntity.StepId = currentFlowWaitingEntity.StepId;
                //CurrentWatingEntity.StepName = currentFlowWaitingEntity.StepName;
                //CurrentWatingEntity.RoleId = currentFlowWaitingEntity.RoleId;
                //CurrentWatingEntity.RoleName = currentFlowWaitingEntity.RoleName;
                //CurrentWatingEntity.Opinion = string.IsNullOrEmpty(opinion.Trim()) ? "不同意" : opinion.Trim();
                //CurrentWatingEntity.OpinionType = "4";
                //CurrentWatingEntity.AllowFlag = 0;// “不同意”或“退回”赋值0，“同意”赋值1。
                //CurrentWatingEntity.TargetId = currentFlowWaitingEntity.TargetId;
                //CurrentWatingEntity.TargetItemId = currentFlowWaitingEntity.TargetItemId;
                //CurrentWatingEntity.FinishPercent = currentFlowWaitingEntity.FinishPercent;
                //CurrentWatingEntity.ActivityFlag = 1;
                //currentFlowWaitingEntity.SmType = currentFlowWaitingEntity.SmType;
                //SuperviseMissionWorkFlow.SendBack(CurrentWatingEntity, prevFlowId); 
                #endregion

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "操作成功"
                };

            }
            catch (Exception ex)
            {
                WriteLog("主办单位任务反馈-退回时出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "退回出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        /// <summary>
        /// 主办单位任务反馈发送处理
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId">当前主办单位任意措施的流程ID</param>
        /// <param name="entity"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage14(string smId, int flowId, FreeFlowSendRequestEntity entity)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                int intFinishPercent = 0;
                if (!flag && string.IsNullOrEmpty(entity.Percent.Trim()))
                {
                    strMsg = "参数错误：完成进度不允许为空";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.Opinion.Trim()))
                {
                    strMsg = "参数错误：反馈意见不允许为空";
                    flag = true;
                }
                if (!flag && !int.TryParse(entity.Percent, out intFinishPercent))
                {
                    strMsg = "参数错误：完成进度必须为整数";
                    flag = true;
                }
                if (!flag && (intFinishPercent < 0 | intFinishPercent > 100))
                {
                    strMsg = "参数错误：完成进度需介于0~100之间";
                    flag = true;
                }
                if (!flag && entity.Opinion.Length > _HOST_DEPT_FEEDBACK_MAX_LENGTH)
                {
                    strMsg = "参数错误：反馈意见最大长度不能超过" + _HOST_DEPT_FEEDBACK_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (!flag && entity.NextStep == null)
                {
                    strMsg = "请先选择下一步骤信息";
                    flag = true;
                }
                if (!flag && (string.IsNullOrEmpty(entity.NextStep.StepId) || string.IsNullOrEmpty(entity.NextStep.StepName)))
                {
                    strMsg = "请先选择下一步骤信息";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.NextStep.UserId))
                {
                    strMsg = "请先选择当前骤对应的处理部门/处理人信息";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //1.获取当前待办信息
                var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                if (flowWaitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前待办信息"
                    };
                }
                //2.获取措施信息
                var itemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(flowWaitingEntity.TargetItemId);
                if (itemEntity == null || itemEntity.ActivityFlag != 1)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前措施信息"
                    };
                }

                #region 3.获取新的待办

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.StepId = "ZBDWRWFK";
                CurrentWatingEntity.StepName = "主办单位任务反馈";
                CurrentWatingEntity.Opinion = entity.Opinion;
                CurrentWatingEntity.OpinionType = "7";//默认"反馈意见"意见类型
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FinishPercent = intFinishPercent;
                CurrentWatingEntity.TargetId = flowWaitingEntity.TargetId;

                var nextStepEntity = new SmSystemStepDefinitionEntity()
                {
                    StepId = entity.NextStep.StepId,
                    StepName = entity.NextStep.StepName
                };

                var newFlowWaitingEntity = SuperviseMissionWorkFlow.GenerateWaitingFlowItemForSpecailStep(CurrentWatingEntity, nextStepEntity);

                #endregion

                //4.更新任务子表（主办单位记录）
                SuperviseMissionBodyBiz.UpdateLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity()
                {
                    SmId = smId,
                    LmmId = flowWaitingEntity.TargetId,
                    FinishPercent = intFinishPercent
                });

                //5.流转
                newFlowWaitingEntity.AllowFlag = 1;
                newFlowWaitingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                newFlowWaitingEntity.UserName = this.CurrentUserInfo.Name;
                newFlowWaitingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                newFlowWaitingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                newFlowWaitingEntity.FinishPercent = intFinishPercent;

                SmFlowWaitingEntity NextWatingEntity = new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = entity.NextStep.StepId,
                    StepName = entity.NextStep.StepName
                };
                if (entity.NextStep.RoleType == "1")
                {
                    //个人角色
                    NextWatingEntity.UserName = entity.NextStep.UserName;
                    NextWatingEntity.UserId = entity.NextStep.UserId;
                }
                else if (entity.NextStep.RoleType == "2")
                {
                    //部门角色
                    NextWatingEntity.FlowDeptId = entity.NextStep.UserId;
                }

                SuperviseMissionWorkFlow.Send(newFlowWaitingEntity, NextWatingEntity);


                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "发送成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("主办单位任务反馈发送处理出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "发送出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 办公厅任务反馈

        /// <summary>
        /// 办公厅任务反馈--退回
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="opinion"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendBackByBGTRWFK(string smId, string flowId, string opinion)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                int intFlowId = 0;
                if (!flag && string.IsNullOrEmpty(smId))
                {
                    strMsg = "参数错误：缺失文档ID";
                    flag = true;
                }
                if (!flag && !int.TryParse(flowId, out intFlowId))
                {
                    strMsg = "参数错误：无法获取当前流程ID";
                    flag = true;
                }
                if (!flag && !string.IsNullOrEmpty(opinion) && opinion.Trim().Length > _OPINION_MAX_LENGTH)
                {
                    strMsg = "参数错误：退回理由最大长度不能超过" + _OPINION_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //获取主表信息
                var smMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId, ActivityFlag = 1 });

                //获取当前待办信息
                var currentFlowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = intFlowId });
                if (currentFlowWaitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前待办信息"
                    };
                }

                //获取主办单位信息
                var mainDeptEntity = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity() { ActivityFlag = 1, LmmId = currentFlowWaitingEntity.TargetId });
                if(mainDeptEntity== null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前主办单位信息"
                    };
                }

                #region 依据当前主办单位是否已分解措施决定退回的步骤

                var prevStepId = "";    //上一步步骤ID
                var prevStepName = "";  //上一步步骤名称

                var itemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(new SmTargetItemEntity() { SmId = smId, ActivityFlag = 1, TargetId = mainDeptEntity.LmmId });
                if (itemList != null && itemList.Any())
                {
                    //已分解措施的
                    prevStepId = "ZBDWRWFK";
                    prevStepName = "主办单位任务反馈";
                }
                else
                {
                    //直接反馈的
                    prevStepId = "RWFK";
                    prevStepName = "任务反馈";
                }

                #endregion

                //流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = intFlowId;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = string.IsNullOrEmpty(opinion.Trim()) ? "不同意" : opinion.Trim();
                CurrentWatingEntity.OpinionType = "8";//默认"退回意见"意见类型
                CurrentWatingEntity.AllowFlag = 1;

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = prevStepId,
                    StepName = prevStepName,
                    FlowDeptId = mainDeptEntity.DeptId
                });

                #region 调用引擎接口，对退回进行特殊处理

                SmFlowFinishEntity tempCurrentFlowItem = new SmFlowFinishEntity();
                tempCurrentFlowItem.SmId = smId;
                tempCurrentFlowItem.FlowId = intFlowId;
                tempCurrentFlowItem.SmType = smMainEntity.SmType;
                tempCurrentFlowItem.UserId = CurrentUserInfo.Employee_ID;
                tempCurrentFlowItem.UserName = CurrentUserInfo.Name;
                tempCurrentFlowItem.UserDeptId = CurrentUserInfo.Dept_ID;
                tempCurrentFlowItem.UserDeptName = CurrentUserInfo.Dept_Name;

                SmFlowWaitingEntity tempNextFlowItem = new SmFlowWaitingEntity();
                tempNextFlowItem.FlowDeptId = mainDeptEntity.DeptId;
                tempNextFlowItem.StepId = prevStepId;

                SuperviseMissionWorkFlow.GenerateWaitingFlowItemForReturnBack(tempCurrentFlowItem, tempNextFlowItem, false);

                #endregion

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "操作成功"
                };

            }
            catch (Exception ex)
            {
                WriteLog("办公厅任务反馈--退回时出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "退回出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        /// <summary>
        /// 办公厅任务反馈发送
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage15(string smId, int flowId, FreeFlowSendRequestEntity entity)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                int intFinishPercent = 0;
                if (!flag && string.IsNullOrEmpty(entity.Percent.Trim()))
                {
                    strMsg = "参数错误：完成进度不允许为空";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(entity.Opinion.Trim()))
                {
                    strMsg = "参数错误：反馈意见不允许为空";
                    flag = true;
                }
                if (!flag && !int.TryParse(entity.Percent, out intFinishPercent))
                {
                    strMsg = "参数错误：完成进度必须为整数";
                    flag = true;
                }
                if (!flag && (intFinishPercent < 0 | intFinishPercent > 100))
                {
                    strMsg = "参数错误：完成进度需介于0~100之间";
                    flag = true;
                }
                if (!flag && entity.Opinion.Length > _MISSION_FEEDBACK_MAX_LENGTH)
                {
                    strMsg = "参数错误：反馈意见最大长度不能超过" + _MISSION_FEEDBACK_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (!flag && entity.NextStep == null)
                {
                    strMsg = "请先选择下一步骤信息";
                    flag = true;
                }
                if (!flag && (string.IsNullOrEmpty(entity.NextStep.StepId) || string.IsNullOrEmpty(entity.NextStep.StepName)))
                {
                    strMsg = "请先选择下一步骤信息";
                    flag = true;
                }
                if (entity.NextStep.StepId.ToUpper() != "JS" && entity.NextStep.StepId.ToUpper() != "FKJS")
                {
                    if (!flag && string.IsNullOrEmpty(entity.NextStep.UserId))
                    {
                        strMsg = "请先选择当前骤对应的处理部门/处理人信息";
                        flag = true;
                    }
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //获取当前待办信息
                var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                if (flowWaitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前待办信息"
                    };
                }
                //获取当前主表信息
                var smMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId });
                if (smMainEntity == null || smMainEntity.ActivityFlag != 1)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前任务信息"
                    };
                }

                //更新任务主表
                SuperviseMissionBodyBiz.UpdateSmMainEntity(new SmMainEntity() { SmId = smId, FinshPercent = intFinishPercent });

                SmFlowWaitingEntity NextWatingEntity = new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = entity.NextStep.StepId,
                    StepName = entity.NextStep.StepName
                };
                if (entity.NextStep.RoleType == "1")
                {
                    //个人角色
                    NextWatingEntity.UserName = entity.NextStep.UserName;
                    NextWatingEntity.UserId = entity.NextStep.UserId;
                }
                else if (entity.NextStep.RoleType == "2")
                {
                    //部门角色
                    NextWatingEntity.FlowDeptId = entity.NextStep.UserId;
                }

                if ("JS".Equals(entity.NextStep.StepId.ToUpper()))
                {
                    //结束步骤，无需获取新的待办
                    SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                    CurrentWatingEntity.SmId = smId;
                    CurrentWatingEntity.FlowId = flowId;
                    CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                    CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                    CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                    CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                    CurrentWatingEntity.Opinion = entity.Opinion;
                    CurrentWatingEntity.OpinionType = "4";//这个意见类型最后要传入
                    CurrentWatingEntity.AllowFlag = 1;
                    CurrentWatingEntity.FinishPercent = intFinishPercent;
                    SuperviseMissionWorkFlow.Send(CurrentWatingEntity, NextWatingEntity);
                }
                else
                {
                    #region 获取新的待办

                    SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                    CurrentWatingEntity.SmId = smId;
                    CurrentWatingEntity.FlowId = flowId;
                    CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                    CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                    CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                    CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                    CurrentWatingEntity.StepId = "BGTRWFK";
                    CurrentWatingEntity.StepName = "办公厅任务反馈";
                    CurrentWatingEntity.Opinion = entity.Opinion;
                    CurrentWatingEntity.OpinionType = "7";//默认"反馈意见"意见类型
                    CurrentWatingEntity.AllowFlag = 1;
                    CurrentWatingEntity.FinishPercent = intFinishPercent;

                    var nextStepEntity = new SmSystemStepDefinitionEntity()
                    {
                        StepId = entity.NextStep.StepId,
                        StepName = entity.NextStep.StepName
                    };

                    var newFlowWaitingEntity = SuperviseMissionWorkFlow.GenerateWaitingFlowItemForSpecailStep(CurrentWatingEntity, nextStepEntity);

                    #endregion

                    //流转
                    newFlowWaitingEntity.AllowFlag = 1;
                    newFlowWaitingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                    newFlowWaitingEntity.UserName = this.CurrentUserInfo.Name;
                    newFlowWaitingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                    newFlowWaitingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;
                    newFlowWaitingEntity.FinishPercent = intFinishPercent;

                    SuperviseMissionWorkFlow.Send(newFlowWaitingEntity, NextWatingEntity);
                }


                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "发送成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("办公厅任务反馈发送处理出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "发送出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 部门审核、部门审批、秘书处理发送处理

        /// <summary>
        /// 部门审核、部门审批、秘书处理发送处理
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="opinion"></param>
        ///  <param name="opinionType"></param>
        /// <param name="nextStep">下一步处理步骤、处理人信息</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPageByFreeFlow(string smId, int flowId, string opinion, string opinionType, NextStepModel nextStep)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                if (!flag && !string.IsNullOrEmpty(opinion) && opinion.Trim().Length > _OPINION_MAX_LENGTH)
                {
                    strMsg = "审批意见最大长度不能超过" + _OPINION_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (!flag && nextStep == null)
                {
                    strMsg = "请先选择下一步骤信息";
                    flag = true;
                }
                if (!flag && (string.IsNullOrEmpty(nextStep.StepId) || string.IsNullOrEmpty(nextStep.StepName)))
                {
                    strMsg = "请先选择下一步骤信息";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(nextStep.UserId))
                {
                    strMsg = "请先选择当前骤对应的处理人信息";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //获取当前待办信息
                var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                if (flowWaitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前待办信息"
                    };
                }

                //意见类型处理
                if (flowWaitingEntity.StepId == "BMSP")
                {
                    opinionType = "9";//默认"审批意见"类型
                }
                else if(flowWaitingEntity.StepId == "BMSH")
                {
                    opinionType = "10";//默认"审核意见"类型
                }

                //流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = Convert.ToInt32(flowId);
                CurrentWatingEntity.OpinionType = opinionType;
                CurrentWatingEntity.Opinion = string.IsNullOrEmpty(opinion) ? "同意" : opinion.Trim();
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;

                SmFlowWaitingEntity NextWatingEntity = new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = nextStep.StepId,
                    StepName = nextStep.StepName
                };
                if (nextStep.RoleType == "1")
                {
                    //个人角色
                    NextWatingEntity.UserName = nextStep.UserName;
                    NextWatingEntity.UserId = nextStep.UserId;
                }
                else if (nextStep.RoleType == "2")
                {
                    //部门角色
                    NextWatingEntity.FlowDeptId = nextStep.UserId;
                }

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, NextWatingEntity);

                //如果下一步为主流程的步骤(责任处室措施反馈、主办单位任务反馈、办公厅任务反馈)，则需调用重置为多条待办接口
                if (nextStep.StepId == "ZRCSCSFK" || nextStep.StepId == "ZBDWRWFK" || nextStep.StepId == "BGTRWFK")
                {
                    //获取主表信息
                    var smMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId, ActivityFlag = 1 });

                    #region 调用引擎接口，对不同意进行特殊处理

                    SmFlowFinishEntity tempCurrentFlowItem = new SmFlowFinishEntity();
                    tempCurrentFlowItem.SmId = smId;
                    tempCurrentFlowItem.FlowId = Convert.ToInt32(flowId);
                    tempCurrentFlowItem.SmType = smMainEntity.SmType;
                    tempCurrentFlowItem.UserId = CurrentUserInfo.Employee_ID;
                    tempCurrentFlowItem.UserName = CurrentUserInfo.Name;
                    tempCurrentFlowItem.UserDeptId = CurrentUserInfo.Dept_ID;
                    tempCurrentFlowItem.UserDeptName = CurrentUserInfo.Dept_Name;

                    SmFlowWaitingEntity tempNextFlowItem = new SmFlowWaitingEntity();
                    tempNextFlowItem.FlowDeptId = flowWaitingEntity.FlowDeptId;
                    tempNextFlowItem.StepId = nextStep.StepId;

                    SuperviseMissionWorkFlow.GenerateWaitingFlowItemForReturnBack(tempCurrentFlowItem, tempNextFlowItem, false);

                    #endregion
                }


                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "发送成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("自由流发送处理出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "发送出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        /// <summary>
        /// 部门审核、部门审批不同意处理（退回上一步）
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="opinion"></param>
        ///  <param name="opinionType"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse ReurnBackPrevStep(string smId, int flowId, string opinion, string opinionType)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                if (!flag && !string.IsNullOrEmpty(opinion) && opinion.Trim().Length > _OPINION_MAX_LENGTH)
                {
                    strMsg = "审批意见最大长度不能超过" + _OPINION_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //获取当前待办信息
                var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                if (flowWaitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前待办信息"
                    };
                }

                //获取主表信息
                var smMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId, ActivityFlag = 1 });

                //意见类型处理
                if (flowWaitingEntity.StepId == "BMSP")
                {
                    opinionType = "9";//默认"审批意见"类型
                }
                else if (flowWaitingEntity.StepId == "BMSH")
                {
                    opinionType = "10";//默认"审核意见"类型
                }

                //流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = Convert.ToInt32(flowId);
                CurrentWatingEntity.OpinionType = opinionType;
                CurrentWatingEntity.Opinion = string.IsNullOrEmpty(opinion) ? "不同意" : opinion.Trim();
                CurrentWatingEntity.AllowFlag = 0;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;

                //获取上一步流程信息
                var prevFlowItem = SuperviseMissionWorkFlow.GetReurnBackPrevFlowItem(smId, Convert.ToInt32(flowId));
                SmFlowWaitingEntity NextWatingEntity = new SmFlowWaitingEntity();
                NextWatingEntity.SmId = smId;
                NextWatingEntity.StepId = prevFlowItem.StepId;
                NextWatingEntity.StepName = prevFlowItem.StepName;
                NextWatingEntity.UserId = prevFlowItem.UserId;
                NextWatingEntity.UserName = prevFlowItem.UserName;
                NextWatingEntity.FlowDeptId = prevFlowItem.FlowDeptId;

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, NextWatingEntity);

                //如果上一步为主流程的步骤(责任处室措施反馈、主办单位任务反馈、办公厅任务反馈)，则需调用重置为多条待办接口
                if (prevFlowItem.StepId == "ZRCSCSFK" || prevFlowItem.StepId == "ZBDWRWFK" || prevFlowItem.StepId == "BGTRWFK")
                {
                    #region 调用引擎接口，对不同意进行特殊处理

                    SmFlowFinishEntity tempCurrentFlowItem = new SmFlowFinishEntity();
                    tempCurrentFlowItem.SmId = smId;
                    tempCurrentFlowItem.FlowId = Convert.ToInt32(flowId);
                    tempCurrentFlowItem.SmType = smMainEntity.SmType;
                    tempCurrentFlowItem.UserId = CurrentUserInfo.Employee_ID;
                    tempCurrentFlowItem.UserName = CurrentUserInfo.Name;
                    tempCurrentFlowItem.UserDeptId = CurrentUserInfo.Dept_ID;
                    tempCurrentFlowItem.UserDeptName = CurrentUserInfo.Dept_Name;

                    SmFlowWaitingEntity tempNextFlowItem = new SmFlowWaitingEntity();
                    tempNextFlowItem.FlowDeptId = prevFlowItem.FlowDeptId;
                    tempNextFlowItem.StepId = prevFlowItem.StepId;

                    SuperviseMissionWorkFlow.GenerateWaitingFlowItemForReturnBack(tempCurrentFlowItem, tempNextFlowItem, false);

                    #endregion
                }


                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "操作成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("审核、审批退回上一步出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "操作出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        /// <summary>
        /// 领导的发送处理
        /// </summary>
        /// <param name="smId">主表ID</param>
        /// <param name="flowId">流程ID</param>
        /// <param name="opinion">意见</param>
        /// <param name="allowFlag">是否同意</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPageForLeader(string smId, int flowId, string opinion, int allowFlag)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                if (!flag && !string.IsNullOrEmpty(opinion) && opinion.Trim().Length > _OPINION_MAX_LENGTH)
                {
                    strMsg = "审批意见最大长度不能超过" + _OPINION_MAX_LENGTH + "个字符";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //获取当前待办信息
                var flowWaitingEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                if (flowWaitingEntity == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "无法获取当前待办信息"
                    };
                }

                string opinionType = string.Empty;
                //意见类型处理
                if (flowWaitingEntity.StepId == "BMSP")
                {
                    opinionType = "9";//默认"审批意见"类型
                }
                else if (flowWaitingEntity.StepId == "BMSH")
                {
                    opinionType = "10";//默认"审核意见"类型
                }

                //流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowId;
                CurrentWatingEntity.OpinionType = opinionType;
                CurrentWatingEntity.Opinion = string.IsNullOrEmpty(opinion) ? (allowFlag == 1 ? "同意" : "不同意") : opinion.Trim();
                CurrentWatingEntity.AllowFlag = allowFlag;
                CurrentWatingEntity.UserId = this.CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = this.CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = this.CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = this.CurrentUserInfo.Dept_Name;

                //下一步处理人信息
                SmFlowWaitingEntity NextWatingEntity = new SmFlowWaitingEntity();
                NextWatingEntity.SmId = smId;
                NextWatingEntity.StepId = "MSCL";
                NextWatingEntity.StepName = "秘书处理";
                NextWatingEntity.FlowDeptId = flowWaitingEntity.FlowDeptId;

                //获取当前流程部门秘书角色用户集合
                var secretaryList = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(new SmBasicDataDeptRoleDefinitionEntity() { DeptId = flowWaitingEntity.FlowDeptId, RoleId = "MS" });
                if (secretaryList == null || !secretaryList.Any())
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败：当前部门秘书角色尚未配置或已删除"
                    };
                }

                //获取上一步步骤信息
                var finishFlowList = SuperviseMissionWorkFlow.GetSmFlowItemList(new SmFlowFinishEntity() { SmId = smId });
                var prevFlowEntity = finishFlowList.FirstOrDefault(m => m.ActivityFlag == 1 && m.FlowId == flowWaitingEntity.FlowIdPrev);
                if (prevFlowEntity != null)
                {
                    if (secretaryList.Any(m => m.MemberId == prevFlowEntity.UserId))
                    {
                        //上一步处理人为秘书角色用户，直接发送回去
                        NextWatingEntity.UserId = prevFlowEntity.UserId;
                        NextWatingEntity.UserName = prevFlowEntity.UserName;
                    }
                    else
                    {
                        //上一步处理非秘书角色用户，给所有秘书都发一条
                        NextWatingEntity.UserId = string.Join(";", secretaryList.Select(m => m.MemberId).ToArray());
                        NextWatingEntity.UserName = string.Join(";", secretaryList.Select(m => m.MemberName).ToArray());
                    }
                }
                else
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败：无法获取上一步处理信息"
                    };
                }

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, NextWatingEntity);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "发送成功"
                };
            }
            catch (Exception ex)
            {
                WriteLog("领导发送出错：" + ex.Message, ErrorTypeEnumEntity.UI, ModuleTypeEnumEntity.LeaderMeetingMissionForm);
                string msg = "";
                NullReferenceException nrex = ex as NullReferenceException;
                if (nrex != null)
                {
                    msg = nrex.Message;
                }
                else
                {
                    msg = "操作出错";
                }
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = msg
                };
            }
        }

        #endregion

        #region 获取自由流步骤与处理人信息

        /// <summary>
        /// 获取下一步步骤（自由流）
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetNextStepFreeList(string smId, int flowId)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                var nextStepEntityList = SuperviseMissionWorkFlow.GetNextStep(smId, flowId);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "获取成功",
                    data = JsonHelper.ToJson(nextStepEntityList)
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = ex.Message
                };
            }
        }

        /// <summary>
        /// 获取自由流步骤处理人信息
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowId"></param>
        /// <param name="stepId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetUserListByStepFree(string smId, int flowId, string stepId)
        {
            try
            {
                #region  登录校验
                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }
                #endregion
                #region 越权校验
                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return UrlCheckResponse;
                }
                #endregion

                //TODO 检验参数合法性

                #region 非空性检查

                bool flag = false;
                string strMsg = "";
                if (!flag && string.IsNullOrEmpty(smId))
                {
                    strMsg = "参数错误：缺失文档ID";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(stepId))
                {
                    strMsg = "参数错误：缺失当前步骤信息";
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = strMsg
                    };
                }

                #endregion

                //1.获取流转的deptid
                var flowEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity() { SmId = smId, FlowId = flowId });

                //2.获取下一步处理人信息
                List<StepUserEntity> stepUsers = SuperviseMissionWorkFlow.GetUserListByStep(flowEntity.FlowDeptId, stepId, smId, flowEntity.TargetId, flowEntity.TargetItemId, CurrentUserInfo.Employee_ID, CurrentUserInfo.Name);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(stepUsers),
                    message = "成功"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "-1",
                    message = ex.Message
                };
            }
        }

        #endregion
    }
}
