using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys;
using OA30.Common.Entity;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.Common.Entity.MissionBase;
using OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys;
using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.UI.CommonComponents;
using System.Data;
using System.Runtime.Remoting.Messaging;
using OA30.SuperviseMission.Common.Entity.Mission.Enum;
using System.Text;
using OA30.SuperviseMission.UI.CommonComponents.Utilities;
using System.Text.RegularExpressions;

namespace OA30.SuperviseMission.UI.MainSite.WebServices
{
    public class BaseWebService : WebService
    {
        #region 字符最大长度常量。

        public const int TASK_CONTENT_MAX_LENGTH = 400; // 任务内容数最大限长量。
        public const int TARGET_NAME_MAX_LENGTH = 400; // 目标字符数最大限长量。
        public const int TARGET_ITEM_NAME_MAX_LENGTH = 400; // 措施字符数最大限长量。
        public const int OPINION_MAX_LENGTH = 400; // 反馈字符数最大限长量。 

        #endregion

        #region 页面共用属性

        protected static string NoLoginMessage = "您还没有登录系统，无法进行相关操作。";
        protected static string UrlCheckMessage = "您的URL存在被篡改的风险，系统不允许进行相关操作。";

        protected static SuperviseMissionResponse NoLoginResponse = new SuperviseMissionResponse()
        { data = "", message = NoLoginMessage, status = "0" };

        protected static SuperviseMissionResponse UrlCheckResponse = new SuperviseMissionResponse()
        { data = "", message = UrlCheckMessage, status = "0" };

        protected string _ErrorMessage = "页面出错";

