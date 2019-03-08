using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.UI.CommonComponents;

namespace OA30.SuperviseMission.UI.MainSite.Statistics
{
    public partial class Export_ToExcel : BasePage
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
            try
            {
                if (!IsPostBack)
                {
                    string headthml = @"
                 <table border=1>
                      <tr>
                          <td> 序号 </td>
                          <td> 督查编号 </td>
                           <td> 重点工作任务 </td>
                            <td> 任务进度 </td>
                            <td> 主管领导 </td>
                            <td> 协管领导 </td>
                             <td> 状态 </td>
                             <td> 主办单位 </td>
                             <td> 年度目标 </td>
                              <td> 目标进度 </td>
                              <td> 措施流水号 </td>
                              <td> 措施 </th>
                              <td> 完成时间 </td>
                              <td> 措施进度 </td>
                              <td> 责任处室 </td>
                              <td> 子措施 </td>
                              <td> 子措施进度 </td>
                              <td> 责任人 </td>
                      </tr>";

                    StatisticsPageListRequestEntity model = GetSelectApplyEntity();
                    if (IsDeptManager || IsSuperManager)
                    {
                        //是超级管理员或者部门管理员
                        string html = GetTableHtml(model);
                        //html = "";
                        if (string.IsNullOrEmpty(html))
                        {
                            //没有数据
                            AlertAndClosePage(this.Page, "没有需要导出的数据，不用导出", true);
                        }
                        else
                        {
                            string newstr = headthml + html + "</table>";
                            ExcelRender.ExportExcel(HttpContext.Current, newstr, string.Format("督查任务统计{0}", DateTime.Now.ToString("yyyyMMddHHmmssfff")));
                        }
                    }
                    else
                    {
                        //普通用户，导出单个自己查看的数据
                        if (!string.IsNullOrEmpty(model.SmId))
                        {
                            SmMainEntity model1 = SuperviseMissionBodyBiz.GetOneSmMainEntityByRightLimt(model.SmId, IsSuperManager, CurrentUserInfo.Employee_ID, this.DeptList);
                            if (model1 != null)
                            {
                                List<SmTargetEntity> tlist = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(model.SmId);
                                List<SmTargetItemEntity> tilist = SuperviseMissionBodyBiz.GetSmTargetItemEntityListBySmId(model.SmId, true);
                                string htmlStr = StatisticHelper.GetSmMainForhtml(model1, tlist, tilist,null);
                                string newstr = headthml + htmlStr + "</table>";
                                ExcelRender.ExportExcel(HttpContext.Current, newstr, string.Format("督查任务(ID:{0})明细详情{1}", model.SmId, DateTime.Now.ToString("yyyyMMddHHmmssfff")));
                            }
                            else
                            {
                                string msg = "没有需要导出的数据，不用导出";
                                AlertAndClosePage(this.Page, msg, true);
                            }
                        }
                        else
                        {
                            string msg = "参数传递错误：任务ID不能为空";
                            AlertAndClosePage(this.Page, msg, true);
                        }
                    }
                }
                //else
                //{
                //    SmMainEntity model1 = SuperviseMissionBodyBiz.GetOneSmMainEntityByRightLimt("18081700001", IsSuperManager, CurrentUserInfo.Employee_ID, this.DeptList);
                //    model1.Index = 1;
                //    List<SmTargetEntity> tlist = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId("18081700001");
                //    List<SmTargetItemEntity> tilist = SuperviseMissionBodyBiz.GetSmTargetItemEntityListBySmId("18081700001", true);
                //    SmMainListStatisticsToExcelHelper.RenderToExcel(model1, tlist, tilist, HttpContext.Current, "test.xls");
                //}
            }
            catch (Exception er)
            {
                string msg = "导出出错，错误原因是：" + er.Message;
                AlertAndClosePage(this.Page, msg, true);
            }
        }

        //protected override void OnPreInit(EventArgs e)
        //{
        //    //判断是否收到CSRF攻击(宽松版，可处理外部进来的连接)
        //    if (OA30.Common.Security.CSRFTools.IsAttackByCSRF(this.Request.UrlReferrer, this.Request.Url, true))
        //    {
        //        throw new OA30.Common.Exception.UIExceptions.IsCSRFException(OA30.Common.Exception.UIExceptions.UIExceptionDescriptionCollection.CSRF);
        //    }
        //    base.OnPreInit(e);
        //}


        private StatisticsPageListRequestEntity GetSelectApplyEntity()
        {

            StatisticsPageListRequestEntity model = new StatisticsPageListRequestEntity();
            model.PageIndex = 1;
            model.PageSize = 10;
            model.MainDeptId = Request.QueryString["MainDeptId"] == null ? "" : Request.QueryString["MainDeptId"].ToString();
            model.KeyWord = Request.QueryString["KeyWord"] == null ? "" : Request.QueryString["KeyWord"].ToString();
            model.SmId = Request.QueryString["SmId"] == null ? "" : Request.QueryString["SmId"].ToString();
            model.SmType = Request.QueryString["SmType"] == null ? "" : Request.QueryString["SmType"].ToString();
            model.MissionStatus = Request.QueryString["MissionStatus"] == null ? "" : Request.QueryString["MissionStatus"].ToString();
            model.MainLeaderName = Request.QueryString["MainLeaderName"] == null ? "" : Request.QueryString["MainLeaderName"].ToString();
            model.AssistLeaderName = Request.QueryString["AssistLeaderName"] == null ? "" : Request.QueryString["AssistLeaderName"].ToString();
            if (Request.QueryString["BeginDate"] != null && Request.QueryString["BeginDate"].ToString() != "")
            {
                model.BeginDate = DateTime.Parse(Request.QueryString["BeginDate"].ToString());
            }
            if (Request.QueryString["EndDate"] != null && Request.QueryString["EndDate"].ToString() != "")
            {
                model.EndDate = DateTime.Parse(Request.QueryString["EndDate"].ToString());
            }
            return model;
        }

        private string GetTableHtml(StatisticsPageListRequestEntity statisticsPageListRequestEntity)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt = new DataTable();
            List<string> missionStatusList = new List<string>();
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
            dt = SuperviseMissionBodyBiz.GetAllStatisticSMList(statisticsPageListRequestEntity.MainDeptId, statisticsPageListRequestEntity.KeyWord, statisticsPageListRequestEntity.BeginDate, statisticsPageListRequestEntity.EndDate, missionStatusList, statisticsPageListRequestEntity.SmId, statisticsPageListRequestEntity.SmType, statisticsPageListRequestEntity.MainLeaderName, statisticsPageListRequestEntity.AssistLeaderName, IsSuperManager, CurrentUserInfo.Employee_ID);
            List<SmMainEntity> smList = new List<SmMainEntity>();
            if (dt.Rows.Count > 0)
            {
                int index = 1;
                foreach (DataRow item in dt.Rows)
                {
                    SmMainEntity model = new SmMainEntity();
                    model.Index = index++;
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
                    List<SmTargetEntity> targetList = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(model.SmId);
                    List<SmTargetItemEntity> allTargetItemList = SuperviseMissionBodyBiz.GetSmTargetItemEntityListBySmId(model.SmId, true);
                    List<SmFlowFinishEntity> flowWaitingList = SuperviseMissionBodyBiz.GetSmFlowFinishList(e => e.SmId != null).ToList();
                    sb.Append(Statistics.StatisticHelper.GetSmMainForhtml(model, targetList, allTargetItemList, flowWaitingList));
                }
            }
            return sb.ToString();
        }
    }
}