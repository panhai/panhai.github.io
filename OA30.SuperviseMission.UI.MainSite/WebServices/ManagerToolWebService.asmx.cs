namespace OA30.SuperviseMission.UI.MainSite.WebServices
{
    using OA30.SuperviseMission.Common.Entity.Mission;
    using OA30.SuperviseMission.Common.Entity.Mission.Enum;
    using OA30.SuperviseMission.Common.Interface.Mission;
    using OA30.SuperviseMission.UI.CommonComponents;
    using OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys;
    using RequestEntitys;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web.Services;

    /// <summary>
    /// 运维管理员工具服务接口。
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class ManagerToolWebService : BaseWebService
    {
        protected ISuperviseMissionFormManage _SuperviseMissionFormManageBiz;
        protected ISuperviseMissionFormManage SuperviseMissionFormManageBiz
        {
            get
            {
                if (_SuperviseMissionFormManageBiz == null)
                {
                    _SuperviseMissionFormManageBiz = objCreator.CreateObject<ISuperviseMissionFormManage>();
                }
                return _SuperviseMissionFormManageBiz;
            }
        }

        /// <summary>
        /// 更新表单信息。
        /// </summary>
        /// <param name="mainTargetItems">任务目标措施实体信息。</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse UpdateMainTargetItem(List<MainTargetItem> mainTargetItems)
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

                string modifyContent = "";

                foreach (var item in mainTargetItems)
                {
                    if (!String.IsNullOrEmpty(item.SmId))
                    {
                        #region 1)更新任务。

                        //督查编号校验。
                        if (item.NumberCode > 0
                            && !string.IsNullOrEmpty(item.NumberName)
                            && !string.IsNullOrEmpty(item.NumberYear))
                        {
                            if (SuperviseMissionBodyBiz.ExistSmNumberCode(item.SmId, item.NumberCode, item.NumberName,
                                item.NumberYear))
                            {
                                return new SuperviseMissionResponse
                                {
                                    status = "0",
                                    message = "更新出错，督查编号已存在，请重新输入。"
                                };
                            }
                        }

                        if (String.IsNullOrEmpty(item.TargetId))
                        {
                            // 更新前将修改前与修改后的值写入日志，下同。
                            var mainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = item.SmId });
                            if (mainEntity != null)
                            {
                                modifyContent = String.Format("修改前[SmId={0},TaskContent={1},MainLeaderId={2},MainLeaderName={3},AssistLeaderId={4},AssistLeaderName={5},AssistDeptId={6},AssistDeptName={7},NumberName={8},NumberCode={9},NumberYear={10}]",
                                    mainEntity.SmId, mainEntity.TaskContent, mainEntity.MainLeaderId, mainEntity.MainLeaderName, mainEntity.AssistLeaderId, mainEntity.AssistLeaderName, mainEntity.AssistDeptId, mainEntity.AssistDeptName, item.NumberName, item.NumberCode, item.NumberYear);
                                modifyContent += String.Format(",修改后[SmId={0},TaskContent={1},MainLeaderId={2},MainLeaderName={3},AssistLeaderId={4},AssistLeaderName={5},AssistDeptId={6},AssistDeptName={7},NumberName={8},NumberCode={9},NumberYear={10}]",
                                    item.SmId, item.TaskContent, item.MainLeaderId, item.MainLeaderName, item.AssLeaderId, item.AssLeaderName, item.AssistDeptId, item.AssistDeptName, item.NumberName, item.NumberCode, item.NumberYear);
                            }

                            UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                            {
                                Content = modifyContent,
                                ErrorType = (int?)ErrorTypeEnumEntity.SUCCESSED,
                                ErrorTypeName = ErrorTypeEnumEntity.SUCCESSED.ToString(),
                                LayerType = (int?)LayerTypeEnumEntity.UI,
                                LayerName = LayerTypeEnumEntity.UI.ToString(),
                                ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                                ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                                OpreateTime = DateTime.Now,
                                OpreatorDeptId = CurrentUserInfo.Dept_ID,
                                OpreatorDeptName = CurrentUserInfo.Dept_Name,
                                OpreatorId = CurrentUserInfo.Employee_ID,
                                OpreatorName = CurrentUserInfo.Name,
                                OpreatorIp = CurrentUserInfo.IP
                            });

                            SuperviseMissionBodyBiz.UpdateSmMainEntity(new SmMainEntity()
                            {
                                SmId = item.SmId,
                                TaskContent = item.TaskContent,
                                MainLeaderId = item.MainLeaderId,
                                MainLeaderName = item.MainLeaderName,
                                AssistLeaderId = item.AssLeaderId,
                                AssistLeaderName = item.AssLeaderName,
                                AssistDeptId = item.AssistDeptId,
                                AssistDeptName = item.AssistDeptName,
                                SpNumberName = item.NumberName,
                                SpNumberCode = item.NumberCode,
                                SpNumberYear = item.NumberYear,
                                MainDeptName = item.MainDeptName,
                                MainDeptId = item.MainDeptId
                            });
                        }
                        #endregion

                        #region 2)更新目标。
                        if (!String.IsNullOrEmpty(item.TargetId) && String.IsNullOrEmpty(item.ItemId))
                        {
                            var targetEntity = SuperviseMissionBodyBiz.GetSmTargetEntity(new SmTargetEntity() { SmId = item.SmId, TargetId = item.TargetId });
                            if (targetEntity != null)
                            {
                                modifyContent = String.Format("修改前[TargetId={0},TargetName={1},TargetPercent={2}]", targetEntity.TargetId, targetEntity.TargetName, targetEntity.TargetPercent);
                                modifyContent += String.Format(",修改后[TargetId={0},TargetName={1},TargetPercent={2}]", item.TargetId, item.TargetName, item.TargetPercent);
                            }

                            UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                            {
                                Content = modifyContent,
                                ErrorType = (int?)ErrorTypeEnumEntity.SUCCESSED,
                                ErrorTypeName = ErrorTypeEnumEntity.SUCCESSED.ToString(),
                                LayerType = (int?)LayerTypeEnumEntity.UI,
                                LayerName = LayerTypeEnumEntity.UI.ToString(),
                                ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                                ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                                OpreateTime = DateTime.Now,
                                OpreatorDeptId = CurrentUserInfo.Dept_ID,
                                OpreatorDeptName = CurrentUserInfo.Dept_Name,
                                OpreatorId = CurrentUserInfo.Employee_ID,
                                OpreatorName = CurrentUserInfo.Name,
                                OpreatorIp = CurrentUserInfo.IP
                            });

                            int result = 0;
                            if (item.TargetPercent != null)
                            {
                                Int32.TryParse(item.TargetPercent.Replace("%", ""), out result);
                            }

                            SuperviseMissionBodyBiz.UpdateSmTargetEntity(new SmTargetEntity()
                            {
                                SmId = item.SmId,
                                TargetId = item.TargetId,
                                TargetName = item.TargetName,
                                TargetPercent = result,
                                MainDeptId = item.MainDeptId,
                                MainDeptName = item.MainDeptName
                            });
                        }
                        #endregion

                        #region 3)更新措施。
                        if (!String.IsNullOrEmpty(item.TargetId) && !String.IsNullOrEmpty(item.ItemId))
                        {
                            var targetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity() { SmId = item.SmId, TargetId = item.TargetId, ItemId = item.ItemId });
                            if (targetItemEntity != null)
                            {
                                // 判断是否是子措施且更改了责任人，或者是措施且更改了责任单位。
                                if (!String.IsNullOrEmpty(item.ParentTargetItemId))
                                {
                                    // 是子措施则判断是否更改了责任人。
                                    if (targetItemEntity.ExcutorId != item.ExcutorId)
                                    {
                                        SuperviseMissionFormManageBiz.UpdateTargetItemExcutor(item.ItemId, item.ExcutorId, item.ExcutorName);
                                    }
                                }
                                else
                                {
                                    // 是措施则判断是否更改了责任处室。
                                    if (targetItemEntity.DutyDeptId != item.DutyDeptId)
                                    {
                                        SuperviseMissionFormManageBiz.UpdateTargetItemDutyDept(item.ItemId, item.DutyDeptId, item.DutyDeptName);
                                    }
                                }


                                modifyContent = String.Format("修改前[ItemId={0},ItemName={1},AssistDeptId={2},AssistDeptName={3},DeadLineTime={4},FinshPercent={5}]",
                                    targetItemEntity.ItemId, targetItemEntity.ItemName, targetItemEntity.AssistDeptId, targetItemEntity.AssistDeptName, targetItemEntity.DeadLineTime, targetItemEntity.FinshPercent);
                                modifyContent += String.Format(",修改后[ItemId={0},ItemName={1},AssistDeptId={2},AssistDeptName={3},DeadLineTime={4},FinshPercent={5}]",
                                    item.ItemId, item.ItemName, item.AssistDeptId, item.AssistDeptName, item.DeadLineTime, item.FinshPercent);
                            }

                            UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                            {
                                Content = modifyContent,
                                ErrorType = (int?)ErrorTypeEnumEntity.SUCCESSED,
                                ErrorTypeName = ErrorTypeEnumEntity.SUCCESSED.ToString(),
                                LayerType = (int?)LayerTypeEnumEntity.UI,
                                LayerName = LayerTypeEnumEntity.UI.ToString(),
                                ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                                ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                                OpreateTime = DateTime.Now,
                                OpreatorDeptId = CurrentUserInfo.Dept_ID,
                                OpreatorDeptName = CurrentUserInfo.Dept_Name,
                                OpreatorId = CurrentUserInfo.Employee_ID,
                                OpreatorName = CurrentUserInfo.Name,
                                OpreatorIp = CurrentUserInfo.IP
                            });

                            int result = 0;
                            if (item.TargetPercent != null)
                            {
                                Int32.TryParse(item.TargetPercent.Replace("%", ""), out result);
                            }

                            SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(new SmTargetItemEntity()
                            {
                                SmId = item.SmId,
                                TargetId = item.TargetId,
                                ItemId = item.ItemId,
                                ItemName = item.ItemName,
                                AssistDeptId = item.AssistDeptId,
                                AssistDeptName = item.AssistDeptName,
                                DeadLineTime = Convert.ToDateTime(item.DeadLineTime),
                                FinshPercent = result,
                                DutyDeptId = item.DutyDeptId,
                                DutyDeptName = item.DutyDeptName,
                                ExcutorId = item.ExcutorId,
                                ExcutorName = item.ExcutorName
                            });
                        }
                        #endregion
                    }
                }

                return new SuperviseMissionResponse
                {
                    data = "",
                    status = "1",
                    message = "成功。"
                };
            }
            catch (Exception ex)
            {
                UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                {
                    Content = "修改表单失败：" + ex.Message,
                    ErrorType = (int?)ErrorTypeEnumEntity.UI,
                    ErrorTypeName = ErrorTypeEnumEntity.UI.ToString(),
                    LayerType = (int?)LayerTypeEnumEntity.UI,
                    LayerName = LayerTypeEnumEntity.UI.ToString(),
                    ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                    ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                    OpreateTime = DateTime.Now,
                    OpreatorDeptId = CurrentUserInfo.Dept_ID,
                    OpreatorDeptName = CurrentUserInfo.Dept_Name,
                    OpreatorId = CurrentUserInfo.Employee_ID,
                    OpreatorName = CurrentUserInfo.Name,
                    OpreatorIp = CurrentUserInfo.IP
                });

                return new SuperviseMissionResponse
                {
                    status = "0",
                    message = ex.Message
                };
            }
        }

        private string GetDeptString(List<string> depts)
        {
            int count = 0;
            var deptString = "";
            foreach (var dept in depts)
            {
                if (count == 0)
                {
                    deptString = dept;
                }
                else
                {
                    deptString = deptString + ";" + dept;
                }

                count++;
            }

            return deptString;
        }

        /// <summary>
        /// 更新领导表单信息。
        /// </summary>
        /// <param name="mainTargetItems">任务目标措施实体信息。</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse UpdateLDMainTargetItem(List<MainTargetItem> mainTargetItems)
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

                string modifyContent = "";

                foreach (var item in mainTargetItems)
                {
                    if (!String.IsNullOrEmpty(item.SmId))
                    {
                        #region 1)更新任务。

                        //督查编号校验。
                        if (item.NumberCode > 0
                            && !string.IsNullOrEmpty(item.NumberName)
                            && !string.IsNullOrEmpty(item.NumberYear))
                        {
                            if (SuperviseMissionBodyBiz.ExistSmNumberCode(item.SmId, item.NumberCode, item.NumberName,
                                item.NumberYear))
                            {
                                return new SuperviseMissionResponse
                                {
                                    status = "0",
                                    message = "更新出错，督查编号已存在，请重新输入。"
                                };
                            }
                        }

                        if (String.IsNullOrEmpty(item.TargetId))
                        {
                            // 更新前将修改前与修改后的值写入日志，下同。
                            var mainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = item.SmId });
                            if (mainEntity != null)
                            {
                                modifyContent = String.Format("修改前[SmId={0},TaskContent={1},MainLeaderId={2},MainLeaderName={3},AssistLeaderId={4},AssistLeaderName={5},AssistDeptId={6},AssistDeptName={7},NumberName={8},NumberCode={9},NumberYear={10}]",
                                    mainEntity.SmId, mainEntity.TaskContent, mainEntity.MainLeaderId, mainEntity.MainLeaderName, mainEntity.AssistLeaderId, mainEntity.AssistLeaderName, mainEntity.AssistDeptId, mainEntity.AssistDeptName, item.NumberName, item.NumberCode, item.NumberYear);
                                modifyContent += String.Format(",修改后[SmId={0},TaskContent={1},MainLeaderId={2},MainLeaderName={3},AssistLeaderId={4},AssistLeaderName={5},AssistDeptId={6},AssistDeptName={7},NumberName={8},NumberCode={9},NumberYear={10}]",
                                    item.SmId, item.TaskContent, item.MainLeaderId, item.MainLeaderName, item.AssLeaderId, item.AssLeaderName, item.AssistDeptId, item.AssistDeptName, item.NumberName, item.NumberCode, item.NumberYear);
                            }

                            UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                            {
                                Content = modifyContent,
                                ErrorType = (int?)ErrorTypeEnumEntity.SUCCESSED,
                                ErrorTypeName = ErrorTypeEnumEntity.SUCCESSED.ToString(),
                                LayerType = (int?)LayerTypeEnumEntity.UI,
                                LayerName = LayerTypeEnumEntity.UI.ToString(),
                                ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                                ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                                OpreateTime = DateTime.Now,
                                OpreatorDeptId = CurrentUserInfo.Dept_ID,
                                OpreatorDeptName = CurrentUserInfo.Dept_Name,
                                OpreatorId = CurrentUserInfo.Employee_ID,
                                OpreatorName = CurrentUserInfo.Name,
                                OpreatorIp = CurrentUserInfo.IP
                            });

                            var oldSmMainEntity =
                                SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = item.SmId });
                            var oldMainDeptIds = oldSmMainEntity.MainDeptId.Split(';').ToList();
                            var newMainDeptIds = item.MainDeptId.Split(';').ToList();

                            SuperviseMissionBodyBiz.UpdateSmMainEntity(new SmMainEntity()
                            {
                                SmId = item.SmId,
                                TaskContent = item.TaskContent,
                                MainLeaderId = item.MainLeaderId,
                                MainLeaderName = item.MainLeaderName,
                                AssistLeaderId = item.AssLeaderId,
                                AssistLeaderName = item.AssLeaderName,
                                AssistDeptId = item.AssistDeptId,
                                AssistDeptName = item.AssistDeptName,
                                SpNumberName = item.NumberName,
                                SpNumberCode = item.NumberCode,
                                SpNumberYear = item.NumberYear,
                                StartTime = item.StartTime,
                                MainDeptName = item.MainDeptName,
                                MainDeptId = item.MainDeptId
                            });

                            //如果两个数组内容和长度均相同，证明用户没改过主办单位，无需特殊处理,若有差异需要进行特殊处理。
                            if (oldMainDeptIds.Count != newMainDeptIds.Count || oldMainDeptIds.Count(t => !newMainDeptIds.Contains(t)) != 0)
                            {
                                var newSmMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = item.SmId });
                                SaveSmLeaderMeetingMissionChange(newSmMainEntity);
                            }
                        }
                        #endregion

                        #region 2)更新领导SM_LEADER_MEETING_MISSION表。
                        if (!String.IsNullOrEmpty(item.TargetId) && String.IsNullOrEmpty(item.ItemId))
                        {
                            var mainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = item.SmId });
                            var smLeaderMeetingMissionEntity = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity() { SmId = item.SmId, LmmId = item.TargetId });
                            if (smLeaderMeetingMissionEntity != null && !string.IsNullOrEmpty(item.MainDeptId) && !string.IsNullOrEmpty(item.MainDeptName))
                            {
                                modifyContent = String.Format("修改前[LmmId={0},FinishPercent={1}]", smLeaderMeetingMissionEntity.LmmId, smLeaderMeetingMissionEntity.FinishPercent);
                                modifyContent += String.Format(",修改后[LmmId={0},FinishPercent={1}]", item.TargetId, item.TargetPercent);
                            }

                            UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                            {
                                Content = modifyContent,
                                ErrorType = (int?)ErrorTypeEnumEntity.SUCCESSED,
                                ErrorTypeName = ErrorTypeEnumEntity.SUCCESSED.ToString(),
                                LayerType = (int?)LayerTypeEnumEntity.UI,
                                LayerName = LayerTypeEnumEntity.UI.ToString(),
                                ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                                ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                                OpreateTime = DateTime.Now,
                                OpreatorDeptId = CurrentUserInfo.Dept_ID,
                                OpreatorDeptName = CurrentUserInfo.Dept_Name,
                                OpreatorId = CurrentUserInfo.Employee_ID,
                                OpreatorName = CurrentUserInfo.Name,
                                OpreatorIp = CurrentUserInfo.IP
                            });

                            int result = 0;
                            if (item.TargetPercent != null)
                            {
                                Int32.TryParse(item.TargetPercent.Replace("%", ""), out result);
                            }

                            //如果领导子表存在这个主办单位，提示用户主办单位已被占用
                            if (SuperviseMissionBodyBiz.ExistLeaderMeetingMissionEntityByTZ(item.SmId, item.AssistDeptId, item.TargetId))
                            {
                                return new SuperviseMissionResponse
                                {
                                    status = "0",
                                    message = "修改失败，表单" + item.SmId + "已存在主办单位Id为" + item.AssistDeptId + "的流程，请用户重新选择。"
                                };
                            }
                            else
                            {
                                var smLeaderMeetingMission = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity
                                {
                                    LmmId = item.TargetId,
                                    ActivityFlag = 1
                                });
                                if (smLeaderMeetingMission != null)
                                {
                                    List<string> mainDeptIdList = mainEntity.MainDeptId.Split(';').ToList();
                                    List<string> mainDeptNameList = mainEntity.MainDeptName.Split(';').ToList();
                                    var oldDeptId = smLeaderMeetingMission.DeptId;
                                    var oldDeptName = smLeaderMeetingMission.DeptName;
                                    smLeaderMeetingMission.DeptId = item.AssistDeptId;
                                    smLeaderMeetingMission.DeptName = item.AssistDeptName;
                                    smLeaderMeetingMission.FinishPercent = result;
                                    SuperviseMissionBodyBiz.UpdateLeaderMeetingMissionEntity(smLeaderMeetingMission);
                                    mainDeptIdList.RemoveAll(n => n.Equals(oldDeptId));
                                    mainDeptNameList.RemoveAll(n => n.Equals(oldDeptName));
                                    mainDeptIdList.Add(item.AssistDeptId);
                                    mainDeptNameList.Add(item.AssistDeptName);
                                    mainEntity.MainDeptId = GetDeptString(mainDeptIdList);
                                    mainEntity.MainDeptName = GetDeptString(mainDeptNameList);
                                    SuperviseMissionBodyBiz.UpdateSmMainEntity(mainEntity);
                                }
                            }
                        }
                        #endregion

                        #region 3)更新措施。
                        if (!String.IsNullOrEmpty(item.TargetId) && !String.IsNullOrEmpty(item.ItemId))
                        {
                            var targetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity() { SmId = item.SmId, TargetId = item.TargetId, ItemId = item.ItemId });
                            if (targetItemEntity != null)
                            {
                                // 判断是否是子措施且更改了责任人，或者是措施且更改了责任单位。
                                if (!String.IsNullOrEmpty(item.ParentTargetItemId))
                                {
                                    // 是子措施则判断是否更改了责任人。
                                    if (targetItemEntity.ExcutorId != item.ExcutorId)
                                    {
                                        SuperviseMissionFormManageBiz.UpdateTargetItemExcutor(item.ItemId, item.ExcutorId, item.ExcutorName);
                                    }
                                }
                                else
                                {
                                    // 是措施则判断是否更改了责任处室。
                                    if (targetItemEntity.DutyDeptId != item.DutyDeptId)
                                    {
                                        SuperviseMissionFormManageBiz.UpdateTargetItemDutyDept(item.ItemId, item.DutyDeptId, item.DutyDeptName);
                                    }
                                }


                                modifyContent = String.Format("修改前[ItemId={0},ItemName={1},AssistDeptId={2},AssistDeptName={3},DeadLineTime={4},FinshPercent={5}]",
                                    targetItemEntity.ItemId, targetItemEntity.ItemName, targetItemEntity.AssistDeptId, targetItemEntity.AssistDeptName, targetItemEntity.DeadLineTime, targetItemEntity.FinshPercent);
                                modifyContent += String.Format(",修改后[ItemId={0},ItemName={1},AssistDeptId={2},AssistDeptName={3},DeadLineTime={4},FinshPercent={5}]",
                                    item.ItemId, item.ItemName, item.AssistDeptId, item.AssistDeptName, item.DeadLineTime, item.FinshPercent);
                            }

                            UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                            {
                                Content = modifyContent,
                                ErrorType = (int?)ErrorTypeEnumEntity.SUCCESSED,
                                ErrorTypeName = ErrorTypeEnumEntity.SUCCESSED.ToString(),
                                LayerType = (int?)LayerTypeEnumEntity.UI,
                                LayerName = LayerTypeEnumEntity.UI.ToString(),
                                ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                                ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                                OpreateTime = DateTime.Now,
                                OpreatorDeptId = CurrentUserInfo.Dept_ID,
                                OpreatorDeptName = CurrentUserInfo.Dept_Name,
                                OpreatorId = CurrentUserInfo.Employee_ID,
                                OpreatorName = CurrentUserInfo.Name,
                                OpreatorIp = CurrentUserInfo.IP
                            });

                            int result = 0;
                            if (item.TargetPercent != null)
                            {
                                Int32.TryParse(item.TargetPercent.Replace("%", ""), out result);
                            }

                            SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(new SmTargetItemEntity()
                            {
                                SmId = item.SmId,
                                TargetId = item.TargetId,
                                ItemId = item.ItemId,
                                ItemName = item.ItemName,
                                AssistDeptId = item.AssistDeptId,
                                AssistDeptName = item.AssistDeptName,
                                DeadLineTime = Convert.ToDateTime(item.DeadLineTime),
                                FinshPercent = result,
                                DutyDeptId = item.DutyDeptId,
                                DutyDeptName = item.DutyDeptName,
                                ExcutorId = item.ExcutorId,
                                ExcutorName = item.ExcutorName
                            });
                        }
                        #endregion
                    }
                }

                return new SuperviseMissionResponse
                {
                    data = "",
                    status = "1",
                    message = "成功。"
                };
            }
            catch (Exception ex)
            {
                UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                {
                    Content = "修改表单失败：" + ex.Message,
                    ErrorType = (int?)ErrorTypeEnumEntity.UI,
                    ErrorTypeName = ErrorTypeEnumEntity.UI.ToString(),
                    LayerType = (int?)LayerTypeEnumEntity.UI,
                    LayerName = LayerTypeEnumEntity.UI.ToString(),
                    ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                    ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                    OpreateTime = DateTime.Now,
                    OpreatorDeptId = CurrentUserInfo.Dept_ID,
                    OpreatorDeptName = CurrentUserInfo.Dept_Name,
                    OpreatorId = CurrentUserInfo.Employee_ID,
                    OpreatorName = CurrentUserInfo.Name,
                    OpreatorIp = CurrentUserInfo.IP
                });

                return new SuperviseMissionResponse
                {
                    status = "0",
                    message = ex.Message
                };
            }
        }

        private void SaveSmLeaderMeetingMissionChange(SmMainEntity smMainEntity)
        {
            List<string> mainDeptIdList = smMainEntity.MainDeptId.Split(';').ToList();
            List<string> mainDeptNameList = smMainEntity.MainDeptName.Split(';').ToList();
            var smLeaderMeetingMissionList = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(new SmLeaderMeetingMissionEntity
            {
                SmId = smMainEntity.SmId,
                ActivityFlag = 1
            });
            int index = 0;
            foreach (var deptId in mainDeptIdList)
            {
                if (string.IsNullOrEmpty(deptId))
                {
                    continue;
                }

                if (!smLeaderMeetingMissionList.Exists(n => n.DeptId.Equals(deptId)))
                {
                    //若不存在，插入
                    var laderMeetingMissionEntity = new SmLeaderMeetingMissionEntity()
                    {
                        LmmId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber(),
                        DeptId = deptId,
                        SmId = smMainEntity.SmId,
                        ActivityFlag = 1,
                        DeptName = mainDeptNameList[index],
                        StartTime = smMainEntity.StartTime,
                        DeadLineTime = smMainEntity.DeadLineTime,
                        CreateTime = smMainEntity.CreateTime,
                        CreatorId = smMainEntity.CreatorId,
                        CreatorName = smMainEntity.CreatorName,
                        CreatorDeptId = smMainEntity.CreatorDeptId,
                        CreatorDeptName = smMainEntity.CreatorDeptName
                    };

                    SuperviseMissionBodyBiz.InsertLeaderMeetingMissionEntity(laderMeetingMissionEntity);
                }
                else
                {
                    //若存在，从数组移除(为后面的去重作准备)
                    smLeaderMeetingMissionList.RemoveAll(n => n.DeptId.Equals(deptId) && n.SmId.Equals(smMainEntity.SmId));
                }

                index++;
            }

            //如果数组还存在数据，那证明用户改变主办单位的时候删除了这些主办单位。
            if (smLeaderMeetingMissionList.Count > 0)
            {
                foreach (var smLeaderMeetingMission in smLeaderMeetingMissionList)
                {
                    smLeaderMeetingMission.ActivityFlag = 0;
                    SuperviseMissionBodyBiz.UpdateLeaderMeetingMissionEntity(smLeaderMeetingMission);
                    UpdateTargetItemListActivityFlag(smLeaderMeetingMission.LmmId, 0);
                }
            }
        }

        /// <summary>
        /// 根据targetId修改措施列表的ActivityFlag值为无效。
        /// </summary>
        /// <param name="targetId">措施Id。</param>
        private void UpdateTargetItemListActivityFlag(string targetId, byte activityFlag)
        {
            var targetItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByTargetId(targetId, true);
            if (targetItemList != null && targetItemList.Count > 0)
            {
                foreach (var targetItem in targetItemList)
                {
                    targetItem.ActivityFlag = activityFlag;
                    SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(targetItem);
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse UpdateSmFlowFinishAndWaitingList(List<SmFlowFinishAndWaitingRequestEntity> smFlowFinishAndWaitingRequestEntityList)
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

                if (smFlowFinishAndWaitingRequestEntityList != null &&
                    smFlowFinishAndWaitingRequestEntityList.Count > 0)
                {
                    foreach (var smFlowFinishAndWaitingRequestEntity in smFlowFinishAndWaitingRequestEntityList)
                    {
                        if (smFlowFinishAndWaitingRequestEntity.FlowType.Equals("Finish"))
                        {
                            //更新已办表数据
                            var smFlowFinishEntity = SuperviseMissionBodyBiz.GetSmFlowFinishEntity(new SmFlowFinishEntity { FlowId = smFlowFinishAndWaitingRequestEntity.FlowId, SmId = smFlowFinishAndWaitingRequestEntity.SmId });
                            smFlowFinishEntity.ActivityFlag = smFlowFinishAndWaitingRequestEntity.ActivityFlag;
                            SuperviseMissionBodyBiz.UpdateSmFlowFinishEntity(smFlowFinishEntity);
                        }
                        else
                        {
                            //更新待办表数据
                            var smFlowWaitingEntity = SuperviseMissionBodyBiz.GetSmFlowWaitingEntity(new SmFlowWaitingEntity { FlowId = smFlowFinishAndWaitingRequestEntity.FlowId, SmId = smFlowFinishAndWaitingRequestEntity.SmId });
                            smFlowWaitingEntity.ActivityFlag = smFlowFinishAndWaitingRequestEntity.ActivityFlag;
                            SuperviseMissionBodyBiz.UpdateSmFlowWaitingEntity(smFlowWaitingEntity);
                        }
                    }
                }

                return new SuperviseMissionResponse
                {
                    data = "",
                    status = "1",
                    message = "成功。"
                };
            }
            catch (Exception ex)
            {
                UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                {
                    Content = "修改表单失败：" + ex.Message,
                    ErrorType = (int?)ErrorTypeEnumEntity.UI,
                    ErrorTypeName = ErrorTypeEnumEntity.UI.ToString(),
                    LayerType = (int?)LayerTypeEnumEntity.UI,
                    LayerName = LayerTypeEnumEntity.UI.ToString(),
                    ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                    ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                    OpreateTime = DateTime.Now,
                    OpreatorDeptId = CurrentUserInfo.Dept_ID,
                    OpreatorDeptName = CurrentUserInfo.Dept_Name,
                    OpreatorId = CurrentUserInfo.Employee_ID,
                    OpreatorName = CurrentUserInfo.Name,
                    OpreatorIp = CurrentUserInfo.IP
                });

                return new SuperviseMissionResponse
                {
                    status = "0",
                    message = "更新出错"
                };
            }
        }

        /// <summary>
        /// 更新修改意见信息。
        /// </summary>
        /// <param name="mainTargetItems">意见相关的实例。</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]

        public SuperviseMissionResponse UpdateSmFlowItemBaseEntitys(List<ModifyOpinion> modifyOpinion)
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


                foreach (var item in modifyOpinion)
                {


                    if (!String.IsNullOrEmpty(item.SmIdTab2) && !String.IsNullOrEmpty(item.FlowIdTab2))
                    {

                        int resultFlowId = 0;
                        if (item.FlowIdTab2 != null)
                        {
                            Int32.TryParse(item.FlowIdTab2, out resultFlowId);
                        }

                        SuperviseMissionBodyBiz.UpdateSmFlowItemBaseEntity(new SmFlowFinishEntity() { SmId = item.SmIdTab2, FlowId = resultFlowId, Opinion = item.HandleOption, OpinionType = item.OpinionType });


                    }
                }

                return new SuperviseMissionResponse
                {
                    data = "",
                    status = "1",
                    message = "成功。"
                };
            }
            catch (Exception ex)
            {
                UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                {
                    Content = "修改表单意见失败：" + ex.Message,
                    ErrorType = (int?)ErrorTypeEnumEntity.UI,
                    ErrorTypeName = ErrorTypeEnumEntity.UI.ToString(),
                    LayerType = (int?)LayerTypeEnumEntity.UI,
                    LayerName = LayerTypeEnumEntity.UI.ToString(),
                    ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                    ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                    OpreateTime = DateTime.Now,
                    OpreatorDeptId = CurrentUserInfo.Dept_ID,
                    OpreatorDeptName = CurrentUserInfo.Dept_Name,
                    OpreatorId = CurrentUserInfo.Employee_ID,
                    OpreatorName = CurrentUserInfo.Name,
                    OpreatorIp = CurrentUserInfo.IP
                });

                return new SuperviseMissionResponse
                {
                    status = "0",
                    message = "更新出错"
                };
            }
        }

    }



    /// <summary>
    /// 运维工具修改意见类。
    /// </summary>   
    [Serializable]
    public class ModifyOpinion
    {
        /// <summary>
        /// 任务Id。
        /// </summary>
        public string SmIdTab2 { get; set; }
        /// <summary>
        /// 流程Id。
        /// </summary>
        public string FlowIdTab2 { get; set; }
        /// <summary>
        /// 意见。
        /// </summary>
        public string HandleOption { get; set; }
        /// <summary>
        /// 意见类型。
        /// </summary>
        public string OpinionType { get; set; }

    }
    /// <summary>
    /// 运维工具修改表单类。
    /// </summary>
    [Serializable]
    public class MainTargetItem
    {
        #region 任务域。
        /// <summary>
        /// 任务Id。
        /// </summary>
        public string SmId { get; set; }
        /// <summary>
        /// 督查字号
        /// </summary>
        public string NumberName { get; set; }
        /// <summary>
        /// 督查年号。
        /// </summary>
        public string NumberYear { get; set; }
        /// <summary>
        /// 流水号。
        /// </summary>
        public int NumberCode { get; set; }
        /// <summary>
        /// 任务内容。
        /// </summary>
        public string TaskContent { get; set; }
        /// <summary>
        /// 主管领导员工Id。
        /// </summary>
        public string MainLeaderId { get; set; }
        /// <summary>
        /// 主管领导员工姓名。
        /// </summary>
        public string MainLeaderName { get; set; }
        /// <summary>
        /// 协管领导员工Id。
        /// </summary>
        public string AssLeaderId { get; set; }
        /// <summary>
        /// 协管领导员工姓名。
        /// </summary>
        public string AssLeaderName { get; set; }

        public DateTime StartTime { get; set; }
        #endregion

        #region 年度域。
        /// <summary>
        /// 目标Id。
        /// </summary>
        public string TargetId { get; set; }
        /// <summary>
        /// 目标名称。
        /// </summary>
        public string TargetName { get; set; }
        /// <summary>
        /// 目标完成进度。
        /// </summary>
        public string TargetPercent { get; set; }
        #endregion

        #region 父措施和子措施域。
        /// <summary>
        /// 措施Id。
        /// </summary>
        public string ItemId { get; set; }
        /// <summary>
        /// 父措施Id。
        /// </summary>
        public string ParentTargetItemId { get; set; }
        /// <summary>
        /// 措施名称。
        /// </summary>
        public string ItemName { get; set; }
        /// <summary>
        /// 完成时间。
        /// </summary>
        public string DeadLineTime { get; set; }
        /// <summary>
        /// 措施完成进度。
        /// </summary>
        public string FinshPercent { get; set; }
        /// <summary>
        /// 责任处室部门Id。
        /// </summary>
        public string DutyDeptId { get; set; }
        /// <summary>
        /// 责任处室部门名称。
        /// </summary>
        public string DutyDeptName { get; set; }
        /// <summary>
        /// 子措施的责任人员工Id。
        /// </summary>
        public string ExcutorId { get; set; }
        /// <summary>
        /// 子措施的责任人员工姓名。
        /// </summary>
        public string ExcutorName { get; set; }
        #endregion

        #region 任务域、年度域、父措施、子措施域共同属性(在不同的域各自的值也可能不同)。
        /// <summary>
        /// 协办单位部门Id。
        /// </summary>
        public string AssistDeptId { get; set; }
        /// <summary>
        /// 协办单位部门名称。
        /// </summary>
        public string AssistDeptName { get; set; }
        /// <summary>
        /// 主办单位部门Id。
        /// </summary>
        public string MainDeptId { get; set; }
        /// <summary>
        /// 主办单位部门名称。
        /// </summary>
        public string MainDeptName { get; set; }
        #endregion
    }
}