        /// <summary>
        /// 是否需要身份验证
        /// </summary>
        protected bool RequestVerification
        {
            get
            {
                string rv = System.Configuration.ConfigurationManager.AppSettings["RequestVerification"];
                if (string.IsNullOrEmpty(rv))
                {
                    return true;
                }

                if (rv == "0")
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        /// <summary>
        /// 在每个WebMethod中都需要调用一次CurrentUserInfo，以此判断用户是否登录
        /// </summary>     
        protected SmUserInformationEntity _SmUser;

        protected SmUserInformationEntity CurrentUserInfo
        {
            get
            {
                if (this.Context.User == null || this.Context.User.Identity == null ||
                    !this.Context.User.Identity.IsAuthenticated)
                {
                    _ErrorMessage = "{\"result\":\"error\",\"status\":\"0\",\"message\":\"访问来源非法(1)！\"}";
                    throw new Exception("访问来源非法(0)！");
                }

                if (!Context.User.Identity.IsAuthenticated)
                {
                    _ErrorMessage = "{\"result\":\"error\",\"status\":\"0\",\"message\":\"访问来源非法(1)！\"}";
                    throw new Exception("访问来源非法(1)！");
                }

                var strIdentity = Context.User.Identity.Name;
                if (Session["SmUser"] == null)
                {
                    if (string.IsNullOrEmpty(Context.User.Identity.Name))
                    {
                        _ErrorMessage = "{\"result\":\"error\",\"status\":\"0\",\"message\":\"访问来源非法(2)！\"}";
                        throw new Exception("访问来源非法(2)！");
                    }

                    var _objUser = SMBasicDataBiz.GetGenericUserInfoByID(strIdentity);

                    if (_objUser == null)
                    {
                        _ErrorMessage = "{\"result\":\"error\",\"status\":\"0\",\"message\":\"无法取得用户信息！\"}";
                        throw new Exception("无法取得用户信息！");
                    }

                    _objUser.Theme = "Flower";
                    _objUser.IP = Context.Request.UserHostAddress;
                    _objUser.MachineName = Context.Request.UserHostName;
                    _SmUser = new SmUserInformationEntity()
                    {
                        ContSecretaryDetail = _objUser.ContSecretaryDetail,
                        Dept_ID = _objUser.Dept_ID,
                        Dept_Name = _objUser.Dept_Name,
                        DocManagerDetail = _objUser.DocManagerDetail,
                        Employee_ID = _objUser.Employee_ID,
                        InfoManagerDetail = _objUser.InfoManagerDetail,
                        IP = UiClientHelper.GetIPAddress,
                        IsContSecretaryRole = _objUser.IsContSecretaryRole,
                        IsCorpSuperManager = _objUser.IsCorpSuperManager,
                        IsDocManager = _objUser.IsDocManager,
                        IsInfoManager = _objUser.IsInfoManager,
                        IsJDSecretaryRole = _objUser.IsJDSecretaryRole,
                        IsLeader = _objUser.IsLeader,
                        IsSBSUser = _objUser.IsSBSUser,
                        IsSecretary = _objUser.IsSecretary,
                        IsStockCompanySuperManager = _objUser.IsStockCompanySuperManager,
                        IsUserHaveApplyMsOffice = _objUser.IsUserHaveApplyMsOffice,
                        IsUserUseWPSForTreatDoc = _objUser.IsUserUseWPSForTreatDoc,
                        JDSecretaryDetail = _objUser.JDSecretaryDetail,
                        MachineName = _objUser.MachineName,
                        MobilephoneNo = _objUser.MobilephoneNo,
                        Name = _objUser.Name,
                        Rank = _objUser.Rank,
                        SecretaryDetail = _objUser.SecretaryDetail,
                        Sex = _objUser.Sex,
                        TelephoneNo = _objUser.TelephoneNo,
                        Theme = _objUser.Theme
                    };
                    Session["SmUser"] = _SmUser;
                }
                else
                {
                    _SmUser = (SmUserInformationEntity)Session["SmUser"];
                    if (_SmUser.Employee_ID != strIdentity)
                    {
                        _ErrorMessage = "{\"result\":\"error\",\"status\":\"0\",\"message\":\"请不要同时使用多个不同的身份！\"}";
                        throw new Exception("请不要同时使用多个不同的身份！");
                    }

                }

                return _SmUser;
            }
        }

        #endregion

        #region 应用BIZ属性    

        protected AppRCObjectActivatorV2 objCreator = new AppRCObjectActivatorV2();

        protected ISuperviseMissionBasicData _SMBasicDataBiz = null;

        protected ISuperviseMissionBasicData SMBasicDataBiz
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

        protected ISuperviseMissionBody _SuperviseMissionBodyBiz;

        protected ISuperviseMissionBody SuperviseMissionBodyBiz
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

        protected ISuperviseMissionWorkFlow _SuperviseMissionWorkFlow;

        protected ISuperviseMissionWorkFlow SuperviseMissionWorkFlow
        {
            get
            {
                if (_SuperviseMissionWorkFlow == null)
                {
                    _SuperviseMissionWorkFlow = objCreator.CreateObject<ISuperviseMissionWorkFlow>();
                }

                return _SuperviseMissionWorkFlow;
            }
        }

        #endregion


        #region 登录用户相关

        /// <summary>
        /// 用户校验
        /// </summary>
        /// <returns></returns>
        protected bool CheckLogin()
        {
            try
            {
                var c = CurrentUserInfo;
                return true;
            }
            catch (Exception ex)
            {
                _ErrorMessage = "{\"result\":\"error\",\"message\":\"" + ex.Message + "\"}";
                return false;
            }

        }

        /// <summary>
        /// 获取当前用户。
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetCurrentUser()
        {
            return new SuperviseMissionResponse()
            {
                status = "1",
                data = JsonHelper.ToJson(CurrentUserInfo),
                message = "获取当前用户成功。"
            };
        }

        #endregion

        #region 管理员判断

        /// <summary>
        /// 运维管理员
        /// </summary>
        public bool IsMaintainer
        {
            get
            {
                var list = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity()
                    { MemberId = CurrentUserInfo.Employee_ID, RoleId = "MAINTAINER" });
                if (list != null && list.Count > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        /// <summary>
        /// 系统管理员
        /// </summary>       
        public bool IsSystemManager
        {
            get
            {
                var list = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity()
                    { MemberId = CurrentUserInfo.Employee_ID, RoleId = "SYSTEM" });
                if (list != null && list.Count > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        /// <summary>
        /// 超级管理员
        /// </summary>
        public bool IsSuperManager
        {
            get
            {
                var list = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity()
                    { MemberId = CurrentUserInfo.Employee_ID, RoleId = "SUPER" });
                if (list != null && list.Count > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        /// <summary>
        /// 部门管理员
        /// </summary>
        public bool IsDeptManager
        {
            get
            {
                var list = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity()
                    { MemberId = CurrentUserInfo.Employee_ID, RoleId = "DEPTADMIN" });
                if (list != null && list.Count > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        #endregion

        #region 获取常用领导

        /// <summary>
        /// 获取常用领导
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetDefaultLeader()
        {
            try
            {
                var leaderList = SuperviseMissionBodyBiz.GetDefaultLeaderByDeptId(CurrentUserInfo.Dept_ID);
                List<UserInfo> returnList = new List<UserInfo>();

                #region 对象转换

                if (leaderList != null)
                {
                    leaderList = leaderList.OrderBy(e => e.OrderNumber).ToList();
                    UserInfo userInfo = null;
                    foreach (var item in leaderList)
                    {
                        userInfo = new UserInfo();
                        userInfo.Employee_ID = item.LeaderUserId;
                        userInfo.Name = item.LeaderUserName;
                        userInfo.Dept_Name = item.LeaderDeptName;

                        returnList.Add(userInfo);
                    }
                }

                #endregion

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "获取默认领导成功",
                    data = JsonHelper.ToJson(returnList)
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = ex.Message
                };
            }
        }

        #endregion

        #region 部门查询相关

        /// <summary>
        /// 获取当前用户的所管辖的可见部门列表
        /// </summary>
        /// <returns></returns>
        public List<DeptListEntity> GetDeptList()
        {
            List<DeptListEntity> result = new List<DeptListEntity>();
            //首先判断是不是超级管理员
            var list1 = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(new SmBasicDataDeptRoleDefinitionEntity()
            { MemberId = CurrentUserInfo.Employee_ID, RoleId = "SUPER" });
            if (list1 != null && list1.Count > 0)
            {
                //是超级管理员 添加所有部门
                result = CacheHelper.AllVisbleDeptEntityList;
            }
            else
            {
                //再判断是不是部门管理员
                var list2 = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity()
                    { MemberId = CurrentUserInfo.Employee_ID, RoleId = "DEPTADMIN" });
                string dept_temp = "";
                foreach (var item in list2)
                {
                    dept_temp += item.DeptId + ",";
                    result.Add(new DeptListEntity()
                    {
                        DeptId = item.DeptId,
                        DeptName = item.DeptName
                    });
                }

                //排序
                result = result.OrderBy(n => n.DeptId).ToList();
                if (result != null && result.Count > 0)
                {
                    //插入全部选项
                    result.Insert(0, new DeptListEntity() { DeptId = dept_temp, DeptName = "全部" });
                }
            }

            return result;
        }

        /// <summary>
        /// 获取当前用户的所管辖的可用部门列表
        /// </summary>
        /// <returns></returns>
        public List<DeptListEntity> GetDeptActivityList()
        {
            List<DeptListEntity> result = new List<DeptListEntity>();
            //首先判断是不是超级管理员
            var list1 = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(new SmBasicDataDeptRoleDefinitionEntity()
            { MemberId = CurrentUserInfo.Employee_ID, RoleId = "SUPER" });
            if (list1 != null && list1.Count > 0)
            {
                //是超级管理员 添加所有部门
                result = CacheHelper.AllActiveDeptEntityList;
            }
            else
            {
                //构造全部的部门
                string dept_temp = "";
                //再判断是不是部门管理员
                var list2 = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity()
                    { MemberId = CurrentUserInfo.Employee_ID, RoleId = "DEPTADMIN" });
                //获取管理部门下面的子部门
                foreach (var temp in list2)
                {
                    //获取可用的子级单位
                    var list3 = CacheHelper.AllActiveDeptEntityList.FindAll(n =>
                        n.DeptId.Length >= temp.DeptId.Length &&
                        n.DeptId.Substring(0, temp.DeptId.Length) == temp.DeptId);
                    foreach (var item in list3)
                    {
                        //如果不在结果集中 则进行添加
                        if (!result.Any(n => n.DeptId == item.DeptId))
                        {
                            //构造全部的单位
                            dept_temp += item.DeptId + ",";
                            result.Add(new DeptListEntity()
                            {
                                DeptId = item.DeptId,
                                DeptName = item.DeptName
                            });
                        }
                    }

                }


                //排序
                result = result.OrderBy(n => n.DeptId).ToList();
                if (result != null && result.Count > 0)
                {
                    //插入全部选项
                    result.Insert(0, new DeptListEntity() { DeptId = dept_temp, DeptName = "全部" });
                }
            }

            return result;
        }

        /// <summary>
        /// 获取当前用户管理的部门列表（二级部门列表，带权限）
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DeptList()
        {
            try
            {
                List<DeptListEntity> result = GetDeptList();

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(result),
                    message = "获取二级部门列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取部门列表失败。"
                };
                //throw;
            }
        }

        /// <summary>
        /// 获取当前用户管理的所有部门列表 包含子级单位（多级部门列表，带权限）
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DeptActivityList()
        {
            try
            {
                List<DeptListEntity> result = GetDeptActivityList();

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(result),
                    message = "获取多级部门列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取部门列表失败。"
                };
                //throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetAllDeptList()
        {
            try
            {
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(CacheHelper.AllVisbleDeptEntityList),
                    message = "获取部门列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取部门列表失败。"
                };
                //throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetAllDeptListNoContainAll()
        {
            try
            {
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(CacheHelper.AllVisbleDeptEntityListWithNoContainAllDept),
                    message = "获取部门列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取部门列表失败。"
                };
            }
        }

        /// <summary>
        /// 获取所有可用部门列表（含不可见）
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetAllActiveDeptList()
        {
            try
            {
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(CacheHelper.AllActiveDeptEntityList),
                    message = "获取部门列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取部门列表失败。"
                };
            }
        }

        /// <summary>
        /// 根据名查询部门
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetDeptListByName(string name)
        {
            try
            {
                List<DeptListEntity> result = new List<DeptListEntity>();
                //是超级管理员 添加所有部门
                DataTable dt = SMBasicDataBiz.GetGenericDeptInfoByName(name);
                foreach (DataRow dr in dt.Rows)
                {
                    result.Add(new DeptListEntity()
                    {
                        DeptId = dr["DEPT_ID"].ToString(),
                        DeptName = dr["DEPT_NAME"].ToString()
                    });
                }

                //排序
                result = result.OrderBy(n => n.DeptId).ToList();
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(result),
                    message = "根据名称部门列表成功。"
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "根据名称部门列表失败。"
                };
            }
        }

        /// <summary>
        /// 获取当前用户管理的部门列表
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetGroupListByUser()
        {
            try
            {
                List<DeptGroupListEntity> list = GetDeptGroupListEntity();
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(list),
                    message = "获取部门组列表成功。"
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取部门组列表失败。"
                };
                //throw;
            }
        }

        /// <summary>
        /// 根据二级部门id列表获取多级部门Id列表。
        /// </summary>
        /// <param name="searchDeptIds"></param>
        /// <returns></returns>
        protected List<string> GetDeptActivityListByIds(string searchDeptIds)
        {
            List<string> deptIds = new List<string>();
            List<string> allDeptIds = new List<string>();
            deptIds = searchDeptIds.Split(',').ToList();
            foreach (var deptId in deptIds)
            {
                allDeptIds.AddRange(GetDeptActivityList().Select(n => n.DeptId).ToList()
                    .FindAll(n => n.StartsWith(deptId)));
            }

            return allDeptIds;
        }


        #endregion

        #region 自定义部门组

        /// <summary>
        /// 获取自定义部门组
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public MyGroupDeptListResponse GetGroupListByUser2()
        {
            try
            {
                List<DeptGroupListEntity> list = GetDeptGroupListEntity();
                return new MyGroupDeptListResponse()
                {
                    status = "1",
                    List = list,
                    message = "获取部门组列表成功。"
                };
            }
            catch (Exception ex)
            {
                return new MyGroupDeptListResponse()
                {
                    status = "0",
                    message = "获取部门组列表失败。"
                };
            }
        }

        /// <summary>
        /// 根据组id获取组的部门列表
        /// </summary>
        /// <param name="groupId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public MyGroupListResponse GetGroupDepts(int groupId)
        {
            try
            {
                SmBasicDataPersonalDeptGroupDetailEntity condition = new SmBasicDataPersonalDeptGroupDetailEntity()
                {
                    GroupId = groupId
                };
                List<SmBasicDataPersonalDeptGroupDetailEntity> SmBasicDataPersonalDeptGroupDetailEntityList =
                    SMBasicDataBiz.GetDeptGroupDetailEntityList(condition, null).ToList();
                List<DeptNameIdList> list = new List<DeptNameIdList>();
                foreach (var item in SmBasicDataPersonalDeptGroupDetailEntityList)
                {
                    list.Add(new DeptNameIdList() { DeptId = item.DeptId, DeptName = item.DeptName });
                }

                return new MyGroupListResponse()
                {
                    status = "1",
                    List = list,
                    message = "获取我的部门组成功"
                };
            }
            catch (Exception ex)
            {
                return new MyGroupListResponse()
                {
                    status = "0",
                    List = null,
                    message = "获取我的部门组失败"
                };
            }
        }

        protected List<DeptGroupListEntity> GetDeptGroupListEntity()
        {
            List<DeptGroupListEntity> deptGroupListEntityList = new List<DeptGroupListEntity>();
            //List<DeptListEntity> deptList =this.AllDeptEntityList;
            List<SmBasicDataPersonalDeptGroupEntity> deptGroupList = GetDeptGroupsByUserId();
            List<SmBasicDataPersonalDeptGroupDetailEntity> deptGroupDetailList =
                GetDeptGroupDetailByGroupList(deptGroupList);

            foreach (var deptGroup in deptGroupList)
            {
                List<string> deptIds = new List<string>();
                deptIds.AddRange(deptGroupDetailList.Where(n => n.GroupId == deptGroup.GroupId).Select(d => d.DeptId)
                    .ToList());
                var deptGroupListEntity = new DeptGroupListEntity
                {
                    GroupName = deptGroup.GroupName,
                    GroupId = deptGroup.GroupId ?? 0,
                    DeptIds = deptIds
                };
                deptGroupListEntityList.Add(deptGroupListEntity);
            }


            return deptGroupListEntityList;
        }

        protected List<SmBasicDataPersonalDeptGroupEntity> GetDeptGroupsByUserId()
        {
            SmBasicDataPersonalDeptGroupEntity smBasicDataPersonalDeptGroupEntity =
                new SmBasicDataPersonalDeptGroupEntity
                {
                    UserId = CurrentUserInfo.Employee_ID
                };
            //DEPT_GROUP数据
            var deptGroupEntityList = SMBasicDataBiz.GetDeptGroupEntityList(smBasicDataPersonalDeptGroupEntity)
                .OrderByDescending(n => n.GroupId).ToList();
            return deptGroupEntityList;
        }

        protected List<SmBasicDataPersonalDeptGroupDetailEntity> GetDeptGroupDetailByGroupList(
            List<SmBasicDataPersonalDeptGroupEntity> SmBasicDataPersonalDeptGroupEntityList)
        {
            List<SmBasicDataPersonalDeptGroupDetailEntity> SmBasicDataPersonalDeptGroupDetailEntityList =
                new List<SmBasicDataPersonalDeptGroupDetailEntity>();
            var groupIdList = new List<int>();

            foreach (var entity in SmBasicDataPersonalDeptGroupEntityList)
            {
                int groupId = entity.GroupId ?? 0;
                if (groupId != 0)
                {
                    SmBasicDataPersonalDeptGroupDetailEntityList.AddRange(SMBasicDataBiz.GetDeptGroupDetailEntityList(
                        new SmBasicDataPersonalDeptGroupDetailEntity
                        { GroupId = groupId }, null).ToList());
                }
            }

            return SmBasicDataPersonalDeptGroupDetailEntityList;
        }

        #endregion

        #region 人员信息查询

        /// <summary>
        /// 查询员工信息
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetUserInfoByUserIdOrName(string UserId)
        {
            try
            {
                List<UserInfo> list = new List<UserInfo>();
                //首先根据id查询 如果没有查询到结果 用名字进行查询
                UserInfo user = SMBasicDataBiz.GetGenericUserInfoByID(UserId);
                if (user != null)
                {
                    list.Add(user);
                    return new SuperviseMissionResponse()
                    {
                        status = "1",
                        data = JsonHelper.ToJson(list),
                        message = "查询成功"
                    };
                }
                else
                {
                    //用名字查询
                    list = SMBasicDataBiz.GetGenericUserInfoByUserNmae(UserId);
                    if (list == null || list.Count == 0)
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "0",
                            message = "没有查询到员工（" + UserId + "）的相关信息"
                        };
                    }
                    else
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "1",
                            data = JsonHelper.ToJson(list),
                            message = "查询成功"
                        };
                    }

                }


            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "查询员工信息出错。" + ex.Message
                };
                //throw ex;
            }
        }

