using OA30.Common.Exception.UIExceptions;
using OA30.LogCenter.Client.ExceptionLogs;
using OA30.LogCenter.Common.Entitys.ExceptionLogs;
using OA30.SuperviseMission.Common.PublicUtility;
using OA30.TimingCallDispatcher;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace OA30.SuperviseMission.UI.MainSite
{
    public class Global : System.Web.HttpApplication
    {
        #region 错误处理

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception exp = Server.GetLastError().GetBaseException();
            try
            {
                //对于已经登录的用户，将异常写入日志中心(wukea 2018-06-13)
                if (this.Context.User != null && this.Context.User.Identity != null && this.Context.User.Identity.IsAuthenticated)
                {
                    ExceptionLogEntity exceptionLogEntity = new ExceptionLogEntity()
                    {
                        AboutEmployeeId = this.Context.User.Identity.Name,
                        AboutModule = "Doc",
                        DescMessage = "用户访问时发生异常\r\n客户端IP：" + this.Request.UserHostAddress + "\r\nURL：" + this.Request.Url.ToString(),
                        OccurTime = DateTime.Now,
                        ServerIPAddress = RuntimeInfo.ServerIPAddress,
                        TheException = exp
                    };
                    if (exp is System.Web.HttpException && exp.Message != null && exp.Message.Contains("请求已超时"))
                    {
                        exceptionLogEntity.DescMessage = exceptionLogEntity.DescMessage + "\r\n请求送达时间：" + this.Context.Timestamp.ToString("yyyy-MM-dd HH:mm:ss fff");
                    }
                    if (exp is System.Web.UI.ViewStateException && this.Request.Form != null && this.Request.Form["__VIEWSTATE"] != null)
                    {
                        exceptionLogEntity.DescMessage = exceptionLogEntity.DescMessage + "\r\nViewState内容：\r\n" + this.Request.Form["__VIEWSTATE"];
                    }
                    if (exp is System.FormatException && exp.Message != null && exp.Message.Contains("字符数组的无效长度") && this.Request.Form != null && this.Request.Form["__VIEWSTATE"] != null)
                    {
                        exceptionLogEntity.DescMessage = exceptionLogEntity.DescMessage + "\r\nViewState内容：\r\n" + this.Request.Form["__VIEWSTATE"];
                    }
                    ExceptionLogClient.SaveExceptionLog(exceptionLogEntity);
                }


                //对OA项目组所在的网段开放异常日志(2016-10-18)
                if (TheDebugMode == "1" || Request.UserHostAddress.StartsWith("10.95.28."))
                {
                    //调试模式，显示异常信息
                    ShowException(exp);
                    Server.ClearError();
                }
                else
                {
                    Server.ClearError();
                    //根据错误类型跳转到主网站相关的提示页
                    if (exp is IExceptionWithDescPage)
                    {
                        var theExp = exp as IExceptionWithDescPage;
                        Response.Redirect(theExp.ExceptionDescPageURL);
                    }
                    else if (exp is System.Web.HttpRequestValidationException)
                    {
                        //有不支持的字符输入
                        Response.Redirect("/ErrorPages/UnSupportInputContent.html");
                    }
                    else if (exp is OA30.Common.Exception.UIExceptions.SystemException)
                    {
                        //系统错误
                        Response.Redirect("/error.htm");
                    }
                    else
                    {
                        //其他错误
                        Response.Redirect("/error.htm");
                    }
                }
            }
            catch
            {
            }
            finally
            {
            }
        }

        private static string _TheDebugMode = null;
        private static string TheDebugMode
        {
            get
            {
                if (_TheDebugMode == null)
                {
                    _TheDebugMode = "0";
                    if (System.Configuration.ConfigurationManager.AppSettings["DebugMode"] != null)
                        _TheDebugMode = System.Configuration.ConfigurationManager.AppSettings["DebugMode"];
                }
                return _TheDebugMode;
            }
        }

        /// <summary>
        /// 显示异常信息
        /// </summary>
        /// <param name="exp"></param>
        private void ShowException(Exception exp)
        {
            string str = "<script language=javascript>function OnShow(){var id=document.all('ErrorInfo');if(id.style.display!='none'){id.style.display='none';}else{id.style.display='';}}</script>";
            str += "<table border=0 style='font-size:10pt' align='center'><tr ><td align='center'>";
            str += "<img src='" + "http://" + Request.Url.Authority + "/Images/sorry.gif'" + "</td></tr>";
            str += "<tr><td>" + string.Format("<b>错误信息：</b><font color=red><pre>{0}</pre></font>", exp.Message) + "</tr></td>";
            str += "<tr><td><a href='javascript:OnShow()'><b>+</b></a><b>  查看详细信息：</b><br>";
            str += "<div id='ErrorInfo' style='DISPLAY: none'>" + string.Format("<font color=red><pre>{0}</pre></font>", exp.StackTrace) + "</div>";
            str += "</td></tr></table>";
            Response.Write(str);
        }

        #endregion


        protected void Application_Start(object sender, EventArgs e)
        {
            //注册定时调度任务
            AssemblyReflectionForTimingCall.FindAndRegisterTimingCallDelegate();
            //启动调度
            Dispatcher.StartDispatch();
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}