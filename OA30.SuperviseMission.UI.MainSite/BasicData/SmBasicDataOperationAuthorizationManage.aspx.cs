using System;
using OA30.SuperviseMission.UI.WebSiteInfo;

namespace OA30.SuperviseMission.UI.MainSite.BasicData
{
    public partial class SmBasicDataOperationAuthorizationManage : BasePage
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsSuperManager)
            {
                Response.Write("<script language=javascript>alert('请使用超级管理员登陆！');window.location = '/SM/MainPage.aspx';</script>");
            }
        }
    }
}