        #endregion

        #region 操作记录

        /// <summary>
        /// 获取操作记录
        /// </summary>
        /// <param name="smid"></param>
        /// <param name="targetid"></param>
        /// <param name="targetItemId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public HistoryResponse GetSmFlowFinishList(string smid, string targetid, string targetItemId, string page)
        {
            //TODO:做安全校验
            try
            {
                #region  登录校验

                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return new HistoryResponse()
                    {
                        data = NoLoginResponse.data,
                        message = NoLoginResponse.message,
                        status = NoLoginResponse.status
                    };
                }

                #endregion

                #region 越权校验

                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return new HistoryResponse()
                    {
                        data = UrlCheckResponse.data,
                        message = UrlCheckResponse.message,
                        status = UrlCheckResponse.status
                    };
                }

                #endregion

                IEnumerable<SmFlowFinishEntity> listEntity = null;
                if (!string.IsNullOrEmpty(smid) && !string.IsNullOrEmpty(targetid) &&
                    !string.IsNullOrEmpty(targetItemId))
                {
                    listEntity = SuperviseMissionBodyBiz.GetSmFlowFinishList(n =>
                        n.SmId == smid && n.TargetId == targetid && n.TargetItemId == targetItemId);
                }
                else if (!string.IsNullOrEmpty(smid) && !string.IsNullOrEmpty(targetid))
                {
                    listEntity =
                        SuperviseMissionBodyBiz.GetSmFlowFinishList(n => n.SmId == smid && n.TargetId == targetid);
                }
                else if (!string.IsNullOrEmpty(smid))
                {
                    listEntity = SuperviseMissionBodyBiz.GetSmFlowFinishList(n => n.SmId == smid);
                }

