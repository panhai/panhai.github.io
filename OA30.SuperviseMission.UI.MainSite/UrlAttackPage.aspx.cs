using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class UrlAttackPage : Page
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

        }
    }
}