using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Entity.MissionBase;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using System.Data;
using OA30.SuperviseMission.UI.CommonComponents;


namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class SuperviseMissionExport : BasePage
    {
        private ISuperviseMissionBasicData _BasicDataBiz = null;
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
            //判断是否收到CSRF攻击(宽松版，可处理外部进来的连接)
            if (OA30.Common.Security.CSRFTools.IsAttackByCSRF(this.Request.UrlReferrer, this.Request.Url, true))
            {
                throw new OA30.Common.Exception.UIExceptions.IsCSRFException(OA30.Common.Exception.UIExceptions.UIExceptionDescriptionCollection.CSRF);
            }
            base.OnPreInit(e);
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //校验登录
                CheckLogin();
                //对传入的参数进行处理
                string type = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["type"]) == true ? "" : HttpContext.Current.Request.QueryString["type"].Trim();
                //根据参数去调用函数导出数据
                switch (type)
                {
                    
                    case "SmBasicDataAuthorizeManage":{ ExportAuthorizeManage(); break; }
                    case "SmBasicDataDeptAuthorizationManage": { ExportDeptAuthorizationManage(); break; }
                    case "SmBasicDataOperationAuthorizationManage": { ExportOperationAuthorizationManage(); break; }

                    case "SmBasicDataOpinionTypeManage": { ExportDataOpinionTypeManage(); break; }
                    case "SmBasicDataPersonalDeptGroupManage": { ExportPersonalDeptGroupManage(); break; }
                    case "SmBasicDataSuperviseNumberManage": { ExportSuperviseNumber(); break; }

                    case "SmBasicDtataDeptRoleManage": { ExportDtataDeptRoleManage(); break; }
                    case "SmOpreationLogManage": { ExportOpreationLogManage(); break; }
                    case "SmSystemRoleManage": { ExportRoleManage(); break; }

                    case "SmSystemStepManage": { ExportSmSystemStepManage(); break; }
                    case "SmSystemStepRoleManage": { ExportSmSystemStepRoleManage(); break; }
                    case "SmSystemTypeDefintionManage": { SmSystemTypeDefintionManage(); break; }

                    case "SmSystemWorkFlowFreeManage": { ExportSmSystemWorkFlowFreeManage(); break; }
                    case "SmSystemWorkFlowStaticDetailManage": { ExportSmSystemWorkFlowStaticDetailManage(); break; }
                    case "SmSystemWorkFlowStaticManage": { ExportSmSystemWorkFlowStaticManage(); break; }
                    case "SmBasicDtataDeptDefaultLeaderManage": { ExportSmDeptDefaultLeaderManage(); break; }
                        


                    default: { break; }
                }
             }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        //1.导出督查委托管理数据
        private void ExportAuthorizeManage()
        {
            try
            {
                //解析参数
                string authorizerUserName = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["authorizerUserName"]) == true ? "" : HttpContext.Current.Request.QueryString["authorizerUserName"].Trim();
                string consigneeUserName = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["consigneeUserName"]) == true ? "" : HttpContext.Current.Request.QueryString["consigneeUserName"].Trim();
                string type = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["type"]) == true ? "" : HttpContext.Current.Request.QueryString["type"].Trim();
                //参数赋值
                SmBasicDataAuthorizeEntity condition = new SmBasicDataAuthorizeEntity();
                condition.AuthorizerName = authorizerUserName;
                condition.ConsigneeName = consigneeUserName;



                var smBasicDataAuthorizeEntityList = BasicDataBiz.GetAuthorizeEntityList(condition).OrderByDescending(n => n.CreateTime).ToList();

             

                string[] listTitleChinese = new string[] { "授权人ID","授权人姓名" ,"委托人ID",
                "委托人姓名","开始时间", "结束时间","状态", "创建时间", "创建者ID" };

                string[] listTitleEnglish = new string[] { "AuthorizerId","AuthorizerName" ,"ConsigneeId",
                "ConsigneeName","BeginTime", "EndTime","Status", "CreateTime", "OperatorId" };

                if (smBasicDataAuthorizeEntityList != null && smBasicDataAuthorizeEntityList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmBasicDataAuthorizeEntity>(smBasicDataAuthorizeEntityList,
                        context, "督查委托管理" + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //2.导出部门管理员授权数据
        private void ExportDeptAuthorizationManage()
        {
            try
            {
                //解析参数
                string dept_ids = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["dept_ids"]) == true ? "" : HttpContext.Current.Request.QueryString["dept_ids"].Trim();

                string searchMemberId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchMemberId"]) == true ? "" : HttpContext.Current.Request.QueryString["searchMemberId"].Trim();
         
                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(dept_ids) && !dept_ids.Equals("0"))
                {
                    dept_ids = dept_ids.TrimEnd(',');
                    deptIds = GetDeptActivityListByIds(dept_ids);
                }

                SmBasicDataDeptRoleDefinitionEntity condition = new SmBasicDataDeptRoleDefinitionEntity
                {

                    MemberId = searchMemberId.Trim()
                };

                var smBasicDataDeptRoleList = BasicDataBiz.GetSuperviseMissionDeptRoleEntityList(condition).
                    FindAll(n => n.RoleId == "DEPTADMIN" && GetDeptActivityList().Select(d => d.DeptId).
                    Contains(n.DeptId)).ToList();

                if (deptIds != null && deptIds.Count > 0)
                {
                    smBasicDataDeptRoleList = smBasicDataDeptRoleList.FindAll(n => deptIds.Contains(n.DeptId));
                }


                string[] listTitleEnglish = new string[] { "DeptId","DeptName" , "MemberId", "MemberName" };

                string[] listTitleChinese = new string[] { "部门ID","部门名", "成员ID","成员名" };

                
                if (smBasicDataDeptRoleList != null && smBasicDataDeptRoleList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmBasicDataDeptRoleDefinitionEntity>(smBasicDataDeptRoleList,
                        context, "部门管理员授权" + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls",listTitleEnglish, listTitleChinese);


                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //3.导出运维管理员授权数据
        private void ExportOperationAuthorizationManage()
        {
            try
            {
                //解析参数
                string searchDepartment = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchDepartment"]) == true ? "" : HttpContext.Current.Request.QueryString["searchDepartment"].Trim();
                string dept_ids = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["dept_ids"]) == true ? "" : HttpContext.Current.Request.QueryString["dept_ids"].Trim();

                string searchMemberId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchMemberId"]) == true ? "" : HttpContext.Current.Request.QueryString["searchMemberId"].Trim();
                //参数赋值
                SmBasicDataDeptRoleDefinitionEntity condition = new SmBasicDataDeptRoleDefinitionEntity();
                condition.DeptName = searchDepartment;
                condition.MemberId = searchMemberId;

                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(dept_ids))
                {
                    dept_ids = dept_ids.TrimEnd(',');
                    deptIds = dept_ids.Split(',').ToList();
                }
                var smBasicDataDeptRoleList = BasicDataBiz.GetSuperviseMissionDeptRoleEntityList(condition)
                     .FindAll(n => n.RoleId == "MAINTAINER").ToList();
                if (deptIds != null && deptIds.Count > 0)
                {
                    smBasicDataDeptRoleList = smBasicDataDeptRoleList.FindAll(n => deptIds.Contains(n.DeptId));
                }

                string[] listTitleEnglish = new string[] { "DeptId", "DeptName", "MemberId", "MemberName" };

                string[] listTitleChinese = new string[] { "部门ID", "部门名", "成员ID", "成员名" };


                if (smBasicDataDeptRoleList != null && smBasicDataDeptRoleList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmBasicDataDeptRoleDefinitionEntity>(smBasicDataDeptRoleList, context, "运维管理员授权" + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //4.导出意见类型数据
        private void ExportDataOpinionTypeManage()
        {
            try
            {
                //解析参数
                string typeName = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["typeName"]) == true ? "" : HttpContext.Current.Request.QueryString["typeName"].Trim();

                //参数赋值
                SmBasicDataOpinionTypeEntity condition = new SmBasicDataOpinionTypeEntity();
                condition.TypeName = typeName;

                var smSystemTypeDefintionList = BasicDataBiz.GetSmBasicDataOpinionTypeEntityList(condition).ToList();


       

                string[] listTitleEnglish = new string[] { "TypeId", "TypeName", "ActivityFlag" };

                string[] listTitleChinese = new string[] { "类型ID", "类型名", "是否可用" };



                if (smSystemTypeDefintionList != null && smSystemTypeDefintionList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmBasicDataOpinionTypeEntity>(smSystemTypeDefintionList, context, "意见类型" + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //5.导出自定义部门管理数据
       private void ExportPersonalDeptGroupManage()
        {
            try
            {
                //解析参数
                string searchDepartment = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchDepartment"]) == true ? "" : HttpContext.Current.Request.QueryString["searchDepartment"].Trim();
                string dept_ids = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["dept_ids"]) == true ? "" : HttpContext.Current.Request.QueryString["dept_ids"].Trim();
                string deptGroupName = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["deptGroupName"]) == true ? "" : HttpContext.Current.Request.QueryString["deptGroupName"].Trim();

                //参数赋值

                if (dept_ids=="0") { dept_ids =""; }
                SmBasicDataPersonalDeptGroupEntity smBasicDataPersonalDeptGroupEntity = new SmBasicDataPersonalDeptGroupEntity
                {
                    GroupName = deptGroupName.Trim(),
                    UserId = CurrentUserInfo.Employee_ID
                };

                SmBasicDataPersonalDeptGroupDetailEntity smBasicDataPersonalDeptGroupDetailEntity = new SmBasicDataPersonalDeptGroupDetailEntity
                {
                    DeptName = searchDepartment.Trim(),
                    DeptId = dept_ids
                };

                var dt = BasicDataBiz.GetSmBasicDataPersonalDeptGroupDataTable(smBasicDataPersonalDeptGroupEntity, smBasicDataPersonalDeptGroupDetailEntity);





                string[] listTitleChinese = new string[] { "部门组名称","部门组ID" ,"部门名称", "部门ID" };

                string[] listTitleEnglish = new string[] { "GroupName","GroupId" ,"DeptName", "DeptId" };

                if (dt != null)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
             ExcelRender.RenderToExcelAndTitle(dt, context, "自定义部门管理"
                     + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        


        //6.导出督查字号数据
        private void ExportSuperviseNumber()
        {
            try
            {
                //解析参数
                string dept_ids = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["dept_ids"]) == true ? "" : HttpContext.Current.Request.QueryString["dept_ids"].Trim();
                string year = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["year"]) == true ? "" : HttpContext.Current.Request.QueryString["year"].Trim();
                string name = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["name"]) == true ? "" : HttpContext.Current.Request.QueryString["name"].Trim();
                string code = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["code"]) == true ? "" : HttpContext.Current.Request.QueryString["code"].Trim();
                string type = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["type"]) == true ? "" : HttpContext.Current.Request.QueryString["type"].Trim();
                
                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(dept_ids))
                {
                    dept_ids = dept_ids.TrimEnd(',');
                    deptIds = GetDeptActivityListByIds(dept_ids);
                }

                //搜索条件。
                var yearValue = string.IsNullOrEmpty(year) ? 0 : int.Parse(year.Trim());
                var codeValue = string.IsNullOrEmpty(code) ? -999 : int.Parse(code.Trim());

                SmBasicDataSuperviseNumberEntity condition = new SmBasicDataSuperviseNumberEntity
                {

                    Code = codeValue,
                    Name = name.Trim(),
                    Year = yearValue
                };

                var m = BasicDataBiz.GetSuperviseNumberEntityList(condition, deptIds).ToList();
                var smBasicDataSuperviseNumberList = m.FindAll(n => GetDeptActivityList().Select(d => d.DeptId).Contains(n.DeptId)).OrderByDescending(n => n.CreateTime).ToList();

                if (deptIds != null && deptIds.Count > 0)
                {
                    smBasicDataSuperviseNumberList = smBasicDataSuperviseNumberList.FindAll(n => deptIds.Contains(n.DeptId));
                }


                string[] listTitleChinese = new string[] { "部门ID","部门名" ,"文件字",
                "年号","当前流水号", "是否可用" };

                string[] listTitleEnglish = new string[] { "DeptId","DeptName" ,"Name",
                "Year","Code", "ActivityFlag" };

                if (smBasicDataSuperviseNumberList != null && smBasicDataSuperviseNumberList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmBasicDataSuperviseNumberEntity>(smBasicDataSuperviseNumberList, context, "督查字号" 
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //7.导出部门角色配置数据
        private void ExportDtataDeptRoleManage()
        {
            try
            {
                //解析参数
                string searchDeptIds = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchDeptIds"]) == true ? "" : HttpContext.Current.Request.QueryString["searchDeptIds"].Trim();
                string roleId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["roleId"]) == true ? "" : HttpContext.Current.Request.QueryString["roleId"].Trim();
                string memberId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["memberId"]) == true ? "" : HttpContext.Current.Request.QueryString["memberId"].Trim();
                //参数赋值
                SmBasicDataDeptRoleDefinitionEntity condition = new SmBasicDataDeptRoleDefinitionEntity();

                condition.RoleId = roleId;
                condition.MemberId = memberId;

                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDeptIds) && !searchDeptIds.Equals("0"))
                {
                    searchDeptIds = searchDeptIds.TrimEnd(',');
                    deptIds = GetDeptActivityListByIds(searchDeptIds);
                }

                var smBasicDataDeptRoleList = BasicDataBiz.GetSuperviseMissionDeptRoleEntityList(condition)
                    .FindAll(n => n.RoleId != "DEPTADMIN"
                                  && !n.RoleName.Equals("系统管理员")
                                  && !n.RoleName.Equals("运维管理员")
                                  && !n.RoleName.Equals("超级管理员")
                                  && !n.RoleName.Equals("部门管理员")
                                  && GetDeptActivityList().Select(d => d.DeptId).Contains(n.DeptId)).ToList(); ;
                if (deptIds != null && deptIds.Count > 0)
                {
                    smBasicDataDeptRoleList = smBasicDataDeptRoleList.FindAll(n => deptIds.Contains(n.DeptId));
                }


                string[] listTitleEnglish = new string[] { "DeptId", "DeptName", "RoleID", "RoleName", "MemberId", "MemberName" };

                string[] listTitleChinese = new string[] { "部门ID", "部门名", "角色ID", "角色名称",  "成员ID", "成员名" };

                if (smBasicDataDeptRoleList != null && smBasicDataDeptRoleList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmBasicDataDeptRoleDefinitionEntity>(smBasicDataDeptRoleList, context, "部门角色配置" 
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls",listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //8.导出操作日志数据
        private void ExportOpreationLogManage()
        {
            try
            {
                //解析参数
                string startSearchTime = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["startSearchTime"]) == true ? "" : HttpContext.Current.Request.QueryString["startSearchTime"].Trim();
                string endSearchTime = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["endSearchTime"]) == true ? "" : HttpContext.Current.Request.QueryString["endSearchTime"].Trim();
                string logModuleType = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["logModuleType"]) == true ? "-1" : HttpContext.Current.Request.QueryString["logModuleType"].Trim();
                string logLayerType = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["memberId"]) == true ? "-1" : HttpContext.Current.Request.QueryString["logLayerType"].Trim();
                string logErrorType = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["logErrorType"]) == true ? "-1" : HttpContext.Current.Request.QueryString["logErrorType"].Trim();
                string logOpreator = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["logOpreator"]) == true ? "" : HttpContext.Current.Request.QueryString["logOpreator"].Trim();
                string logContent = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["logContent"]) == true ? "" : HttpContext.Current.Request.QueryString["logContent"].Trim();

                //参数赋值
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
                DataTable dt = BasicDataBiz.GetOpreationLogDataTable(condition);
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

                string[] listTitleEnglish = new string[] { "ModuleName", "LayerName", "ErrorTypeName", "Content", "OpreatorId", "OpreatorName", "OpreateTime", "OpreatorIp", "OpreatorDeptId", "OpreatorDeptName" };

                string[] listTitleChinese = new string[] { "模块名", "层次名", "错误名", "错误提示", "操作者员工号", "操作者姓名", "操作时间", "操作者IP",  "操作者所属部门ID", "操作者部门名称" };


                if (result != null && result.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmOpreationLogEntity>(result, context, "操作日志"
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //9.导出角色定义数据
        private void ExportRoleManage()
        {
            try
            {
                //解析参数
                string searchRoleId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchRoleId"]) == true ? "" : HttpContext.Current.Request.QueryString["searchRoleId"].Trim();
                string searchRoleName = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchRoleName"]) == true ? "" : HttpContext.Current.Request.QueryString["searchRoleName"].Trim();

                //参数赋值
                SmSystemRoleDefinitionEntity condition = new SmSystemRoleDefinitionEntity
                {
                    RoleId = searchRoleId,
                    RoleName = searchRoleName
                };

                var smSystemRoleEntityList = BasicDataBiz.GetSuperviseMissionSystemRoleEntityList(condition);



                string[] listTitleEnglish = new string[] { "RoleId", "RoleName", "RoleType", "ActivityFlag" };

                string[] listTitleChinese = new string[] { "角色ID", "角色名称", "角色性质", "是否可用" };

                if (smSystemRoleEntityList != null && smSystemRoleEntityList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmSystemRoleDefinitionEntity>(smSystemRoleEntityList, context, "角色定义"
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //10.导出步骤定义数据
        private void ExportSmSystemStepManage()
        {
            try
            {
                //解析参数
                string searchStepId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchStepId"]) == true ? "" : HttpContext.Current.Request.QueryString["searchStepId"].Trim();
                string searchStepName = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchStepName"]) == true ? "" : HttpContext.Current.Request.QueryString["searchStepName"].Trim();

                //参数赋值
                SmSystemStepDefinitionEntity condition = new SmSystemStepDefinitionEntity
                {
                    StepId = searchStepId,
                    StepName = searchStepName
                };

                var smSystemStepEntityList = BasicDataBiz.GetSuperviseMissionSystemStepEntityList(condition);



                string[] listTitleEnglish = new string[] { "StepId", "StepName", " StepType", "ActivityFlag" };

                string[] listTitleChinese = new string[] { "步骤ID", "步骤名称", "步骤类型", "是否可用" };

                if (smSystemStepEntityList != null && smSystemStepEntityList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmSystemStepDefinitionEntity>(smSystemStepEntityList, context, "步骤定义"
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //11.导出步骤角色定义数据
        private void ExportSmSystemStepRoleManage()
        {
            try
            {
                //解析参数
                string stepId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["stepId"]) == true ? "" : HttpContext.Current.Request.QueryString["stepId"].Trim();
                string roleId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["roleId"]) == true ? "" : HttpContext.Current.Request.QueryString["roleId"].Trim();

                //参数赋值
                SmSystemStepRoleDefinitionEntity condition = new SmSystemStepRoleDefinitionEntity
                {
                    StepId = stepId.Trim(),
                    RoleId = roleId.Trim()
                };

                var smBasicDataDeptRoleList = BasicDataBiz.GetSuperviseMissionSystemStepRoleEntityList(condition).ToList();



                string[] listTitleEnglish = new string[] { "StepId", "StepName", "RoleId", "RoleName" };

                string[] listTitleChinese = new string[] { "步骤ID", "步骤名称", "角色ID", "角色名称" };

                if (smBasicDataDeptRoleList != null && smBasicDataDeptRoleList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmSystemStepRoleDefinitionEntity>(smBasicDataDeptRoleList, context, "步骤角色定义"
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //12.导出文件类型数据
        private void SmSystemTypeDefintionManage()
        {
            try
            {
                //解析参数
                string typename = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["typename"]) == true ? "" : HttpContext.Current.Request.QueryString["typename"].Trim();
                string typeid = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["typeid"]) == true ? "" : HttpContext.Current.Request.QueryString["typeid"].Trim();

                //参数赋值
                SmSystemTypeDefinitionEntity condition = new SmSystemTypeDefinitionEntity
                {
                    TypeId = typeid.Trim(),
                    TypeName = typename.Trim()

                };

                var smSystemTypeDefintionList = BasicDataBiz.GetSuperviseMissionTypeDefinitionEntityList(condition).ToList();

             
                string[] listTitleEnglish = new string[] { "typeid", "typename" };
                string[] listTitleChinese = new string[] { "类型号"," 类型名"};

                if (smSystemTypeDefintionList != null && smSystemTypeDefintionList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmSystemTypeDefinitionEntity>(smSystemTypeDefintionList, context, "文件类型"
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        //13.导出自由流程数据
        private void ExportSmSystemWorkFlowFreeManage()
        {
            try
            {
                //解析参数
                string nextStepId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["nextStepId"]) == true ? "" : HttpContext.Current.Request.QueryString["nextStepId"].Trim();
                string currentStepId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["currentStepId"]) == true ? "" : HttpContext.Current.Request.QueryString["currentStepId"].Trim();
                string smType = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["smType"]) == true ? "" : HttpContext.Current.Request.QueryString["smType"].Trim();


             
                //参数赋值
                SmSystemWorkFlowFreeDefinitionEntity condition = new SmSystemWorkFlowFreeDefinitionEntity
                {
                    CurrentStepId = currentStepId,
                    NextStepId = nextStepId,
                    SmType=smType
                };

                var superviseMissionSystemWorkFlowFreeEntityList = BasicDataBiz.GetSuperviseMissionSystemWorkFlowFreeEntityList(condition);


                SmSystemTypeDefinitionEntity conditionType = new SmSystemTypeDefinitionEntity { };

                var SmSystemTypeDefintionList = BasicDataBiz.GetSuperviseMissionTypeDefinitionEntityList(conditionType).ToList();

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
                
                string[] listTitleEnglish = new string[] { "CurrentStepId", "CurrentStepName","NextStepId", "NextStepName", "SmType", "ActivityFlag" };
                string[] listTitleChinese = new string[] { "当前步骤ID", "当前步骤名称", "下一步骤ID", "下一步骤名称", "所属类型", "是否可用" };

                if (superviseMissionSystemWorkFlowFreeEntityList != null && superviseMissionSystemWorkFlowFreeEntityList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmSystemWorkFlowFreeDefinitionEntity>(superviseMissionSystemWorkFlowFreeEntityList, context, "自由流程定义"
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //14.导出固定流程配置数据
        private void ExportSmSystemWorkFlowStaticDetailManage()
        {
            try
            {
                //解析参数
                string stepId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["stepId"]) == true ? "" : HttpContext.Current.Request.QueryString["stepId"].Trim();
                string workflowId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["workflowId"]) == true ? "" : HttpContext.Current.Request.QueryString["workflowId"].Trim();

                //参数赋值
                SmWorkFlowStaticDetailEntity condition = new SmWorkFlowStaticDetailEntity
                {
                    StepId = stepId,
                    WorkFlowId = workflowId
                };

                var smSystemWorkFlowStaticDetailEntityList = BasicDataBiz.GetSuperviseMissionSystemWorkFlowStaticDetailEntityList(condition).OrderByDescending(n => n.FlowId).ToList();


                string[] listTitleEnglish = new string[] { "WorkFlowId", "FlowId", "FatherFlowId", "StepId", "StepName" };
                string[] listTitleChinese = new string[] { "流程配置ID", "流程", "父流程ID", "步骤ID", "步骤名称" };

                if (smSystemWorkFlowStaticDetailEntityList != null && smSystemWorkFlowStaticDetailEntityList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmWorkFlowStaticDetailEntity>(smSystemWorkFlowStaticDetailEntityList, context, "自由流程定义"
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //15.导出固定流程定义数据
        private void ExportSmSystemWorkFlowStaticManage()
        {
            try
            {
                //解析参数
                string searchDeptName = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchDeptName"]) == true ? "" : HttpContext.Current.Request.QueryString["searchDeptName"].Trim();
                string searchDeptIds = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchDeptIds"]) == true ? "" : HttpContext.Current.Request.QueryString["searchDeptIds"].Trim();
               // string typeWorkFlow = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["typeWorkFlow"]) == true ? "" : HttpContext.Current.Request.QueryString["typeWorkFlow"].Trim();
                string workflowId = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["workflowId"]) == true ? "" : HttpContext.Current.Request.QueryString["workflowId"].Trim();
                string smType = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["smType"]) == true ? "" : HttpContext.Current.Request.QueryString["smType"].Trim();


                //参数赋值
                List<string> deptIds = new List<string>();
                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDeptIds) && !searchDeptIds.Equals("0"))
                {
                    searchDeptIds = searchDeptIds.TrimEnd(',');
                    deptIds = searchDeptIds.Split(',').ToList();
                }

                SmWorkFlowStaticEntity condition = new SmWorkFlowStaticEntity
                {
                    DeptName = searchDeptName,
                    WorkFlowId = workflowId,
                    SmType = smType
                };

                var smSystemStepEntityList = BasicDataBiz.GetSuperviseMissionSystemWorkFlowStaticEntityList(condition);
                if (deptIds != null && deptIds.Count > 0)
                {
                    smSystemStepEntityList = smSystemStepEntityList.FindAll(n => deptIds.Contains(n.DeptId));
                }

                string[] listTitleEnglish = new string[] { "WorkFlowId", "WorkFlowName", "DeptId", "DeptName", "SmType", "SubType","ActivityFlag" };
                string[] listTitleChinese = new string[] { "工作流程ID", "工作流程名称", "部门号", "部门名称", "步骤类型","子步骤流程", "是否可用" };

                foreach(SmWorkFlowStaticEntity singleSmWorkFlowStaticEntity in smSystemStepEntityList)
                {
                    if (string.IsNullOrEmpty(singleSmWorkFlowStaticEntity.SubType))
                    {
                        singleSmWorkFlowStaticEntity.SubType = "";
                    }
                }

                if (smSystemStepEntityList != null && smSystemStepEntityList.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmWorkFlowStaticEntity>(smSystemStepEntityList, context, "固定流程定义"
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        //16.导出部门默认领导数据
        private void ExportSmDeptDefaultLeaderManage()
        {
            try
            {
                //解析参数
                string searchDeptIds = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["searchDeptIds"]) == true ? "" : HttpContext.Current.Request.QueryString["searchDeptIds"].Trim();
                string leaderName = string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["leaderName"]) == true ? "" : HttpContext.Current.Request.QueryString["leaderName"].Trim();


                List<string> deptIds = new List<string>();


                //获取部门id列表。
                if (!string.IsNullOrEmpty(searchDeptIds) && !searchDeptIds.Equals("0"))
                {
                    searchDeptIds = searchDeptIds.TrimEnd(',');
                    deptIds =GetDeptActivityListByIds(searchDeptIds);
                }


                SmBasicDataDeptDefaultLeaderEntity condition = new SmBasicDataDeptDefaultLeaderEntity
                {
                    DeptId = searchDeptIds,
                    LeaderUserName = leaderName.Trim(),

                };

             
                List<SmBasicDataDeptDefaultLeaderEntity> result = new List<SmBasicDataDeptDefaultLeaderEntity>();
                DataTable dt = BasicDataBiz.GetDeptDefaultLeadeDataTable(condition);
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
                        OrderNumber = (int?)(dr["ORDER_NUMBER"])
                    });
                }

             
                string[] listTitleEnglish = new string[] { "DeptId", "DeptName", "LeaderUserId", "LeaderUserName", "LeaderDeptId", "LeaderDeptName","OrderNumber"};
                string[] listTitleChinese = new string[] { "部门号", "部门名称", "领导工号", "领导姓名", "领导所在部门号", "领导所在部门","排序号" };

                var resultNew = result.OrderBy(i => i.OrderNumber).ToList();
                if (resultNew != null && resultNew.Count > 0)
                {
                    HttpContext context = HttpContext.Current;
                    context.Response.Charset = "UTF-8";
                    context.Response.ContentEncoding = System.Text.Encoding.UTF8;
                    HttpContext.Current.Response.ContentType = "application/ms-excel";
                    ExcelRender.RenderToExcelFromEntityList<SmBasicDataDeptDefaultLeaderEntity>(resultNew, context, "部门默认领导"
                        + DateTime.Now.ToString("yyyyMMddHHmmsss") + ".xls", listTitleEnglish, listTitleChinese);

                }
                else
                {
                    close();
                    Response.Write("<script language = \"javascript\">confirm('数据为空，不需要导出')</script>");

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        private void close()
        {
            string script = "<script type=\"text/javascript\">" + ("window.close();") + "</script>";
            Page.ClientScript.RegisterStartupScript(GetType(), "alert" + Guid.NewGuid(), script, false);
        }


        private List<string> GetDeptActivityListByIds(string searchDeptIds)
        {
            List<string> deptIds = new List<string>();
            List<string> allDeptIds = new List<string>();
            deptIds = searchDeptIds.Split(',').ToList();
            foreach (var deptId in deptIds)
            {
                allDeptIds.AddRange(GetDeptActivityList().Select(n => n.DeptId).ToList().FindAll(n => n.StartsWith(deptId)));
            }

            return allDeptIds;
        }


        private List<DeptListEntity> GetDeptActivityList()
        {
            List<DeptListEntity> result = new List<DeptListEntity>();
            //首先判断是不是超级管理员
            var list1 = BasicDataBiz.GetSuperviseMissionDeptRoleEntityList(new SmBasicDataDeptRoleDefinitionEntity() { MemberId = CurrentUserInfo.Employee_ID, RoleId = "SUPER" });
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
                var list2 = BasicDataBiz.GetSuperviseMissionDeptRoleEntityList(new SmBasicDataDeptRoleDefinitionEntity() { MemberId = CurrentUserInfo.Employee_ID, RoleId = "DEPTADMIN" });
                //获取管理部门下面的子部门
                foreach (var temp in list2)
                {
                    //获取可用的子级单位
                    var list3 = CacheHelper.AllActiveDeptEntityList.FindAll(n => n.DeptId.Length >= temp.DeptId.Length && n.DeptId.Substring(0, temp.DeptId.Length) == temp.DeptId);
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


    }
}