                listEntity = listEntity.OrderBy(e => e.FlowId);
                List<SmBasicDataOpinionTypeEntity> opintionList =
                    SMBasicDataBiz.GetSmBasicDataOpinionTypeEntityList(new SmBasicDataOpinionTypeEntity()
                    { ActivityFlag = 1 });
                List<HistoryFlow> flowList = new List<HistoryFlow>();
                foreach (var item in listEntity)
                {
                    if (null == item.Opinion) continue;
                    HistoryFlow flow = new HistoryFlow();
                    if (!String.IsNullOrEmpty(item.UserIdConsigned) && !String.IsNullOrEmpty(item.UserNameConsigned))
                    {
                        flow.OperatorId = String.Format("{0}<br/>{1}<br/>(委托人:{2}[{3}])",item.UserId ,item.UserName,item.UserIdConsigned,item.UserNameConsigned);
                    }
                    else
                    {
                        flow.OperatorId = item.UserId + "<br/>" + item.UserName;
                    }
                    flow.OperatorId = item.UserId + "<br/>" + item.UserName;
                    flow.OperatorName = item.UserDeptName + "<br/>" + item.UserRank;
                    flow.OperaTime = item.FinishTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                    flow.Opintion = item.Opinion;
                    flow.OpintionType = opintionList.Find(n =>
                        n.TypeId == (string.IsNullOrEmpty(item.OpinionType) ? "4" : item.OpinionType)).TypeName;
                    flow.StepName = item.StepName;
                    flowList.Add(flow);
                }

                HistoryResponse response = new HistoryResponse()
                {
                    status = "1",
                    message = "成功",
                    historyFlow = flowList //flowList.OrderByDescending(q => q.OperaTime).ToList<HistoryFlow>()
                };

