using CSN.DotNetLibrary.EntityExpressions.Entitys;
using OA30.Common.Entity;
using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Entity.MissionBase;
using OA30.SuperviseMission.UI.CommonComponents;
using OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys;
using OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Services;
using System.Text;
using OA30.SuperviseMission.UI.MainSite.Statistics;
using OA30.SuperviseMission.UI.CommonComponents.Utilities;
using OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys;
using System.IO;

namespace OA30.SuperviseMission.UI.MainSite.WebServices
{
    /// <summary>
    /// SuperviseMissionWebServices 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class SuperviseMissionWebServices : BaseWebService
    {
        #region 督查字号

        /// <summary>
        /// 获取督查字号列表。
        /// </summary>
        /// <param name="searchDepartmentIds">部门id集合。</param>
        /// <param name="searchDepartment">部门名称。</param>
        /// <param name="searchCode">流水号。</param>
        /// <param name="searchName">督查字号名称。</param>
        /// <param name="searchYear">年号。</param>
        /// <param name="limit">分页参数。</param>
        /// <param name="offset">分页参数。</param>
        /// <returns>获取督查字号列表及请求结果。</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSMBasicDataSuperviseNumbers(string searchDepartmentIds, string searchCode, string searchName, string searchYear, int limit, int offset)
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

                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDepartmentIds))
                {
                    searchDepartmentIds = searchDepartmentIds.TrimEnd(',');
                    deptIds = GetDeptActivityListByIds(searchDepartmentIds);
                }

                //搜索条件。
                var yearValue = string.IsNullOrEmpty(searchYear) ? 0 : int.Parse(searchYear.Trim());
                var codeValue = string.IsNullOrEmpty(searchCode) ? -999 : int.Parse(searchCode.Trim());

                SmBasicDataSuperviseNumberEntity condition = new SmBasicDataSuperviseNumberEntity
                {

                    Code = codeValue,
                    Name = searchName.Trim(),
                    Year = yearValue
                };

                var m = SMBasicDataBiz.GetSuperviseNumberEntityList(condition, deptIds).ToList();
                var smBasicDataSuperviseNumberList = m.FindAll(n => GetDeptActivityList().Select(d => d.DeptId).Contains(n.DeptId)).OrderByDescending(n => n.CreateTime).ToList();


                if (deptIds != null && deptIds.Count > 0)
                {
                    smBasicDataSuperviseNumberList = smBasicDataSuperviseNumberList.FindAll(n => deptIds.Contains(n.DeptId));
                }
                int total = smBasicDataSuperviseNumberList.Count;
                var rows = smBasicDataSuperviseNumberList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });


                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取督查字号成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取督查字号失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSMBasicDataSuperviseNumber(SmBasicDataSuperviseNumberEntity smBasicDataSuperviseNumberEntity)
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

                #region Xss攻击校验
                var xxsHtml = smBasicDataSuperviseNumberEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (!SMBasicDataSuperviseNumberRequiredFieldValidator(smBasicDataSuperviseNumberEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查字号失败：元素不能为空。" };
                }

                //根据部门Id查到部门名字
                var department = GetDeptActivityList().Find(n => n.DeptId == smBasicDataSuperviseNumberEntity.DeptId);
                if (department == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查字号失败：查无此部门。" };
                }

                if (SMBasicDataBiz.ExistSmBasicDataSuperviseNumberEntityByKey(smBasicDataSuperviseNumberEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查字号失败：该督查字号已经存在，请勿重复添加。" };
                }

                //undo CREATOR_ID,TYPE赋值
                smBasicDataSuperviseNumberEntity.Type = "2";
                smBasicDataSuperviseNumberEntity.DeptId = department.DeptId;
                smBasicDataSuperviseNumberEntity.CreatorId = CurrentUserInfo.Employee_ID;
                smBasicDataSuperviseNumberEntity.CreateTime = DateTime.Now;
                smBasicDataSuperviseNumberEntity.DeptName = department.DeptName;
                smBasicDataSuperviseNumberEntity.Code = 0;

                SMBasicDataBiz.InsertSuperviseNumberEntity(smBasicDataSuperviseNumberEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增督查字号(" + smBasicDataSuperviseNumberEntity.Name + ")成功");
                return new SuperviseMissionResponse() { status = "1", message = "新增督查字号成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增督查字号失败：详情请查看日志！" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse EditSMBasicDataSuperviseNumber(SmBasicDataSuperviseNumberEntity smBasicDataSuperviseNumberEntity, SmBasicDataSuperviseNumberEntity oldSmBasicDataSuperviseNumberEntity)
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
                #region Xss攻击校验
                var xxsHtml = smBasicDataSuperviseNumberEntity.ToJson() + oldSmBasicDataSuperviseNumberEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                //非空验证。
                if (!SMBasicDataSuperviseNumberRequiredFieldValidator(smBasicDataSuperviseNumberEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑督查字号失败：元素不能为空。" };
                }

                //查询更改对象。
                var smBasicDataSuperviseNumber = SMBasicDataBiz.GetSuperviseNumberEntityList(new SmBasicDataSuperviseNumberEntity(), null).Find(
                    n => n.Name == oldSmBasicDataSuperviseNumberEntity.Name
                    && n.Code == oldSmBasicDataSuperviseNumberEntity.Code
                    && n.DeptId == oldSmBasicDataSuperviseNumberEntity.DeptId
                    && n.Year == oldSmBasicDataSuperviseNumberEntity.Year);

                //根据部门Id查到部门名字
                var department = GetDeptActivityList().Find(n => n.DeptId == smBasicDataSuperviseNumberEntity.DeptId);
                if (department == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑督查字号失败：查无此部门。" };
                }

                //为更改对象赋新的值。
                smBasicDataSuperviseNumber.ActivityFlag = smBasicDataSuperviseNumberEntity.ActivityFlag;
                smBasicDataSuperviseNumber.DeptId = department.DeptId;
                smBasicDataSuperviseNumber.DeptName = department.DeptName;
                smBasicDataSuperviseNumber.Name = smBasicDataSuperviseNumberEntity.Name;

                GenericWhereEntity<SmBasicDataSuperviseNumberEntity> whereEntity = new GenericWhereEntity<SmBasicDataSuperviseNumberEntity>();
                whereEntity.Where(n => n.Name == oldSmBasicDataSuperviseNumberEntity.Name
                    && n.Code == oldSmBasicDataSuperviseNumberEntity.Code
                    && n.DeptId == oldSmBasicDataSuperviseNumberEntity.DeptId
                    && n.Year == oldSmBasicDataSuperviseNumberEntity.Year);
                SMBasicDataBiz.UpdateSuperviseNumberEntity(whereEntity, smBasicDataSuperviseNumber);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "编辑督查字号(" + oldSmBasicDataSuperviseNumberEntity.Name + ")成功");
                return new SuperviseMissionResponse() { status = "1", message = "督查字号编辑成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "督查字号编辑失败：详情请查看日志！" };
            }
        }

        //非空验证方法，true为通过验证，false为不通过验证。
        private bool SMBasicDataSuperviseNumberRequiredFieldValidator(SmBasicDataSuperviseNumberEntity smBasicDataSuperviseNumberEntity)
        {
            if (string.IsNullOrEmpty(smBasicDataSuperviseNumberEntity.Name)
                || string.IsNullOrEmpty(smBasicDataSuperviseNumberEntity.DeptId)
                || smBasicDataSuperviseNumberEntity.Year == null
                || smBasicDataSuperviseNumberEntity.Year == 0
                || smBasicDataSuperviseNumberEntity.ActivityFlag == null)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        //根据部门号，名称获取年号
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSuSuperviseNumberYear(string deptId, string name)
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
                List<string> deptIds = new List<string>();
                deptIds.Add(deptId);
                SmBasicDataSuperviseNumberEntity condition = new SmBasicDataSuperviseNumberEntity
                {
                    Name = name
                };
                var smBasicDataSuperviseNumberList = SMBasicDataBiz.GetSuperviseNumberEntityList(condition, deptIds).OrderByDescending(n => n.Year).ToList();
                if (smBasicDataSuperviseNumberList.Count < 1)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        data = "",
                        message = "年号未定义"
                    };
                }
                List<string> years = new List<string>();
                foreach (var item in smBasicDataSuperviseNumberList)
                {
                    years.Add(item.Year.ToString());
                }
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = string.Join("|", years.ToArray()),
                    message = "OK"
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = ex.Message
                };
            }
        }
        //根据部门号，名称，年号获取序号
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSuSuperviseNumberCode(string deptId, string name, string year)
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
                List<string> deptIds = new List<string>();
                deptIds.Add(deptId);
                SmBasicDataSuperviseNumberEntity condition = new SmBasicDataSuperviseNumberEntity
                {
                    Name = name,
                    Year = int.Parse(year)
                };
                int? intCode = SMBasicDataBiz.GetSuperviseNumberEntityList(condition, deptIds).OrderByDescending(n => n.Year).Max(n => n.Code);
                if (intCode == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        data = "",
                        message = "未定义"
                    };
                }
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = (intCode + 1).ToString(),
                    message = "OK"
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = ex.Message
                };
            }
        }

        /// <summary>
        /// 获取督查字号集合--用于拟稿绑定
        /// </summary>
        /// <param name="deptId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetDistinctSuperviseNumberNameList()
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
                //获取当前员工所在部门的第一个可见部门，比如管理研发部的部门号，可见部门是信息中心
                string visualDept = SuperviseMissionWorkFlow.GetFlowDeptIdByDeptId(CurrentUserInfo.Dept_ID);
                if (string.IsNullOrEmpty(visualDept))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "获取可见部门失败"
                    };
                }
                List<string> deptids = new List<string>();
                deptids.Add(visualDept);
                List<SmBasicDataSuperviseNumberEntity> spList = SMBasicDataBiz.GetSuperviseNumberEntityList(new SmBasicDataSuperviseNumberEntity() { ActivityFlag = 1 }, deptids);
                List<SuperviseNumberResponseEntity> spListByDistinct = new List<SuperviseNumberResponseEntity>();
                if (spList.Any())
                {
                    //过滤督查字号相同的数据
                    var tempList = spList.Select(m => new { m.DeptId, m.Name }).Distinct().ToList();
                    SuperviseNumberResponseEntity spEntity = null;
                    foreach (var item in tempList)
                    {
                        spEntity = new SuperviseNumberResponseEntity();
                        spEntity.DeptId = item.DeptId;
                        spEntity.Name = item.Name;

                        spListByDistinct.Add(spEntity);
                    }
                }

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "",
                    data = JsonHelper.ToJson(spListByDistinct)
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = ex.Message
                };
            }
        }

        #endregion

        #region 意见类型



        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSmOpinionType()
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
                var superviseMissionOpinionTypeEntityList = SMBasicDataBiz.GetSmBasicDataOpinionTypeEntityList(
                    new SmBasicDataOpinionTypeEntity());

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(superviseMissionOpinionTypeEntityList),
                    message = "获取所属类型列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取所属类型列表失败。"
                };
            }
        }


        /// <summary>
        /// 获取意见类型实体信息
        /// </summary>
        /// <param name="searchTypeName">查询类型名</param>
        /// <param name="limit"></param>
        /// <param name="offset"></param>
        /// <returns></returns>

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSmBasicDataOpinionTypeEntityList(string searchTypeName, int limit, int offset)
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
                SmBasicDataOpinionTypeEntity condition = new SmBasicDataOpinionTypeEntity
                {

                    TypeName = searchTypeName.Trim()

                };

                var SmSystemTypeDefintionList = SMBasicDataBiz.GetSmBasicDataOpinionTypeEntityList(condition).OrderByDescending(n => n.CreateTime).ToList();
                int total = SmSystemTypeDefintionList.Count;
                var rows = SmSystemTypeDefintionList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取类型信息成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取类型信息失败，详情请查看日志。"
                };
            }
        }





        /// <summary>
        /// 增加意见类型实体信息
        /// </summary>
        /// <param name="smBasicDataOpinionTypeEntity">意见类型实体列表</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddBasicDataOpinionType(SmBasicDataOpinionTypeEntity smBasicDataOpinionTypeEntity)
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
                #region Xss攻击校验
                var xxsHtml = smBasicDataOpinionTypeEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                // 非空验证。


                if (string.IsNullOrEmpty(smBasicDataOpinionTypeEntity.TypeId) || string.IsNullOrEmpty(smBasicDataOpinionTypeEntity.TypeName))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增意见类型失败：元素不能为空。" };
                }

                smBasicDataOpinionTypeEntity.CreateTime = DateTime.Now;
                SMBasicDataBiz.InsertSmBasicDataOpinionTypeEntity(smBasicDataOpinionTypeEntity);


                return new SuperviseMissionResponse() { status = "1", message = "新增意见类型字号成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增意见类型字号失败：详情请查看日志！" };
            }
        }



        /// <summary>
        /// 根据意见类型号置否意见类型信息是否可用
        /// </summary>
        /// <param name="typeId">意见类型ID号</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse InversionSmBasicDataOpinionType(string typeId)
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
                #region Xss攻击校验
                var xxsHtml = typeId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                var smBasicDataOpinionTypeEntity = SMBasicDataBiz.GetSmBasicDataOpinionTypeEntity(typeId);
                if (smBasicDataOpinionTypeEntity == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "置否角色定义失败：查无此角色。" };
                }

                if (smBasicDataOpinionTypeEntity.ActivityFlag == 0)
                {
                    smBasicDataOpinionTypeEntity.ActivityFlag = 1;
                }
                else
                {
                    smBasicDataOpinionTypeEntity.ActivityFlag = 0;
                }

                SMBasicDataBiz.UpdateSmBasicDataOpinionTypeEntity(smBasicDataOpinionTypeEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "置否角色定义成功，角色Id：" + smBasicDataOpinionTypeEntity.TypeId);
                return new SuperviseMissionResponse() { status = "1", message = "置否角色定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "置否角色定义失败。" };
            }
        }


        #endregion

        #region 操作日志

        /// <summary>
        /// 获取操作日志实体信息
        /// </summary>
        /// <param name="logModuleType">模式类型号</param>
        /// <param name="logLayerType">层级类型号</param>
        /// <param name="logErrorType">错误类型号</param>
        /// <param name="startSearchTime">开始时间</param>
        /// <param name="endSearchTime">结束时间</param>
        /// <param name="logOpreator">操作者</param>
        /// <param name="logContent">错误提示内容</param>
        /// <param name="limit"></param>
        /// <param name="offset"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSMOpreationLog(string logModuleType, string logLayerType, string logErrorType, string startSearchTime, string endSearchTime, string logOpreator, string logContent, int limit, int offset)
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
                if (string.IsNullOrEmpty(startSearchTime))
                {
                    startSearchTime = "1111-11-11 00:00:00";
                }

                if (string.IsNullOrEmpty(endSearchTime))
                {
                    endSearchTime = "1111-11-11 00:00:00";
                }

                SmOpreationLogEntity condition = new SmOpreationLogEntity
                {

                    ModuleType = int.Parse(logModuleType),
                    LayerType = int.Parse(logLayerType),
                    ErrorType = int.Parse(logErrorType),
                    OpreateTime = Convert.ToDateTime(startSearchTime),
                    EndOpreateTime = Convert.ToDateTime(endSearchTime),
                    OpreatorName = logOpreator.Trim(),
                    Content = logContent.Trim()

                };

                List<SmOpreationLogEntity> result = new List<SmOpreationLogEntity>();
                DataTable dt = SMBasicDataBiz.GetOpreationLogDataTable(condition);
                foreach (DataRow dr in dt.Rows)
                {
                    result.Add(new SmOpreationLogEntity()
                    {

                        ModuleName = dr["MODULE_NAME"].ToString(),
                        LayerName = dr["LAYER_NAME"].ToString(),
                        ErrorTypeName = dr["ERROR_TYPE_NAME"].ToString(),
                        Content = dr["CONTENT"].ToString(),
                        OpreatorId = dr["OPREATOR_ID"].ToString(),
                        OpreatorName = dr["OPREATOR_NAME"].ToString(),
                        OpreateTime = (DateTime)(dr["OPREATE_TIME"]),
                        OpreatorIp = dr["OPREATOR_IP"].ToString(),
                        OpreatorDeptId = dr["OPREATOR_DEPT_ID"].ToString(),
                        OpreatorDeptName = dr["OPREATOR_DEPT_NAME"].ToString()

                    });
                }

                int total = result.Count;
                var rows = result.Skip(offset).Take(limit);
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取日志信息成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取日志信息失败，详情请查看日志。"
                };
            }
        }
        #endregion

        #region 文件类型

        /// <summary>
        /// 获取文件类型实体信息
        /// </summary>
        /// <param name="typeid">类型号</param>
        /// <param name="typename">类型名</param>
        /// <param name="limit"></param>
        /// <param name="offset"></param>
        /// <returns></returns>

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSMSystemTypeDefintion(string typeid, string typename, int limit, int offset)
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
                SmSystemTypeDefinitionEntity condition = new SmSystemTypeDefinitionEntity
                {
                    TypeId = typeid.Trim(),
                    TypeName = typename.Trim()

                };

                var SmSystemTypeDefintionList = SMBasicDataBiz.GetSuperviseMissionTypeDefinitionEntityList(condition).OrderByDescending(n => n.CreateTime).ToList();
                int total = SmSystemTypeDefintionList.Count;
                var rows = SmSystemTypeDefintionList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取类型信息成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取类型信息失败，详情请查看日志。"
                };
            }
        }

        /// <summary>
        /// 增加文件类型实体信息
        /// </summary>
        /// <param name="smSystemTypeDefinitionEntity">文件实体参数</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSMSystemTypeDefintion(SmSystemTypeDefinitionEntity smSystemTypeDefinitionEntity)
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
                #region Xss攻击校验
                var xxsHtml = smSystemTypeDefinitionEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                // 非空验证。
                if (!SMSystemTypeDefinitionRequiredFieldValidator(smSystemTypeDefinitionEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增类型名失败：元素不能为空。" };
                }

                if (SMBasicDataBiz.ExistSuperviseMissionTypeDefinitionEntityByKey((smSystemTypeDefinitionEntity)))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查字号失败：该督查字号已经存在，请勿重复添加。" };
                }

                smSystemTypeDefinitionEntity.CreateTime = DateTime.Now;
                SMBasicDataBiz.InsertSuperviseMissionTypeDefinitionEntity(smSystemTypeDefinitionEntity);

                return new SuperviseMissionResponse() { status = "1", message = "新增文件类型字号成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增文件类型字号失败：详情请查看日志！" };
            }
        }

        /// <summary>
        /// 编辑文件类型信息
        /// </summary>
        /// <param name="smSystemTypeDefinitionEntity">新文件实体参数</param>
        /// <param name="oldSmSystemTypeDefinitionEntity">原文件实体参数</param>
        /// <returns></returns>

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse EditSMSystemTypeDefinitionNumber(SmSystemTypeDefinitionEntity smSystemTypeDefinitionEntity, SmSystemTypeDefinitionEntity oldSmSystemTypeDefinitionEntity)
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
                #region Xss攻击校验
                var xxsHtml = smSystemTypeDefinitionEntity.ToJson() + oldSmSystemTypeDefinitionEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (!SMSystemTypeDefinitionRequiredFieldValidator(smSystemTypeDefinitionEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑类型字号失败：元素不能为空。" };
                }
                //查询更改对象。
                var smSystemTypeDefinition = SMBasicDataBiz.GetSuperviseMissionTypeDefinitionEntityList(new SmSystemTypeDefinitionEntity()).Find(
                    n => n.TypeName == oldSmSystemTypeDefinitionEntity.TypeName
                    && n.TypeId == oldSmSystemTypeDefinitionEntity.TypeId
                );

                smSystemTypeDefinition.TypeName = smSystemTypeDefinitionEntity.TypeName;
                smSystemTypeDefinition.TypeId = smSystemTypeDefinitionEntity.TypeId;
                GenericWhereEntity<SmSystemTypeDefinitionEntity> whereEntity = new GenericWhereEntity<SmSystemTypeDefinitionEntity>();
                whereEntity.Where(n => n.TypeName == oldSmSystemTypeDefinitionEntity.TypeName
                    && n.TypeId == oldSmSystemTypeDefinitionEntity.TypeId
                   );
                SMBasicDataBiz.UpdateSuperviseMissionTypeDefinitionEntity(smSystemTypeDefinition);
                return new SuperviseMissionResponse() { status = "1", message = "类型字号编辑成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "类型字号编辑失败：详情请查看日志！" };
            }
        }

        //非空验证方法，true为通过验证，false为不通过验证。
        private bool SMSystemTypeDefinitionRequiredFieldValidator(SmSystemTypeDefinitionEntity smSystemTypeDefinitionEntity)
        {
            if (string.IsNullOrEmpty(smSystemTypeDefinitionEntity.TypeName)
                || string.IsNullOrEmpty(smSystemTypeDefinitionEntity.TypeId)
              )
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        #endregion

        #region 督查委托
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSmBasicDataAuthorize(int limit, int offset, string searchAuthorizeName, string searchConsigneeName)
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
                var smBasicDataAuthorizeEntity = new SmBasicDataAuthorizeEntity
                {
                    AuthorizerName = searchAuthorizeName.Trim(),
                    ConsigneeName = searchConsigneeName.Trim()
                };

                var authorizeEntityList = SMBasicDataBiz.GetAuthorizeEntityList(smBasicDataAuthorizeEntity).OrderByDescending(n => n.CreateTime).ToList();
                int total = authorizeEntityList.Count;
                var rows = authorizeEntityList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取督查委托列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取督查委托列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DelSmBasicDataAuthorize(string authorizerId, string consigneeId)
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
                SMBasicDataBiz.DeleteDataAuthorizeEntity(authorizerId, consigneeId);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "删除督查委托成功，授权人Id为：" + authorizerId + "委托人Id为：" + consigneeId);
                return new SuperviseMissionResponse() { status = "1", message = "删除督查委托成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "删除督查委托失败。" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSmBasicDataAuthorize(SmBasicDataAuthorizeEntity smBasicDataAuthorizeEntity)
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
                #region Xss攻击校验
                var xxsHtml = smBasicDataAuthorizeEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(smBasicDataAuthorizeEntity.ConsigneeId)
                    || smBasicDataAuthorizeEntity.BeginTime == null
                    || smBasicDataAuthorizeEntity.EndTime == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查委托失败：元素不能为空。" };
                }


                UserInfo consignee = SMBasicDataBiz.GetGenericUserInfoByID(smBasicDataAuthorizeEntity.ConsigneeId);
                if (consignee == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查委托失败：查无此用户。" };
                }
                smBasicDataAuthorizeEntity.AuthorizerId = CurrentUserInfo.Employee_ID;
                smBasicDataAuthorizeEntity.AuthorizerName = CurrentUserInfo.Name;
                smBasicDataAuthorizeEntity.CreateTime = DateTime.Now;
                smBasicDataAuthorizeEntity.OperatorId = CurrentUserInfo.Employee_ID;
                smBasicDataAuthorizeEntity.ConsigneeName = consignee.Name;
                smBasicDataAuthorizeEntity.EndTime =
                    smBasicDataAuthorizeEntity.EndTime?.AddHours(23).AddMinutes(59).AddSeconds(59);
                if (smBasicDataAuthorizeEntity.ConsigneeId == smBasicDataAuthorizeEntity.AuthorizerId)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查委托失败：授权人与委托人不能是同一人。" };
                }

                var oldModel = SMBasicDataBiz.ExistDataAuthorizeEntityByKey(smBasicDataAuthorizeEntity);
                //去重。
                if (oldModel != null)
                {
                    //过期
                    if (oldModel.Status == 0)
                    {
                        //覆盖。
                        SMBasicDataBiz.UpdateDataAuthorizeEntity(smBasicDataAuthorizeEntity);
                        AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "更新督查委托成功，授权人Id为：" + smBasicDataAuthorizeEntity.AuthorizerId + "委托人Id为：" + smBasicDataAuthorizeEntity.ConsigneeId);
                        return new SuperviseMissionResponse() { status = "1", message = "更新督查委托成功。" };
                    }
                    else
                    {
                        return new SuperviseMissionResponse() { status = "0", message = "新增督查委托失败：该督查委托已经存在，请勿重复添加。" };
                    }
                }

                SMBasicDataBiz.InsertAuthorizeEntity(smBasicDataAuthorizeEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增督查委托成功，授权人Id为：" + smBasicDataAuthorizeEntity.AuthorizerId + "委托人Id为：" + smBasicDataAuthorizeEntity.ConsigneeId);
                return new SuperviseMissionResponse() { status = "1", message = "新增督查委托成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增督查委托失败：详情请查看日志！" };
            }
        }
        #endregion

        #region 督查自定义部门组
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSMBasicDataDeptGroups(string searchDeptIds, string searchDeptName, string deptGroupName, int limit, int offset)
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
                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDeptIds) && !searchDeptIds.Equals("0"))
                {
                    searchDeptIds = searchDeptIds.TrimEnd(',');
                    deptIds = searchDeptIds.Split(',').ToList();
                }

                SmBasicDataPersonalDeptGroupEntity smBasicDataPersonalDeptGroupEntity = new SmBasicDataPersonalDeptGroupEntity
                {
                    GroupName = deptGroupName.Trim(),
                    UserId = CurrentUserInfo.Employee_ID
                };

                SmBasicDataPersonalDeptGroupDetailEntity smBasicDataPersonalDeptGroupDetailEntityEntity = new SmBasicDataPersonalDeptGroupDetailEntity
                {
                    DeptName = searchDeptName.Trim()
                };

                //DEPT_GROUP数据
                var deptGroupEntityList = SMBasicDataBiz.GetDeptGroupEntityList(smBasicDataPersonalDeptGroupEntity).OrderByDescending(n => n.GroupId).ToList();

                //DEPT_GROUP_DETAIL数据
                var deptGroupDetailEntityList = SMBasicDataBiz.GetDeptGroupDetailEntityList(smBasicDataPersonalDeptGroupDetailEntityEntity, deptIds).ToList();

                //取两个集合的交集。
                var retainGroupList = deptGroupEntityList.FindAll(n => deptGroupDetailEntityList.Select(a => a.GroupId).Contains(n.GroupId));
                var deptGroupAllDetailEntityList = new List<SmBasicDataPersonalDeptGroupDetailEntity>();
                foreach (var retainGroup in retainGroupList)
                {
                    deptGroupAllDetailEntityList.AddRange(SMBasicDataBiz.GetDeptGroupDetailEntityList(new SmBasicDataPersonalDeptGroupDetailEntity { GroupId = retainGroup.GroupId }, null).ToList());
                }

                //查询公式
                var groupJoin = retainGroupList.GroupJoin(deptGroupAllDetailEntityList,
                    group => group.GroupId,
                    dept => dept.GroupId,
                    (group, depts) => new
                    {
                        Group = group,
                        Depts = depts.OrderBy(d => d.Order)
                    }).ToList().FindAll(n => n.Depts.Count() > 0);//感觉和字典类型一样，一个key，对应一个velue, velue = IEnumerable<Dept>


                int total = groupJoin.Count;
                var rows = groupJoin.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取督查自定义部门组成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取督查自定义部门组，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSMBasicDataDeptGroup(string groupName, string deptIds)
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
                #region Xss攻击校验
                var xxsHtml = groupName + deptIds;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(groupName) || string.IsNullOrEmpty(deptIds))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查自定义部门组失败：元素不能为空。" };
                }

                //把部门Id转换为list。
                List<string> deptIdList = GetDeptIdList(deptIds);

                //部门id重复验证
                if (deptIdList.GroupBy(n => n).Where(g => g.Count() > 1).Count() > 0)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查自定义部门组失败：存在重复部门，请核对。" };
                }

                //验证传递进来的部门Id，当前用户是否有权限设置,并构造SmBasicDataPersonalDeptGroupDetailEntity的集合。
                var deptList = CacheHelper.AllVisbleDeptEntityList;
                List<SmBasicDataPersonalDeptGroupDetailEntity> smBasicDataPersonalDeptGroupDetailList = new List<SmBasicDataPersonalDeptGroupDetailEntity>();
                int count = 0;
                foreach (var deptId in deptIdList)
                {
                    count++;
                    var department = deptList.Find(n => n.DeptId == deptId);
                    if (department == null)
                    {
                        return new SuperviseMissionResponse() { status = "0", message = "新增督查自定义部门组失败：查无此部门。" };
                    }

                    SmBasicDataPersonalDeptGroupDetailEntity smBasicDataPersonalDeptGroupDetailEntity = new SmBasicDataPersonalDeptGroupDetailEntity
                    {
                        DeptId = department.DeptId,
                        DeptName = department.DeptName,
                        Order = count
                    };
                    smBasicDataPersonalDeptGroupDetailList.Add(smBasicDataPersonalDeptGroupDetailEntity);
                }

                int newGroupId = SMBasicDataBiz.GetMaxGroupId() + 1;

                //构造需要新增的DeptGroup对象。
                SmBasicDataPersonalDeptGroupEntity smBasicDataPersonalDeptGroupEntity = new SmBasicDataPersonalDeptGroupEntity
                {
                    GroupName = groupName.Trim(),
                    UserId = CurrentUserInfo.Employee_ID,
                    UserName = CurrentUserInfo.Name,
                    GroupId = newGroupId
                };

                SMBasicDataBiz.InsertDeptGroupEntity(smBasicDataPersonalDeptGroupEntity);
                foreach (var smBasicDataPersonalDeptGroupDetail in smBasicDataPersonalDeptGroupDetailList)
                {
                    smBasicDataPersonalDeptGroupDetail.GroupId = newGroupId;
                    //构造需要新增的DeptGroupDetail对象。
                    SMBasicDataBiz.InsertDeptGroupDetailEntity(smBasicDataPersonalDeptGroupDetail);
                }

                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增督查自定义部门组(" + groupName + ")成功");
                return new SuperviseMissionResponse() { status = "1", message = "新增督查自定义部门组成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增督查自定义部门组失败：详情请查看日志！" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DelSMBasicDataDeptGroup(int deptGroupId)
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
                var smBasicDataPersonalDeptGroupEntity = SMBasicDataBiz.GetSmBasicDataPersonalDeptGroupEntity(deptGroupId);
                if (smBasicDataPersonalDeptGroupEntity.UserId != CurrentUserInfo.Employee_ID)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "删除督查自定义部门组失败，当前用户无权限！" };
                }
                SMBasicDataBiz.DeleteAllDeptDetail(deptGroupId);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "删除督查自定义部门组成功，部门组Id为：" + deptGroupId);
                return new SuperviseMissionResponse() { status = "1", message = "删除督查自定义部门组成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "删除督查自定义部门组失败。" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse EditSMBasicDataDeptGroup(int deptGroupId, string groupName, string deptIds)
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
                #region Xss攻击校验
                var xxsHtml = groupName + deptIds;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(groupName) || string.IsNullOrEmpty(deptIds) || deptGroupId <= 0)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑督查自定义部门组失败：元素不能为空。" };
                }

                var smBasicDataPersonalDeptGroupEntity = SMBasicDataBiz.GetSmBasicDataPersonalDeptGroupEntity(deptGroupId);
                if (smBasicDataPersonalDeptGroupEntity.UserId != CurrentUserInfo.Employee_ID)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑督查自定义部门组失败，当前用户无权限！" };
                }

                //把部门Id转换为list。
                List<string> deptIdList = GetDeptIdList(deptIds);
                //部门id重复验证
                if (deptIdList.GroupBy(n => n).Where(g => g.Count() > 1).Count() > 0)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增督查自定义部门组失败：存在重复部门，请核对。" };
                }


                //更新部门分组表。
                SMBasicDataBiz.UpdateDeptGroupEntity(deptGroupId, groupName);
                //更新部门分组详细表。
                string message;
                if (UpdateDeptGroupDetail(deptGroupId, deptIds, out message))
                {
                    AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "编辑督查自定义部门组(" + groupName + ")成功");
                    return new SuperviseMissionResponse() { status = "1", message = "编辑督查自定义部门组成功。" };
                }
                else
                {
                    return new SuperviseMissionResponse() { status = "0", message = message };
                }
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "编辑督查自定义部门组失败。" };
            }
        }

        private List<string> GetDeptGroupDetailDeptIdList(int groupId)
        {
            List<string> deptIds = new List<string>();
            foreach (var deptGroupEntity in SMBasicDataBiz.GetDeptGroupDetailEntityList(new SmBasicDataPersonalDeptGroupDetailEntity { GroupId = groupId }, null))
            {
                deptIds.Add(deptGroupEntity.DeptId);
            }

            return deptIds;
        }

        private bool UpdateDeptGroupDetail(int deptGroupId, string searchDeptIds, out string message)
        {
            try
            {

                #region Xss攻击校验
                var xxsHtml = searchDeptIds;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    message = "您提交的Post数据有恶意字符。";
                }
                #endregion

                //把部门Id转换为list。
                List<string> deptIds = GetDeptIdList(searchDeptIds);
                //获取原有部门组详细集合。
                List<string> oldDeptIds = GetDeptGroupDetailDeptIdList(deptGroupId);
                //取差集，获取用户需要删除的部门Id集合。
                List<string> exceptDeptIds = oldDeptIds.Except(deptIds).ToList();
                //删除差集。
                foreach (var deptId in exceptDeptIds)
                {
                    SMBasicDataBiz.DeleteDeptGroupDetail(deptGroupId, deptId);
                }

                //添加、编辑新部门详细数据。
                var deptList = CacheHelper.AllVisbleDeptEntityList;
                //取交集
                List<string> retainList = deptIds.Intersect(oldDeptIds).ToList();
                int count = 0;
                foreach (var deptId in deptIds)
                {
                    count++;
                    //判断数据库里面是否有相同建的数据。
                    if (!retainList.Contains(deptId))
                    {
                        var department = deptList.Find(n => n.DeptId == deptId);
                        if (department == null)
                        {
                            message = "编辑督查自定义部门组失败：查无此部门。";
                            return false;
                        }

                        SmBasicDataPersonalDeptGroupDetailEntity smBasicDataPersonalDeptGroupDetailEntity = new SmBasicDataPersonalDeptGroupDetailEntity
                        {
                            DeptId = department.DeptId,
                            DeptName = department.DeptName,
                            Order = count,
                            GroupId = deptGroupId
                        };
                        SMBasicDataBiz.InsertDeptGroupDetailEntity(smBasicDataPersonalDeptGroupDetailEntity);
                    }
                    else
                    {
                        SMBasicDataBiz.UpdateDeptGroupDetailOrder(deptGroupId, deptId, count);
                    }
                }
                message = "编辑督查自定义部门组成功。";
                return true;
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                message = "编辑督查自定义部门组失败。";
                return false;
            }
        }

        private List<string> GetDeptIdList(string searchDeptIds)
        {
            // 把部门Id转换为list。
            List<string> deptIds = new List<string>();
            searchDeptIds = searchDeptIds.TrimEnd(',');
            deptIds = searchDeptIds.Trim().Split(',').ToList();
            return deptIds;
        }
        #endregion

        #region 督查部门角色配置

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSMBasicDataDeptRoles(string searchDeptIds, string roleId, string memberId, int limit, int offset)
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
                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDeptIds) && !searchDeptIds.Equals("0"))
                {
                    searchDeptIds = searchDeptIds.TrimEnd(',');
                    deptIds = GetDeptActivityListByIds(searchDeptIds);
                }

                SmBasicDataDeptRoleDefinitionEntity condition = new SmBasicDataDeptRoleDefinitionEntity
                {
                    RoleId = roleId.Trim(),
                    MemberId = memberId.Trim()
                };

                var smBasicDataDeptRoleList = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(condition)
                    .FindAll(n => n.RoleId != "DEPTADMIN"
                                  && !n.RoleName.Equals("系统管理员")
                                  && !n.RoleName.Equals("运维管理员")
                                  && !n.RoleName.Equals("超级管理员")
                                  && !n.RoleName.Equals("部门管理员")
                                  && GetDeptActivityList().Select(d => d.DeptId).Contains(n.DeptId)).ToList();
                if (deptIds != null && deptIds.Count > 0)
                {
                    smBasicDataDeptRoleList = smBasicDataDeptRoleList.FindAll(n => deptIds.Contains(n.DeptId)).OrderByDescending(n => n.CreateTime).ToList();
                }
                int total = smBasicDataDeptRoleList.Count;
                var rows = smBasicDataDeptRoleList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "督查部门角色配置列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "督查部门角色配置列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetRoleListByDeptRole()
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
                List<SmSystemRoleDefinitionEntity> result = SMBasicDataBiz.GetSuperviseMissionSystemRoleEntityList(new SmSystemRoleDefinitionEntity()).FindAll(n => n.ActivityFlag == 1
                                                                                                                                                                   && !n.RoleName.Equals("部门管理员"));
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(result),
                    message = "获取角色列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取角色列表失败。"
                };
                //throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetAllRoleList()
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
                List<SmSystemRoleDefinitionEntity> result = SMBasicDataBiz.GetSuperviseMissionSystemRoleEntityList(new SmSystemRoleDefinitionEntity()).FindAll(n => n.ActivityFlag == 1);
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(result),
                    message = "获取角色列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取角色列表失败。"
                };
                //throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSmBasicDataDeptRole(SmBasicDataDeptRoleDefinitionEntity smBasicDataDeptRoleDefinitionEntity)
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
                #region Xss攻击校验
                var xxsHtml = smBasicDataDeptRoleDefinitionEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(smBasicDataDeptRoleDefinitionEntity.DeptId)
                    || string.IsNullOrEmpty(smBasicDataDeptRoleDefinitionEntity.MemberId)
                    || string.IsNullOrEmpty(smBasicDataDeptRoleDefinitionEntity.RoleId))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门角色配置失败：元素不能为空。" };
                }

                //根据部门Id查到部门名字
                var department = GetDeptActivityList().Find(n => n.DeptId == smBasicDataDeptRoleDefinitionEntity.DeptId);
                if (department == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门角色配置失败：查无此部门。" };
                }

                var role = SMBasicDataBiz.GetSuperviseMissionSystemRoleEntityList(new SmSystemRoleDefinitionEntity()).FindAll(n => n.ActivityFlag == 1
                                                                                                                                   && !n.RoleName.Equals("系统管理员")
                                                                                                                                   && !n.RoleName.Equals("运维管理员")
                                                                                                                                   && !n.RoleName.Equals("超级管理员")
                                                                                                                                   && !n.RoleName.Equals("部门管理员"))
                                                                                                                                    .Find(r => r.RoleId == smBasicDataDeptRoleDefinitionEntity.RoleId);
                if (role == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门角色配置失败：查无此角色。" };
                }

                UserInfo member = SMBasicDataBiz.GetGenericUserInfoByID(smBasicDataDeptRoleDefinitionEntity.MemberId);
                if (member == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门角色配置失败：查无此成员。" };
                }

                if (SMBasicDataBiz.ExistSmBasicDataDeptRoleDefinitionEntity(smBasicDataDeptRoleDefinitionEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门角色配置失败：角色配置已经存在，请勿重复添加。" };
                }

                smBasicDataDeptRoleDefinitionEntity.DeptName = department.DeptName;
                smBasicDataDeptRoleDefinitionEntity.RoleName = role.RoleName;
                smBasicDataDeptRoleDefinitionEntity.MemberName = member.Name;
                smBasicDataDeptRoleDefinitionEntity.CreateTime = DateTime.Now;
                SMBasicDataBiz.InsertSuperviseMissionDeptRoleEntity(smBasicDataDeptRoleDefinitionEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增部门角色配置成功，部门Id：" + smBasicDataDeptRoleDefinitionEntity.DeptId + "角色Id：" + smBasicDataDeptRoleDefinitionEntity.RoleId + "成员工号：" + smBasicDataDeptRoleDefinitionEntity.MemberId);
                return new SuperviseMissionResponse() { status = "1", message = "新增部门角色配置成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增部门角色配置失败：详情请查看日志！" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DelSMBasicDataDeptRole(string deptId, string roleId, string memberId)
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
                SMBasicDataBiz.DeleteSuperviseMissionDeptRoleEntity(deptId, roleId, memberId);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "删除部门角色配置成功，部门Id：" + deptId + "角色Id：" + roleId + "成员工号：" + memberId);
                return new SuperviseMissionResponse() { status = "1", message = "删除部门角色配置成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "删除部门角色配置失败。" };
            }
        }
        #endregion

        #region 部门默认领导

        /// <summary>
        /// 获取部门默认领导信息
        /// </summary>
        /// <param name="searchDeptIds">部门号</param>
        /// <param name="searchDeptName">部门名</param>
        /// <param name="leaderId">领导工号</param>
        /// <param name="searchLeaderDeptIds">领导所属部门号</param>
        /// <param name="searchLeaderDeptName">领导所属部门名部门名</param>
        /// <param name="limit">分页字段</param>
        /// <param name="offset">分页字段</param>
        /// <returns>部门默认领导数据信息</returns>

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSMBasicDeptDefaultLeader(string searchDeptIds, string leaderName, int limit, int offset)
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

                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDeptIds) && !searchDeptIds.Equals("0"))
                {
                    searchDeptIds = searchDeptIds.TrimEnd(',');
                    deptIds = GetDeptActivityListByIds(searchDeptIds);
                }

                SmBasicDataDeptDefaultLeaderEntity condition = new SmBasicDataDeptDefaultLeaderEntity
                {

                    LeaderUserName = leaderName.Trim(),


                };

                List<SmBasicDataDeptDefaultLeaderEntity> result = new List<SmBasicDataDeptDefaultLeaderEntity>();
                List<SmBasicDataDeptDefaultLeaderEntity> resultOrder = new List<SmBasicDataDeptDefaultLeaderEntity>();
                DataTable dt = SMBasicDataBiz.GetDeptDefaultLeadeDataTable(condition);
                foreach (DataRow dr in dt.Rows)
                {
                    result.Add(new SmBasicDataDeptDefaultLeaderEntity()
                    {
                        DeptId = dr["DEPT_ID"].ToString(),
                        DeptName = dr["DEPT_NAME"].ToString(),
                        LeaderUserId = dr["LEADER_USER_ID"].ToString(),
                        LeaderUserName = dr["LEADER_USER_NAME"].ToString(),
                        LeaderDeptId = dr["LEADER_DEPT_ID"].ToString(),
                        LeaderDeptName = dr["LEADER_DEPT_NAME"].ToString(),
                        OrderNumber = (int?)(dr["ORDER_NUMBER"]),
                        CreateTime = (DateTime?)(dr["CREATE_TIME"])

                    });
                }



                result.FindAll(n => GetDeptActivityList().Select(d => d.DeptId).Contains(n.DeptId)).ToList();
                resultOrder = result.OrderByDescending(n => n.CreateTime).ToList();
                if (deptIds != null && deptIds.Count > 0)
                {
                    resultOrder = result.FindAll(n => deptIds.Contains(n.DeptId)).OrderByDescending(n => n.CreateTime).ToList();
                }



                int total = resultOrder.Count;
                var rows = resultOrder.Skip(offset).Take(limit).ToList();

                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "督查部门默认领导列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "督查部门默认领导列表失败，详情请查看日志。"
                };
            }
        }
        /// <summary>
        /// 增加部门默认领导信息
        /// </summary>
        /// <param name="smBasicDataDeptDefaultLeaderEntity">部门默认领导参数实体</param>
        /// <returns>是否增加成功的信息</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSmBasicDeptDefaultLeader(SmBasicDataDeptDefaultLeaderEntity smBasicDataDeptDefaultLeaderEntity)
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
                #region Xss攻击校验
                var xxsHtml = smBasicDataDeptDefaultLeaderEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.DeptId) || string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.LeaderUserId))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门默认领导失败：元素不能为空。" };
                }

                var entity = SMBasicDataBiz.GetSmBasicDataDeptDefaultLeaderEntityList(smBasicDataDeptDefaultLeaderEntity);

                if (entity.Count > 0)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门默认领导失败：该用户信息已经存在，无需重复添加。" };
                }

                if (smBasicDataDeptDefaultLeaderEntity.OrderNumber == null)//序列号不填时默认为999
                {
                    smBasicDataDeptDefaultLeaderEntity.OrderNumber = 999;
                }
                //根据部门Id查到部门名字
                var department = GetDeptActivityList().Find(n => n.DeptId == smBasicDataDeptDefaultLeaderEntity.DeptId);
                if (department == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门默认领导失败：查无此部门。" };
                }
                //根据领导工号查到领导信息
                UserInfo member = SMBasicDataBiz.GetGenericUserInfoByID(smBasicDataDeptDefaultLeaderEntity.LeaderUserId);
                if (member == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门默认领导失败：查无此成员。" };
                }
                smBasicDataDeptDefaultLeaderEntity.DeptName = department.DeptName;
                smBasicDataDeptDefaultLeaderEntity.CreateTime = DateTime.Now;
                smBasicDataDeptDefaultLeaderEntity.LeaderUserName = member.Name;
                smBasicDataDeptDefaultLeaderEntity.LeaderDeptId = member.Dept_ID;
                smBasicDataDeptDefaultLeaderEntity.LeaderDeptName = member.Dept_Name;
                SMBasicDataBiz.InsertSuperviseMissionDataDeptDefaultLeaderEntity(smBasicDataDeptDefaultLeaderEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增部门默认领导成功，部门Id：" + smBasicDataDeptDefaultLeaderEntity.DeptId + "领导工号：" + smBasicDataDeptDefaultLeaderEntity.LeaderUserId + "领导所在部门号：" + smBasicDataDeptDefaultLeaderEntity.LeaderDeptId);
                return new SuperviseMissionResponse() { status = "1", message = "新增部门默认领导成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增部门默认领导失败：详情请查看日志！" };
            }
        }


        /// <summary>
        /// 删除部门默认领导信息
        /// </summary>
        /// <param name="deptId">部门号/param>
        /// <param name="leaderUserId,">领导工号</param>
        /// <param name="leaderDeptId">部门所属部门号</param>
        /// <returns>是否删除成功的信息</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DelSMBasicDataDeptDefaultLeader(string deptId, string leaderUserId, string leaderDeptId)
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
                SMBasicDataBiz.DeleteSuperviseMissionDeptDefaultLeaderEntity(deptId, leaderUserId, leaderDeptId);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "删除部门默认领导成功，部门Id：" + deptId + "领导工号：" + leaderUserId + "领导所在部门号：" + leaderDeptId);
                return new SuperviseMissionResponse() { status = "1", message = "删除部门默认领导成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "删除部门默认领导失败。" };
            }
        }
        /// <summary>
        /// 编辑文件类型信息
        /// </summary>
        /// <param name="smSystemTypeDefinitionEntity">新文件实体参数</param>
        /// <param name="oldSmSystemTypeDefinitionEntity">原文件实体参数</param>
        /// <returns></returns>

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse EditSMBasicDataDeptDefaultLeader(SmBasicDataDeptDefaultLeaderEntity smBasicDataDeptDefaultLeaderEntity, SmBasicDataDeptDefaultLeaderEntity oldSmBasicDataDeptDefaultLeaderEntity)
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
                #region Xss攻击校验
                var xxsHtml = smBasicDataDeptDefaultLeaderEntity.ToJson() + oldSmBasicDataDeptDefaultLeaderEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.DeptId) || string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.LeaderUserId))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑部门默认领导失败：元素不能为空。" };
                }

                var entity = SMBasicDataBiz.GetSmBasicDataDeptDefaultLeaderEntityList(smBasicDataDeptDefaultLeaderEntity);

                if (entity.Count > 0)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑部门默认领导失败：该用户信息已经存在。" };
                }

                //根据部门Id查到部门名字
                var department = GetDeptActivityList().Find(n => n.DeptId == smBasicDataDeptDefaultLeaderEntity.DeptId);
                if (department == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑部门默认领导失败：查无此部门。" };
                }
                //根据领导工号查到领导信息
                UserInfo member = SMBasicDataBiz.GetGenericUserInfoByID(smBasicDataDeptDefaultLeaderEntity.LeaderUserId);
                if (member == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑部门默认领导失败：查无此成员。" };
                }
                smBasicDataDeptDefaultLeaderEntity.DeptName = department.DeptName;
                smBasicDataDeptDefaultLeaderEntity.LeaderUserName = member.Name;
                smBasicDataDeptDefaultLeaderEntity.LeaderDeptId = member.Dept_ID;
                smBasicDataDeptDefaultLeaderEntity.LeaderDeptName = member.Dept_Name;
                if (smBasicDataDeptDefaultLeaderEntity.DeptId == oldSmBasicDataDeptDefaultLeaderEntity.DeptId &&
                   smBasicDataDeptDefaultLeaderEntity.DeptName == oldSmBasicDataDeptDefaultLeaderEntity.DeptName &&
                   smBasicDataDeptDefaultLeaderEntity.LeaderUserId == oldSmBasicDataDeptDefaultLeaderEntity.LeaderUserId &&
                    smBasicDataDeptDefaultLeaderEntity.LeaderUserName == oldSmBasicDataDeptDefaultLeaderEntity.LeaderUserName &&
                     smBasicDataDeptDefaultLeaderEntity.LeaderDeptId == oldSmBasicDataDeptDefaultLeaderEntity.LeaderDeptId &&
                      smBasicDataDeptDefaultLeaderEntity.LeaderDeptName == oldSmBasicDataDeptDefaultLeaderEntity.LeaderDeptName &&
                       smBasicDataDeptDefaultLeaderEntity.OrderNumber == oldSmBasicDataDeptDefaultLeaderEntity.OrderNumber)

                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑部门默认领导失败：您没有编辑更改任何信息。" };

                }
                //查询更改对象。
                var smSystemDeptDefaultLeader = SMBasicDataBiz.GetSmBasicDataDeptDefaultLeaderEntityList(new SmBasicDataDeptDefaultLeaderEntity()).Find(
                    n => n.DeptId == oldSmBasicDataDeptDefaultLeaderEntity.DeptId
                    && n.DeptName == oldSmBasicDataDeptDefaultLeaderEntity.DeptName
                             && n.LeaderUserId == oldSmBasicDataDeptDefaultLeaderEntity.LeaderUserId
                                      && n.LeaderUserName == oldSmBasicDataDeptDefaultLeaderEntity.LeaderUserName
                                               && n.LeaderDeptId == oldSmBasicDataDeptDefaultLeaderEntity.LeaderDeptId
                                                        && n.LeaderDeptName == oldSmBasicDataDeptDefaultLeaderEntity.LeaderDeptName
                                                                 && n.OrderNumber == oldSmBasicDataDeptDefaultLeaderEntity.OrderNumber
                );

                smSystemDeptDefaultLeader.DeptId = smBasicDataDeptDefaultLeaderEntity.DeptId;
                smSystemDeptDefaultLeader.DeptName = smBasicDataDeptDefaultLeaderEntity.DeptName;
                smSystemDeptDefaultLeader.LeaderUserId = smBasicDataDeptDefaultLeaderEntity.LeaderUserId;
                smSystemDeptDefaultLeader.LeaderUserName = smBasicDataDeptDefaultLeaderEntity.LeaderUserName;
                smSystemDeptDefaultLeader.LeaderDeptId = smBasicDataDeptDefaultLeaderEntity.LeaderDeptId;
                smSystemDeptDefaultLeader.LeaderDeptName = smBasicDataDeptDefaultLeaderEntity.LeaderDeptName;
                smSystemDeptDefaultLeader.OrderNumber = smBasicDataDeptDefaultLeaderEntity.OrderNumber;
                SMBasicDataBiz.UpdateSuperviseMissionDeptDefaultLeaderEntityDataTable(smSystemDeptDefaultLeader, oldSmBasicDataDeptDefaultLeaderEntity);

                return new SuperviseMissionResponse() { status = "1", data = smBasicDataDeptDefaultLeaderEntity.ToJson(), message = "部门默认领导编辑成功。" };
            }

            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "部门默认领导编辑失败：详情请查看日志！" };
            }
        }

        //非空验证方法，true为通过验证，false为不通过验证。
        private bool SMSystemDeptDefaultLeaderRequiredFieldValidator(SmBasicDataDeptDefaultLeaderEntity smBasicDataDeptDefaultLeaderEntity)
        {
            if (string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.DeptId)
                || string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.DeptName)
                || string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.LeaderUserId)
                 || string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.LeaderUserName)
                  || string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.LeaderDeptId)
                   || string.IsNullOrEmpty(smBasicDataDeptDefaultLeaderEntity.LeaderDeptName))
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        #endregion

        #region 督查部门管理员授权

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSMBasicDataDeptRolesByDept(string searchDeptIds, string memberId, int limit, int offset)
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

                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDeptIds) && !searchDeptIds.Equals("0"))
                {
                    searchDeptIds = searchDeptIds.TrimEnd(',');
                    deptIds = GetDeptActivityListByIds(searchDeptIds);
                }

                SmBasicDataDeptRoleDefinitionEntity condition = new SmBasicDataDeptRoleDefinitionEntity
                {

                    MemberId = memberId.Trim()
                };

                var smBasicDataDeptRoleList = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(condition).
                    FindAll(n => n.RoleId == "DEPTADMIN" && GetDeptActivityList().Select(d => d.DeptId).
                    Contains(n.DeptId)).OrderByDescending(n => n.CreateTime).ToList();

                if (deptIds != null && deptIds.Count > 0)
                {
                    smBasicDataDeptRoleList = smBasicDataDeptRoleList.FindAll(n => deptIds.Contains(n.DeptId)).OrderByDescending(n => n.CreateTime).ToList();
                }

                int total = smBasicDataDeptRoleList.Count;
                var rows = smBasicDataDeptRoleList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取督查部门管理员授权列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取督查部门管理员授权列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSmBasicDataDeptRoleByDept(SmBasicDataDeptRoleDefinitionEntity smBasicDataDeptRoleDefinitionEntity)
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
                #region Xss攻击校验
                var xxsHtml = smBasicDataDeptRoleDefinitionEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(smBasicDataDeptRoleDefinitionEntity.DeptId)
                    || string.IsNullOrEmpty(smBasicDataDeptRoleDefinitionEntity.MemberId))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门管理授权失败：元素不能为空。" };
                }

                //根据部门Id查到部门名字
                var department = GetDeptActivityList().Find(n => n.DeptId == smBasicDataDeptRoleDefinitionEntity.DeptId);
                if (department == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门管理授权失败：查无此部门。" };
                }

                UserInfo member = SMBasicDataBiz.GetGenericUserInfoByID(smBasicDataDeptRoleDefinitionEntity.MemberId);
                if (member == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门管理授权失败：查无此成员。" };
                }

                smBasicDataDeptRoleDefinitionEntity.RoleId = "DEPTADMIN";
                if (SMBasicDataBiz.ExistSmBasicDataDeptRoleDefinitionEntity(smBasicDataDeptRoleDefinitionEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增部门管理授权失败：角色配置已经存在，请勿重复添加。" };
                }

                smBasicDataDeptRoleDefinitionEntity.DeptName = department.DeptName;
                smBasicDataDeptRoleDefinitionEntity.RoleName = "部门管理员";
                smBasicDataDeptRoleDefinitionEntity.CreateTime = DateTime.Now;
                smBasicDataDeptRoleDefinitionEntity.MemberName = member.Name;
                SMBasicDataBiz.InsertSuperviseMissionDeptRoleEntity(smBasicDataDeptRoleDefinitionEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增部门管理授权成功，部门Id：" + smBasicDataDeptRoleDefinitionEntity.DeptId + "角色Id：" + smBasicDataDeptRoleDefinitionEntity.RoleId + "成员工号：" + smBasicDataDeptRoleDefinitionEntity.MemberId);
                return new SuperviseMissionResponse() { status = "1", message = "新增部门管理授权成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增部门管理授权失败：详情请查看日志！" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DelSMBasicDataDeptRoleByDept(string deptId, string memberId)
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
                SMBasicDataBiz.DeleteSuperviseMissionDeptRoleEntity(deptId, "DEPTADMIN", memberId);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "删除部门管理员授权成功，部门Id：" + deptId + "角色Id：" + "DEPTADMIN" + "成员工号：" + memberId);
                return new SuperviseMissionResponse() { status = "1", message = "删除部门管理员授权成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "删除部门管理员授权失败。" };
            }
        }
        #endregion

        #region 督查运维管理员授权

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSMBasicDataDeptRolesByMaintainer(string searchDeptIds, string searchDeptName, string memberId, int limit, int offset)
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

                if (!IsSuperManager)
                {
                    throw new Exception("督查运维管理员授权，必须使用超级管理员登陆！");
                }

                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDeptIds) && !searchDeptIds.Equals("0"))
                {
                    searchDeptIds = searchDeptIds.TrimEnd(',');
                    deptIds = searchDeptIds.Split(',').ToList();
                }

                SmBasicDataDeptRoleDefinitionEntity condition = new SmBasicDataDeptRoleDefinitionEntity
                {
                    DeptName = searchDeptName.Trim(),
                    MemberId = memberId.Trim()
                };

                var smBasicDataDeptRoleList = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(condition)
                    .FindAll(n => n.RoleId == "MAINTAINER").OrderByDescending(n => n.CreateTime).ToList();
                if (deptIds != null && deptIds.Count > 0)
                {
                    smBasicDataDeptRoleList = smBasicDataDeptRoleList.FindAll(n => deptIds.Contains(n.DeptId)).OrderByDescending(n => n.CreateTime).ToList();
                }
                int total = smBasicDataDeptRoleList.Count;
                var rows = smBasicDataDeptRoleList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取督查运维管理员授权列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取督查运维管理员授权列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSmBasicDataDeptRoleByMaintainer(SmBasicDataDeptRoleDefinitionEntity smBasicDataDeptRoleDefinitionEntity)
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
                #region Xss攻击校验
                var xxsHtml = smBasicDataDeptRoleDefinitionEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                if (!IsSuperManager)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增运维管理员授权失败：请使用超级管理员登陆。" };
                }

                //非空验证。
                if (string.IsNullOrEmpty(smBasicDataDeptRoleDefinitionEntity.DeptId)
                    || string.IsNullOrEmpty(smBasicDataDeptRoleDefinitionEntity.MemberId))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增运维管理员授权失败：元素不能为空。" };
                }

                //根据部门Id查到部门名字
                var department = this.GetDeptList().Find(n => n.DeptId == smBasicDataDeptRoleDefinitionEntity.DeptId);
                if (department == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增运维管理员授权失败：查无此部门。" };
                }

                UserInfo member = SMBasicDataBiz.GetGenericUserInfoByID(smBasicDataDeptRoleDefinitionEntity.MemberId);
                if (member == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增运维管理员授权失败：查无此成员。" };
                }

                smBasicDataDeptRoleDefinitionEntity.RoleId = "MAINTAINER";
                if (SMBasicDataBiz.ExistSmBasicDataDeptRoleDefinitionEntity(smBasicDataDeptRoleDefinitionEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增运维管理员授权失败：角色配置已经存在，请勿重复添加。" };
                }

                smBasicDataDeptRoleDefinitionEntity.DeptName = department.DeptName;
                smBasicDataDeptRoleDefinitionEntity.RoleName = "运维管理员";
                smBasicDataDeptRoleDefinitionEntity.CreateTime = DateTime.Now;
                smBasicDataDeptRoleDefinitionEntity.MemberName = member.Name;
                SMBasicDataBiz.InsertSuperviseMissionDeptRoleEntity(smBasicDataDeptRoleDefinitionEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增运维管理员授权成功，部门Id：" + smBasicDataDeptRoleDefinitionEntity.DeptId + "角色Id：" + smBasicDataDeptRoleDefinitionEntity.RoleId + "成员工号：" + smBasicDataDeptRoleDefinitionEntity.MemberId);
                return new SuperviseMissionResponse() { status = "1", message = "新增运维管理员授权成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增运维管理员授权失败：详情请查看日志！" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DelSMBasicDataDeptRoleByMaintainer(string deptId, string memberId)
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
                if (!IsSuperManager)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "删除运维管理员授权失败：请使用超级管理员登陆。" };
                }

                SMBasicDataBiz.DeleteSuperviseMissionDeptRoleEntity(deptId, "MAINTAINER", memberId);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "删除运维管理员授权成功，部门Id：" + deptId + "角色Id：" + "DEPTADMIN" + "成员工号：" + memberId);
                return new SuperviseMissionResponse() { status = "1", message = "删除运维管理员授权成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "删除运维管理员授权失败。" };
            }
        }
        #endregion

        #region 督查角色定义

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSuperviseMissionSystemRoleEntityList(string searchRoleId, string searchRoleName, int limit, int offset)
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

                SmSystemRoleDefinitionEntity condition = new SmSystemRoleDefinitionEntity
                {
                    RoleId = searchRoleId.Trim(),
                    RoleName = searchRoleName.Trim()
                };

                var smSystemRoleEntityList = SMBasicDataBiz.GetSuperviseMissionSystemRoleEntityList(condition).OrderByDescending(n => n.CreateTime).ToList();
                int total = smSystemRoleEntityList.Count;
                var rows = smSystemRoleEntityList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取角色定义列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取角色定义列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse InversionSMSystemRole(string roleId)
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
                #region Xss攻击校验
                var xxsHtml = roleId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                var smSystemRoleEntity = SMBasicDataBiz.GetSuperviseMissionSystemRoleEntity(roleId);
                if (smSystemRoleEntity == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "置否角色定义失败：查无此角色。" };
                }

                if (smSystemRoleEntity.ActivityFlag == 0)
                {
                    smSystemRoleEntity.ActivityFlag = 1;
                }
                else
                {
                    smSystemRoleEntity.ActivityFlag = 0;
                }

                SMBasicDataBiz.UpdateSuperviseMissionSystemRoleEntity(smSystemRoleEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "置否角色定义成功，角色Id：" + smSystemRoleEntity.RoleId);
                return new SuperviseMissionResponse() { status = "1", message = "置否角色定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "置否角色定义失败。" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSMSystemRole(SmSystemRoleDefinitionEntity smSystemRoleDefinitionEntity)
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
                #region Xss攻击校验
                var xxsHtml = smSystemRoleDefinitionEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                if (string.IsNullOrEmpty(smSystemRoleDefinitionEntity.RoleId) ||
                    string.IsNullOrEmpty(smSystemRoleDefinitionEntity.RoleName) ||
                    smSystemRoleDefinitionEntity.ActivityFlag > 1 || smSystemRoleDefinitionEntity.ActivityFlag < 0 ||
                    smSystemRoleDefinitionEntity.RoleType <= 0)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增角色定义失败：元素不能为空。" };
                }

                var smSystemRoleEntity = SMBasicDataBiz.GetSuperviseMissionSystemRoleEntity(smSystemRoleDefinitionEntity.RoleId);
                if (smSystemRoleEntity != null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增角色定义失败：角色已存在，请勿重复添加。" };
                }

                smSystemRoleDefinitionEntity.CreateTime = DateTime.Now;
                SMBasicDataBiz.InsertSuperviseMissionSystemRoleEntity(smSystemRoleDefinitionEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增角色定义成功，角色Id：" + smSystemRoleDefinitionEntity.RoleId);
                return new SuperviseMissionResponse() { status = "1", message = "新增角色定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增角色定义失败。" };
            }
        }

        #endregion

        #region 督查步骤定义

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSuperviseMissionSystemStepEntityList(string searchStepId, string searchStepName, int limit, int offset)
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
                SmSystemStepDefinitionEntity condition = new SmSystemStepDefinitionEntity
                {
                    StepId = searchStepId.Trim(),
                    StepName = searchStepName.Trim()
                };

                var smSystemStepEntityList = SMBasicDataBiz.GetSuperviseMissionSystemStepEntityList(condition).OrderByDescending(n => n.CreateTime).ToList();
                int total = smSystemStepEntityList.Count;
                var rows = smSystemStepEntityList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取步骤定义列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取步骤定义列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse InversionSMSystemStep(string stepId)
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

                var smSystemStepEntity = SMBasicDataBiz.GetSuperviseMissionSystemStepEntity(stepId);
                if (smSystemStepEntity == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "置否步骤定义失败：查无此步骤。" };
                }

                if (smSystemStepEntity.ActivityFlag == 0)
                {
                    smSystemStepEntity.ActivityFlag = 1;
                }
                else
                {
                    smSystemStepEntity.ActivityFlag = 0;
                }

                SMBasicDataBiz.UpdateSuperviseMissionSystemStepEntity(smSystemStepEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "置否步骤定义成功，步骤Id：" + smSystemStepEntity.StepId);
                return new SuperviseMissionResponse() { status = "1", message = "置否步骤定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "置否步骤定义失败。" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSMSystemStep(SmSystemStepDefinitionEntity smSystemStepDefinitionEntity)
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
                #region Xss攻击校验
                var xxsHtml = smSystemStepDefinitionEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                if (string.IsNullOrEmpty(smSystemStepDefinitionEntity.StepId) ||
                    string.IsNullOrEmpty(smSystemStepDefinitionEntity.StepName) ||
                    smSystemStepDefinitionEntity.ActivityFlag > 1 || smSystemStepDefinitionEntity.ActivityFlag < 0 ||
                    string.IsNullOrEmpty(smSystemStepDefinitionEntity.StepType))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增步骤定义失败：元素不能为空。" };
                }

                var smSystemStepEntity = SMBasicDataBiz.GetSuperviseMissionSystemStepEntity(smSystemStepDefinitionEntity.StepId);
                if (smSystemStepEntity != null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增步骤定义失败：步骤已存在，请勿重复添加。" };
                }

                smSystemStepDefinitionEntity.CreateTime = DateTime.Now;
                SMBasicDataBiz.InsertSuperviseMissionSystemStepEntity(smSystemStepDefinitionEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增步骤定义成功，步骤Id：" + smSystemStepDefinitionEntity.StepId);
                return new SuperviseMissionResponse() { status = "1", message = "新增步骤定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增步骤定义失败。" };
            }
        }

        #endregion

        #region 督查步骤角色定义

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetRoleListByStepRoleManage()
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

                List<SmSystemRoleDefinitionEntity> result = SMBasicDataBiz.GetSuperviseMissionSystemRoleEntityList(new SmSystemRoleDefinitionEntity()).FindAll(n => n.ActivityFlag == 1
                                                                                                                                                                    && !n.RoleName.Equals("超级管理员"));
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(result),
                    message = "获取角色列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取角色列表失败。"
                };
                //throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetStepListByStepRoleManage()
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
                List<SmSystemStepDefinitionEntity> result = SMBasicDataBiz.GetSuperviseMissionSystemStepEntityList(new SmSystemStepDefinitionEntity()).FindAll(n => n.ActivityFlag == 1);
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(result),
                    message = "获取步骤列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取步骤列表失败。"
                };
                //throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSuperviseMissionSystemStepRoleEntityList(string stepId, string roleId, int limit, int offset)
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
                SmSystemStepRoleDefinitionEntity condition = new SmSystemStepRoleDefinitionEntity
                {
                    StepId = stepId.Trim(),
                    RoleId = roleId.Trim()
                };

                var smBasicDataDeptRoleList = SMBasicDataBiz.GetSuperviseMissionSystemStepRoleEntityList(condition).OrderByDescending(n => n.CreateTime).ToList();
                int total = smBasicDataDeptRoleList.Count;
                var rows = smBasicDataDeptRoleList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取步骤角色定义列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取步骤角色定义列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSMSystemStepRole(SmSystemStepRoleDefinitionEntity smSystemStepRoleDefinitionEntity)
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
                #region Xss攻击校验
                var xxsHtml = smSystemStepRoleDefinitionEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(smSystemStepRoleDefinitionEntity.RoleId)
                    || string.IsNullOrEmpty(smSystemStepRoleDefinitionEntity.StepId))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增步骤角色定义失败：元素不能为空。" };
                }

                var role = SMBasicDataBiz.GetSuperviseMissionSystemRoleEntityList(new SmSystemRoleDefinitionEntity()).FindAll(n => n.ActivityFlag == 1
                                                                                                                                   && !n.RoleName.Equals("系统管理员")
                                                                                                                                   && !n.RoleName.Equals("运维管理员")
                                                                                                                                   && !n.RoleName.Equals("超级管理员"))
                                                                                                                                    .Find(r => r.RoleId == smSystemStepRoleDefinitionEntity.RoleId);
                if (role == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增步骤角色定义失败：查无此角色。" };
                }

                var step = SMBasicDataBiz.GetSuperviseMissionSystemStepEntityList(new SmSystemStepDefinitionEntity()).FindAll(n => n.ActivityFlag == 1).Find(r => r.StepId == smSystemStepRoleDefinitionEntity.StepId);
                if (step == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增步骤角色定义失败：查无此步骤。" };
                }

                smSystemStepRoleDefinitionEntity.RoleName = role.RoleName;
                smSystemStepRoleDefinitionEntity.StepName = step.StepName;
                smSystemStepRoleDefinitionEntity.CreateTime = DateTime.Now;
                if (SMBasicDataBiz.ExistSuperviseMissionSystemStepRoleEntity(smSystemStepRoleDefinitionEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增步骤角色定义失败：步骤角色定义已经存在，请勿重复添加。" };
                }

                SMBasicDataBiz.InsertSuperviseMissionSystemStepRoleEntity(smSystemStepRoleDefinitionEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增步骤角色定义成功，步骤Id：" + smSystemStepRoleDefinitionEntity.StepId + "角色Id：" + smSystemStepRoleDefinitionEntity.RoleId);
                return new SuperviseMissionResponse() { status = "1", message = "新增步骤角色定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增步骤角色定义失败：详情请查看日志！" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DelSMSystemStepRole(string stepId, string roleId)
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
                var systemStepRoleEntity = SMBasicDataBiz.GetSuperviseMissionSystemStepRoleEntity(stepId, roleId);
                if (systemStepRoleEntity == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "删除步骤角色定义失败：查无此步骤角色定义。" };
                }
                SMBasicDataBiz.DeleteSuperviseMissionSystemStepRoleEntity(systemStepRoleEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "删除步骤角色定义错过，角色Id：" + roleId + "步骤Id：" + stepId);
                return new SuperviseMissionResponse() { status = "1", message = "删除步骤角色定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "删除步骤角色定义失败。" };
            }
        }
        #endregion

        #region 督查自由流程定义

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSmType()
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
                var superviseMissionTypeDefinitionEntityList = SMBasicDataBiz.GetSuperviseMissionTypeDefinitionEntityList(
                    new SmSystemTypeDefinitionEntity());

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(superviseMissionTypeDefinitionEntityList),
                    message = "获取所属类型列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取所属类型列表失败。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSuperviseMissionSystemWorkFlowFreeEntityList(string currentStepId, string smType, string nextStepId, int limit, int offset)
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
                SmSystemWorkFlowFreeDefinitionEntity condition = new SmSystemWorkFlowFreeDefinitionEntity
                {
                    CurrentStepId = currentStepId,
                    NextStepId = nextStepId,
                    SmType = smType
                };

                var superviseMissionSystemWorkFlowFreeEntityList = SMBasicDataBiz.GetSuperviseMissionSystemWorkFlowFreeEntityList(condition);

                SmSystemTypeDefinitionEntity conditionType = new SmSystemTypeDefinitionEntity { };
                var SmSystemTypeDefintionList = SMBasicDataBiz.GetSuperviseMissionTypeDefinitionEntityList(conditionType).ToList();
                int total = superviseMissionSystemWorkFlowFreeEntityList.Count;

                for (int i = 0; i < total; i++)
                {
                    for (int j = 0; j < SmSystemTypeDefintionList.Count; j++)
                    {
                        if (SmSystemTypeDefintionList[j].TypeId == superviseMissionSystemWorkFlowFreeEntityList[i].SmType)
                        {
                            superviseMissionSystemWorkFlowFreeEntityList[i].SmType = SmSystemTypeDefintionList[j].TypeName;
                        }
                    }
                }

                var rows = superviseMissionSystemWorkFlowFreeEntityList.OrderByDescending(n => n.CreateTime).Skip(offset).Take(limit).ToList();

                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取自由流程定义列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取自由流程定义列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSMSystemWorkFlowFree(SmSystemWorkFlowFreeDefinitionEntity smSystemWorkFlowFreeEntity)
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
                #region Xss攻击校验
                var xxsHtml = smSystemWorkFlowFreeEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                if (string.IsNullOrEmpty(smSystemWorkFlowFreeEntity.CurrentStepId) ||
                    string.IsNullOrEmpty(smSystemWorkFlowFreeEntity.NextStepId) ||
                    smSystemWorkFlowFreeEntity.ActivityFlag > 1 || smSystemWorkFlowFreeEntity.ActivityFlag < 0)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增自由流程定义失败：元素不能为空。" };
                }

                if (smSystemWorkFlowFreeEntity.CurrentStepId.Equals(smSystemWorkFlowFreeEntity.NextStepId))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增自由流程定义失败：当前步骤和下一步骤不能相同，请重新选择。" };
                }

                var smCurrentSystemStepEntity = SMBasicDataBiz.GetSuperviseMissionSystemStepEntity(smSystemWorkFlowFreeEntity.CurrentStepId);
                var smNextSystemStepEntity = SMBasicDataBiz.GetSuperviseMissionSystemStepEntity(smSystemWorkFlowFreeEntity.NextStepId);
                if (smCurrentSystemStepEntity == null || smNextSystemStepEntity == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增自由流程定义失败：查无此步骤。" };
                }

                if (SMBasicDataBiz.ExistSmSystemWorkFlowFreeDefinitionEntity(smSystemWorkFlowFreeEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增自由流程定义失败：当前自由流程已存在。" };
                }

                smSystemWorkFlowFreeEntity.CurrentStepName = smCurrentSystemStepEntity.StepName;
                smSystemWorkFlowFreeEntity.NextStepName = smNextSystemStepEntity.StepName;
                smSystemWorkFlowFreeEntity.CreateTime = DateTime.Now;
                SMBasicDataBiz.InsertSuperviseMissionSystemWorkFlowFreeEntity(smSystemWorkFlowFreeEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增自由流程定义成功，当前步骤Id：" + smSystemWorkFlowFreeEntity.CurrentStepId + "，下一步骤Id：" + smSystemWorkFlowFreeEntity.NextStepId);
                return new SuperviseMissionResponse() { status = "1", message = "新增自由流程定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增自由流程定义失败。" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse InversionSMSystemWorkFlowFree(string currentStepId, string nextStepId, string smType)
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
                #region Xss攻击校验
                var xxsHtml = currentStepId + nextStepId + smType;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                var smSystemWorkFlowFreeDefinitionEntity =
                    SMBasicDataBiz.GetSmSystemWorkFlowFreeDefinitionEntity(currentStepId, nextStepId, smType);
                if (smSystemWorkFlowFreeDefinitionEntity == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "置否自由流程定义失败：查无此自由流程。" };
                }

                if (smSystemWorkFlowFreeDefinitionEntity.ActivityFlag == 0)
                {
                    smSystemWorkFlowFreeDefinitionEntity.ActivityFlag = 1;
                }
                else
                {
                    smSystemWorkFlowFreeDefinitionEntity.ActivityFlag = 0;
                }

                SMBasicDataBiz.UpdateSuperviseMissionSystemWorkFlowFreeEntity(smSystemWorkFlowFreeDefinitionEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "置否自由流程定义成功，当前步骤Id：" + currentStepId + "，下一步骤Id：" + nextStepId);
                return new SuperviseMissionResponse() { status = "1", message = "置否自由流程定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "置否自由流程定义失败。" };
            }
        }

        #endregion

        #region 督查固定流程定义

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSuperviseMissionSystemWorkFlowStaticEntityList(string searchDeptIds, string searchDeptName, string workflowId, string smType, int limit, int offset)
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
                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDeptIds) && !searchDeptIds.Equals("0"))
                {
                    searchDeptIds = searchDeptIds.TrimEnd(',');
                    deptIds = searchDeptIds.Split(',').ToList();
                }

                SmWorkFlowStaticEntity condition = new SmWorkFlowStaticEntity
                {
                    DeptName = searchDeptName.Trim(),
                    WorkFlowId = workflowId.Trim(),
                    SmType = smType.Trim()
                };

                var smSystemStepEntityList = SMBasicDataBiz.GetSuperviseMissionSystemWorkFlowStaticEntityList(condition);
                if (deptIds != null && deptIds.Count > 0)
                {
                    smSystemStepEntityList = smSystemStepEntityList.FindAll(n => deptIds.Contains(n.DeptId));
                }

                int total = smSystemStepEntityList.Count;
                var rows = smSystemStepEntityList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取步骤定义列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取步骤定义列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSmWorkFlowStatic(SmWorkFlowStaticEntity smWorkFlowStaticEntity)
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
                #region Xss攻击校验
                var xxsHtml = smWorkFlowStaticEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(smWorkFlowStaticEntity.DeptId)
                    || string.IsNullOrEmpty(smWorkFlowStaticEntity.SmType)
                    || string.IsNullOrEmpty(smWorkFlowStaticEntity.WorkFlowId)
                    || string.IsNullOrEmpty(smWorkFlowStaticEntity.WorkFlowName)
                    || smWorkFlowStaticEntity.ActivityFlag == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增固定流程定义失败：元素不能为空。" };
                }

                //根据部门Id查到部门名字
                var department = this.GetDeptList().Find(n => n.DeptId == smWorkFlowStaticEntity.DeptId);
                if (department == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增固定流程定义失败：查无此部门。" };
                }

                if (SMBasicDataBiz.ExistSmWorkFlowStaticEntity(smWorkFlowStaticEntity))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增固定流程定义失败：固定流程定义已经存在，请勿重复添加。" };
                }

                smWorkFlowStaticEntity.DeptName = department.DeptName;
                SMBasicDataBiz.InsertSuperviseMissionSystemWorkFlowStaticEntity(smWorkFlowStaticEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增固定流程定义成功，部门Id：" + smWorkFlowStaticEntity.DeptId + "流程Id：" + smWorkFlowStaticEntity.WorkFlowId + "类型：" + smWorkFlowStaticEntity.SmType);
                return new SuperviseMissionResponse() { status = "1", message = "新增固定流程定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增固定流程定义失败：详情请查看日志！" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse EditSmWorkFlowStatic(SmWorkFlowStaticEntity smWorkFlowStaticEntity, SmWorkFlowStaticEntity oldSmSystemWorkFlowStaticTableObj)
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
                #region Xss攻击校验
                var xxsHtml = smWorkFlowStaticEntity.ToJson() + oldSmSystemWorkFlowStaticTableObj.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                if (string.IsNullOrEmpty(smWorkFlowStaticEntity.WorkFlowName)
                    || string.IsNullOrEmpty(smWorkFlowStaticEntity.DeptId)
                    || string.IsNullOrEmpty(smWorkFlowStaticEntity.SmType)
                    || string.IsNullOrEmpty(smWorkFlowStaticEntity.WorkFlowId))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑固定流程定义失败：元素不能为空。" };
                }


                var entity = SMBasicDataBiz.GetSmWorkFlowStaticEntity(oldSmSystemWorkFlowStaticTableObj.DeptId,
                     oldSmSystemWorkFlowStaticTableObj.SmType, oldSmSystemWorkFlowStaticTableObj.WorkFlowId);
                if (entity == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑固定流程定义失败：固定流程定义不存在。" };
                }

                //entity.WorkFlowName = smWorkFlowStaticEntity.WorkFlowName;
                SMBasicDataBiz.UpdateSuperviseMissionSystemWorkFlowStaticEntityDataTable(smWorkFlowStaticEntity, oldSmSystemWorkFlowStaticTableObj);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "编辑固定流程定义成功，部门Id：" + smWorkFlowStaticEntity.DeptId + "流程Id：" + smWorkFlowStaticEntity.WorkFlowId + "类型：" + smWorkFlowStaticEntity.SmType);
                return new SuperviseMissionResponse() { status = "1", message = "编辑固定流程定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "编辑固定流程定义失败：详情请查看日志！" };
            }
        }




        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse InversionSmWorkFlowStatic(string deptId, string smType, string workFlowId)
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
                #region Xss攻击校验
                var xxsHtml = deptId + smType + workFlowId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                var entity = SMBasicDataBiz.GetSmWorkFlowStaticEntity(deptId, smType, workFlowId);
                if (entity == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "置否固定流程定义失败：固定流程定义不存在。" };
                }

                if (entity.ActivityFlag == 0)
                {
                    entity.ActivityFlag = 1;
                }
                else
                {
                    entity.ActivityFlag = 0;
                }

                SMBasicDataBiz.UpdateSuperviseMissionSystemWorkFlowStaticEntity(entity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "置否固定流程定义成功，部门Id：" + deptId + "流程Id：" + workFlowId + "类型：" + smType);
                return new SuperviseMissionResponse() { status = "1", message = "置否固定流程定义成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "置否固定流程定义失败：详情请查看日志！" };
            }
        }

        #endregion

        #region 督查固定流程配置

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetWorkFlowStaticList()
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
                var result = SMBasicDataBiz.GetSuperviseMissionSystemWorkFlowStaticEntityList(new SmWorkFlowStaticEntity()).FindAll(n => n.ActivityFlag == 1);
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(result),
                    message = "获取流程列表成功。"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取流程列表失败。"
                };
                //throw;
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSuperviseMissionSystemWorkFlowStaticDetailEntityList(string stepId, string workflowId, int limit, int offset)
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
                SmWorkFlowStaticDetailEntity condition = new SmWorkFlowStaticDetailEntity
                {
                    StepId = stepId,
                    WorkFlowId = workflowId
                };

                var smSystemWorkFlowStaticDetailEntityList = SMBasicDataBiz.GetSuperviseMissionSystemWorkFlowStaticDetailEntityList(condition).OrderByDescending(n => n.FlowId).ToList();
                int total = smSystemWorkFlowStaticDetailEntityList.Count;
                var rows = smSystemWorkFlowStaticDetailEntityList.Skip(offset).Take(limit).ToList();
                var resultJson = JsonHelper.ToJson(
                    new
                    {
                        total,
                        rows
                    });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = resultJson,
                    message = "获取固定流程配置列表成功。"
                };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取固定流程配置列表失败，详情请查看日志。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AddSmWorkFlowStaticDetail(SmWorkFlowStaticDetailEntity smWorkFlowStaticDetailEntity)
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
                #region Xss攻击校验
                var xxsHtml = smWorkFlowStaticDetailEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(smWorkFlowStaticDetailEntity.WorkFlowId)
                    || string.IsNullOrEmpty(smWorkFlowStaticDetailEntity.StepId))
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增固定流程配置失败：元素不能为空。" };
                }

                var step = SMBasicDataBiz.GetSuperviseMissionSystemStepEntityList(new SmSystemStepDefinitionEntity()).FindAll(n => n.ActivityFlag == 1).Find(r => r.StepId == smWorkFlowStaticDetailEntity.StepId);
                if (step == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增固定流程配置失败：查无此步骤。" };
                }

                var workflow = SMBasicDataBiz.GetSuperviseMissionSystemWorkFlowStaticEntityList(new SmWorkFlowStaticEntity()).FindAll(n => n.ActivityFlag == 1);
                if (workflow == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "新增固定流程配置失败：查无此固定流程。" };
                }

                smWorkFlowStaticDetailEntity.FlowId =
                    SMBasicDataBiz.GetMaxSuperviseMissionSystemWorkFlowStaticDetailEntityFlowId() + 1;
                smWorkFlowStaticDetailEntity.StepName = step.StepName;
                smWorkFlowStaticDetailEntity.FatherFlowId =
                    SMBasicDataBiz.GetMaxSuperviseMissionSystemWorkFlowStaticDetailEntityFatherFlowId(smWorkFlowStaticDetailEntity.WorkFlowId);
                SMBasicDataBiz.InsertSuperviseMissionSystemWorkFlowStaticDetailEntity(smWorkFlowStaticDetailEntity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "新增固定流程配置成功，流程配置ID：" + smWorkFlowStaticDetailEntity.FlowId);
                return new SuperviseMissionResponse() { status = "1", message = "新增固定流程配置成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "新增固定流程配置失败：详情请查看日志！" };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse EditSmWorkFlowStaticDetail(SmWorkFlowStaticDetailEntity smWorkFlowStaticDetailEntity)
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
                #region Xss攻击校验
                var xxsHtml = smWorkFlowStaticDetailEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                var step = SMBasicDataBiz.GetSuperviseMissionSystemStepEntityList(new SmSystemStepDefinitionEntity()).FindAll(n => n.ActivityFlag == 1).Find(r => r.StepId == smWorkFlowStaticDetailEntity.StepId);
                if (step == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑固定流程配置失败：查无此步骤。" };
                }

                var entity = SMBasicDataBiz.GetSmWorkFlowStaticDetailEntity(smWorkFlowStaticDetailEntity.FlowId);
                if (entity == null)
                {
                    return new SuperviseMissionResponse() { status = "0", message = "编辑固定流程配置失败：固定流程配置不存在。" };
                }

                entity.StepId = step.StepId;
                entity.StepName = step.StepName;
                SMBasicDataBiz.UpdateSuperviseMissionSystemWorkFlowStaticDetailEntity(entity);
                AddBasicDataSuccessedLog(CurrentUserInfo.Name + "(" + CurrentUserInfo.Employee_ID + ")" + "编辑固定流程配置成功，流程配置ID：" + smWorkFlowStaticDetailEntity.FlowId);
                return new SuperviseMissionResponse() { status = "1", message = "编辑固定流程配置成功。" };
            }
            catch (Exception ex)
            {
                AddBasicDataErrorLog(ex.StackTrace);
                return new SuperviseMissionResponse() { status = "0", message = "编辑固定流程配置失败：详情请查看日志！" };
            }
        }

        #endregion

        #region 获取待办数量
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetMyBoxCount()
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
                DataTable dt = SuperviseMissionBodyBiz.GetMyBoxCount(CurrentUserInfo.Employee_ID);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(dt),
                    message = "查询成功"
                };

            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "查询督查任务出错。" + ex.Message
                };
            }
        }
        #endregion

        #region 督查任务
        /// <summary>
        /// 分页查询数据列表
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="deptId"></param>
        /// <param name="keyWord"></param>
        /// <param name="beginDate"></param>
        /// <param name="endDate"></param>
        /// <param name="missionStatus"></param>
        /// <param name="smId"></param>
        /// <param name="smType"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SmMainPageListResponseEntity GetIndexSMListByPage(string pageIndex, string pageSize, string deptId, string keyWord, string beginDate, string endDate, string missionStatus, string smId, string smType)
        {
            #region  登录校验
            if (!CheckLogin())
            {
                //没有登录不能进行操作
                return new SmMainPageListResponseEntity() { data = NoLoginResponse.data, message = NoLoginResponse.message, status = NoLoginResponse.status };
            }
            #endregion
            #region 越权校验
            if (!CheckFormRequest())
            {
                //url存在被篡改的风险
                return new SmMainPageListResponseEntity() { data = UrlCheckResponse.data, message = UrlCheckResponse.message, status = UrlCheckResponse.status };
            }
            #endregion

            DataTable dt = new DataTable();
            try
            {
                uint pageindex = 1;
                uint pagesize = 10;
                DateTime? beginTime = null;
                DateTime? endTime = null;
                List<string> missionStatusList = new List<string>();
                if (string.IsNullOrEmpty(smType))
                {
                    return new SmMainPageListResponseEntity()
                    {
                        status = "0",
                        data = "",
                        message = "必须查询指定类型的督查列表"
                    };
                }
                try
                {
                    if (!string.IsNullOrEmpty(pageIndex))
                    {
                        pageindex = uint.Parse(pageIndex);
                    }
                    if (!string.IsNullOrEmpty(pageSize))
                    {
                        pagesize = uint.Parse(pageSize);
                    }
                    if (!string.IsNullOrEmpty(beginDate))
                    {
                        beginTime = DateTime.Parse(beginDate).Date;
                    }
                    if (!string.IsNullOrEmpty(endDate))
                    {
                        endTime = DateTime.Parse(endDate).Date.AddDays(1).AddSeconds(-1);
                    }

                    //任务状态，多选
                    if (!string.IsNullOrEmpty(missionStatus))
                    {
                        string[] arr = missionStatus.Trim().Trim('|').Split('|');
                        foreach (var item in arr)
                        {
                            if (!string.IsNullOrEmpty(item))
                            {
                                missionStatusList.Add(item);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    return new SmMainPageListResponseEntity()
                    {
                        status = "0",
                        data = "",
                        message = ex.Message
                    };
                }
                dt = SuperviseMissionBodyBiz.GetIndexSMListByPage(pageindex, pagesize, deptId, keyWord, beginTime, endTime, missionStatusList, smId, smType, IsSuperManager, CurrentUserInfo.Employee_ID);
                int totalCount = SuperviseMissionBodyBiz.GetIndexSMListAllCount(deptId, keyWord, beginTime, endTime, missionStatusList, smId, smType, IsSuperManager, CurrentUserInfo.Employee_ID);

                List<SmMainEntity> smList = new List<SmMainEntity>();
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow item in dt.Rows)
                    {
                        SmMainEntity model = new SmMainEntity();
                        model.Index = item["RowIndex"] is DBNull ? -1 : int.Parse(item["RowIndex"].ToString());
                        model.SmId = item["SM_ID"] is DBNull ? "" : item["SM_ID"].ToString();
                        model.Title = item["TITLE"] is DBNull ? "" : item["TITLE"].ToString();
                        model.TaskContent = item["TASK_CONTENT"] is DBNull ? "" : item["TASK_CONTENT"].ToString();
                        model.FinshPercent = item["FINSH_PERCENT"] is DBNull ? 0 : int.Parse(item["FINSH_PERCENT"].ToString());
                        model.OrderValue = item["ORDER_VALUE"] is DBNull ? "" : item["ORDER_VALUE"].ToString();
                        model.MissionStatus = item["MISSION_STATUS"] is DBNull ? "" : item["MISSION_STATUS"].ToString();
                        model.SmType = item["SM_TYPE"] is DBNull ? "" : item["SM_TYPE"].ToString();
                        model.SubType = item["SUB_TYPE"] is DBNull ? "" : item["SUB_TYPE"].ToString();
                        model.SpNumberName = item["SP_NUMBER_NAME"] is DBNull ? "" : item["SP_NUMBER_NAME"].ToString();
                        model.SpNumberYear = item["SP_NUMBER_YEAR"] is DBNull ? "0" : item["SP_NUMBER_YEAR"].ToString();
                        model.SpNumberCode = item["SP_NUMBER_CODE"] is DBNull ? 0 : Convert.ToInt32(item["SP_NUMBER_CODE"].ToString());
                        smList.Add(model);
                    }
                }
                return new SmMainPageListResponseEntity()
                {
                    status = "1",
                    message = "获取数列表成功",
                    SmMainList = smList,
                    TotalCount = totalCount,
                    PageIndex = (int)pageindex
                };
            }
            catch (Exception ex)
            {
                return new SmMainPageListResponseEntity()
                {
                    status = "0",
                    data = "",
                    message = "获取督查列表数据出错" + ex.Message
                };
            }
        }

        /// <summary>
        /// 分页查询数据列表
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="deptId"></param>
        /// <param name="keyWord"></param>
        /// <param name="beginDate"></param>
        /// <param name="endDate"></param>
        /// <param name="missionStatus"></param>
        /// <param name="smId"></param>
        /// <param name="smType"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public StatisticsPageListResponseEntity GetStatisticSMListByPage(StatisticsPageListRequestEntity statisticsPageListRequestEntity)
        {
            #region  登录校验
            if (!CheckLogin())
            {
                //没有登录不能进行操作
                return new StatisticsPageListResponseEntity() { data = NoLoginResponse.data, message = NoLoginResponse.message, status = NoLoginResponse.status };
            }
            #endregion
            #region 越权校验
            if (!CheckFormRequest())
            {
                //url存在被篡改的风险
                return new StatisticsPageListResponseEntity() { data = UrlCheckResponse.data, message = UrlCheckResponse.message, status = UrlCheckResponse.status };
            }
            #endregion
            DataTable dt = new DataTable();
            StringBuilder retsb = new StringBuilder(); ;
            try
            {
                List<string> missionStatusList = new List<string>();

                if (statisticsPageListRequestEntity.PageIndex == null)
                {
                    statisticsPageListRequestEntity.PageIndex = 1;
                }

                if (statisticsPageListRequestEntity.PageSize == null)
                {
                    statisticsPageListRequestEntity.PageSize = 10;
                }
                //任务状态，多选
                if (!string.IsNullOrEmpty(statisticsPageListRequestEntity.MissionStatus))
                {
                    string[] arr = statisticsPageListRequestEntity.MissionStatus.Trim().Trim('|').Split('|');
                    foreach (var item in arr)
                    {
                        if (!string.IsNullOrEmpty(item))
                        {
                            missionStatusList.Add(item);
                        }
                    }
                }

                dt = SuperviseMissionBodyBiz.GetStatisticSMListByPage((uint)statisticsPageListRequestEntity.PageIndex, (uint)statisticsPageListRequestEntity.PageSize, statisticsPageListRequestEntity.MainDeptId, "%" + statisticsPageListRequestEntity.KeyWord + "%", statisticsPageListRequestEntity.BeginDate, statisticsPageListRequestEntity.EndDate, missionStatusList, statisticsPageListRequestEntity.SmId, statisticsPageListRequestEntity.SmType, statisticsPageListRequestEntity.MainLeaderName, statisticsPageListRequestEntity.AssistLeaderName, IsSuperManager, CurrentUserInfo.Employee_ID);
                int totalCount = SuperviseMissionBodyBiz.GetStatisticSMListAllCount(statisticsPageListRequestEntity.MainDeptId, statisticsPageListRequestEntity.KeyWord, statisticsPageListRequestEntity.BeginDate, statisticsPageListRequestEntity.EndDate, missionStatusList, statisticsPageListRequestEntity.SmId, statisticsPageListRequestEntity.SmType, statisticsPageListRequestEntity.MainLeaderName, statisticsPageListRequestEntity.AssistLeaderName, IsSuperManager, CurrentUserInfo.Employee_ID);
                List<SmMainEntity> smList = new List<SmMainEntity>();
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow item in dt.Rows)
                    {
                        SmMainEntity model = new SmMainEntity();
                        model.Index = item["RowIndex"] is DBNull ? -1 : int.Parse(item["RowIndex"].ToString());
                        model.SmId = item["SM_ID"] is DBNull ? "" : item["SM_ID"].ToString();
                        model.SpNumberName = item["SP_NUMBER_NAME"] is DBNull ? "" : item["SP_NUMBER_NAME"].ToString();
                        model.SpNumberYear = item["SP_NUMBER_YEAR"] is DBNull ? "" : item["SP_NUMBER_YEAR"].ToString();
                        model.SpNumberCode = item["SP_NUMBER_CODE"] is DBNull ? -1 : int.Parse(item["SP_NUMBER_CODE"].ToString());
                        model.Title = item["TITLE"] is DBNull ? "" : item["TITLE"].ToString();
                        model.FinshPercent = item["FINSH_PERCENT"] is DBNull ? 0 : int.Parse(item["FINSH_PERCENT"].ToString());
                        model.OrderValue = item["ORDER_VALUE"] is DBNull ? "" : item["ORDER_VALUE"].ToString();
                        model.MissionStatus = item["MISSION_STATUS"] is DBNull ? "" : item["MISSION_STATUS"].ToString();
                        model.SmType = item["SM_TYPE"] is DBNull ? "" : item["SM_TYPE"].ToString();
                        model.MainDeptName = item["MAIN_DEPT_NAME"] is DBNull ? "" : item["MAIN_DEPT_NAME"].ToString();
                        model.MainLeaderName = item["MAIN_LEADER_NAME"] is DBNull ? "" : item["MAIN_LEADER_NAME"].ToString();
                        model.AssistLeaderName = item["ASSIST_LEADER_NAME"] is DBNull ? "" : item["ASSIST_LEADER_NAME"].ToString();
                        model.TaskContent = item["TASK_CONTENT"] is DBNull ? "" : item["TASK_CONTENT"].ToString();

                        List<SmTargetEntity> targetList = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(model.SmId);
                        List<SmTargetItemEntity> allTargetItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListBySmId(model.SmId, true);
                        List<SmFlowFinishEntity> flowWaitingList = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId == model.SmId).ToList();
                        retsb.Append(Statistics.StatisticHelper.GetSmMainForhtml(model, targetList, allTargetItemList, flowWaitingList));
                    }
                }
                return new StatisticsPageListResponseEntity()
                {
                    status = "1",
                    message = "获取数列表成功",
                    data = retsb.ToString(),
                    TotalCount = totalCount,
                    PageIndex = (int)statisticsPageListRequestEntity.PageIndex
                };
            }
            catch (Exception ex)
            {
                return new StatisticsPageListResponseEntity()
                {
                    status = "0",
                    data = "",
                    message = "获取督办列表数据出错" + ex.Message
                };
            }
        }

        /// <summary>
        /// 分页查询数据列表,督办任务详情报表
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="deptId"></param>
        /// <param name="keyWord"></param>
        /// <param name="beginDate"></param>
        /// <param name="endDate"></param>
        /// <param name="missionStatus"></param>
        /// <param name="smId"></param>
        /// <param name="smType"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public StatisticsPageListResponseEntity GetStatisticSMListByPageDetail(StatisticsPageListRequestEntity statisticsPageListRequestEntity)
        {
            #region  登录校验
            if (!CheckLogin())
            {
                //没有登录不能进行操作
                return new StatisticsPageListResponseEntity() { data = NoLoginResponse.data, message = NoLoginResponse.message, status = NoLoginResponse.status };
            }
            #endregion
            #region 越权校验
            if (!CheckFormRequest())
            {
                //url存在被篡改的风险
                return new StatisticsPageListResponseEntity() { data = UrlCheckResponse.data, message = UrlCheckResponse.message, status = UrlCheckResponse.status };
            }
            #endregion
            DataTable dt = new DataTable();
            StringBuilder retsb = new StringBuilder(); ;
            try
            {
                List<string> missionStatusList = new List<string>();

                if (statisticsPageListRequestEntity.PageIndex == null)
                {
                    statisticsPageListRequestEntity.PageIndex = 1;
                }

                if (statisticsPageListRequestEntity.PageSize == null)
                {
                    statisticsPageListRequestEntity.PageSize = 10;
                }
                //任务状态，多选
                if (!string.IsNullOrEmpty(statisticsPageListRequestEntity.MissionStatus))
                {
                    string[] arr = statisticsPageListRequestEntity.MissionStatus.Trim().Trim('|').Split('|');
                    foreach (var item in arr)
                    {
                        if (!string.IsNullOrEmpty(item))
                        {
                            missionStatusList.Add(item);
                        }
                    }
                }

                dt = SuperviseMissionBodyBiz.GetStatisticSMListByPage((uint)statisticsPageListRequestEntity.PageIndex, (uint)statisticsPageListRequestEntity.PageSize, statisticsPageListRequestEntity.MainDeptId, "%" + statisticsPageListRequestEntity.KeyWord + "%", statisticsPageListRequestEntity.BeginDate, statisticsPageListRequestEntity.EndDate, missionStatusList, statisticsPageListRequestEntity.SmId, statisticsPageListRequestEntity.SmType, statisticsPageListRequestEntity.MainLeaderName, statisticsPageListRequestEntity.AssistLeaderName, IsSuperManager, CurrentUserInfo.Employee_ID);
                int totalCount = SuperviseMissionBodyBiz.GetStatisticSMListAllCount(statisticsPageListRequestEntity.MainDeptId, statisticsPageListRequestEntity.KeyWord, statisticsPageListRequestEntity.BeginDate, statisticsPageListRequestEntity.EndDate, missionStatusList, statisticsPageListRequestEntity.SmId, statisticsPageListRequestEntity.SmType, statisticsPageListRequestEntity.MainLeaderName, statisticsPageListRequestEntity.AssistLeaderName, IsSuperManager, CurrentUserInfo.Employee_ID);
                List<SmMainEntity> smList = new List<SmMainEntity>();
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow item in dt.Rows)
                    {
                        SmMainEntity model = new SmMainEntity();
                        model.Index = item["RowIndex"] is DBNull ? -1 : int.Parse(item["RowIndex"].ToString());
                        model.SmId = item["SM_ID"] is DBNull ? "" : item["SM_ID"].ToString();
                        model.SpNumberName = item["SP_NUMBER_NAME"] is DBNull ? "" : item["SP_NUMBER_NAME"].ToString();
                        model.SpNumberYear = item["SP_NUMBER_YEAR"] is DBNull ? "" : item["SP_NUMBER_YEAR"].ToString();
                        model.SpNumberCode = item["SP_NUMBER_CODE"] is DBNull ? -1 : int.Parse(item["SP_NUMBER_CODE"].ToString());
                        model.Title = item["TITLE"] is DBNull ? "" : item["TITLE"].ToString();
                        model.FinshPercent = item["FINSH_PERCENT"] is DBNull ? 0 : int.Parse(item["FINSH_PERCENT"].ToString());
                        model.OrderValue = item["ORDER_VALUE"] is DBNull ? "" : item["ORDER_VALUE"].ToString();
                        model.MissionStatus = item["MISSION_STATUS"] is DBNull ? "" : item["MISSION_STATUS"].ToString();
                        model.SmType = item["SM_TYPE"] is DBNull ? "" : item["SM_TYPE"].ToString();
                        model.MainDeptName = item["MAIN_DEPT_NAME"] is DBNull ? "" : item["MAIN_DEPT_NAME"].ToString();
                        model.MainLeaderName = item["MAIN_LEADER_NAME"] is DBNull ? "" : item["MAIN_LEADER_NAME"].ToString();
                        model.AssistLeaderName = item["ASSIST_LEADER_NAME"] is DBNull ? "" : item["ASSIST_LEADER_NAME"].ToString();
                        model.TaskContent = item["TASK_CONTENT"] is DBNull ? "" : item["TASK_CONTENT"].ToString();

                        List<SmTargetEntity> targetList = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(model.SmId);
                        List<SmTargetItemEntity> allTargetItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListBySmId(model.SmId, true);
                        List<SmFlowFinishEntity> flowWaitingList = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId == model.SmId).ToList();
                        retsb.Append(Statistics.StatisticHelper.GetSmMainDetailForhtml(model, targetList, allTargetItemList, flowWaitingList));
                    }
                }
                return new StatisticsPageListResponseEntity()
                {
                    status = "1",
                    message = "获取数列表成功",
                    data = retsb.ToString(),
                    TotalCount = totalCount,
                    PageIndex = (int)statisticsPageListRequestEntity.PageIndex
                };
            }
            catch (Exception ex)
            {
                return new StatisticsPageListResponseEntity()
                {
                    status = "0",
                    data = "",
                    message = "获取督办列表数据出错" + ex.Message
                };
            }
        }

        #endregion

        /// <summary>
        /// 根据smId查询单个有权限的督查任务的table的html
        /// </summary>
        /// <param name="smId"></param>
        /// <returns></returns>
        public SuperviseMissionResponse GetSmMainEntityForTableHtmlBySmId(string smId)
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

                SmMainEntity model = SuperviseMissionBodyBiz.GetOneSmMainEntityByRightLimt(smId, IsSuperManager, CurrentUserInfo.Employee_ID, GetDeptList());
                if (model != null)
                {
                    model.Index = 1;
                    List<SmTargetEntity> tlist = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(model.SmId);
                    List<SmTargetItemEntity> tilist = SuperviseMissionBodyBiz.GetSmTargetItemEntityListBySmId(model.SmId, true);
                    string htmlStr = StatisticHelper.GetSmMainForhtml(model, tlist, tilist, null);
                    return new SuperviseMissionResponse()
                    {
                        status = "1",
                        data = htmlStr,
                        message = "查询成功"
                    };
                }
                else
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "没有查询到督查任务（" + smId + "）的相关信息或者是您没有权限查看该督办任务"
                    };
                }
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "查询督查任务出错。" + ex.Message
                };
            }
        }

        /// <summary>
        /// 根据smId查询单个督查任务
        /// </summary>
        /// <param name="smId"></param>
        /// <returns></returns>
        public SuperviseMissionResponse GetSmMainEntityBySmId(string smId)
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
                SmMainEntity model = SuperviseMissionBodyBiz.GetOneSmMainEntityByRightLimt(smId, IsSuperManager, CurrentUserInfo.Employee_ID, GetDeptList());
                if (model != null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "1",
                        data = JsonHelper.ToJson(model),
                        message = "查询成功"
                    };
                }
                else
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "没有查询到督查任务（" + smId + "）的相关信息或者是您没有权限查看该督办任务"
                    };
                }
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "查询督查任务出错。" + ex.Message
                };
            }
        }

        #region 领导行政会议督查任务

        /// <summary>
        /// 获取督查编号
        /// </summary>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetSMBasicDataSuperviseNumberByFlowDeptId()
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
                var flowDeptId = SuperviseMissionBodyBiz.GetFlowDeptIdByDeptId(CurrentUserInfo.Dept_ID);
                var superviseNumberList = SMBasicDataBiz.GetSuperviseNumberEntityList(new SmBasicDataSuperviseNumberEntity { DeptId = flowDeptId }, null);
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(superviseNumberList),
                    message = "获取督查编号列表成功。"
                };
            }
            catch
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取督查编号列表失败。"
                };
            }
        }

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetNewSuperviseNumber(SmBasicDataSuperviseNumberEntity smBasicDataSuperviseNumberEntity)
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
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(SuperviseMissionBodyBiz.GetNewSuperviseNumber(smBasicDataSuperviseNumberEntity)),
                    message = "获取督查编号流水号成功。"
                };
            }
            catch
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    data = "",
                    message = "获取督查编号流水号失败。"
                };
            }
        }

        #endregion

        #region 待处理批量发送功能
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse AgreeAllTask(List<AgreeItem> items)
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

                List<SmFlowWaitingEntity> CurrentFlowItemList = new List<SmFlowWaitingEntity>();
                foreach (var item in items)
                {
                    SmFlowWaitingEntity entity = new SmFlowWaitingEntity();
                    entity.SmId = item.smid;
                    entity.FlowId = item.flowid;
                    CurrentFlowItemList.Add(entity);
                }
                SuperviseMissionWorkFlow.Send(CurrentFlowItemList);
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "批量发送成功"
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

        #region 详情流转页面
        //page=2的功能 同意
        /// <summary>
        /// 办公厅目标确认（拟稿部门秘书来处理）
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <param name="remind"></param>
        /// <param name="action"></param>
        /// <param name="option"></param>
        /// <param name="flowids"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage2(string smId, int flowid, int remindType, int remindInterval, int action, string option, string opinionType, int[] flowids, string[] deptids)
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
                #region Xss攻击校验
                var xxsHtml = smId + deptids.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                if (flowids != null && deptids != null)
                {
                    if (flowids.Length != deptids.Length) { return new SuperviseMissionResponse() { data = "", message = "目标确认时参数有误。", status = "0" }; }
                }
                //TODO：校验输入参数的合法性
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.Opinion = option;
                CurrentWatingEntity.OpinionType = opinionType;
                CurrentWatingEntity.AllowFlag = action;
                #region 同意的逻辑
                if (action == 1)
                {
                    SmMainEntity smMainEntity = new SmMainEntity()
                    {
                        SmId = smId,
                        RemindType = remindType,
                        RemindInterval = remindInterval
                    };
                    CurrentWatingEntity.FlowId = flowid;
                    SuperviseMissionWorkFlow.Send(smMainEntity, CurrentWatingEntity, new SmFlowWaitingEntity());
                }
                #endregion
                #region 不同意的逻辑
                else if (action == 0)
                {
                    for (int i = 0; i < flowids.Length; i++)
                    {
                        CurrentWatingEntity.FlowId = flowids[i];
                        if (option.Trim() == "不同意")
                        {
                            IEnumerable<SmFlowWaitingEntity> source = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == smId && e.FlowId == flowids[i]);
                            foreach (SmFlowWaitingEntity item in source)
                            {
                                string deptName = SuperviseMissionWorkFlow.GetFlowDeptNameByDeptId(SuperviseMissionWorkFlow.GetFlowDeptIdByDeptId(item.FlowDeptIdPrev));
                                CurrentWatingEntity.Opinion = string.Format("不同意({0})", deptName);
                            }
                        }
                        SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                        {
                            SmId = CurrentWatingEntity.SmId,
                            FlowDeptId = deptids[i]
                        });
                    }
                }
                #endregion
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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
        /// <summary>
        /// 获取办公厅目标确认不同意时的上一步骤的单位
        /// </summary>
        /// <param name="smId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public PrevStepInformationForBgtmbqrResponse GetPrevStepInformationForBgtmbqr(string smId)
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

                List<string> list = SuperviseMissionWorkFlow.GetPrevStepInformationForBgtmbqr(smId);
                return new PrevStepInformationForBgtmbqrResponse()
                {
                    status = "1",
                    myData = list,
                    message = "成功"
                };

            }
            catch (Exception ex)
            {
                return new PrevStepInformationForBgtmbqrResponse()
                {
                    status = "0",
                    message = ex.Message
                };
            }
        }

        #region 主办单位目标分解相关

        /// <summary>
        /// 主办单位目标分解
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <param name="targets"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage12(string smId, int flowid, List<Target> targets, RemoveTargetOrItem removeModel)
        {
            try
            {
                #region Xss攻击校验
                var xxsHtml = targets.ToJson() + smId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                //0.检查参数合法性
                bool flag = false;
                if (string.IsNullOrEmpty(smId))
                {
                    flag = true;
                }
                else if (flowid <= 0)
                {
                    flag = true;
                }
                else if (targets.Count < 1)
                {
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "参数错误"
                    };
                }

                var newTargetList = targets.Where(m => m.TargetId == "" || m.TargetId == null).ToList();    //新增年度目标
                var updateTargetList = targets.Where(m => m.TargetId != "" && m.TargetId != null).ToList(); //已有的年度目标
                // 取当前流程的待办。
                var fw = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.FlowId == flowid && e.SmId == smId);
                if (fw == null || fw.Count() == 0)
                {
                    throw new InvalidOperationException("流程不存在。");
                }

                string mainDeptId = fw.First().FlowDeptId;
                string mainDeptName = SuperviseMissionWorkFlow.GetFlowDeptNameByDeptId(mainDeptId);

                #region 移除业务

                if (removeModel != null)
                {
                    //删除年度目标及其对应的措施
                    if (removeModel.TargetIds != null && removeModel.TargetIds.Any())
                    {
                        foreach (var targetId in removeModel.TargetIds)
                        {
                            var removeItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByTargetId(targetId, false);
                            foreach (var item in removeItemList)
                            {
                                SmTargetItemEntity targetItem = new SmTargetItemEntity() { ItemId = item.ItemId };
                                SuperviseMissionBodyBiz.DeleteSmTargetItemEntity(targetItem);
                            }

                            SmTargetEntity targetEntity = new SmTargetEntity() { TargetId = targetId };
                            SuperviseMissionBodyBiz.DeleteSmTargetEntity(targetEntity);
                        }
                    }

                    //删除指定年度目标的措施
                    if (removeModel.TargetItemIds != null && removeModel.TargetItemIds.Any())
                    {
                        foreach (var targetItemId in removeModel.TargetItemIds)
                        {
                            SmTargetItemEntity targetItem = new SmTargetItemEntity() { ItemId = targetItemId };
                            SuperviseMissionBodyBiz.DeleteSmTargetItemEntity(targetItem);
                        }
                    }
                }

                #endregion

                #region 编辑业务(由上一步退回)

                foreach (var target in updateTargetList)
                {
                    SmTargetEntity targetEntity = new SmTargetEntity();
                    targetEntity.TargetId = target.TargetId;
                    targetEntity.TargetName = target.TargetName;
                    SuperviseMissionBodyBiz.UpdateSmTargetEntity(targetEntity);

                    if (target.Item != null && target.Item.Any())
                    {
                        var newTargetItemList = target.Item.Where(m => m.ItemId == "" || m.ItemId == null).ToList();    //新增措施
                        var updateTargetItemList = target.Item.Where(m => m.ItemId != "" && m.ItemId != null).ToList(); //已有的措施

                        #region 插入新增的措施

                        foreach (var newTargetItem in newTargetItemList)
                        {
                            InsertSmTargetItemEntity(smId, target.TargetId, newTargetItem);
                        }

                        #endregion

                        #region 已有的措施保存更改

                        foreach (var updateTargetItem in updateTargetItemList)
                        {
                            SmTargetItemEntity itemEntity = new SmTargetItemEntity();
                            itemEntity.ItemId = updateTargetItem.ItemId;
                            itemEntity.ItemName = updateTargetItem.ItemName;
                            itemEntity.AssistDeptId = updateTargetItem.AssDeptId;
                            itemEntity.AssistDeptName = updateTargetItem.AssDeptName;
                            itemEntity.DutyDeptId = updateTargetItem.DutyDeptId;
                            itemEntity.DutyDeptName = updateTargetItem.DutyDeptName;
                            itemEntity.DeadLineTime = updateTargetItem.DeadLine;

                            SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(itemEntity);
                        }

                        #endregion
                    }
                }

                #endregion

                #region 新增业务处理（未流转到下一步）

                foreach (var target in newTargetList)
                {
                    SmTargetEntity targetEntity = new SmTargetEntity();
                    targetEntity.TargetId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber();
                    targetEntity.SmId = smId;
                    targetEntity.TargetName = target.TargetName;
                    targetEntity.CreateTime = DateTime.Now;
                    targetEntity.CreatorId = this.CurrentUserInfo.Employee_ID;
                    targetEntity.CreatorName = this.CurrentUserInfo.Name;
                    targetEntity.CreatorDeptId = this.CurrentUserInfo.Dept_ID;
                    targetEntity.CreatorDeptName = this.CurrentUserInfo.Dept_Name;
                    targetEntity.MainDeptId = mainDeptId;//SuperviseMissionWorkFlow.GetFlowDeptIdByDeptId(CurrentUserInfo.Dept_ID);
                    targetEntity.MainDeptName = mainDeptName; //SuperviseMissionWorkFlow.GetFlowDeptNameByDeptId(targetEntity.MainDeptId);
                    targetEntity.ActivityFlag = 1;
                    SuperviseMissionBodyBiz.InsertSmTargetEntity(targetEntity);
                    string targetId = targetEntity.TargetId;

                    #region 插入新增的措施

                    if (target.Item != null && target.Item.Any())
                    {
                        foreach (var newTargetItem in target.Item)
                        {
                            InsertSmTargetItemEntity(smId, targetId, newTargetItem);
                        }
                    }

                    #endregion
                }

                #endregion
                //流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowid;
                CurrentWatingEntity.Opinion = "";
                CurrentWatingEntity.OpinionType = "4";//这个意见类型最后要传入
                CurrentWatingEntity.AllowFlag = 1;
                //CurrentWatingEntity.TargetId = string.Join(";", targetIdList.ToArray());
                //CurrentWatingEntity.TargetItemId = string.Join(";", targetItemIdList.ToArray());
                //SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity());
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity());
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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

        /// <summary>
        /// 新增措施
        /// </summary>
        /// <param name="smId">主表ID</param>
        /// <param name="targetId">年度目标ID</param>
        /// <param name="entity">措施的实体</param>
        private void InsertSmTargetItemEntity(string smId, string targetId, TargetItem entity)
        {
            SmTargetItemEntity itemEntity = new SmTargetItemEntity();
            itemEntity.ItemId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber();
            itemEntity.TargetId = targetId;
            itemEntity.SmId = smId;
            itemEntity.ItemName = entity.ItemName;
            itemEntity.AssistDeptName = entity.AssDeptName;
            itemEntity.AssistDeptId = entity.AssDeptId;
            itemEntity.DutyDeptName = entity.DutyDeptName;
            itemEntity.DutyDeptId = entity.DutyDeptId;
            itemEntity.DeadLineTime = entity.DeadLine;
            itemEntity.CreateTime = DateTime.Now;
            itemEntity.CreatorId = this.CurrentUserInfo.Employee_ID;
            itemEntity.CreatorName = this.CurrentUserInfo.Name;
            itemEntity.CreatorDeptId = this.CurrentUserInfo.Dept_ID;
            itemEntity.CreatorDeptName = this.CurrentUserInfo.Dept_Name;
            itemEntity.Status = "0";
            itemEntity.ActivityFlag = 1;
            SuperviseMissionBodyBiz.InsertSmTargetItemEntity(itemEntity);
        }

        /// <summary>
        /// 获取年度目标及其措施集合
        /// </summary>
        /// <param name="smId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetTargetAndTargetItemData(string smId)
        {
            try
            {
                List<Target> targetList = new List<Target>();
                Target tempTarget = null;
                //1.先获取所有的年度目标
                var targetEntityList = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(smId);

                // 先获取当前用户的部门角色信息。
                IEnumerable<SmBasicDataDeptRoleDefinitionEntity> roles = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                        new SmBasicDataDeptRoleDefinitionEntity
                        {
                            MemberId = CurrentUserInfo.Employee_ID,
                            RoleId = "MS"
                        }
                );

                // 判断多主办单位的权限，如果是A用户创建的目标，则B用户打开时不能删除、修改A用户创建的目标\措施，即对B用户来说A用户创建的目标\措施是只读的。
                Func<String, bool> predicate = d =>
                 {
                     if (roles == null || roles.Count() == 0) return false;
                     if (null != roles.FirstOrDefault(e => e.DeptId == d && e.RoleId == "MS")) return true;
                     return false;
                 };

                if (targetEntityList != null)
                {
                    //2.遍历获取年度目标及其措施的数据
                    foreach (var targetEntity in targetEntityList)
                    {
                        tempTarget = new Target();
                        tempTarget.TargetId = targetEntity.TargetId;
                        tempTarget.TargetName = targetEntity.TargetName;
                        bool isPower = predicate(targetEntity.MainDeptId);
                        tempTarget.IsSameDept = isPower;

                        List<TargetItem> itemList = new List<TargetItem>();
                        TargetItem tempTargetItem = null;
                        var targetItemEntityList = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(
                            new SmTargetItemEntity()
                            {
                                SmId = smId,
                                TargetId = targetEntity.TargetId,
                                ParentTargetItemId = null
                            });
                        if (targetItemEntityList != null)
                        {
                            //3.遍历获取措施数据
                            foreach (var targetItemEntity in targetItemEntityList)
                            {
                                tempTargetItem = new TargetItem();
                                tempTargetItem.ItemId = targetItemEntity.ItemId;
                                tempTargetItem.ItemName = targetItemEntity.ItemName;
                                tempTargetItem.AssDeptId = targetItemEntity.AssistDeptId;
                                tempTargetItem.AssDeptName = targetItemEntity.AssistDeptName;
                                tempTargetItem.DeadLineFormat = targetItemEntity.DeadLineTime != null ? Convert.ToDateTime(targetItemEntity.DeadLineTime).ToString("yyyy-MM-dd") : "";
                                tempTargetItem.DutyDeptId = targetItemEntity.DutyDeptId;
                                tempTargetItem.DutyDeptName = targetItemEntity.DutyDeptName;
                                tempTargetItem.IsSameDept = isPower;
                                itemList.Add(tempTargetItem);
                            }
                        }
                        tempTarget.Item = itemList;
                        targetList.Add(tempTarget);
                    }

                }
                else
                {
                    targetList = new List<Target>();
                }

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "获取成功",
                    data = JsonHelper.ToJson(targetList)
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

        /// <summary>
        /// 固定流审批
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <param name="action"></param>
        /// <param name="option"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage4(string smId, int flowid, int action, string option, string opinionType)
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
                #region Xss攻击校验
                var xxsHtml = smId + option;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //TODO:检查参数合法性和权限问题
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowid;
                CurrentWatingEntity.Opinion = option;
                CurrentWatingEntity.OpinionType = opinionType;
                CurrentWatingEntity.AllowFlag = action;
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity());
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "操作成功"
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

        #region 措施反馈相关

        /// <summary>
        /// 措施反馈保存措施进度和意见。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SavePage11(SavePercentRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 参数合法性检查
                bool flag = false;
                string strMsg = "";

                if (!flag && string.IsNullOrEmpty(requestParameter.ItemId.Trim()))
                {
                    strMsg = "参数错误：缺失措施流水号";
                    flag = true;
                }

                if (!flag && string.IsNullOrEmpty(requestParameter.Opinion.Trim()))
                {
                    strMsg = "参数错误：最新反馈不允许为空";
                    flag = true;
                }

                if (!flag && requestParameter.Opinion.Length > OPINION_MAX_LENGTH)
                {
                    strMsg = "参数错误：最新反馈最大长度不能超过" + OPINION_MAX_LENGTH + "个字符";
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

                //1.如果是发送保存就更新措施表，否则只更新待办的完成进度。2018-12-05
                if (requestParameter.IsSendSave)
                {
                    SmTargetItemEntity itemEntity = new SmTargetItemEntity();
                    itemEntity.ItemId = requestParameter.ItemId;
                    itemEntity.FinshPercent = requestParameter.FinishPercent;
                    SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(itemEntity);
                }

                //2.更新意见
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FinishPercent = requestParameter.FinishPercent;

                SuperviseMissionWorkFlow.SaveFlowItem(CurrentWatingEntity);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "保存成功"
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

        /// <summary>
        /// 措施反馈发送年度目标进度。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage11(FreeFlowRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                if (!flag && string.IsNullOrEmpty(requestParameter.TargetId.Trim()))
                {
                    strMsg = "参数错误：缺失目标进度ID";
                    flag = true;
                }

                if (!flag && string.IsNullOrEmpty(requestParameter.Opinion.Trim()))
                {
                    strMsg = "参数错误：反馈意见不允许为空";
                    flag = true;
                }

                if (!flag && requestParameter.Opinion.Length > OPINION_MAX_LENGTH)
                {
                    strMsg = "参数错误：反馈意见最大长度不能超过" + OPINION_MAX_LENGTH + "个字符";
                    flag = true;
                }

                if (!flag && (String.IsNullOrEmpty(requestParameter.StepId) || String.IsNullOrEmpty(requestParameter.StepName)))
                {
                    strMsg = "请先选择下一步骤信息";
                    flag = true;
                }

                if (!flag && string.IsNullOrEmpty(requestParameter.UserId))
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

                //1.更新年度目标进度信息
                SmTargetEntity itemEntity = new SmTargetEntity();
                itemEntity.TargetId = requestParameter.TargetId;
                itemEntity.TargetPercent = requestParameter.FinishPercent;
                SuperviseMissionBodyBiz.UpdateSmTargetEntity(itemEntity);

                //2.生成年度目标的待办
                SmFlowWaitingEntity WatingEntity = new SmFlowWaitingEntity();
                WatingEntity.SmId = requestParameter.SmId;
                WatingEntity.FlowId = requestParameter.FlowId;
                WatingEntity.TargetId = requestParameter.TargetId;
                WatingEntity.UserId = CurrentUserInfo.Employee_ID;
                WatingEntity.UserName = CurrentUserInfo.Name;
                WatingEntity.UserDeptId = CurrentUserInfo.Dept_ID;
                WatingEntity.UserDeptName = CurrentUserInfo.Dept_Name;
                WatingEntity.AllowFlag = 1;
                SmFlowWaitingEntity CurrentWatingEntity = SuperviseMissionWorkFlow.GenerateWaitingFlowItemForTarget(WatingEntity);

                //3.流转
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                SmFlowWaitingEntity NextWatingEntity = new SmFlowWaitingEntity()
                {
                    SmId = requestParameter.SmId,
                    StepId = requestParameter.StepId,
                    StepName = requestParameter.StepName
                };
                if (requestParameter.RoleType == "1")
                {
                    //个人角色
                    NextWatingEntity.UserName = requestParameter.UserName;
                    NextWatingEntity.UserId = requestParameter.UserId;
                }
                else if (requestParameter.RoleType == "2")
                {
                    //部门角色
                    NextWatingEntity.FlowDeptId = requestParameter.UserId;
                }

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, NextWatingEntity);
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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

        #region 获取自由流步骤与处理人信息

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetNextStepFreeList(string stepid, string smType, string subType)
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

                var nextStepEntityList = SuperviseMissionWorkFlow.GetNextStepFreeList(new SmSystemWorkFlowFreeDefinitionEntity() { CurrentStepId = stepid.ToUpper(), SmType = smType, SubType = subType });

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
                    status = "0",
                    message = ex.Message
                };
            }
        }

        /// <summary>
        /// 获取自由流步骤处理人信息
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <param name="stepId"></param>
        /// <param name="targetId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetUserListByStepFree(string smId, int flowid, string stepId, string targetId)
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
                    strMsg = "参数错误：缺失smId";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(stepId))
                {
                    strMsg = "参数错误：缺失stepId";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(smId))
                {
                    strMsg = "参数错误：缺失目标流水号";
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
                var flowEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity() { SmId = smId, FlowId = flowid });

                //2.获取下一步处理人信息
                List<StepUserEntity> stepUsers = SuperviseMissionWorkFlow.GetUserListByStep(flowEntity.FlowDeptId, stepId, smId, targetId, "", CurrentUserInfo.Employee_ID, CurrentUserInfo.Name);

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

        /// <summary>
        /// 获取自由流步骤处理人信息
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <param name="stepId"></param>
        /// <param name="targetId"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse BGGetUserListByStepFree(string smId, int flowid, string stepId, string targetId)
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
                    strMsg = "参数错误：缺失smId";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(stepId))
                {
                    strMsg = "参数错误：缺失stepId";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(smId))
                {
                    strMsg = "参数错误：缺失目标流水号";
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

                var deptId = SuperviseMissionBodyBiz.GetFlowDeptIdByDeptId(CurrentUserInfo.Dept_ID);
                //如果是上报督查单位，是走原单拟稿部门的秘书。
                if (stepId.Equals("CSBGSBBGT") || stepId.Equals("ZCSBGSBBGT"))
                {
                    deptId = SuperviseMissionBodyBiz.GetFlowDeptIdByDeptId(SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smId }).CreatorDeptId);
                }

                if (stepId.Equals("CSBGMSCL"))
                {
                    //如果是措施变更的秘书处理，无论什么人，都显示主办单位的秘书列表。
                    deptId = SuperviseMissionBodyBiz.GetFlowDeptIdByDeptId(SuperviseMissionBodyBiz.GetSmTargetEntity(new SmTargetEntity { TargetId = targetId }).CreatorDeptId);
                }

                if (stepId.Equals("ZCSBGMSCL"))
                {
                    //如果是子措施变更的秘书处理，先判断当前用户是不是责任处室的秘书。
                }

                List<StepUserEntity> stepUsers = SuperviseMissionWorkFlow.GetUserListByStep(deptId, stepId, smId, targetId, "", CurrentUserInfo.Employee_ID, CurrentUserInfo.Name);
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

        /// <summary>
        /// 获取下一步步骤列表
        /// </summary>
        /// <param name="smId">任务主表Id。</param>
        /// <param name="flowid">流程Id。</param>
        /// <returns>返回响应状态及数据。</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetNextStep(string smId, int flowid, string stepid)
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

                var NextStepEntity = SuperviseMissionWorkFlow.GetNextStep(smId, flowid);

                if (NextStepEntity.StepFreeList.Any())
                {
                    //措施反馈：过滤责任处室分解子措施（ZRCSFJZCS）步骤（ps:此步骤在"主办单位目标推进"步骤发送实现）
                    if ("CSFK".Equals(stepid.ToUpper()))
                    {
                        NextStepEntity.StepFreeList = NextStepEntity.StepFreeList.Where(m => m.NextStepId != "ZRCSFJZCS").ToList();
                    }
                }


                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "获取成功。",
                    data = JsonHelper.ToJson(NextStepEntity.StepFreeList)
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

        /// <summary>
        /// 子措施处理。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage10(FreeFlowRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                #region 参数合法性检查

                bool flag = false;
                string strMsg = "";
                if (!flag && string.IsNullOrEmpty(requestParameter.TargetId.Trim()))
                {
                    strMsg = "参数错误：缺失年度目标流水号";
                    flag = true;
                }
                if (!flag && string.IsNullOrEmpty(requestParameter.ItemId.Trim()))
                {
                    strMsg = "参数错误：缺失子措施流水号";
                    flag = true;
                }

                if (!flag && string.IsNullOrEmpty(requestParameter.Opinion.Trim()))
                {
                    strMsg = "参数错误：最新反馈不允许为空";
                    flag = true;
                }

                if (!flag && requestParameter.Opinion.Length > OPINION_MAX_LENGTH)
                {
                    strMsg = "参数错误：最新反馈最大长度不能超过" + OPINION_MAX_LENGTH + "个字符";
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

                //0.获取下一步处理人信息
                var flowEntity = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity() { SmId = requestParameter.SmId, FlowId = requestParameter.FlowId });
                var StepUserEntityList = SuperviseMissionWorkFlow.GetUserListByStep(flowEntity.FlowDeptId, "ZCSFK",
                    requestParameter.SmId, requestParameter.TargetId, requestParameter.ItemId, CurrentUserInfo.Employee_ID, CurrentUserInfo.Name);
                var StepUserEntity = StepUserEntityList.FirstOrDefault();

                //1.更新子措施完成进度
                SmTargetItemEntity itemEntity = new SmTargetItemEntity();
                itemEntity.ItemId = requestParameter.ItemId;
                itemEntity.FinshPercent = requestParameter.FinishPercent;
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(itemEntity);

                //2.流转
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FinishPercent = requestParameter.FinishPercent;

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = requestParameter.SmId,
                    StepId = "ZRCSCSFK",
                    StepName = "责任处室措施反馈",
                    FlowDeptId = flowEntity.FlowDeptId,
                    UserId = StepUserEntity.MemberId,
                    UserName = StepUserEntity.MemberName
                });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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

        /// <summary>
        /// 责任处室分解子措施
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <param name="subMeasures"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage13(string smId, int flowid, string opinion, string opinionType, List<SubMeasureItem> subMeasures)
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
                #region Xss攻击校验
                var xxsHtml = smId + subMeasures.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //0.检查参数合法性
                bool flag = false;
                if (string.IsNullOrEmpty(smId))
                {
                    flag = true;
                }
                else if (flowid <= 0)
                {
                    flag = true;
                }
                if (flag)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "参数错误"
                    };
                }
                if (!subMeasures.Any())
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "请先添加子措施"
                    };
                }

                #region 判断可分解子措施的措施是否存在未添加子措施。
                // 先获取当前FlowId的待办。
                var SmFlowItem = SuperviseMissionWorkFlow.GetSmFlowItemByFlowId(new SmFlowItemBaseEntity() { SmId = smId, FlowId = flowid });
                SmTargetItemEntity condition = new SmTargetItemEntity()
                {
                    ActivityFlag = 1,
                    SmId = smId,
                    DutyDeptId = SmFlowItem.FlowDeptId,
                    ParentTargetItemId = null,
                };
                // 获取可分解子措施的措施。
                var targetItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(condition);
                bool isExisted = true;
                foreach (var item in targetItems)
                {
                    var temp = subMeasures.Where(e => e.MeasureId == item.ItemId);
                    if (temp == null || temp.Count() == 0)
                    {
                        isExisted = false;
                        break;
                    }
                }
                if (!isExisted)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "存在未分解的措施。"
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
                CurrentWatingEntity.Opinion = opinion;
                CurrentWatingEntity.OpinionType = opinionType;
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
                    message = "成功"
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
        /// <summary>
        /// 主办单位目标推进（秘书收文）
        /// </summary>
        /// <param name="smId"></param>
        /// <param name="flowid"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage14(string smId, int flowid)
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
                #region Xss攻击校验
                var xxsHtml = smId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //TODO:检查参数合法性和权限问题
                //List<SmTargetItemEntity> targetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(new SmTargetItemEntity() { SmId = smId, ActivityFlag = 1 });
                //if (targetItemEntity == null || targetItemEntity.Count == 0)
                //{
                //    return new SuperviseMissionResponse()
                //    {
                //        status = "0",
                //        message = "没有措施"
                //    };
                //}

                // 1)获取当前用户的部门角色。
                IEnumerable<SmBasicDataDeptRoleDefinitionEntity> roles = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity
                    {
                        MemberId = CurrentUserInfo.Employee_ID,
                        RoleId = "MS"
                    }
                );

                if (roles == null || roles.Count() == 0) throw new InvalidOperationException("您没有权限操作。");

                //这三个参数需要一一对应 数量和格式上都必须保持一致
                string flowDeptIds = "";  // 用于拼接流程部门Id。
                string targetIds = "";    // 用于拼接目标Id。
                string targetItemIds = "";// 用于拼接措施Id。

                // 2)获取目标。
                var targets = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(smId);
                foreach (SmTargetEntity target in targets)
                {
                    // 3)判断当前用户是否拥有该主办单位的权限。
                    if (null != roles.FirstOrDefault(e => e.DeptId == target.MainDeptId))
                    {
                        //根据目标id获取所有措施（不包含子措施）
                        var targetItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByTargetId(target.TargetId, false);
                        //循环操作子措施 构造相应的发送字段
                        foreach (var item in targetItems)
                        {
                            if (string.IsNullOrEmpty(targetIds)) targetIds = target.TargetId;
                            else targetIds += ";" + target.TargetId;

                            if (string.IsNullOrEmpty(flowDeptIds)) flowDeptIds = item.DutyDeptId;
                            else flowDeptIds += ";" + item.DutyDeptId;

                            if (string.IsNullOrEmpty(targetItemIds)) targetItemIds = item.ItemId;
                            else targetItemIds += ";" + item.ItemId;
                        }
                    }
                }

                //// 拼接责任部门Id号。
                //foreach (var item in targetItemEntity)
                //{
                //    // 过滤重复的部门Id。
                //    if (flowdeptIds.Contains(item.DutyDeptId)) continue;

                //    flowdeptIds += item.DutyDeptId + ";";
                //}

                if (String.IsNullOrEmpty(flowDeptIds)) throw new InvalidOperationException("您没有权限操作。");

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                CurrentWatingEntity.FlowId = flowid;
                CurrentWatingEntity.Opinion = "目标推进发送到措施推进";
                CurrentWatingEntity.OpinionType = "4";//这个意见类型最后要传入
                CurrentWatingEntity.AllowFlag = 1;

                //SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                //{
                //    SmId = smId,
                //    StepId = "ZRCSFJZCS",
                //    StepName = "责任处室分解子措施",
                //    FlowDeptId = flowDeptIds,
                //    TargetItemId = targetItemIds,
                //    TargetId = targetIds
                //});
                // 需求变更，现发送到"责任处室目标推进"。
                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = smId,
                    StepId = "ZRCSCSTJ",
                    StepName = "责任处室措施推进",
                    FlowDeptId = flowDeptIds,
                    TargetItemId = targetItemIds,
                    TargetId = targetIds
                });
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "操作成功"
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

        #region page3\page8\page9\page15的功能。
        #region 公共方法。

        /// <summary>
        /// 获取下一步步骤列表。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetNextStep2(StepRequestParameter requestParameter)
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

                if (String.IsNullOrEmpty(requestParameter.SmId))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "任务Id不能为空。"
                    };
                }

                NextStepResponse nsr = new NextStepResponse();
                NextStepEntity nextSteps = SuperviseMissionWorkFlow.GetNextStep(requestParameter.SmId, requestParameter.FlowId);
                nsr.NextStep = nextSteps;
                var fw = SuperviseMissionBodyBiz.GetSmFlowWaitingList(f => f.SmId == requestParameter.SmId && f.FlowId == requestParameter.FlowId).FirstOrDefault();
                if (null != fw) nsr.FlowDeptId = fw.FlowDeptId;

                StringBuilder opinions = new StringBuilder();
                int index = 0;
                // 判断是哪一步请求？
                if (requestParameter.StepId == "ZRCSCSFK")
                {
                    // 当前请求步骤是【责任处室措施反馈】。
                    ICollection<SmTargetItemEntity> childItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByParentId(requestParameter.ItemId);
                    if (childItems != null && childItems.Any())
                    {
                        childItems = childItems.OrderBy(k => k.ItemId).ToList();
                        foreach (var item in childItems)
                        {
                            var ff = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId == requestParameter.SmId && e.TargetItemId == item.ItemId && e.StepId == "ZCSFK" && e.Opinion != null && e.Opinion != "").OrderByDescending(k => k.FlowId).FirstOrDefault();
                            if (null != ff)
                            {
                                opinions.Append(String.Format("子措施{0}:{1} {2}\r\n", (++index).ToString(), Convert.ToDateTime(ff.FinishTime).ToString("yyyy-MM-dd"), ff.Opinion));
                            }
                        }
                    }
                }
                else if (requestParameter.StepId == "ZBDWMBFK")
                {
                    // 当前请求步骤是【主办单位目标反馈】。
                    ICollection<SmTargetItemEntity> parentItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByTargetId(requestParameter.TargetId, false);
                    if (parentItems != null && parentItems.Any())
                    {
                        parentItems = parentItems.OrderBy(k => k.ItemId).ToList();
                        foreach (var item in parentItems)
                        {
                            var ff = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId == requestParameter.SmId && e.TargetItemId == item.ItemId && (e.StepId == "ZRCSCSFK" || e.StepId == "CSFK" || e.StepId == "ZBDWMBTJ") && e.Opinion != null && e.Opinion != "").OrderByDescending(k => k.FlowId).FirstOrDefault();
                            if (null != ff)
                            {
                                opinions.Append(String.Format("措施{0}:{1} {2}\r\n", (++index).ToString(), Convert.ToDateTime(ff.FinishTime).ToString("yyyy-MM-dd"), ff.Opinion));
                            }
                        }
                    }
                }
                else if (requestParameter.StepId == "BGTRWFK")
                {
                    // 当前请求步骤是【办公厅任务反馈】。
                    ICollection<SmTargetEntity> targets = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(requestParameter.SmId);
                    if (targets != null && targets.Any())
                    {
                        targets = targets.OrderBy(k => k.TargetId).ToList();
                        foreach (var item in targets)
                        {
                            var ff = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId == requestParameter.SmId && e.TargetId == item.TargetId && (e.StepId == "ZBDWMBFK" || (e.StepId == "CSFK" &&(e.TargetItemId==""||e.TargetItemId==null))|| e.StepId == "ZBDWMBTJ") && e.Opinion != null && e.Opinion != "").OrderByDescending(k => k.FlowId).FirstOrDefault();
                            if (null != ff)
                            {
                                opinions.Append(String.Format("目标{0}:{1} {2}\r\n", (++index).ToString(), Convert.ToDateTime(ff.FinishTime).ToString("yyyy-MM-dd"), ff.Opinion));
                            }
                        }
                    }
                }

                nsr.Opinion = opinions.ToString();

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(nsr),
                    message = "成功"
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取步骤列表失败。" + ex.Message
                };
            }
        }
        /// <summary>
        /// 获取下一步步骤列表。
        /// </summary>
        /// <param name="smId">任务Id。</param>
        /// <param name="flowId">流程Id。</param>
        /// <returns>返回响应状态及数据。</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetNextStep389(string smId, int flowId)
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

                if (String.IsNullOrEmpty(smId))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "任务Id不能为空。"
                    };
                }

                NextStepEntity nextSteps = SuperviseMissionWorkFlow.GetNextStep(smId, flowId);

                if (nextSteps != null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "1",
                        data = JsonHelper.ToJson(nextSteps),
                        message = "成功"
                    };
                }

                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取步骤列表失败。"
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

        /// <summary>
        /// 根据部门和当前步骤获取相关的人员列表。
        /// </summary>
        /// <param name="deptId">部门Id(传流程表的FLOW_DEPT_ID)。</param>
        /// <param name="stepId">步骤Id。</param>
        /// <param name="smId">任务Id。</param>
        /// <param name="targetId">目标Id。</param>
        /// <param name="itemId">措施Id。</param>
        /// <returns>返回响应状态及数据。</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetUserListByStep(string deptId, string stepId, string smId, string targetId, string itemId, int flowId)
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

                // 如果目标Id为空则取当前流程的待办的目标。
                if (String.IsNullOrEmpty(targetId))
                {
                    var fw = SuperviseMissionBodyBiz.GetSmFlowWaitingEntity(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                    if (fw != null) targetId = fw.TargetId;
                }

                List<StepUserEntity> stepUsers = SuperviseMissionWorkFlow.GetUserListByStep(deptId, stepId, smId, targetId, itemId, CurrentUserInfo.Employee_ID, CurrentUserInfo.Name);

                if (stepUsers != null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "1",
                        data = JsonHelper.ToJson(stepUsers),
                        message = "成功"
                    };
                }

                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取步骤用户列表失败。"
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

        /// <summary>
        /// 根据部门和当前步骤获取相关的人员列表。
        /// </summary>
        /// <param name="deptId">部门Id(传流程表的FLOW_DEPT_ID)。</param>
        /// <param name="stepId">步骤Id。</param>
        /// <param name="smId">任务Id。</param>
        /// <param name="targetId">目标Id。</param>
        /// <param name="itemId">措施Id。</param>
        /// <returns>返回响应状态及数据。</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetBGUserListByStep(string deptId, string stepId, string smId, string targetId, string itemId, int flowId)
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

                // 如果目标Id为空则取当前流程的待办的目标。
                if (String.IsNullOrEmpty(targetId))
                {
                    var fw = SuperviseMissionBodyBiz.GetSmFlowWaitingEntity(new SmFlowWaitingEntity() { SmId = smId, FlowId = flowId });
                    if (fw != null) targetId = fw.TargetId;
                }

                if (stepId.Equals("CSBGSBBGT") || stepId.Equals("ZCSBGSBBGT"))
                {
                    //上报督查单位，是走原单拟稿部门的秘书
                    var changeEntity =
                        SuperviseMissionBodyBiz.GetSmTargetItemChangeEntity(new SmTargetItemChangeEntity
                        { ChangeId = smId });
                    deptId = SuperviseMissionBodyBiz.GetFlowDeptIdByDeptId(SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = changeEntity.SourceSmId }).CreatorDeptId);
                }

                List<StepUserEntity> stepUsers = SuperviseMissionWorkFlow.GetUserListByStep(deptId, stepId, smId, targetId, itemId, CurrentUserInfo.Employee_ID, CurrentUserInfo.Name);

                if (stepUsers != null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "1",
                        data = JsonHelper.ToJson(stepUsers),
                        message = "成功"
                    };
                }

                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取步骤用户列表失败。"
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

        /// <summary>
        /// 获取指定任务Id对应的流程部门Id。
        /// </summary>
        /// <param name="smid">任务Id。</param>
        /// <param name="flowId">流程Id。</param>
        /// <returns>返回响应状态及数据。</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse GetFlowDeptId(string smId, int flowId)
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

                var fw = SuperviseMissionBodyBiz.GetSmFlowWaitingList(f => f.SmId == smId && f.FlowId == flowId).FirstOrDefault();
                if (null == fw) throw new InvalidOperationException("获取流程部门Id失败。");

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = fw.FlowDeptId,
                    message = "成功。"
                };
            }
            catch (Exception ex)
            {
                return new SuperviseMissionResponse()
                {
                    status = "0",
                    message = "获取流程部门Id失败。"
                };
            }
        }
        #endregion

        /// <summary>
        /// 办公厅任务反馈退回。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse BackPreviousStep3(BackRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.TargetId + requestParameter.Opinion;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 发送退回。               

                SmFlowFinishEntity previousStep = SuperviseMissionBodyBiz.GetSmFlowFinishPrevEntity(requestParameter.SmId, requestParameter.FlowId);
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 0;// “不同意”或“退回”赋值0，“同意”赋值1。            
                SuperviseMissionWorkFlow.SendBack(CurrentWatingEntity, previousStep.StepId);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
                };
                #endregion
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

        /// <summary>
        /// 主办单位目标反馈退回。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse BackPreviousStep8(BackRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.ItemId + requestParameter.Opinion;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 发送退回。 
                //var previousStep = SuperviseMissionBodyBiz.GetSmFlowFinishPrevEntity(requestParameter.SmId, requestParameter.FlowId);

                #region 寻找最近且非当前步骤的前驱步骤作为退回步骤。
                ICollection<SmFlowFinishEntity> source = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId == requestParameter.SmId && e.FlowId <= requestParameter.FlowId).OrderByDescending(e => e.FlowId).ToList();
                int previousFlowId = Convert.ToInt32(SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == requestParameter.SmId && e.FlowId == requestParameter.FlowId).First().FlowIdPrev);
                int temp = previousFlowId;
                string currentStepId = "ZBDWMBFK";
                string backStepId = "";
                foreach (SmFlowFinishEntity step in source)
                {
                    // 寻找最近且非当前步骤的前驱步骤。
                    if (step.FlowId == temp)
                    {
                        if (step.StepId != currentStepId)
                        {
                            backStepId = step.StepId;
                            break;
                        }
                        temp = Convert.ToInt32(step.FlowIdPrev);
                    }
                }
                #endregion

                #region 回滚完成进度为当前步骤的上一步发送前的状态。
                int k = 3;                            // 反向查找k步后停止。
                int rollbackFinishPercent = 0;        // 回滚的完成进度。
                temp = previousFlowId;                // 重置上一步流程用于重新寻找。
                Queue<String> q = new Queue<string>();// 用于存储访问过的步骤。
                q.Enqueue(currentStepId);             // 当前步骤入队。
                q.Enqueue("BMSH");                    // 特殊的3步不作计数。
                q.Enqueue("BMSP");
                q.Enqueue("MSCL");
                foreach (SmFlowFinishEntity step in source)
                {
                    if (step.FlowId == temp)
                    {
                        if (!q.Contains(step.StepId))
                        {
                            q.Enqueue(step.StepId);// 访问过的步骤入队。
                            rollbackFinishPercent = step.FinishPercent;
                            k--;
                        }
                        temp = Convert.ToInt32(step.FlowIdPrev);
                    }

                    if (k <= 0) break;
                }

                // 回滚子措施的完成进度为当前步骤的上一步发送前的状态。
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(new SmTargetItemEntity() { ItemId = requestParameter.ItemId, FinshPercent = rollbackFinishPercent });
                #endregion

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 0;// “不同意”或“退回”赋值0，“同意”赋值1。

                SuperviseMissionWorkFlow.SendBack(CurrentWatingEntity, backStepId);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
                };
                #endregion
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

        /// <summary>
        /// 责任处室措施反馈退回。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse BackPreviousStep9(BackRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.ItemId + requestParameter.Opinion;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 发送退回。

                //SmFlowFinishEntity previousStep = SuperviseMissionBodyBiz.GetSmFlowFinishPrevEntity(requestParameter.SmId, requestParameter.FlowId);
                #region 寻找最近且非当前步骤的前驱步骤作为退回步骤。
                ICollection<SmFlowFinishEntity> source = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId == requestParameter.SmId && e.FlowId <= requestParameter.FlowId).OrderByDescending(e => e.FlowId).ToList();
                int previousFlowId = Convert.ToInt32(SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == requestParameter.SmId && e.FlowId == requestParameter.FlowId).First().FlowIdPrev);
                int temp = previousFlowId;
                string currentStepId = "ZRCSCSFK";
                string backStepId = "";
                foreach (SmFlowFinishEntity step in source)
                {
                    // 寻找最近且非当前步骤的前驱步骤。
                    if (step.FlowId == temp)
                    {
                        if (step.StepId != currentStepId)
                        {
                            backStepId = step.StepId;
                            break;
                        }
                        temp = Convert.ToInt32(step.FlowIdPrev);
                    }
                }
                #endregion

                #region 回滚完成进度为当前步骤的上一步发送前的状态。
                int k = 2;                            // 反向查找k步后停止。
                int rollbackFinishPercent = 0;        // 回滚的完成进度。
                temp = previousFlowId;                // 重置上一步流程用于重新寻找。
                Queue<String> q = new Queue<string>();// 用于存储访问过的步骤。
                q.Enqueue(currentStepId);             // 当前步骤入队。
                q.Enqueue("BMSH");                    // 特殊的3步不作计数。
                q.Enqueue("BMSP");
                q.Enqueue("MSCL");
                foreach (SmFlowFinishEntity step in source)
                {
                    if (step.FlowId == temp)
                    {
                        if (!q.Contains(step.StepId))
                        {
                            q.Enqueue(step.StepId);// 访问过的步骤入队。
                            rollbackFinishPercent = step.FinishPercent;
                            k--;
                        }

                        temp = Convert.ToInt32(step.FlowIdPrev);
                    }

                    if (k <= 0) break;
                }

                // 回滚子措施的完成进度为当前步骤的上一步发送前的状态。
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(new SmTargetItemEntity() { ItemId = requestParameter.ItemId, FinshPercent = rollbackFinishPercent });
                // 回滚附件(目前只是简单地将所有对应的附件标识为不可用)。
                // 先取出所有指定的“SMID”(注意此SMID非彼SMID)的附件并遍历更新。
                var attachments=SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity() { SmId = requestParameter.ItemId });
                foreach (var item in attachments)
                {
                    SuperviseMissionBodyBiz.DeleteSmAttachmentEntity(new SmAttachmentEntity() { SmId=requestParameter.ItemId,AttachmentId=item.AttachmentId});
                }
                #endregion

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 0;// “不同意”或“退回”赋值0，“同意”赋值1。

                SuperviseMissionWorkFlow.SendBack(CurrentWatingEntity, backStepId);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
                };
                #endregion
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

        /// <summary>
        /// 办公厅任务反馈发送。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage3(FreeFlowRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.ItemId + requestParameter.StepId + requestParameter.StepName + requestParameter.FlowDeptId + requestParameter.UserId + requestParameter.Opinion;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                // 1)更新任务进度。
                SuperviseMissionBodyBiz.UpdateSmMainEntity(new SmMainEntity() { SmId = requestParameter.SmId, FinshPercent = requestParameter.FinishPercent });

                // 2)发送到下一步骤。
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.UserId = CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.FinishPercent = requestParameter.FinishPercent;
                CurrentWatingEntity.AllowFlag = 1;  // “不同意”或“退回”赋值0，“同意”赋值1。
                CurrentWatingEntity.StepId = "BGTRWFK";
                CurrentWatingEntity.StepName = "办公厅任务反馈";

                SmSystemStepDefinitionEntity nextStep = new SmSystemStepDefinitionEntity() { StepId = "BGTRWFK", StepName = "办公厅任务反馈" };

                // 合并任务的待办。
                SmFlowWaitingEntity newFlowWaiting = SuperviseMissionWorkFlow.GenerateWaitingFlowItemForSpecailStep(CurrentWatingEntity, nextStep);

                newFlowWaiting.Opinion = requestParameter.Opinion;
                newFlowWaiting.OpinionType = requestParameter.OpinionType;
                newFlowWaiting.AllowFlag = 1;

                SmFlowWaitingEntity nextFlowItem = new SmFlowWaitingEntity();
                nextFlowItem.StepId = requestParameter.StepId;
                nextFlowItem.StepName = requestParameter.StepName;

                // flowDeptId不为空时则发送对象为部门，其中flowDeptId和userId只会其中之一符合条件。
                if (!String.IsNullOrEmpty(requestParameter.FlowDeptId)) nextFlowItem.FlowDeptId = requestParameter.FlowDeptId;
                // userId不为空时则发送对象为用户。
                if (!String.IsNullOrEmpty(requestParameter.UserId))
                {
                    nextFlowItem.UserId = requestParameter.UserId;
                    nextFlowItem.UserName = requestParameter.UserName;
                }

                SuperviseMissionWorkFlow.Send(newFlowWaiting, nextFlowItem);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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

        /// <summary>
        /// 主办单位目标反馈发送。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage8(FreeFlowRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.TargetId + requestParameter.StepId + requestParameter.StepName + requestParameter.FlowDeptId + requestParameter.UserId + requestParameter.UserId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 1)更新目标进度。
                IEnumerable<SmFlowWaitingEntity> en = SuperviseMissionBodyBiz.GetSmFlowWaitingList(f => f.SmId == requestParameter.SmId && f.FlowId == requestParameter.FlowId);

                foreach (var item in en)
                {
                    SmTargetEntity targetEntity = new SmTargetEntity();
                    targetEntity.SmId = requestParameter.SmId;
                    targetEntity.TargetId = item.TargetId;
                    targetEntity.TargetPercent = requestParameter.FinishPercent;
                    SuperviseMissionBodyBiz.UpdateSmTargetEntity(targetEntity);
                }
                #endregion

                #region 2)合并年度目标的待办。
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.UserId = CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 1;// “不同意”或“退回”赋值0，“同意”赋值1。
                CurrentWatingEntity.FlowDeptId = CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.StepId = "ZBDWMBFK";
                CurrentWatingEntity.StepName = "主办单位目标反馈";
                CurrentWatingEntity.TargetId = requestParameter.TargetId;

                SmSystemStepDefinitionEntity nextStep = new SmSystemStepDefinitionEntity();
                nextStep.StepId = "ZBDWMBFK";
                nextStep.StepName = "主办单位目标反馈";
                SmFlowWaitingEntity newFlowWaiting = SuperviseMissionWorkFlow.GenerateWaitingFlowItemForSpecailStep(CurrentWatingEntity, nextStep);

                newFlowWaiting.Opinion = requestParameter.Opinion;
                newFlowWaiting.OpinionType = requestParameter.OpinionType;
                newFlowWaiting.AllowFlag = 1;
                #endregion

                #region 3)使用新生成的待办来发送到下一步骤。
                SmFlowWaitingEntity nextFlowItem = new SmFlowWaitingEntity();
                nextFlowItem.StepId = requestParameter.StepId;
                nextFlowItem.StepName = requestParameter.StepName;

                // flowDeptId不为空时则发送对象为部门，其中flowDeptId和userId只会其中之一符合条件。
                if (!String.IsNullOrEmpty(requestParameter.FlowDeptId)) nextFlowItem.FlowDeptId = requestParameter.FlowDeptId;
                // userId不为空时则发送对象为用户。
                if (!String.IsNullOrEmpty(requestParameter.UserId))
                {
                    nextFlowItem.UserId = requestParameter.UserId;
                    nextFlowItem.UserName = requestParameter.UserName;
                }

                SuperviseMissionWorkFlow.Send(newFlowWaiting, nextFlowItem);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
                };
                #endregion
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

        /// <summary>
        /// 责任处室措施反馈发送。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage9(FreeFlowRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.StepId + requestParameter.StepName + requestParameter.FlowDeptId + requestParameter.UserId + requestParameter.Opinion;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 1)更新父措施进度。
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(new SmTargetItemEntity()
                {
                    SmId = requestParameter.SmId,
                    ItemId = requestParameter.ItemId,
                    FinshPercent = requestParameter.FinishPercent
                });
                #endregion

                #region 2)合并子措施的待办。
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.UserId = CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 1;// “不同意”或“退回”赋值0，“同意”赋值1。
                CurrentWatingEntity.FinishPercent = requestParameter.FinishPercent;
                CurrentWatingEntity.StepId = "ZRCSCSFK";
                CurrentWatingEntity.StepName = "责任处室措施反馈";
                CurrentWatingEntity.TargetItemId = requestParameter.ItemId;// 这个ItemId是父措施Id不是子措施Id。
                CurrentWatingEntity.TargetId = requestParameter.TargetId;

                SmSystemStepDefinitionEntity nextStep = new SmSystemStepDefinitionEntity();
                nextStep.StepId = "ZRCSCSFK";
                nextStep.StepName = "责任处室措施反馈";
                SmFlowWaitingEntity newFlowWaiting = SuperviseMissionWorkFlow.GenerateWaitingFlowItemForSpecailStep(CurrentWatingEntity, nextStep);

                newFlowWaiting.Opinion = requestParameter.Opinion;
                newFlowWaiting.OpinionType = requestParameter.OpinionType;
                newFlowWaiting.AllowFlag = 1;
                #endregion

                #region 3)使用新生成的待办来发送到下一步骤。
                SmFlowWaitingEntity nextFlowItem = new SmFlowWaitingEntity();
                nextFlowItem.StepId = requestParameter.StepId;
                nextFlowItem.StepName = requestParameter.StepName;

                // flowDeptId不为空时则发送对象为部门，其中flowDeptId和userId只会其中之一符合条件。
                if (!String.IsNullOrEmpty(requestParameter.FlowDeptId)) nextFlowItem.FlowDeptId = requestParameter.FlowDeptId;
                // userId不为空时则发送对象为用户。
                if (!String.IsNullOrEmpty(requestParameter.UserId))
                {
                    nextFlowItem.UserId = requestParameter.UserId;
                    nextFlowItem.UserName = requestParameter.UserName;
                }

                SuperviseMissionWorkFlow.Send(newFlowWaiting, nextFlowItem);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
                };
                #endregion
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

        /// <summary>
        /// 部门审核/部门审批同意发送。
        /// </summary>
        ///<param name="requestParameter"></param>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage15(FreeFlowRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.ItemId + requestParameter.StepId + requestParameter.StepName + requestParameter.FlowDeptId + requestParameter.UserId + requestParameter.Opinion + requestParameter.FlowId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 发送到下一步骤。
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 1;

                SmFlowWaitingEntity nextFlowItem = new SmFlowWaitingEntity();
                nextFlowItem.StepId = requestParameter.StepId;
                nextFlowItem.StepName = requestParameter.StepName;

                // flowDeptId和userId仅有一个会有值。
                if (!String.IsNullOrEmpty(requestParameter.FlowDeptId)) nextFlowItem.FlowDeptId = requestParameter.FlowDeptId;
                if (!String.IsNullOrEmpty(requestParameter.UserId))
                {
                    nextFlowItem.UserId = requestParameter.UserId;
                    nextFlowItem.UserName = requestParameter.UserName;
                }

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, nextFlowItem);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
                };
                #endregion
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

        /// <summary>
        /// 部门审核/部门审批不同意发送。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DisagreeSendPage15(BackRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.Opinion;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                // 1)不同意退回到上一步。 流程工具有判断 不需要重复判断
                var fw = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == requestParameter.SmId && e.FlowId == requestParameter.FlowId).FirstOrDefault();
                SmFlowFinishEntity previousStep = SuperviseMissionBodyBiz.GetSmFlowFinishPrevEntity(requestParameter.SmId, requestParameter.FlowId);

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.FlowIdPrev = previousStep.FlowId;
                CurrentWatingEntity.UserDeptId = fw.UserDeptId;
                CurrentWatingEntity.UserDeptName = fw.UserDeptName;
                CurrentWatingEntity.UserId = fw.UserId;
                CurrentWatingEntity.UserName = fw.UserName;
                CurrentWatingEntity.UserIdPrev = fw.UserIdPrev;
                CurrentWatingEntity.UserNamePrev = fw.UserNamePrev;
                CurrentWatingEntity.StepId = fw.StepId;
                CurrentWatingEntity.StepName = fw.StepName;
                CurrentWatingEntity.RoleId = fw.RoleId;
                CurrentWatingEntity.RoleName = fw.RoleName;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 0;// “不同意”或“退回”赋值0，“同意”赋值1。
                // 调用SendBack方法  20181201
                SuperviseMissionWorkFlow.SendBack(CurrentWatingEntity, previousStep.StepId);

                //// 2)解析下一步骤。
                //SmFlowWaitingEntity nextFlowItem = new SmFlowWaitingEntity();
                //nextFlowItem.StepId = ff.StepId;
                //nextFlowItem.StepName = ff.StepName;
                //nextFlowItem.UserId = ff.UserId;
                //nextFlowItem.UserName = ff.UserName;
                //nextFlowItem.FlowDeptId = ff.FlowDeptId;
                //nextFlowItem.SmId = ff.SmId;
                //SuperviseMissionWorkFlow.Send(CurrentWatingEntity, nextFlowItem);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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

        #region 领导延期
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendLeaderLateMessage(string itemId, string parentTargetItemId, DateTime lateTime, string stepId, string stepName, string lateReason, string deptId, string deptName, string userId, string userName, List<TargetItemLateRequestEntity> targetItemLateRequestEntitys)
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
                #region Xss攻击校验
                var xxsHtml = deptName + itemId + stepId + stepName + parentTargetItemId + userId + lateReason + deptId + userName + targetItemLateRequestEntitys.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(lateReason))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，延迟原因不能为空！",
                        data = null
                    };
                }
                else if (lateTime == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，申请延期时限不能为空！",
                        data = null
                    };
                }

                //查询措施Id
                var smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
                {
                    ItemId = itemId,
                    ParentTargetItemId = parentTargetItemId == "" ? null : parentTargetItemId
                });

                //根据smId查询sm主表实体
                var smOldMainEntity =
                    SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smTargetItemEntity.SmId });

                //构造TargetItemChangeEntity对象，用于保存到措施变更主表。
                SmTargetItemChangeEntity smTargetItemChangeEntity = new SmTargetItemChangeEntity
                {
                    ItemId = smTargetItemEntity.ItemId,
                    TargetId = smTargetItemEntity.TargetId,
                    ItemName = smTargetItemEntity.ItemName,
                    Reason = lateReason,
                    LateTime = lateTime,
                    ParentTargetItemId = smTargetItemEntity.ParentTargetItemId,
                    SourceSmId = smOldMainEntity.SmId,
                    Status = "0",
                    ChangeType = "YQ"
                };

                smOldMainEntity.SubType = "YQ";
                smOldMainEntity.CreatorId = CurrentUserInfo.Employee_ID;
                smOldMainEntity.CreatorName = CurrentUserInfo.Name;
                smOldMainEntity.CreatorDeptId = CurrentUserInfo.Dept_ID;
                smOldMainEntity.CreatorDeptName = CurrentUserInfo.Dept_Name;
                smOldMainEntity.MissionStatus = "TJ";

                //构造SmFlowWaitingEntity第一条初始数据。
                SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                sfwe.UserId = CurrentUserInfo.Employee_ID;
                sfwe.UserName = CurrentUserInfo.Name;
                sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                sfwe.TargetId = smTargetItemEntity.TargetId;
                sfwe.TargetItemId = smTargetItemEntity.ItemId;
                sfwe.Opinion = "";
                sfwe.OpinionType = "4";
                sfwe.UserIdPrev = "";
                sfwe.UserNamePrev = "";
                sfwe.AllowFlag = 1;
                sfwe.SmType = smOldMainEntity.SmType;

                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //措施
                    sfwe.StepId = "CSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }
                else
                {
                    //子措施
                    sfwe.StepId = "ZCSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }

                //构造第二条流转数据，并发送开始流转。
                SuperviseMissionWorkFlow.SendTargetItemChange(smOldMainEntity, smTargetItemChangeEntity, sfwe, new SmFlowWaitingEntity
                {
                    TargetItemId = itemId,
                    StepId = stepId,
                    StepName = stepName,
                    FlowDeptId = deptId == "" ? null : deptId,
                    UserId = userId == "" ? null : userId,
                    UserName = userName == "" ? null : userName,
                    UserIdPrev = CurrentUserInfo.Employee_ID,
                    TargetId = smTargetItemEntity.TargetId,
                });

                //申请发送出去以后改变SM_TARGET_ITEM表的STATUS字段（0：进行中1：办结2：延迟3：中止4：调整）
                smTargetItemEntity.Status = "2";
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(smTargetItemEntity);

                if (targetItemLateRequestEntitys.Count > 0)
                {
                    foreach (var targetItemLateRequestEntity in targetItemLateRequestEntitys)
                    {
                        SmTargetItemEntity sonTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity { ItemId = targetItemLateRequestEntity.ItemId, ParentTargetItemId = smTargetItemChangeEntity.ItemId });
                        //判断子措施延期时间不为空，而且被改动过
                        if (targetItemLateRequestEntity.LateTime != null && targetItemLateRequestEntity.LateTime != sonTargetItemEntity.DeadLineTime)
                        {
                            SmTargetItemChangeEntity entity = new SmTargetItemChangeEntity
                            {
                                ChangeId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber(),
                                ItemId = sonTargetItemEntity.ItemId,
                                TargetId = sonTargetItemEntity.TargetId,
                                ItemName = sonTargetItemEntity.ItemName,
                                Reason = lateReason,
                                LateTime = targetItemLateRequestEntity.LateTime,
                                ParentTargetItemId = smTargetItemEntity.ItemId,
                                SourceSmId = smOldMainEntity.SmId,
                                Status = "0",
                                ChangeType = "YQ"
                            };

                            SuperviseMissionBodyBiz.InsertSmTargetItemChangeEntity(entity);
                            sonTargetItemEntity.Status = "2";
                            SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(sonTargetItemEntity);
                        }
                    }
                }

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = null,
                    message = "发送延期申请成功"
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

        #region 年度延期
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendLateMessage(string itemId, string parentTargetItemId, DateTime lateTime, string stepId, string stepName, string lateReason, string deptId, string deptName, string userId, string userName, List<TargetItemLateRequestEntity> targetItemLateRequestEntitys)
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

                #region Xss攻击校验
                var xxsHtml = deptName + itemId + stepId + stepName + parentTargetItemId + userId + lateReason + deptId + userName + targetItemLateRequestEntitys.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (lateTime == null ||
                    string.IsNullOrEmpty(lateReason))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，延迟原因不能为空！",
                        data = null
                    };
                }
                else if (lateTime == null)
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，申请延期时限不能为空！",
                        data = null
                    };
                }

                //查询措施Id
                var smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
                {
                    ItemId = itemId,
                    ParentTargetItemId = parentTargetItemId == "" ? null : parentTargetItemId
                });

                //根据smId查询sm主表实体
                var smOldMainEntity =
                    SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smTargetItemEntity.SmId });

                //构造TargetItemChangeEntity对象，用于保存到措施变更主表。
                SmTargetItemChangeEntity smTargetItemChangeEntity = new SmTargetItemChangeEntity
                {
                    ItemId = smTargetItemEntity.ItemId,
                    TargetId = smTargetItemEntity.TargetId,
                    ItemName = smTargetItemEntity.ItemName,
                    Reason = lateReason,
                    LateTime = lateTime,
                    ParentTargetItemId = smTargetItemEntity.ParentTargetItemId,
                    SourceSmId = smOldMainEntity.SmId,
                    Status = "0",
                    ChangeType = "YQ"
                };

                smOldMainEntity.SubType = "YQ";
                smOldMainEntity.CreatorId = CurrentUserInfo.Employee_ID;
                smOldMainEntity.CreatorName = CurrentUserInfo.Name;
                smOldMainEntity.CreatorDeptId = CurrentUserInfo.Dept_ID;
                smOldMainEntity.CreatorDeptName = CurrentUserInfo.Dept_Name;
                smOldMainEntity.MissionStatus = "TJ";

                //构造SmFlowWaitingEntity第一条初始数据。
                SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                sfwe.UserId = CurrentUserInfo.Employee_ID;
                sfwe.UserName = CurrentUserInfo.Name;
                sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                sfwe.TargetId = smTargetItemEntity.TargetId;
                sfwe.TargetItemId = smTargetItemEntity.ItemId;
                sfwe.Opinion = "";
                sfwe.OpinionType = "4";
                sfwe.UserIdPrev = "";
                sfwe.UserNamePrev = "";
                sfwe.AllowFlag = 1;
                sfwe.SmType = smOldMainEntity.SmType;

                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //措施
                    sfwe.StepId = "CSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }
                else
                {
                    //子措施
                    sfwe.StepId = "ZCSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }

                //构造第二条流转数据，并发送开始流转。
                SuperviseMissionWorkFlow.SendTargetItemChange(smOldMainEntity, smTargetItemChangeEntity, sfwe, new SmFlowWaitingEntity
                {
                    TargetItemId = itemId,
                    StepId = stepId,
                    StepName = stepName,
                    FlowDeptId = deptId == "" ? null : deptId,
                    UserId = userId == "" ? null : userId,
                    UserName = userName == "" ? null : userName,
                    UserIdPrev = CurrentUserInfo.Employee_ID,
                    TargetId = smTargetItemEntity.TargetId,
                });

                //申请发送出去以后改变SM_TARGET_ITEM表的STATUS字段（0：进行中1：办结2：延迟3：中止4：调整）
                smTargetItemEntity.Status = "2";
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(smTargetItemEntity);

                if (targetItemLateRequestEntitys.Count > 0)
                {
                    foreach (var targetItemLateRequestEntity in targetItemLateRequestEntitys)
                    {
                        SmTargetItemEntity sonTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity { ItemId = targetItemLateRequestEntity.ItemId, ParentTargetItemId = smTargetItemChangeEntity.ItemId });
                        //判断子措施延期时间不为空，而且被改动过
                        if (targetItemLateRequestEntity.LateTime != null)
                        {
                            SmTargetItemChangeEntity entity = new SmTargetItemChangeEntity
                            {
                                ChangeId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber(),
                                ItemId = sonTargetItemEntity.ItemId,
                                TargetId = sonTargetItemEntity.TargetId,
                                ItemName = sonTargetItemEntity.ItemName,
                                Reason = lateReason,
                                LateTime = targetItemLateRequestEntity.LateTime,
                                ParentTargetItemId = smTargetItemEntity.ItemId,
                                SourceSmId = smOldMainEntity.SmId,
                                Status = "0",
                                ChangeType = "YQ"
                            };

                            SuperviseMissionBodyBiz.InsertSmTargetItemChangeEntity(entity);
                            sonTargetItemEntity.Status = "2";
                            SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(sonTargetItemEntity);
                        }
                    }
                }

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = null,
                    message = "发送延期申请成功"
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

        #region 领导中止

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendLeaderStopMessage(string itemId, string parentTargetItemId, string stepId, string stepName, string stopReason, string deptId, string deptName, string userId, string userName)
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
                #region Xss攻击校验
                var xxsHtml = deptName + itemId + stepId + stepName + parentTargetItemId + userId + deptId + userName + stopReason + deptName;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(stopReason))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，中止原因不能为空！",
                        data = null
                    };
                }

                //如果是措施，需要校验
                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //检查措施下面是否存在其他子措施的变更
                    if (ExistChangeTargetItem(itemId))
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "0",
                            message = "发送失败，该措施下面的子措施正在进行调整/延期变更，无法对该措施进行中止操作！",
                            data = null
                        };
                    }
                }

                //查询措施Id
                var smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
                {
                    ItemId = itemId,
                    ParentTargetItemId = parentTargetItemId == "" ? null : parentTargetItemId
                });

                //根据smId查询sm主表实体
                var smOldMainEntity =
                    SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smTargetItemEntity.SmId });

                //构造TargetItemChangeEntity对象，用于保存到措施变更主表。
                SmTargetItemChangeEntity smTargetItemChangeEntity = new SmTargetItemChangeEntity
                {
                    ItemId = smTargetItemEntity.ItemId,
                    TargetId = smTargetItemEntity.TargetId,
                    ItemName = smTargetItemEntity.ItemName,
                    Reason = stopReason,
                    ParentTargetItemId = smTargetItemEntity.ParentTargetItemId,
                    SourceSmId = smOldMainEntity.SmId,
                    Status = "0",
                    ChangeType = "ZZ"
                };

                smOldMainEntity.SubType = "ZZ";
                smOldMainEntity.CreatorId = CurrentUserInfo.Employee_ID;
                smOldMainEntity.CreatorName = CurrentUserInfo.Name;
                smOldMainEntity.CreatorDeptId = CurrentUserInfo.Dept_ID;
                smOldMainEntity.CreatorDeptName = CurrentUserInfo.Dept_Name;
                smOldMainEntity.MissionStatus = "TJ";

                //构造SmFlowWaitingEntity第一条初始数据。
                SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                sfwe.UserId = CurrentUserInfo.Employee_ID;
                sfwe.UserName = CurrentUserInfo.Name;
                sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                sfwe.TargetId = smTargetItemEntity.TargetId;
                sfwe.TargetItemId = smTargetItemEntity.ItemId;
                sfwe.Opinion = "";
                sfwe.OpinionType = "4";
                sfwe.UserIdPrev = "";
                sfwe.UserNamePrev = "";
                sfwe.AllowFlag = 1;
                sfwe.SmType = smOldMainEntity.SmType;

                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //措施
                    sfwe.StepId = "CSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }
                else
                {
                    //子措施
                    sfwe.StepId = "ZCSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }

                //构造第二条流转数据，并发送开始流转。
                SuperviseMissionWorkFlow.SendTargetItemChange(smOldMainEntity, smTargetItemChangeEntity, sfwe, new SmFlowWaitingEntity
                {
                    TargetItemId = itemId,
                    StepId = stepId,
                    StepName = stepName,
                    FlowDeptId = deptId == "" ? null : deptId,
                    UserId = userId == "" ? null : userId,
                    UserName = userName == "" ? null : userName,
                    UserIdPrev = CurrentUserInfo.Employee_ID,
                    TargetId = smTargetItemEntity.TargetId,
                });

                //申请发送出去以后改变SM_TARGET_ITEM表的STATUS字段（0：进行中1：办结2：延迟3：中止4：调整）
                smTargetItemEntity.Status = "3";
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(smTargetItemEntity);
                //判断是否是措施，若是，措施下面的子措施状态要变为办结
                if (string.IsNullOrEmpty(smTargetItemChangeEntity.ParentTargetItemId))
                {
                    //保存子措施变更并改变子状态
                    SaveSonTargetItemsChangeByZZorBJ(smTargetItemChangeEntity, smTargetItemEntity);
                }

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = null,
                    message = "发送中止申请成功"
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

        #region 年度中止

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendStopMessage(string itemId, string parentTargetItemId, string stepId, string stepName, string stopReason, string deptId, string deptName, string userId, string userName)
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
                #region Xss攻击校验
                var xxsHtml = deptName + itemId + stepId + stepName + parentTargetItemId + userId + deptId + userName + stopReason + deptName;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(stopReason))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，中止原因不能为空！",
                        data = null
                    };
                }

                //如果是措施，需要校验
                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //检查措施下面是否存在其他子措施的变更
                    if (ExistChangeTargetItem(itemId))
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "0",
                            message = "发送失败，该措施下面的子措施正在进行调整/延期变更，无法对该措施进行中止操作！",
                            data = null
                        };
                    }
                }

                //查询措施Id
                var smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
                {
                    ItemId = itemId,
                    ParentTargetItemId = parentTargetItemId == "" ? null : parentTargetItemId
                });

                //根据smId查询sm主表实体
                var smOldMainEntity =
                    SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smTargetItemEntity.SmId });

                //构造TargetItemChangeEntity对象，用于保存到措施变更主表。
                SmTargetItemChangeEntity smTargetItemChangeEntity = new SmTargetItemChangeEntity
                {
                    ItemId = smTargetItemEntity.ItemId,
                    TargetId = smTargetItemEntity.TargetId,
                    ItemName = smTargetItemEntity.ItemName,
                    Reason = stopReason,
                    ParentTargetItemId = smTargetItemEntity.ParentTargetItemId,
                    SourceSmId = smOldMainEntity.SmId,
                    Status = "0",
                    ChangeType = "ZZ"
                };

                smOldMainEntity.SubType = "ZZ";
                smOldMainEntity.CreatorId = CurrentUserInfo.Employee_ID;
                smOldMainEntity.CreatorName = CurrentUserInfo.Name;
                smOldMainEntity.CreatorDeptId = CurrentUserInfo.Dept_ID;
                smOldMainEntity.CreatorDeptName = CurrentUserInfo.Dept_Name;
                smOldMainEntity.MissionStatus = "TJ";

                //构造SmFlowWaitingEntity第一条初始数据。
                SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                sfwe.UserId = CurrentUserInfo.Employee_ID;
                sfwe.UserName = CurrentUserInfo.Name;
                sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                sfwe.TargetId = smTargetItemEntity.TargetId;
                sfwe.TargetItemId = smTargetItemEntity.ItemId;
                sfwe.Opinion = "";
                sfwe.OpinionType = "4";
                sfwe.UserIdPrev = "";
                sfwe.UserNamePrev = "";
                sfwe.AllowFlag = 1;
                sfwe.SmType = smOldMainEntity.SmType;

                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //措施
                    sfwe.StepId = "CSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }
                else
                {
                    //子措施
                    sfwe.StepId = "ZCSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }

                //构造第二条流转数据，并发送开始流转。
                SuperviseMissionWorkFlow.SendTargetItemChange(smOldMainEntity, smTargetItemChangeEntity, sfwe, new SmFlowWaitingEntity
                {
                    TargetItemId = itemId,
                    StepId = stepId,
                    StepName = stepName,
                    FlowDeptId = deptId == "" ? null : deptId,
                    UserId = userId == "" ? null : userId,
                    UserName = userName == "" ? null : userName,
                    UserIdPrev = CurrentUserInfo.Employee_ID,
                    TargetId = smTargetItemEntity.TargetId,
                });

                //申请发送出去以后改变SM_TARGET_ITEM表的STATUS字段（0：进行中1：办结2：延迟3：中止4：调整）
                smTargetItemEntity.Status = "3";
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(smTargetItemEntity);
                //判断是否是措施，若是，措施下面的子措施状态要变为办结
                if (string.IsNullOrEmpty(smTargetItemChangeEntity.ParentTargetItemId))
                {
                    //保存子措施变更并改变子状态
                    SaveSonTargetItemsChangeByZZorBJ(smTargetItemChangeEntity, smTargetItemEntity);
                }

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = null,
                    message = "发送中止申请成功"
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

        private void SaveSonTargetItemsChangeByZZorBJ(SmTargetItemChangeEntity parentSmTargetItemChangeEntity, SmTargetItemEntity smTargetItemEntity)
        {
            List<SmTargetItemEntity> sonTargetItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(new SmTargetItemEntity
            {
                ParentTargetItemId = parentSmTargetItemChangeEntity.ItemId
            });

            foreach (var sonTargetItem in sonTargetItems)
            {
                SmTargetItemChangeEntity smTargetItemChangeEntity = new SmTargetItemChangeEntity
                {
                    ChangeId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber(),
                    ItemId = sonTargetItem.ItemId,
                    TargetId = sonTargetItem.TargetId,
                    ItemName = sonTargetItem.ItemName,
                    Reason = parentSmTargetItemChangeEntity.Reason,
                    ParentTargetItemId = sonTargetItem.ParentTargetItemId,
                    SourceSmId = parentSmTargetItemChangeEntity.SourceSmId,
                    ChangeType = parentSmTargetItemChangeEntity.ChangeType,
                    Status = parentSmTargetItemChangeEntity.Status
                };
                SuperviseMissionBodyBiz.InsertSmTargetItemChangeEntity(smTargetItemChangeEntity);
                ChangeSonTargetItemStatus(sonTargetItem, smTargetItemEntity.Status);
            }
        }

        private void ChangeSonTargetItemStatus(SmTargetItemEntity smTargetItemEntity, string status)
        {
            smTargetItemEntity.Status = status;
            SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(smTargetItemEntity);

        }

        //判断措施下面是否存在被调整/延时的子措施。
        private bool ExistChangeTargetItem(string parentTargetItemId)
        {
            var sonTargetItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(new SmTargetItemEntity
            {
                ParentTargetItemId = parentTargetItemId
            });

            return sonTargetItemList.Exists(n => n.Status.Equals("1") || n.Status.Equals("3"));
        }

        #endregion

        #region 领导调整

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendLeaderAdjustmentMessage(string deptId, string deptName, string userId,
            string userName, string stepId, string stepName, string reason, SmTargetEntity smTargetEntity,
            List<SmTargetItemChangeEntity> smTargetItemChangeEntitys)
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
                #region Xss攻击校验
                var xxsHtml = deptName + stepId + stepName + userId + deptId + userName + reason + smTargetItemChangeEntitys.ToJson() + smTargetEntity.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(reason))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，调整原因不能为空！",
                        data = null
                    };
                }
                else if ((string.IsNullOrEmpty(smTargetEntity.MainDeptId) || string.IsNullOrEmpty(smTargetEntity.MainDeptName)) && string.IsNullOrEmpty(smTargetItemChangeEntitys[0].ParentTargetItemId))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，主办单位不能为空！",
                        data = null
                    };
                }

                //查询措施Id
                var smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
                {
                    ItemId = smTargetItemChangeEntitys[0].ItemId,
                    ParentTargetItemId = smTargetItemChangeEntitys[0].ParentTargetItemId == "" ? null : smTargetItemChangeEntitys[0].ParentTargetItemId
                });

                //根据smId查询sm主表实体
                var smOldMainEntity =
                    SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smTargetItemEntity.SmId });

                //构造TargetItemChangeEntity对象，用于保存到措施变更主表。

                smTargetItemChangeEntitys[0].ItemId = smTargetItemEntity.ItemId;
                smTargetItemChangeEntitys[0].TargetId = smTargetItemEntity.TargetId;
                smTargetItemChangeEntitys[0].ParentTargetItemId = smTargetItemEntity.ParentTargetItemId;
                smTargetItemChangeEntitys[0].SourceSmId = smOldMainEntity.SmId;
                smTargetItemChangeEntitys[0].Status = "0";
                smTargetItemChangeEntitys[0].ChangeType = "TZ";

                smOldMainEntity.SubType = "TZ";
                smOldMainEntity.CreatorId = CurrentUserInfo.Employee_ID;
                smOldMainEntity.CreatorName = CurrentUserInfo.Name;
                smOldMainEntity.CreatorDeptId = CurrentUserInfo.Dept_ID;
                smOldMainEntity.CreatorDeptName = CurrentUserInfo.Dept_Name;
                smOldMainEntity.MissionStatus = "TJ";

                //构造SmFlowWaitingEntity第一条初始数据。
                SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                sfwe.UserId = CurrentUserInfo.Employee_ID;
                sfwe.UserName = CurrentUserInfo.Name;
                sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                sfwe.TargetId = smTargetItemEntity.TargetId;
                sfwe.TargetItemId = smTargetItemEntity.ItemId;
                sfwe.Opinion = "";
                sfwe.OpinionType = "4";
                sfwe.UserIdPrev = "";
                sfwe.UserNamePrev = "";
                sfwe.AllowFlag = 1;
                sfwe.SmType = smOldMainEntity.SmType;

                if (string.IsNullOrEmpty(smTargetItemChangeEntitys[0].ParentTargetItemId))
                {
                    //措施
                    sfwe.StepId = "CSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                    //把目标变更的数据添加到变更表。（措施才有目标变更）
                    if (!string.IsNullOrEmpty(smTargetEntity.MainDeptId) && !string.IsNullOrEmpty(smTargetEntity.MainDeptName))
                    {
                        smTargetItemChangeEntitys[0].MainDeptId = smTargetEntity.MainDeptId;
                        smTargetItemChangeEntitys[0].MainDeptName = smTargetEntity.MainDeptName;
                    }

                    smTargetItemChangeEntitys[0].Reason = reason;
                }
                else
                {
                    //子措施
                    sfwe.StepId = "ZCSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                    smTargetItemChangeEntitys[0].Reason = reason;
                }

                //构造第二条流转数据，并发送开始流转。
                SuperviseMissionWorkFlow.SendTargetItemChange(smOldMainEntity, smTargetItemChangeEntitys[0], sfwe, new SmFlowWaitingEntity
                {
                    TargetItemId = smTargetItemChangeEntitys[0].ItemId,
                    StepId = stepId,
                    StepName = stepName,
                    FlowDeptId = deptId == "" ? null : deptId,
                    UserId = userId == "" ? null : userId,
                    UserName = userName == "" ? null : userName,
                    UserIdPrev = CurrentUserInfo.Employee_ID,
                    TargetId = smTargetItemEntity.TargetId
                });

                //申请发送出去以后改变SM_TARGET_ITEM表的STATUS字段（0：进行中1：办结2：延迟3：中止4：调整）
                smTargetItemEntity.Status = "4";
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(smTargetItemEntity);
                //判断是否是措施，若是，措施下面的子措施状态要变为调整
                if (string.IsNullOrEmpty(smTargetItemChangeEntitys[0].ParentTargetItemId))
                {
                    //保存子措施变更并改变子状态
                    SaveSonTargetItemsChangeByTZ(smTargetItemEntity, smTargetItemChangeEntitys);
                }
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = null,
                    message = "发送调整申请成功"
                };

            }
            catch (Exception ex)
            {

                throw;
            }
        }

        #endregion

        #region 年度调整

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendAdjustmentMessage(string deptId, string deptName, string userId, string userName, string stepId, string stepName, string reason, List<SmTargetItemChangeEntity> smTargetItemChangeEntitys)
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
                #region Xss攻击校验
                var xxsHtml = deptName + stepId + stepName + userId + deptId + userName + reason + smTargetItemChangeEntitys.ToJson();
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(reason))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，调整原因不能为空！",
                        data = null
                    };
                }

                //查询措施Id
                var smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
                {
                    ItemId = smTargetItemChangeEntitys[0].ItemId,
                    ParentTargetItemId = smTargetItemChangeEntitys[0].ParentTargetItemId == "" ? null : smTargetItemChangeEntitys[0].ParentTargetItemId
                });

                //根据smId查询sm主表实体
                var smOldMainEntity =
                    SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smTargetItemEntity.SmId });

                //构造TargetItemChangeEntity对象，用于保存到措施变更主表。

                smTargetItemChangeEntitys[0].ItemId = smTargetItemEntity.ItemId;
                smTargetItemChangeEntitys[0].TargetId = smTargetItemEntity.TargetId;
                smTargetItemChangeEntitys[0].ParentTargetItemId = smTargetItemEntity.ParentTargetItemId;
                smTargetItemChangeEntitys[0].SourceSmId = smOldMainEntity.SmId;
                smTargetItemChangeEntitys[0].Status = "0";
                smTargetItemChangeEntitys[0].ChangeType = "TZ";

                smOldMainEntity.SubType = "TZ";
                smOldMainEntity.CreatorId = CurrentUserInfo.Employee_ID;
                smOldMainEntity.CreatorName = CurrentUserInfo.Name;
                smOldMainEntity.CreatorDeptId = CurrentUserInfo.Dept_ID;
                smOldMainEntity.CreatorDeptName = CurrentUserInfo.Dept_Name;

                //构造SmFlowWaitingEntity第一条初始数据。
                SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                sfwe.UserId = CurrentUserInfo.Employee_ID;
                sfwe.UserName = CurrentUserInfo.Name;
                sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                sfwe.TargetId = smTargetItemEntity.TargetId;
                sfwe.TargetItemId = smTargetItemEntity.ItemId;
                sfwe.Opinion = "";
                sfwe.OpinionType = "4";
                sfwe.UserIdPrev = "";
                sfwe.UserNamePrev = "";
                sfwe.AllowFlag = 1;
                sfwe.SmType = smOldMainEntity.SmType;

                if (string.IsNullOrEmpty(smTargetItemChangeEntitys[0].ParentTargetItemId))
                {
                    //措施
                    sfwe.StepId = "CSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                    smTargetItemChangeEntitys[0].Reason = reason;
                }
                else
                {
                    //子措施
                    sfwe.StepId = "ZCSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                    smTargetItemChangeEntitys[0].Reason = reason;
                }

                //构造第二条流转数据，并发送开始流转。
                SuperviseMissionWorkFlow.SendTargetItemChange(smOldMainEntity, smTargetItemChangeEntitys[0], sfwe, new SmFlowWaitingEntity
                {
                    TargetItemId = smTargetItemChangeEntitys[0].ItemId,
                    StepId = stepId,
                    StepName = stepName,
                    FlowDeptId = deptId == "" ? null : deptId,
                    UserId = userId == "" ? null : userId,
                    UserName = userName == "" ? null : userName,
                    UserIdPrev = CurrentUserInfo.Employee_ID,
                    TargetId = smTargetItemEntity.TargetId
                });

                //申请发送出去以后改变SM_TARGET_ITEM表的STATUS字段（0：进行中1：办结2：延迟3：中止4：调整）
                smTargetItemEntity.Status = "4";
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(smTargetItemEntity);
                //判断是否是措施，若是，措施下面的子措施状态要变为调整
                if (string.IsNullOrEmpty(smTargetItemChangeEntitys[0].ParentTargetItemId))
                {
                    //保存子措施变更并改变子状态
                    SaveSonTargetItemsChangeByTZ(smTargetItemEntity, smTargetItemChangeEntitys);
                }
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = null,
                    message = "发送调整申请成功"
                };

            }
            catch (Exception ex)
            {

                throw;
            }
        }

        private void SaveSonTargetItemsChangeByTZ(SmTargetItemEntity smTargetItemEntity, List<SmTargetItemChangeEntity> smTargetItemChangeEntitys)
        {
            List<SmTargetItemEntity> sonTargetItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityList(new SmTargetItemEntity
            {
                ParentTargetItemId = smTargetItemChangeEntitys[0].ItemId
            });

            foreach (var sonTargetItem in sonTargetItems)
            {
                var smTargetItemChange = smTargetItemChangeEntitys.First(n => n.ItemId.Equals(sonTargetItem.ItemId));

                if (!string.IsNullOrEmpty(smTargetItemChange.ExcutorId) && !string.IsNullOrEmpty(smTargetItemChange.ItemName))
                {
                    SmTargetItemChangeEntity smTargetItemChangeEntity = new SmTargetItemChangeEntity
                    {
                        ChangeId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber(),
                        ItemId = sonTargetItem.ItemId,
                        TargetId = sonTargetItem.TargetId,
                        ItemName = smTargetItemChange.ItemName,
                        Reason = smTargetItemChangeEntitys[0].Reason,
                        ParentTargetItemId = sonTargetItem.ParentTargetItemId,
                        SourceSmId = smTargetItemChangeEntitys[0].SourceSmId,
                        ChangeType = smTargetItemChangeEntitys[0].ChangeType,
                        AssistDeptId = smTargetItemChange.AssistDeptId,
                        AssistDeptName = smTargetItemChange.AssistDeptName,
                        ExcutorId = smTargetItemChange.ExcutorId,
                        ExcutorName = smTargetItemChange.ExcutorName,
                        Status = smTargetItemChangeEntitys[0].Status
                    };
                    SuperviseMissionBodyBiz.InsertSmTargetItemChangeEntity(smTargetItemChangeEntity);
                    ChangeSonTargetItemStatus(sonTargetItem, smTargetItemEntity.Status);
                }
            }

        }

        #endregion

        #region 领导办结

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendLeaderBJMessage(string itemId, string parentTargetItemId, string stepId, string stepName, string bjReason, string deptId, string deptName, string userId, string userName)
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
                #region Xss攻击校验
                var xxsHtml = deptName + stepId + stepName + userId + deptId + userName + bjReason + parentTargetItemId + itemId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(bjReason))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，办结原因不能为空！",
                        data = null
                    };
                }

                //如果是措施，需要校验
                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //检查措施下面是否存在其他子措施的变更
                    if (ExistChangeTargetItem(itemId))
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "0",
                            message = "发送失败，该措施下面的子措施正在进行调整/延期变更，无法对该措施进行办结操作！",
                            data = null
                        };
                    }
                }

                //查询措施Id
                var smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
                {
                    ItemId = itemId,
                    ParentTargetItemId = parentTargetItemId == "" ? null : parentTargetItemId
                });

                //根据smId查询sm主表实体
                var smOldMainEntity =
                    SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smTargetItemEntity.SmId });

                //构造TargetItemChangeEntity对象，用于保存到措施变更主表。
                SmTargetItemChangeEntity smTargetItemChangeEntity = new SmTargetItemChangeEntity
                {
                    ItemId = smTargetItemEntity.ItemId,
                    TargetId = smTargetItemEntity.TargetId,
                    ItemName = smTargetItemEntity.ItemName,
                    Reason = bjReason,
                    ParentTargetItemId = smTargetItemEntity.ParentTargetItemId,
                    SourceSmId = smOldMainEntity.SmId,
                    ChangeType = "BJ",
                    Status = "0"
                };

                smOldMainEntity.SubType = "BJ";
                smOldMainEntity.CreatorId = CurrentUserInfo.Employee_ID;
                smOldMainEntity.CreatorName = CurrentUserInfo.Name;
                smOldMainEntity.CreatorDeptId = CurrentUserInfo.Dept_ID;
                smOldMainEntity.CreatorDeptName = CurrentUserInfo.Dept_Name;
                smOldMainEntity.MissionStatus = "TJ";

                //构造SmFlowWaitingEntity第一条初始数据。
                SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                sfwe.UserId = CurrentUserInfo.Employee_ID;
                sfwe.UserName = CurrentUserInfo.Name;
                sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                sfwe.TargetId = smTargetItemEntity.TargetId;
                sfwe.TargetItemId = smTargetItemEntity.ItemId;
                sfwe.Opinion = "";
                sfwe.OpinionType = "4";
                sfwe.UserIdPrev = "";
                sfwe.UserNamePrev = "";
                sfwe.AllowFlag = 1;
                sfwe.SmType = smOldMainEntity.SmType;
                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //措施
                    sfwe.StepId = "CSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }
                else
                {
                    //子措施
                    sfwe.StepId = "ZCSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }

                //构造第二条流转数据，并发送开始流转。
                SuperviseMissionWorkFlow.SendTargetItemChange(smOldMainEntity, smTargetItemChangeEntity, sfwe, new SmFlowWaitingEntity
                {
                    TargetItemId = itemId,
                    StepId = stepId,
                    StepName = stepName,
                    FlowDeptId = deptId == "" ? null : deptId,
                    UserId = userId == "" ? null : userId,
                    UserName = userName == "" ? null : userName,
                    UserIdPrev = CurrentUserInfo.Employee_ID,
                    TargetId = smTargetItemEntity.TargetId,
                });

                //申请发送出去以后改变SM_TARGET_ITEM表的STATUS字段（0：进行中1：办结2：延迟3：中止4：调整）
                smTargetItemEntity.Status = "1";
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(smTargetItemEntity);
                //判断是否是措施，若是，措施下面的子措施状态要变为办结
                if (string.IsNullOrEmpty(smTargetItemChangeEntity.ParentTargetItemId))
                {
                    //保存子措施变更并改变子状态
                    SaveSonTargetItemsChangeByZZorBJ(smTargetItemChangeEntity, smTargetItemEntity);
                }
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = null,
                    message = "发送办结申请成功"
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

        #region 年度办结

        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendBJMessage(string itemId, string parentTargetItemId, string stepId, string stepName, string bjReason, string deptId, string deptName, string userId, string userName)
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
                #region Xss攻击校验
                var xxsHtml = deptName + stepId + stepName + userId + deptId + userName + bjReason + parentTargetItemId + itemId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                //非空验证。
                if (string.IsNullOrEmpty(bjReason))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "发送失败，办结原因不能为空！",
                        data = null
                    };
                }

                //如果是措施，需要校验
                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //检查措施下面是否存在其他子措施的变更
                    if (ExistChangeTargetItem(itemId))
                    {
                        return new SuperviseMissionResponse()
                        {
                            status = "0",
                            message = "发送失败，该措施下面的子措施正在进行调整/延期变更，无法对该措施进行办结操作！",
                            data = null
                        };
                    }
                }

                //查询措施Id
                var smTargetItemEntity = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
                {
                    ItemId = itemId,
                    ParentTargetItemId = parentTargetItemId == "" ? null : parentTargetItemId
                });

                //根据smId查询sm主表实体
                var smOldMainEntity =
                    SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smTargetItemEntity.SmId });

                //构造TargetItemChangeEntity对象，用于保存到措施变更主表。
                SmTargetItemChangeEntity smTargetItemChangeEntity = new SmTargetItemChangeEntity
                {
                    ItemId = smTargetItemEntity.ItemId,
                    TargetId = smTargetItemEntity.TargetId,
                    ItemName = smTargetItemEntity.ItemName,
                    Reason = bjReason,
                    ParentTargetItemId = smTargetItemEntity.ParentTargetItemId,
                    SourceSmId = smOldMainEntity.SmId,
                    ChangeType = "BJ",
                    Status = "0"
                };

                smOldMainEntity.SubType = "BJ";
                smOldMainEntity.CreatorId = CurrentUserInfo.Employee_ID;
                smOldMainEntity.CreatorName = CurrentUserInfo.Name;
                smOldMainEntity.CreatorDeptId = CurrentUserInfo.Dept_ID;
                smOldMainEntity.CreatorDeptName = CurrentUserInfo.Dept_Name;
                smOldMainEntity.MissionStatus = "TJ";

                //构造SmFlowWaitingEntity第一条初始数据。
                SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                sfwe.UserId = CurrentUserInfo.Employee_ID;
                sfwe.UserName = CurrentUserInfo.Name;
                sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                sfwe.TargetId = smTargetItemEntity.TargetId;
                sfwe.TargetItemId = smTargetItemEntity.ItemId;
                sfwe.Opinion = "";
                sfwe.OpinionType = "4";
                sfwe.UserIdPrev = "";
                sfwe.UserNamePrev = "";
                sfwe.AllowFlag = 1;
                sfwe.SmType = smOldMainEntity.SmType;
                if (string.IsNullOrEmpty(parentTargetItemId))
                {
                    //措施
                    sfwe.StepId = "CSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }
                else
                {
                    //子措施
                    sfwe.StepId = "ZCSZYLNG";
                    sfwe.StepName = "自由流拟稿";
                }

                //构造第二条流转数据，并发送开始流转。
                SuperviseMissionWorkFlow.SendTargetItemChange(smOldMainEntity, smTargetItemChangeEntity, sfwe, new SmFlowWaitingEntity
                {
                    TargetItemId = itemId,
                    StepId = stepId,
                    StepName = stepName,
                    FlowDeptId = deptId == "" ? null : deptId,
                    UserId = userId == "" ? null : userId,
                    UserName = userName == "" ? null : userName,
                    UserIdPrev = CurrentUserInfo.Employee_ID,
                    TargetId = smTargetItemEntity.TargetId
                });

                //申请发送出去以后改变SM_TARGET_ITEM表的STATUS字段（0：进行中1：办结2：延迟3：中止4：调整）
                smTargetItemEntity.Status = "1";
                SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(smTargetItemEntity);
                //判断是否是措施，若是，措施下面的子措施状态要变为办结
                if (string.IsNullOrEmpty(smTargetItemChangeEntity.ParentTargetItemId))
                {
                    //保存子措施变更并改变子状态
                    SaveSonTargetItemsChangeByZZorBJ(smTargetItemChangeEntity, smTargetItemEntity);
                }
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = null,
                    message = "发送办结申请成功"
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

        #region 变更审核相关代码

        /// <summary>
        /// 变更审核同意->确定。
        /// </summary>
        /// <param name="smId">任务Id。</param>
        /// <param name="flowId">流程Id。</param>
        /// <param name="stepId">步骤Id。</param>
        /// <param name="stepName">步骤名称。</param>
        /// <param name="flowDeptId">流程部门Id。</param>
        /// <param name="userId">用户Id。</param>
        /// <param name="opinion">意见。</param>
        /// <param name="deptName">流程部门名。</param>
        /// <param name="userName">用户名。</param>
        /// <returns>返回响应状态。</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendChangeAudit(string smId, string flowId, string stepId, string stepName, string flowDeptId, string userId, string opinion, string deptName, string userName, string opinionType)
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
                #region Xss攻击校验
                var xxsHtml = deptName + stepId + stepName + userId + userName + flowDeptId + opinion + stepName + flowId + smId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                if (string.IsNullOrEmpty(opinion))
                {
                    opinion = "同意";
                }

                //判断stepId如果是js，那么就应该表示用户同意变更，调用改变措施数据的方法。
                if (stepId.ToLower().Equals("js"))
                {
                    ChangeTargetItem(smId);
                }

                // 1)发送到下一步骤。
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = smId;
                int tempFlowId = 0;
                int.TryParse(flowId, out tempFlowId);
                CurrentWatingEntity.FlowId = tempFlowId;

                CurrentWatingEntity.Opinion = opinion;
                CurrentWatingEntity.OpinionType = opinionType;
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FlowDeptId = CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.SmId = smId;

                SmFlowWaitingEntity nextFlowItem = new SmFlowWaitingEntity();
                nextFlowItem.StepId = stepId;
                nextFlowItem.StepName = stepName;
                if (!String.IsNullOrEmpty(flowDeptId)) nextFlowItem.FlowDeptId = flowDeptId;
                if (!String.IsNullOrEmpty(userId)) nextFlowItem.UserId = userId;
                if (!String.IsNullOrEmpty(userName)) nextFlowItem.UserName = userName;

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, nextFlowItem);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "发送成功。"
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

        private void ChangeTargetItem(string smId)
        {
            var smChangeEntity = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntity(new SmTargetItemChangeEntity { ChangeId = smId });
            var smChangeEntityList = new List<SmTargetItemChangeEntity>();
            //如果是父措施，就把其下得子措施也加进去一起变更。
            if (smChangeEntity.ParentTargetItemId == null)
            {
                smChangeEntityList = SuperviseMissionBodyBiz.GetSmTargetItemChangeEntityList(new SmTargetItemChangeEntity { ParentTargetItemId = smChangeEntity.ItemId });
            }
            smChangeEntityList.Add(smChangeEntity);
            //循环更新措施/子措施
            foreach (var entity in smChangeEntityList)
            {
                //延期
                if (entity.ChangeType.Equals("YQ"))
                {
                    if (!SuperviseMissionBodyBiz.ExistSmFlowWaitingEntity(entity.ChangeId) || entity.ChangeId.Equals(smId))
                    {
                        UpdateTargetItemByYQ(entity);
                    }
                }
                //中止
                else if (entity.ChangeType.Equals("ZZ"))
                {
                    UpdateTargetItemByZZOrBJ(entity);
                }
                //办结
                else if (entity.ChangeType.Equals("BJ"))
                {
                    UpdateTargetItemByZZOrBJ(entity);
                }
                //调整
                else
                {
                    if (!SuperviseMissionBodyBiz.ExistSmFlowWaitingEntity(entity.ChangeId) || entity.ChangeId.Equals(smId))
                    {
                        UpdateTargetItemByTZ(entity);
                    }
                }
            }
        }

        private void UpdateTargetItemByZZOrBJ(SmTargetItemChangeEntity smChangeEntity)
        {
            SmTargetItemEntity oldTargetItem = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
            {
                ItemId = smChangeEntity.ItemId,
                ParentTargetItemId = smChangeEntity.ParentTargetItemId
            });

            SaveChangeTargetItemHistory(oldTargetItem, smChangeEntity);
            smChangeEntity.Status = "1";//结束变更
            SuperviseMissionBodyBiz.UpdateSmTargetItemChangeEntity(smChangeEntity);
        }

        private void UpdateTargetItemByYQ(SmTargetItemChangeEntity smChangeEntity)
        {
            SmTargetItemEntity oldTargetItem = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
            {
                ItemId = smChangeEntity.ItemId,
                ParentTargetItemId = smChangeEntity.ParentTargetItemId
            });

            //先保存措施历史记录。
            SaveChangeTargetItemHistory(oldTargetItem, smChangeEntity);
            //修改措施的完成时限。
            if (smChangeEntity.LateTime != null)
            {
                oldTargetItem.DeadLineTime = smChangeEntity.LateTime;
            }

            //措施的状态改为进行中。
            oldTargetItem.Status = "0";
            SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(oldTargetItem);
            smChangeEntity.Status = "1";//结束变更
            SuperviseMissionBodyBiz.UpdateSmTargetItemChangeEntity(smChangeEntity);
        }

        private void UpdateTargetItemByTZ(SmTargetItemChangeEntity smChangeEntity)
        {
            SmTargetItemEntity oldTargetItem = SuperviseMissionBodyBiz.GetSmTargetItemEntity(new SmTargetItemEntity
            {
                ItemId = smChangeEntity.ItemId,
                ParentTargetItemId = smChangeEntity.ParentTargetItemId
            });
            //先保存措施历史记录。
            SaveChangeTargetItemHistory(oldTargetItem, smChangeEntity);
            //添加修改措施的调整内容。
            if (oldTargetItem.ParentTargetItemId == null)
            {
                oldTargetItem = ChangeParentTargetItemByTZ(oldTargetItem, smChangeEntity);
            }
            else
            {
                oldTargetItem = ChangeSonTargetItemByTZ(oldTargetItem, smChangeEntity);
            }

            //措施的状态改为进行中。
            oldTargetItem.Status = "0";
            SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(oldTargetItem);
            smChangeEntity.Status = "1";//结束变更
            SuperviseMissionBodyBiz.UpdateSmTargetItemChangeEntity(smChangeEntity);
        }

        private SmTargetItemEntity ChangeSonTargetItemByTZ(SmTargetItemEntity oldTargetItem, SmTargetItemChangeEntity smChangeEntity)
        {
            if (!string.IsNullOrEmpty(smChangeEntity.AssistDeptName) && !string.IsNullOrEmpty(smChangeEntity.AssistDeptId) && !oldTargetItem.AssistDeptId.Equals(smChangeEntity.AssistDeptId))
            {
                oldTargetItem.AssistDeptName = smChangeEntity.AssistDeptName;
                oldTargetItem.AssistDeptId = smChangeEntity.AssistDeptId;
            }

            if (!string.IsNullOrEmpty(smChangeEntity.ItemName) && !oldTargetItem.ItemName.Equals(smChangeEntity.ItemName))
            {
                oldTargetItem.ItemName = smChangeEntity.ItemName;
            }

            if (!string.IsNullOrEmpty(smChangeEntity.ExcutorId) && !string.IsNullOrEmpty(smChangeEntity.ExcutorName) && !oldTargetItem.ExcutorId.Equals(smChangeEntity.ExcutorId))
            {
                oldTargetItem.ExcutorId = smChangeEntity.ExcutorId;
                oldTargetItem.ExcutorName = smChangeEntity.ExcutorName;
                SuperviseMissionBodyBiz.UpdateTargetItemExcutor(oldTargetItem.ItemId, smChangeEntity.ExcutorId, smChangeEntity.ExcutorName, smChangeEntity.ChangeId);
            }

            return oldTargetItem;
        }

        private SmTargetItemEntity ChangeParentTargetItemByTZ(SmTargetItemEntity oldTargetItem, SmTargetItemChangeEntity smChangeEntity)
        {
            var smMainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smChangeEntity.SourceSmId });

            //if (smMainEntity.SmType == "ND")
            //{
            //    //如果是年度的变更调整，会调整目标的主办单位
            //    SaveTargetChangeByTZ(oldTargetItem, smChangeEntity);
            //}
            //else if (smMainEntity.SmType == "LD")
            if (smMainEntity.SmType == "LD")
            {
                //如果是领导的变更调整，会调整主表的主办单位
                SaveSmMainChangeByTZ(oldTargetItem, smChangeEntity, smMainEntity);
            }

            if (!string.IsNullOrEmpty(smChangeEntity.AssistDeptName) && !string.IsNullOrEmpty(smChangeEntity.AssistDeptId) && !oldTargetItem.AssistDeptId.Equals(smChangeEntity.AssistDeptId))
            {
                oldTargetItem.AssistDeptName = smChangeEntity.AssistDeptName;
                oldTargetItem.AssistDeptId = smChangeEntity.AssistDeptId;
            }

            if (!string.IsNullOrEmpty(smChangeEntity.ItemName) && !oldTargetItem.ItemName.Equals(smChangeEntity.ItemName))
            {
                oldTargetItem.ItemName = smChangeEntity.ItemName;
            }

            if (!string.IsNullOrEmpty(smChangeEntity.DutyDeptId) && !string.IsNullOrEmpty(smChangeEntity.DutyDeptName) && !oldTargetItem.DutyDeptId.Equals(smChangeEntity.DutyDeptId))
            {
                oldTargetItem.DutyDeptName = smChangeEntity.DutyDeptName;
                oldTargetItem.DutyDeptId = smChangeEntity.DutyDeptId;
                //更改责任处室会改变流程，所以需要调用一下改变流程的接口。
                SuperviseMissionBodyBiz.UpdateTargetItemDutyDept(oldTargetItem.ItemId, smChangeEntity.DutyDeptId, smChangeEntity.DutyDeptName, smChangeEntity.ChangeId);
            }

            return oldTargetItem;
        }

        //private void SaveTargetChangeByTZ(SmTargetItemEntity oldTargetItem, SmTargetItemChangeEntity smChangeEntity)
        //{
        //    SmTargetEntity smTargetEntity =
        //        SuperviseMissionBodyBiz.GetSmTargetEntity(new SmTargetEntity { TargetId = oldTargetItem.TargetId });
        //    if (!string.IsNullOrEmpty(smChangeEntity.MainDeptId) && !string.IsNullOrEmpty(smChangeEntity.MainDeptName))
        //    {
        //        smTargetEntity.MainDeptId = smChangeEntity.MainDeptId;
        //        smTargetEntity.MainDeptName = smChangeEntity.MainDeptName;
        //    }

        //    if (!string.IsNullOrEmpty(smChangeEntity.TargetName))
        //    {
        //        smTargetEntity.TargetName = smChangeEntity.TargetName;
        //    }

        //    SuperviseMissionBodyBiz.UpdateSmTargetEntity(smTargetEntity);
        //}

        private void SaveSmMainChangeByTZ(SmTargetItemEntity oldTargetItem, SmTargetItemChangeEntity smChangeEntity, SmMainEntity smMainEntity)
        {
            if (!string.IsNullOrEmpty(smChangeEntity.MainDeptId) && !string.IsNullOrEmpty(smChangeEntity.MainDeptName))
            {
                //修改领导子表的主办单位和smmain表的主办单位
                SaveSmLeaderMeetingMissionChangeByTZ(smChangeEntity, smMainEntity);
            }
        }

        private void SaveSmLeaderMeetingMissionChangeByTZ(SmTargetItemChangeEntity smChangeEntity, SmMainEntity smMainEntity)
        {
            var smLeaderMeetingMissionList = SuperviseMissionBodyBiz.GetLeaderMeetingMissionList(new SmLeaderMeetingMissionEntity
            {
                SmId = smMainEntity.SmId
            });
            //如果领导子表存在这个主办单位，提示用户主办单位已被占用
            if (SuperviseMissionBodyBiz.ExistLeaderMeetingMissionEntityByTZ(smChangeEntity.SourceSmId, smChangeEntity.MainDeptId, smChangeEntity.TargetId))
            {
                throw new Exception("变更失败，表单" + smMainEntity.SmId + "已存在主办单位为" + smChangeEntity.MainDeptName + "的流程，请用户重新选择。");
            }
            else
            {
                var smLeaderMeetingMission = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity
                {
                    LmmId = smChangeEntity.TargetId
                });
                List<string> mainDeptIdList = smMainEntity.MainDeptId.Split(';').ToList();
                List<string> mainDeptNameList = smMainEntity.MainDeptName.Split(';').ToList();
                var oldDeptId = smLeaderMeetingMission.DeptId;
                var oldDeptName = smLeaderMeetingMission.DeptName;
                smLeaderMeetingMission.DeptId = smChangeEntity.MainDeptId;
                smLeaderMeetingMission.DeptName = smChangeEntity.MainDeptName;
                SuperviseMissionBodyBiz.UpdateLeaderMeetingMissionEntity(smLeaderMeetingMission);
                mainDeptIdList.RemoveAll(n => n.Equals(oldDeptId));
                mainDeptNameList.RemoveAll(n => n.Equals(oldDeptName));
                mainDeptIdList.Add(smChangeEntity.MainDeptId);
                mainDeptNameList.Add(smChangeEntity.MainDeptName);
                smMainEntity.MainDeptId = GetDeptString(mainDeptIdList);
                smMainEntity.MainDeptName = GetDeptString(mainDeptNameList);
                SuperviseMissionBodyBiz.UpdateSmMainEntity(smMainEntity);
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

        private SmTargetEntity GetTargetById(string targetId)
        {
            SmTargetEntity entity = SuperviseMissionBodyBiz.GetSmTargetEntity(new SmTargetEntity { TargetId = targetId });
            return entity;
        }

        private SmLeaderMeetingMissionEntity GetSmLeaderMeetingMissionEntityById(string targetId)
        {
            SmLeaderMeetingMissionEntity entity = SuperviseMissionBodyBiz.GetLeaderMeetingMissionEntity(new SmLeaderMeetingMissionEntity { LmmId = targetId });
            return entity;
        }

        private string GetSmTypeById(string smId)
        {
            SmMainEntity entity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smId });
            return entity.SmType;
        }

        private void SaveChangeTargetItemHistory(SmTargetItemEntity smTargetItemEntity, SmTargetItemChangeEntity smChangeEntity)
        {
            //生成historyId
            var historyId = SuperviseMissionWorkFlow.GetSuperviseMissionSequenceNumber();
            var smtype = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity { SmId = smTargetItemEntity.SmId })
                .SmType;

            var targetName = string.Empty;
            var mainDeptName = string.Empty;
            var mainDeptId = string.Empty;
            if (smtype.Equals("LD"))
            {
                var target = GetSmLeaderMeetingMissionEntityById(smTargetItemEntity.TargetId);
                if (target != null)
                {
                    mainDeptName = target.DeptName;
                    mainDeptId = target.DeptId;
                }
            }
            else
            {
                var target = GetTargetById(smTargetItemEntity.TargetId);
                if (target != null)
                {
                    targetName = target.TargetName;
                    mainDeptName = target.MainDeptName;
                    mainDeptId = target.MainDeptId;
                }
            }
            //赋值保存
            var changeTargetItemHistoryEntity = new SmTargetItemChangeHistoryEntity
            {
                HistoryId = historyId,
                TargetId = smTargetItemEntity.TargetId,
                TargetName = targetName,
                ItemId = smTargetItemEntity.ItemId,
                ItemName = smTargetItemEntity.ItemName,
                SmId = smTargetItemEntity.SmId,
                ChangeId = smChangeEntity.ChangeId,
                AssistDeptId = smTargetItemEntity.AssistDeptId,
                AssistDeptName = smTargetItemEntity.AssistDeptName,
                DutyDeptId = smTargetItemEntity.DutyDeptId,
                DutyDeptName = smTargetItemEntity.DutyDeptName,
                DeadLineTime = smTargetItemEntity.DeadLineTime,
                ExcutorId = smTargetItemEntity.ExcutorId,
                ExcutorName = smTargetItemEntity.ExcutorName,
                SmType = GetSmTypeById(smTargetItemEntity.SmId),
                SubType = smChangeEntity.ChangeType,
                Reason = smTargetItemEntity.Reason,
                ParentTargetItemId = smTargetItemEntity.ParentTargetItemId,
                CreateTime = smTargetItemEntity.CreateTime,
                MainDeptName = mainDeptName,
                MainDeptId = mainDeptId
            };

            SuperviseMissionBodyBiz.InsertSmTargetItemChangeHistoryEntity(changeTargetItemHistoryEntity);
        }

        #endregion

        #region 判断是不是所有主办单位均已到达BGTMBQR步骤。
        /// <summary>
        /// 判断是不是所有主办单位均已到达BGTMBQR步骤。
        /// </summary>
        /// <param name="smId">任务Id。</param>
        /// <returns>返回响应状态。</returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse IsAllPass(string smId)
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

                // 1)获取待办流程涉及步骤为BGTMBQR的部门
                var source = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == smId && e.StepId == "BGTMBQR");
                var mainEntity = SuperviseMissionBodyBiz.GetSmMainEntity(new SmMainEntity() { SmId = smId.Trim() });
                int zbdwCounter = mainEntity.MainDeptId.Split(';').Length;// 获取主办单位数量。
                bool isPassed = true;// 默认只有1个主办单位。

                // 仅判断有2个(含)以上的主办单位。
                if (source != null && source.Any() && zbdwCounter > 1)
                {
                    // 去重。
                    var temp = source.GroupBy(e => new { e.FlowDeptIdPrev, e.StepId });
                    // 2)待办表的主办单位数量与主表的主办单位数量相同时说明全部到达BGTMBQR步骤，反之还有未到达BGTMBQR步骤的主办单位。
                    if (temp.Count() != zbdwCounter)
                    {
                        isPassed = false;
                    }
                }

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
                    status = "0",
                    message = ex.Message
                };
            }
        }
        #endregion

        #region page1。
        /// <summary>
        /// 撤回。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse RollBack(BaseRequestParameter requestParameter)
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

                SuperviseMissionWorkFlow.RollBack(requestParameter.SmId, requestParameter.FlowId);
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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

        #region page16。
        /// <summary>
        /// 继续分解发送。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage16(BaseRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                // 1)获取当前用户的部门角色。
                IEnumerable<SmBasicDataDeptRoleDefinitionEntity> roles = SMBasicDataBiz.GetSuperviseMissionDeptRoleEntityList(
                    new SmBasicDataDeptRoleDefinitionEntity
                    {
                        MemberId = CurrentUserInfo.Employee_ID,
                        RoleId = "MS"
                    }
                );

                if (roles == null || roles.Count() == 0) throw new InvalidOperationException("您没有权限操作。");

                //这三个参数需要一一对应 数量和格式上都必须保持一致
                string flowDeptIds = "";  // 用于拼接流程部门Id。
                string targetIds = "";    // 用于拼接目标Id。
                string targetItemIds = "";// 用于拼接措施Id。

                // 2)获取目标。
                var targets = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(requestParameter.SmId);
                foreach (SmTargetEntity target in targets)
                {
                    // 3)判断当前用户是否拥有该主办单位的权限。
                    if (null != roles.FirstOrDefault(e => e.DeptId == target.MainDeptId))
                    {
                        //根据目标id获取所有措施（不包含子措施）
                        var targetItems = SuperviseMissionBodyBiz.GetSmTargetItemEntityListByTargetId(target.TargetId, false);
                        //循环操作子措施 构造相应的发送字段
                        foreach (var item in targetItems)
                        {
                            if (string.IsNullOrEmpty(targetIds)) targetIds = target.TargetId;
                            else targetIds += ";" + target.TargetId;

                            if (string.IsNullOrEmpty(flowDeptIds)) flowDeptIds = item.DutyDeptId;
                            else flowDeptIds += ";" + item.DutyDeptId;

                            if (string.IsNullOrEmpty(targetItemIds)) targetItemIds = item.ItemId;
                            else targetItemIds += ";" + item.ItemId;
                        }
                    }
                }

                if (String.IsNullOrEmpty(flowDeptIds)) throw new InvalidOperationException("您没有权限操作。");

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = "";
                CurrentWatingEntity.OpinionType = "4";//这个意见类型最后要传入
                CurrentWatingEntity.AllowFlag = 1;

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, new SmFlowWaitingEntity()
                {
                    SmId = requestParameter.SmId,
                    StepId = "ZRCSFJZCS",
                    StepName = "责任处室分解子措施",
                    FlowDeptId = flowDeptIds,
                    TargetItemId = targetItemIds,
                    TargetId = targetIds
                });

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "操作成功"
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

        #region page17。
        /// <summary>
        /// 责任单位措施反馈保存完成进度和最新反馈。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SavePage17(SavePercentRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.ItemId + requestParameter.Opinion;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 参数合法性检查
                #endregion


                //1)如果是发送是保存才更新措施表的完成进度，否则只需更新待办的完成进度。
                if (requestParameter.IsSendSave)
                {
                    SmTargetItemEntity itemEntity = new SmTargetItemEntity();
                    itemEntity.ItemId = requestParameter.ItemId;
                    itemEntity.FinshPercent = requestParameter.FinishPercent;
                    SuperviseMissionBodyBiz.UpdateSmTargetItemEntity(itemEntity);
                }

                //2)更新最新反馈。
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FinishPercent = requestParameter.FinishPercent;
                SuperviseMissionWorkFlow.SaveFlowItem(CurrentWatingEntity);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "保存成功"
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

        /// <summary>
        /// 责任单位措施反馈发送。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage17(FreeFlowRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.ItemId + requestParameter.FlowId + requestParameter.StepId + requestParameter.StepName + requestParameter.FlowDeptId + requestParameter.UserId + requestParameter.TargetId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 参数合法性检查

                #endregion

                // 1)发送到下一步。
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.UserId = CurrentUserInfo.Employee_ID;
                CurrentWatingEntity.UserName = CurrentUserInfo.Name;
                CurrentWatingEntity.UserDeptId = CurrentUserInfo.Dept_ID;
                CurrentWatingEntity.UserDeptName = CurrentUserInfo.Dept_Name;
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                // 如果需要发送前生成一条待办，那么当前步骤的以下属性为必填项。
                CurrentWatingEntity.StepId = "ZRCSCSTJ";
                CurrentWatingEntity.StepName = "责任处室措施推进";
                CurrentWatingEntity.TargetItemId = requestParameter.ItemId; // 这个ItemId是父措施Id，不是子措施Id。
                CurrentWatingEntity.TargetId = requestParameter.TargetId;

                // 发送前生成一条待办。
                SmSystemStepDefinitionEntity nextStep = new SmSystemStepDefinitionEntity();
                nextStep.StepId = "ZRDWCSFK";// 要保留待办就是生成一条新的“责任单位措施反馈”步骤。
                nextStep.StepName = "责任单位措施反馈";
                SmFlowWaitingEntity newCurrentFlowWaiting = SuperviseMissionWorkFlow.GenerateWaitingFlowItemForSpecailStep(CurrentWatingEntity, nextStep);
                newCurrentFlowWaiting.AllowFlag = 1;

                SmFlowWaitingEntity nextFlowItem = new SmFlowWaitingEntity();
                nextFlowItem.StepId = requestParameter.StepId;
                nextFlowItem.StepName = requestParameter.StepName;
                if (!String.IsNullOrEmpty(requestParameter.UserId))
                {
                    nextFlowItem.UserId = requestParameter.UserId;
                    nextFlowItem.UserName = requestParameter.UserName;
                }

                if (!String.IsNullOrEmpty(requestParameter.FlowDeptId)) nextFlowItem.FlowDeptId = requestParameter.FlowDeptId;
                //以新的待办发送
                SuperviseMissionWorkFlow.Send(newCurrentFlowWaiting, nextFlowItem);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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

        #region page18。
        /// <summary>
        /// 秘书处理发送。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage18(FreeFlowRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.ItemId + requestParameter.StepId + requestParameter.StepName + requestParameter.FlowDeptId + requestParameter.UserId + requestParameter.Opinion + requestParameter.FlowId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion
                // 1)发送到下一步骤。
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 1;
                CurrentWatingEntity.FlowDeptId = CurrentUserInfo.Dept_ID;

                SmFlowWaitingEntity nextFlowItem = new SmFlowWaitingEntity();
                nextFlowItem.StepId = requestParameter.StepId;
                nextFlowItem.StepName = requestParameter.StepName;
                // FlowDeptId和UserId仅有一个会符合条件。
                if (!String.IsNullOrEmpty(requestParameter.FlowDeptId)) nextFlowItem.FlowDeptId = requestParameter.FlowDeptId;
                if (!String.IsNullOrEmpty(requestParameter.UserId))
                {
                    nextFlowItem.UserId = requestParameter.UserId;
                    nextFlowItem.UserName = requestParameter.UserName;
                }

                if (requestParameter.StepId == "ZRCSCSFK")
                {
                    // 如果是[秘书处理]步骤发给[责任处室措施反馈]需要解合并。
                    SuperviseMissionWorkFlow.SendBack(CurrentWatingEntity, "ZRCSCSFK");
                }
                else if (requestParameter.StepId == "BGTRWFK")
                {
                    // 如果是[秘书处理]步骤发给[办公厅任务反馈]需要解合并。
                    SuperviseMissionWorkFlow.SendBack(CurrentWatingEntity, "BGTRWFK");
                }
                else
                {
                    SuperviseMissionWorkFlow.Send(CurrentWatingEntity, nextFlowItem);
                }

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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

        #region page19。
        /// <summary>
        /// 公司领导审核/公司领导审批同意发送。
        /// </summary>
        ///<param name="requestParameter"></param>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SendPage19(FreeFlowRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.ItemId + requestParameter.StepId + requestParameter.StepName + requestParameter.FlowDeptId + requestParameter.UserId + requestParameter.Opinion + requestParameter.FlowId;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                #region 发送到下一步骤。
                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 1;

                SmFlowWaitingEntity nextFlowItem = new SmFlowWaitingEntity();
                nextFlowItem.StepId = requestParameter.StepId;
                nextFlowItem.StepName = requestParameter.StepName;

                // flowDeptId和userId仅有一个会有值。
                if (!String.IsNullOrEmpty(requestParameter.FlowDeptId)) nextFlowItem.FlowDeptId = requestParameter.FlowDeptId;
                if (!String.IsNullOrEmpty(requestParameter.UserId))
                {
                    nextFlowItem.UserId = requestParameter.UserId;
                    nextFlowItem.UserName = requestParameter.UserName;
                }

                SuperviseMissionWorkFlow.Send(CurrentWatingEntity, nextFlowItem);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
                };
                #endregion
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

        /// <summary>
        /// 公司领导审核/公司领导审批不同意发送。
        /// </summary>
        /// <param name="requestParameter"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse DisagreeSendPage19(BackRequestParameter requestParameter)
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
                #region Xss攻击校验
                var xxsHtml = requestParameter.SmId + requestParameter.Opinion;
                if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(xxsHtml))
                {
                    return new SuperviseMissionResponse()
                    {
                        status = "0",
                        message = "您提交的Post数据有恶意字符。"
                    };
                }
                #endregion

                // 1)不同意退回到上一步。 流程工具有判断 不需要重复判断
                var fw = SuperviseMissionBodyBiz.GetSmFlowWaitingList(e => e.SmId == requestParameter.SmId && e.FlowId == requestParameter.FlowId).FirstOrDefault();
                SmFlowFinishEntity previousStep = SuperviseMissionBodyBiz.GetSmFlowFinishPrevEntity(requestParameter.SmId, requestParameter.FlowId);

                SmFlowWaitingEntity CurrentWatingEntity = new SmFlowWaitingEntity();
                CurrentWatingEntity.SmId = requestParameter.SmId;
                CurrentWatingEntity.FlowId = requestParameter.FlowId;
                CurrentWatingEntity.FlowIdPrev = previousStep.FlowId;
                CurrentWatingEntity.UserDeptId = fw.UserDeptId;
                CurrentWatingEntity.UserDeptName = fw.UserDeptName;
                CurrentWatingEntity.UserId = fw.UserId;
                CurrentWatingEntity.UserName = fw.UserName;
                CurrentWatingEntity.UserIdPrev = fw.UserIdPrev;
                CurrentWatingEntity.UserNamePrev = fw.UserNamePrev;
                CurrentWatingEntity.StepId = fw.StepId;
                CurrentWatingEntity.StepName = fw.StepName;
                CurrentWatingEntity.RoleId = fw.RoleId;
                CurrentWatingEntity.RoleName = fw.RoleName;
                CurrentWatingEntity.Opinion = requestParameter.Opinion;
                CurrentWatingEntity.OpinionType = requestParameter.OpinionType;
                CurrentWatingEntity.AllowFlag = 0;// “不同意”或“退回”赋值0，“同意”赋值1。
                // 调用SendBack方法  20181201
                SuperviseMissionWorkFlow.SendBack(CurrentWatingEntity, previousStep.StepId);

                return new SuperviseMissionResponse()
                {
                    status = "1",
                    message = "成功"
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

        #region Excel导入
        [WebMethod(EnableSession = true)]
        public SuperviseMissionResponse SuperviseMissionImport()
        {
            //获取文件
            var files = System.Web.HttpContext.Current.Request.Files;
            if (files.Count == 0)
            {
                return new SuperviseMissionResponse
                {
                    status = "0",
                    data = "",
                    message = "请选择需要导入的模板。"
                };
            }

            try
            {
                var loopFile = files[0];
                var excelSmMainList = SuperviseMissionExcelImport.SuperviseMissionImportFromExcel(loopFile.InputStream, "Sheet1", 2, true);
                var list = GetSuperviseMissionExcelImportResponseEntityList(excelSmMainList);
                return new SuperviseMissionResponse()
                {
                    status = "1",
                    data = JsonHelper.ToJson(list),
                    message = "导入成功。"
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

        private List<SuperviseMissionExcelImportResponseEntity> SetSnCode(List<SuperviseMissionExcelImportResponseEntity> list)
        {
            Dictionary<string, int> snNumberList = new Dictionary<string, int>();
            foreach (var entity in list)
            {
                var key = entity.SnDeptId + entity.SmMainEntity.SpNumberYear + entity.SmMainEntity.SpNumberName;
                if (snNumberList.ContainsKey(key))
                {
                    //导入数据有重复督查字号
                    snNumberList[key]++;
                    entity.SnCode = (GetSnCode(entity.SmMainEntity.SpNumberName, entity.SmMainEntity.SpNumberYear,
                        entity.SnDeptId) + snNumberList[key]).ToString();
                }
                else
                {
                    snNumberList.Add(key, 1);
                    entity.SnCode = (GetSnCode(entity.SmMainEntity.SpNumberName, entity.SmMainEntity.SpNumberYear,
                                         entity.SnDeptId) + 1).ToString();
                }
            }

            return list;
        }

        private int? GetSnCode(string name, string year, string deptId)
        {
            List<string> deptIds = new List<string>();
            deptIds.Add(deptId);
            SmBasicDataSuperviseNumberEntity condition = new SmBasicDataSuperviseNumberEntity
            {
                Name = name,
                Year = int.Parse(year)
            };
            int? intCode = SMBasicDataBiz.GetSuperviseNumberEntityList(condition, deptIds).OrderByDescending(n => n.Year).Max(n => n.Code);
            return intCode;
        }

        private List<SuperviseMissionExcelImportResponseEntity> GetSuperviseMissionExcelImportResponseEntityList(List<SmMainEntity> list)
        {
            List<SuperviseMissionExcelImportResponseEntity> importList = new List<SuperviseMissionExcelImportResponseEntity>();
            foreach (var smMainEntity in list)
            {
                var importEntity = new SuperviseMissionExcelImportResponseEntity();
                var tips = new SuperviseMissionExcelImportTips();
                var newSmMainEntity = new SmMainEntity();

                //为年度实体赋值，为错误提示实体赋值。
                string errorMessage;
                string snDeptId;
                //检查督办字号
                if (CheckNDSpNumber(smMainEntity, out snDeptId, out errorMessage))
                {
                    newSmMainEntity.SpNumberYear = smMainEntity.SpNumberYear;
                    newSmMainEntity.SpNumberName = smMainEntity.SpNumberName;
                    importEntity.SnDeptId = snDeptId;
                }
                else
                {
                    tips.SpNumberTips = errorMessage;
                }

                //检查内容
                errorMessage = "";
                if (CheckNDMainContent(smMainEntity, out errorMessage))
                {
                    newSmMainEntity.TaskContent = smMainEntity.TaskContent;
                }
                else
                {
                    tips.TaskContentTips = errorMessage;
                }

                //检查主管领导员工号
                string leaderName;
                errorMessage = "";
                if (CheckNDMainLeaderId(smMainEntity, out leaderName, out errorMessage))
                {
                    newSmMainEntity.MainLeaderId = smMainEntity.MainLeaderId;
                    newSmMainEntity.MainLeaderName = leaderName;
                }
                else
                {
                    tips.MainLeaderIdTips = errorMessage;
                }

                //检查协管领导员工号
                leaderName = "";
                errorMessage = "";
                if (CheckNDAssistLeaderId(smMainEntity, out leaderName, out errorMessage))
                {
                    newSmMainEntity.AssistLeaderId = smMainEntity.AssistLeaderId;
                    newSmMainEntity.AssistLeaderName = leaderName;
                }
                else
                {
                    tips.AssistLeaderIdTips = errorMessage;
                }

                //检查主办单位Id号
                string deptName;
                errorMessage = "";
                if (CheckNDMainDeptId(smMainEntity, out deptName, out errorMessage))
                {
                    newSmMainEntity.MainDeptId = smMainEntity.MainDeptId;
                    newSmMainEntity.MainDeptName = deptName;
                }
                else
                {
                    tips.MainDeptIdTips = errorMessage;
                }

                //检查协办单位Id号
                deptName = "";
                errorMessage = "";
                if (CheckNDAssistDeptId(smMainEntity, out deptName, out errorMessage))
                {
                    newSmMainEntity.AssistDeptId = smMainEntity.AssistDeptId;
                    newSmMainEntity.AssistDeptName = deptName;
                }
                else
                {
                    tips.AssistDeptIdTips = errorMessage;
                }

                importEntity.SuperviseMissionExcelImportTips = tips;
                importEntity.SmMainEntity = newSmMainEntity;
                importList.Add(importEntity);
            }

            
            return SetSnCode(importList);
        }

        private bool CheckNDAssistDeptId(SmMainEntity smMainEntity, out string deptName, out string tips)
        {
            if (string.IsNullOrEmpty(smMainEntity.AssistDeptId))
            {
                deptName = null;
                tips = "协办单位Id号不允许为空，请用户重新输入。";
                return false;
            }

            DeptListEntity entity = CacheHelper.AllVisbleDeptEntityListWithNoContainAllDept.FindAll(n => n.DeptId == smMainEntity.AssistDeptId).ToList().FirstOrDefault();
            if (entity == null)
            {
                deptName = null;
                tips = "查无此协办单位，请用户重新输入。";
                return false;
            }

            deptName = entity.DeptName;
            tips = null;
            return true;
        }

        private bool CheckNDMainDeptId(SmMainEntity smMainEntity, out string deptName, out string tips)
        {
            if (string.IsNullOrEmpty(smMainEntity.MainDeptId))
            {
                deptName = null;
                tips = "主办单位Id号不允许为空，请用户重新输入。";
                return false;
            }

            DeptListEntity entity = CacheHelper.AllVisbleDeptEntityListWithNoContainAllDept.FindAll(n => n.DeptId == smMainEntity.MainDeptId).ToList().FirstOrDefault();
            if (entity == null)
            {
                deptName = null;
                tips = "查无此主办单位，请用户重新输入。";
                return false;
            }

            deptName = entity.DeptName;
            tips = null;
            return true;
        }

        private bool CheckNDMainContent(SmMainEntity smMainEntity, out string tips)
        {
            if (string.IsNullOrEmpty(smMainEntity.TaskContent))
            {
                tips = "年度重点工作任务内容不允许为空，请用户重新输入。";
                return false;
            }

            if (OA30.Common.Security.XSSDetectTool.IsBeAttacked(smMainEntity.TaskContent))
            {
                tips = "年度重点工作任务内容含有恶意字符，请用户重新输入。";
                return false;
            }

            tips = "";
            return true;
        }

        private bool CheckNDAssistLeaderId(SmMainEntity smMainEntity, out string leaderName, out string tips)
        {
            if (string.IsNullOrEmpty(smMainEntity.AssistLeaderId))
            {
                leaderName = null;
                tips = "协管领导员工号不允许为空，请用户重新输入。";
                return false;
            }

            UserInfo user = SMBasicDataBiz.GetGenericUserInfoByID(smMainEntity.AssistLeaderId);
            if (user == null)
            {
                leaderName = null;
                tips = "查无此协管领导，请用户重新输入。";
                return false;
            }

            leaderName = user.Name;
            tips = null;
            return true;
        }

        private bool CheckNDMainLeaderId(SmMainEntity smMainEntity, out string mainLeaderName, out string tips)
        {
            if (string.IsNullOrEmpty(smMainEntity.MainLeaderId))
            {
                mainLeaderName = null;
                tips = "主管领导员工号不允许为空，请用户重新输入。";
                return false;
            }

            UserInfo user = SMBasicDataBiz.GetGenericUserInfoByID(smMainEntity.MainLeaderId);
            if (user == null)
            {
                mainLeaderName = null;
                tips = "查无此主管领导，请用户重新输入。";
                return false;
            }

            mainLeaderName = user.Name;
            tips = null;
            return true;
        }

        private bool CheckNDSpNumber(SmMainEntity smMainEntity, out string snDeptId, out string tips)
        {
            if (string.IsNullOrEmpty(smMainEntity.SpNumberName) || string.IsNullOrEmpty(smMainEntity.SpNumberYear))
            {
                snDeptId = "";
                tips = "督查编号不允许为空，请用户重新输入。";
                return false;
            }

            var year = 0;
            int.TryParse(smMainEntity.SpNumberYear, out year);
            var spNumber = SMBasicDataBiz.GetSuperviseNumberEntityList(new SmBasicDataSuperviseNumberEntity
            {
                Name = smMainEntity.SpNumberName,
                Year = year,
                DeptId = SuperviseMissionWorkFlow.GetFlowDeptIdByDeptId(CurrentUserInfo.Dept_ID)
            }, null).FirstOrDefault();

            if (spNumber == null)
            {
                tips = "督查编号有误，请用户重新输入。";
                snDeptId = "";
                return false;
            }

            snDeptId = spNumber.DeptId;
            tips = null;
            return true;
        }

        #endregion
    }
}