                // 20181026新需求：查询出来下一处理人并添加到末尾(只针对page1)。
                if (page.Equals("1"))
                {
                    IEnumerable<SmFlowWaitingEntity> fws =
                        SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == smid);
                    if (fws != null && response.historyFlow != null)
                    {
                        var grouping = fws.GroupBy(k => new { k.UserId, k.UserName });
                        foreach (var item in grouping)
                        {
                            HistoryFlow flow = new HistoryFlow();
                            var fw = fws.FirstOrDefault(e => e.UserId == item.Key.UserId);
                            flow.OperatorId = item.Key.UserId + "<br/>" + item.Key.UserName;
                            flow.OperatorName = fw.UserDeptName + "<br/>" + fw.UserRank;
                            flow.OperaTime = "";
                            flow.Opintion = "";
                            flow.OpintionType = "";
                            flow.StepName = "";
                            response.historyFlow.Insert(response.historyFlow.Count, flow);
                        }
                    }
                }

                return response;
            }
            catch (Exception ex)
            {
                return new HistoryResponse()
                {
                    status = "0",
                    message = ex.Message
                };
            }
        }

        #region 变更记录

        /// <summary>
        /// 获取变更记录
        /// </summary>
        /// <param name="smid"></param>
        /// <param name="targetItemId"></param>
        /// <returns></returns>

        [WebMethod(EnableSession = true)]
        public ChangeRecordResponse GetSmChangeRecordList(string smid, string targetItemId)
        {
            //TODO:做安全校验
            try
            {
                #region  登录校验

                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return new ChangeRecordResponse()
                    {
                        data = NoLoginResponse.data,
                        message = NoLoginResponse.message,
                        status = NoLoginResponse.status
                    };
                }

                #endregion

                #region 越权校验

                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return new ChangeRecordResponse()
                    {
                        data = UrlCheckResponse.data,
                        message = UrlCheckResponse.message,
                        status = UrlCheckResponse.status
                    };
                }

                #endregion

                List<ChangeItem> changeItemList = new List<ChangeItem>();
                var changeList = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntityList(new SmTargetItemChangeEntity
                {
                    SourceSmId = smid,
                    ItemId = targetItemId
                });

                if (changeList.Count > 0)
                {
                    foreach (var changeEntity in changeList)
                    {
                        var smChangeEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity
                        {
                            SmId = changeEntity.ChangeId
                        });

                        if (smChangeEntity != null)
                        {
                            var changeItem = new ChangeItem();
                            changeItem.ChangeId = changeEntity.ChangeId;
                            changeItem.ChangeTypeName = GetChangeName(smChangeEntity.SubType);
                            changeItem.SubType = smChangeEntity.SubType;
                            changeItem.CreateTime =
                                Convert.ToDateTime(smChangeEntity.CreateTime).ToString("yyyy-MM-dd");
                            changeItem.CreatorDeptName = smChangeEntity.CreatorDeptName;
                            changeItem.CreatorId = smChangeEntity.CreatorId;
                            changeItem.CreatorName = smChangeEntity.CreatorName;
                            changeItem.Reason = changeEntity.Reason;
                            changeItem.SmType = smChangeEntity.SmType;
                            changeItem.Status = changeEntity.Status == "0" ? "申请中" : "已变更";
                            changeItemList.Add(changeItem);
                        }
                    }
                }

                ChangeRecordResponse response = new ChangeRecordResponse()
                {
                    status = "1",
                    message = "成功",
                    changeItemList = changeItemList.OrderBy(n=>n.ChangeId).ToList() //flowList.OrderByDescending(q => q.OperaTime).ToList<HistoryFlow>()
                };

                return response;
            }
            catch (Exception ex)
            {
                return new ChangeRecordResponse()
                {
                    status = "0",
                    message = ex.Message
                };
            }
        }

        private string GetChangeName(string subType)
        {
            if (subType.Equals("YQ"))
            {
                return "延期申请单";
            }
            else if (subType.Equals("TZ"))
            {
                return "调整申请单";
            }
            else if (subType.Equals("BJ"))
            {
                return "办结申请单";
            }

            return "中止申请单";
        }

        #endregion 变更记录

        /// <summary>
        /// 获取反馈记录
        /// </summary>
        /// <param name="smid"></param>
        /// <param name="targetid"></param>
        /// <param name="targetItemId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public HistoryFeedbackResponse GetSmFeedbackFlowFinishList(string smid, string targetid, string targetItemId)
        {
            //TODO:做安全校验
            try
            {
                #region  登录校验

                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return new HistoryFeedbackResponse()
                    {
                        data = NoLoginResponse.data,
                        message = NoLoginResponse.message,
                        status = NoLoginResponse.status
                    };
                }

                #endregion

                #region 越权校验

                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return new HistoryFeedbackResponse()
                    {
                        data = UrlCheckResponse.data,
                        message = UrlCheckResponse.message,
                        status = UrlCheckResponse.status
                    };
                }

                #endregion

                IEnumerable<SmFlowFinishEntity> listEntity = null;
                if (!string.IsNullOrEmpty(smid) && !string.IsNullOrEmpty(targetid) &&
                    !string.IsNullOrEmpty(targetItemId))
                {
                    listEntity = SuperviseMissionBodyBiz.GetSmFlowFinishList(n =>
                        n.SmId == smid && n.TargetId == targetid && n.TargetItemId == targetItemId &&
                        n.StepId.Contains("FK"));
                }
                else if (!string.IsNullOrEmpty(smid) && !string.IsNullOrEmpty(targetid))
                {
                    listEntity = SuperviseMissionBodyBiz.GetSmFlowFinishList(n =>
                        n.SmId == smid && n.TargetId == targetid && n.StepId.Contains("FK"));
                }
                else if (!string.IsNullOrEmpty(smid))
                {
                    listEntity =
                        SuperviseMissionBodyBiz.GetSmFlowFinishList(n => n.SmId == smid && n.StepId.Contains("FK"));
                }

                List<HistoryFlow> LeaderFeedbackFlow =
                    PickHistoryFlowByOptionType(listEntity.TakeWhile(n => n.OpinionType == "1"));
                List<HistoryFlow> MainDeptFeedbackFlow =
                    PickHistoryFlowByOptionType(listEntity.TakeWhile(n => n.OpinionType == "2"));
                return new HistoryFeedbackResponse()
                {
                    status = "1",
                    message = "成功",
                    LeaderFeedbackFlow = LeaderFeedbackFlow,
                    MainDeptFeedbackFlow = MainDeptFeedbackFlow
                };
            }
            catch (Exception ex)
            {
                return new HistoryFeedbackResponse()
                {
                    status = "0",
                    message = ex.Message
                };
            }
        }

        private List<HistoryFlow> PickHistoryFlowByOptionType(IEnumerable<SmFlowFinishEntity> listEntity)
        {

            try
            {
                List<SmBasicDataOpinionTypeEntity> opintionList =
                    SMBasicDataBiz.GetSmBasicDataOpinionTypeEntityList(new SmBasicDataOpinionTypeEntity()
                    { ActivityFlag = 1 });
                List<HistoryFlow> flowList = new List<HistoryFlow>();
                foreach (var item in listEntity)
                {
                    HistoryFlow flow = new HistoryFlow();
                    flow.OperatorId = item.UserId;
                    flow.OperatorName = item.UserName;
                    flow.OperaTime = item.FinishTime.Value.ToString();
                    flow.Opintion = item.Opinion;
                    flow.OpintionType = opintionList.Find(n => n.TypeId == item.OpinionType).TypeName;
                    flow.StepName = item.StepName;
                    flowList.Add(flow);
                }

                return flowList;
            }
            catch (Exception ex)
            {
                return null;
            }

        }

        #endregion


        #region 附件处理

        /// <summary>
        /// 保存附件列表
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SaveSuperviseMissionAttachment()
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

                System.Web.HttpContext.Current.Request.ContentEncoding = Encoding.UTF8;
                string SmId = System.Web.HttpContext.Current.Request.Form["SmId"];
                //校验参数
                if (string.IsNullOrEmpty(SmId))
                {
                    return new SuperviseMissionResponse() { data = "", message = "上传文件时参数不能为空。", status = "0" };
                }

                #region  这里要做权限判断， 用户是否登录，是否是该表单的流转人员

                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }

                var sc = SuperviseMissionBodyBiz.CheckSmFlowItemListByUserId(new SmFlowItemBaseEntity()
                { SmId = SmId, TargetId = SmId, TargetItemId = SmId, UserId = CurrentUserInfo.Employee_ID });
                if (sc == false)
                {
                    //没有操作权限
                    return new SuperviseMissionResponse() { data = "", message = "您无权限操作。", status = "0" };
                }

                #endregion

                //获取文件
                var files = System.Web.HttpContext.Current.Request.Files;
                if (files == null || files.Count == 0)
                {
                    return new SuperviseMissionResponse() { data = "", message = "没有获取到相关的上传文件。", status = "0" };
                }

                //获取子措施的附件列表信息
                List<SmAttachmentEntity> AttachmentList =
                    SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity() { SmId = SmId });
                //当前的时间
                DateTime Now = DateTime.Now;
                //后续的错误信息
                string message = "";
                //循环处理文件
                for (int i = 0; i < files.Count; i++)
                {
                    var loopFile = files[i];
                    string fileTitle = System.IO.Path.GetFileName(loopFile.FileName);
                    string fileExtern = System.IO.Path.GetExtension(loopFile.FileName).Trim().ToLower();
                    if (loopFile.ContentLength <= 0)
                    {
                        message += "附件[" + fileTitle + "]为空文件！";
                        continue;
                    }

                    //文件判断是否重复
                    if (AttachmentList != null && AttachmentList.Count > 0 &&
                        AttachmentList.Any(n => n.AttachmentName == fileTitle))
                    {
                        message += "对不起，附件列表中已存在[" + fileTitle + "]！";
                        continue;
                    }


                    if (UiClientHelper.ForbidFileTypes.Contains(fileExtern))
                    {
                        message += "不允许上传类型为[" + fileExtern + "]的附件！";
                        continue;
                    }


                    if (loopFile.ContentLength > SuperviseMissionConfig.MaxAttachmentSize)
                    {
                        message += "附件[" + fileTitle + "]大小超过限制！";
                        continue;
                    }

                    try
                    {
                        bool skipZip = false;
                        for (int j = 0; j < UiClientHelper.SkipZipFileTypes.Length; j++)
                        {
                            if (fileExtern == UiClientHelper.SkipZipFileTypes[j])
                            {
                                skipZip = true;
                                break;
                            }
                        }

                        //增加模块 和日期部门位置调换 构造路径 刘永生 2016年12月26日
                        //string fileUrl = string.Format("{0}/{1}/{2}/{3}{4}", (CurrentUserInfo.Dept_ID + "0000000000").Substring(0, 11), CommonHelper.GetSystemDateTime().ToString("yyyyMM"), hfDescriptionId.Value, Guid.NewGuid(), fileExtern);
                        //string fileUrl = string.Format("MEETING/{0}/{1}/{2}/{3}{4}", CommonHelper.GetSystemDateTime().ToString("yyyyMMdd"), CurrentUserInfo.Dept_ID, hfDescriptionId.Value, Guid.NewGuid(), fileExtern);
                        //为便于文件服务器进行调整，年月日调整为2段 wukea 2016/12/28
                        string fileUrl = string.Format("{0}/{1}/{2}/{3}/{4}{5}", Now.ToString("yyyy"),
                            Now.ToString("MMdd"), CurrentUserInfo.Dept_ID, SmId, Guid.NewGuid(), fileExtern);

                        //保存到文件服务器
                        int fileSze = (int)loopFile.ContentLength;
                        var srcStream = loopFile.InputStream;
                        byte[] srcFileData = new byte[fileSze];
                        srcStream.Read(srcFileData, 0, fileSze);
                        srcStream.Close();

                        CommonHelper.FileAccessTool.SaveFileToServer(
                            SuperviseMissionConfig.SuperviseMissionAttachmentUrl, fileUrl, srcFileData, skipZip, false);

                        //保存附件信息
                        SmAttachmentEntity entity = new SmAttachmentEntity()
                        {
                            // 附件类型 暂时没有区分 都是1
                            AttachmentName = fileTitle,
                            AttachmentUrl = fileUrl,
                            AttachType = "1",
                            SmId = SmId,
                            CreatorId = this.CurrentUserInfo.Employee_ID,
                            CreatorName = CurrentUserInfo.Name,
                            Activity = "1"
                        };
                        SuperviseMissionBodyBiz.InsertSmAttachmentEntity(entity);
                    }
                    catch (Exception ex)
                    {
                        message += "附件[" + fileTitle + "]保存失败：" + ex.Message + "！";
                        continue;
                    }
                }

                if (string.IsNullOrEmpty(message)) {
                    message = "附件保存成功";
                }

                //返回成功信息 可能有的没有上传成功
                return new SuperviseMissionResponse() { data = "", message = message, status = "1" };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse() { data = ex.ToString(), message = "保存附件操作失败。", status = "0" };
            }
        }

        /// <summary>
        /// 获取附件列表
        /// </summary>
        /// <param name="SmId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSuperviseMissionAttachments(string SmId)
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

                if (string.IsNullOrEmpty(SmId))
                {
                    return new SuperviseMissionResponse() { data = "", message = "获取当前的附件列表时参数不能为空。", status = "0" };
                }

                #region  这里要做权限判断， 用户是否登录，是否是该表单的流转人员

                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }

                var sc = SuperviseMissionBodyBiz.CheckSmFlowItemListByUserId(new SmFlowItemBaseEntity()
                { SmId = SmId, TargetId = SmId, TargetItemId = SmId, UserId = CurrentUserInfo.Employee_ID });
                if (sc == false)
                {
                    //没有操作权限
                    return new SuperviseMissionResponse() { data = "", message = "您无权限操作。", status = "0" };
                }

                #endregion

                //获取附件列表
                var result = SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity()
                { SmId = SmId, Activity = "1" });
                return new SuperviseMissionResponse()
                { data = JsonHelper.ToJson(result), message = "获取当前的附件列表成功。", status = "1" };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse() { data = "", message = "获取当前的附件列表失败。" + ex.Message, status = "0" };
            }
        }

        /// <summary>
        /// 删除指定的附件
        /// </summary>
        /// <param name="SmId"></param>
        /// <param name="AttachmentId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DeleteSuperviseMissionAttachmentByAttachmentId(string SmId, int AttachmentId)
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

                if (string.IsNullOrEmpty(SmId) || AttachmentId < 0)
                {
                    return new SuperviseMissionResponse() { data = "", message = "删除当前的附件时参数不能为空。", status = "0" };
                }

                #region  这里要做权限判断， 用户是否登录，是否是该表单的流转人员

                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return NoLoginResponse;
                }

                var sc = SuperviseMissionBodyBiz.CheckSmFlowItemListByUserId(new SmFlowItemBaseEntity()
                { SmId = SmId, TargetId = SmId, TargetItemId = SmId, UserId = CurrentUserInfo.Employee_ID });
                if (sc == false)
                {
                    //没有操作权限
                    return new SuperviseMissionResponse() { data = "", message = "您无权限操作。", status = "0" };
                }

                #endregion

                //删除 内部是更新了标记
                SuperviseMissionBodyBiz.DeleteSmAttachmentEntity(new SmAttachmentEntity()
                { SmId = SmId, AttachmentId = AttachmentId });
                return new SuperviseMissionResponse() { data = "", message = "删除当前的附件成功。", status = "1" };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse() { data = "", message = "删除当前的附件失败。" + ex.Message, status = "0" };

            }
        }

        #endregion

        #region 测试网络是否联通的接口

        /// <summary>
        /// 测试接口
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse Test()
        {
            return new SuperviseMissionResponse() { status = "1", message = "测试成功", data = "测试成功" };
        }

        #endregion

        #region 记录日志

        /// <summary>
        /// 
        /// </summary>
        /// <param name="content"></param>
        protected void AddBasicDataErrorLog(string content)
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

        /// <summary>
        /// 操作成功日志
        /// </summary>
        /// <param name="content"></param>
        protected void AddBasicDataSuccessedLog(string content)
        {
            UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
            {
                Content = content,
                ErrorType = (int?)ErrorTypeEnumEntity.SUCCESSED,
                ErrorTypeName = ErrorTypeEnumEntity.SUCCESSED.ToString(),
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strMsg"></param>
        /// <param name="errorType"></param>
        /// <param name="moduleType"></param>
        protected void WriteLog(string strMsg, ErrorTypeEnumEntity errorType, ModuleTypeEnumEntity moduleType)
        {
            UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
            {
                Content = strMsg,
                ErrorType = (int?)errorType,
                ErrorTypeName = errorType.ToString(),
                LayerName = LayerTypeEnumEntity.UI.ToString(),
                LayerType = (int?)LayerTypeEnumEntity.UI,
                ModuleName = moduleType.ToString(),
                ModuleType = (int?)moduleType,
                OpreateTime = DateTime.Now,
                OpreatorDeptId = CurrentUserInfo.Dept_ID,
                OpreatorDeptName = CurrentUserInfo.Dept_Name,
                OpreatorId = CurrentUserInfo.Employee_ID,
                OpreatorIp = CurrentUserInfo.IP,
                OpreatorName = CurrentUserInfo.Name
            });
        }

        #endregion

        #region 越权校验

        /// <summary>
        /// 校验表单的信息
        /// </summary>
        /// <param name="UrlParameters"></param>
        /// <returns></returns>
        protected bool CheckFormRequest()
        {
            try
            {
                //测试时候使用直接返回 以后需要注释
                return true;

                //如果是空的处理
                if (string.IsNullOrEmpty(CurrentUserInfo.UrlParameters))
                {
                    return true;
                }

                //获取相关的参数
                string SmId = ""; //表单ID
                string FlowId = ""; //流转号
                string StepId = ""; //步骤ID
                string SmType = ""; //表单类型
                string SubType = ""; //表单子类型               
                string PageType = ""; //页面的类型

                string[] pl = CurrentUserInfo.UrlParameters.Split(';');
                foreach (string s in pl)
                {
                    if (s.Split(':')[0] == "SmId")
                    {
                        SmId = s.Split(':')[1];
                    }

                    if (s.Split(':')[0] == "FlowId")
                    {
                        FlowId = s.Split(':')[1];
                    }

                    if (s.Split(':')[0] == "StepId")
                    {
                        StepId = s.Split(':')[1];
                    }

                    if (s.Split(':')[0] == "SmType")
                    {
                        SmType = s.Split(':')[1];
                    }

                    if (s.Split(':')[0] == "SubType")
                    {
                        SubType = s.Split(':')[1];
                    }

                    if (s.Split(':')[0] == "PageType")
                    {
                        PageType = s.Split(':')[1];
                    }
                }

                #region  如果有表单的信息 则进行表单的校验

                //判断用户是否在该表单中
                if (!string.IsNullOrEmpty(SmId))
                {
                    SmMainEntity MainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = SmId });
                    if (MainEntity == null || MainEntity.ActivityFlag == 0)
                    {
                        //当前的文件已经被删除或者不存在。
                        return false;
                    }

                    if (MainEntity.SmType != SmType)
                    {
                        //文件类型被篡改。
                        return false;
                    }

                    if (!string.IsNullOrEmpty(MainEntity.SubType))
                    {
                        if (MainEntity.SubType != SubType)
                        {
                            //文件类型被篡改。
                            return false;
                        }
                    }

                    #region 检查该用户是否在表单的流程中

                    if (IsSuperManager)
                    {
                        //如果是超级管理员 则跳过                       
                    }
                    else if (IsDeptManager)
                    {
                        bool flag = false;
                        //如果是部门管理员  则要判断 是否有其管辖的部门
                        List<string> ManageDeptList = SuperviseMissionBodyBiz.GetFlowDeptIdListBySmId(SmId);
                        if (ManageDeptList == null || ManageDeptList.Count == 0)
                        {
                            //没有流转部门 
                            return false;
                        }

                        foreach (var dept in GetDeptList())
                        {
                            //循环管理的部门 检查流转部门
                            if (ManageDeptList.Any(n =>
                                n.Length >= dept.DeptId.Length && n.Substring(0, dept.DeptId.Length) == dept.DeptId))
                            {
                                flag = true;
                                break;
                            }
                        }

                        if (flag == false)
                        {
                            //如果不在其管辖范围内 跳转到错误页面
                            return false;
                        }
                    }
                    else
                    {
                        //普通人员的判断
                        bool flag = SuperviseMissionBodyBiz.CheckSmFlowItemListByUserId(new SmFlowItemBaseEntity()
                        { SmId = SmId, UserId = CurrentUserInfo.Employee_ID });
                        //跳转到错误页面
                        if (flag == false)
                        {
                            return false;
                        }
                    }


                    #endregion

                    #region 检查当前这一步骤的相关信息。

                    if (!string.IsNullOrEmpty(FlowId))
                    {
                        SmFlowItemBaseEntity FlowItemEntity =
                            SuperviseMissionBodyBiz.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity()
                            { SmId = SmId, FlowId = Convert.ToInt32(FlowId) });
                        if (FlowItemEntity == null || FlowItemEntity.ActivityFlag == 0)
                        {
                            //当前步骤不存在或者已经被删除
                            return false;

                        }

                        #region  判断是否在指定流程中

                        if (IsSuperManager)
                        {
                            //如果是超级管理员则跳过
                        }
                        else if (IsDeptManager)
                        {
                            //如果是部门管理员 检查该步骤是否在管理范围内
                            bool flag = false;
                            //如果是部门管理员  则要判断 是否有其管辖的部门
                            List<string> ManageDeptList = SuperviseMissionBodyBiz.GetFlowDeptIdListBySmId(SmId);
                            if (ManageDeptList == null || ManageDeptList.Count == 0)
                            {
                                //没有流转部门 
                                return false;
                            }

                            foreach (var dept in GetDeptList())
                            {
                                //循环管理的部门 检查流转部门
                                if (ManageDeptList.Any(n =>
                                    n.Length >= dept.DeptId.Length &&
                                    n.Substring(0, dept.DeptId.Length) == dept.DeptId))
                                {
                                    flag = true;
                                    break;
                                }
                            }

                            if (flag == false)
                            {
                                //如果不在其管辖范围内 跳转到错误页面
                                return false;
                            }
                        }
                        else
                        {
                            //其他普通人员的判断
                            if (FlowItemEntity.UserId != CurrentUserInfo.Employee_ID &&
                                FlowItemEntity.UserIdConsigned != CurrentUserInfo.Employee_ID)
                            {
                                //当前人员不在该步骤中
                                return false;
                            }
                        }

                        #endregion

                        //判断参数是否被篡改
                        if (FlowItemEntity.StepId != StepId)
                        {
                            //当前步骤已经被篡改
                            return false;
                        }

                    }

                    #endregion

                }

                #endregion

                #region 查询的页面校验

                else if (PageType == "Query")
                {
                }

                #endregion

                #region 基础数据管理页面的校验

                else if (PageType == "DeptManagePage")
                {
                }

                #endregion

                #region 超级管理员页面的校验

                else if (PageType == "SuperManagePage")
                {
                }

                #endregion

                #region 系统管理员的页面校验

                else if (PageType == "SystemManagePage")
                {
                }

                #endregion

                #region 报表页面的校验

                else if (PageType == "ReportPage")
                {
                }

                #endregion

                #region 其他情况抛错

                else
                {
                    //其他情况抛出错误
                    //GoToErrorPage();
                }

                #endregion

                //走到这里 表示验证通过
                return true;
            }
            catch (Exception ex)
            {
                //系统校验时出错
                return false;
            }
        }

        #endregion

        #region 反馈记录

        /// <summary>
        /// 获取反馈记录。
        /// </summary>
        /// <param name="smId">任务Id。</param>
        /// <param name="targetId">目标Id。</param>
        /// <param name="itemId">措施/子措施Id。</param>
        /// <param name="opinionType">意见类型。</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public FeedbackResponse GetFeedback(string smId, string targetId, string itemId, string opinionType)
        {
            try
            {
                #region  登录校验

                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return new FeedbackResponse()
                    {
                        data = NoLoginResponse.data,
                        message = NoLoginResponse.message,
                        status = NoLoginResponse.status
                    };
                }

                #endregion

                #region 越权校验

                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return new FeedbackResponse()
                    {
                        data = UrlCheckResponse.data,
                        message = UrlCheckResponse.message,
                        status = UrlCheckResponse.status
                    };
                }

                #endregion

                IEnumerable<SmFlowFinishEntity> source = null;
                if (!string.IsNullOrEmpty(smId) && !string.IsNullOrEmpty(targetId) && !string.IsNullOrEmpty(itemId))
                {
                    source = SuperviseMissionBodyBiz.GetSmFlowFinishList(e =>
                        e.SmId == smId && e.TargetId == targetId && e.TargetItemId == itemId && e.Opinion != null &&
                        e.Opinion != "");
                }
                else if (!string.IsNullOrEmpty(smId) && !string.IsNullOrEmpty(targetId))
                {
                    source = SuperviseMissionBodyBiz.GetSmFlowFinishList(e =>
                        e.SmId == smId && e.TargetId == targetId && e.Opinion != null && e.Opinion != "");
                }
                else if (!string.IsNullOrEmpty(smId))
                {
                    source = SuperviseMissionBodyBiz.GetSmFlowFinishList(e =>
                        e.SmId == smId && e.Opinion != null && e.Opinion != "");
                }

                List<FeedbackItem> items = null;
                String[] steps = { "CSFK", "ZCSFK", "ZRDWCSFK", "ZRCSCSFK" };
                if (source != null && source.Any())
                {
                    items = new List<FeedbackItem>();
                    using (var en = source.GetEnumerator())
                    {
                        while (en.MoveNext())
                        {
                            var t = en.Current;
                            if (steps.Contains(t.StepId))
                            {
                                items.Add(new FeedbackItem()
                                {
                                    Opinion = t.Opinion,
                                    OpinionType = t.OpinionType,
                                    UserId = t.UserId + "<br/>" + t.UserName,
                                    UserName = t.UserDeptName + "<br/>" + t.UserRank,
                                    HandlerTime = Convert.ToDateTime(t.FinishTime).ToString("yyyy-MM-dd HH:mm:ss"),
                                    StepName = t.StepName
                                });
                            }
                        }
                    }
                }

                return new FeedbackResponse()
                {
                    status = "1",
                    message = "成功",
                    Items = items
                };
            }
            catch (Exception ex)
            {
                return new FeedbackResponse()
                {
                    status = "0",
                    message = ex.Message
                };
            }
        }

        #endregion

        #region 获取意见类型

        /// <summary>
        /// 获取意见类型集合
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetOpinionTypeList()
        {
            try
            {
                #region  登录校验

                if (!CheckLogin())
                {
                    //没有登录不能进行操作
                    return new FeedbackResponse()
                    {
                        data = NoLoginResponse.data,
                        message = NoLoginResponse.message,
                        status = NoLoginResponse.status
                    };
                }

                #endregion

                #region 越权校验

                if (!CheckFormRequest())
                {
                    //url存在被篡改的风险
                    return new FeedbackResponse()
                    {
                        data = UrlCheckResponse.data,
                        message = UrlCheckResponse.message,
                        status = UrlCheckResponse.status
                    };
                }

                #endregion

                List<SmBasicDataOpinionTypeEntity> opintionList =
                    SMBasicDataBiz.GetSmBasicDataOpinionTypeEntityList(new SmBasicDataOpinionTypeEntity());
                opintionList = opintionList.Where(m => m.ActivityFlag == 1).ToList();

                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取成功",
                    data = JsonHelper.ToJson(opintionList)
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取意见类型出错：" + ex.Message
                };
            }
        }

        #endregion
    }
}