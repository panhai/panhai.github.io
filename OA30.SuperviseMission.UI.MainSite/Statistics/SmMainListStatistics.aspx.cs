using OA30.Common.Entity;
using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Entity.MissionBase;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace OA30.SuperviseMission.UI.MainSite.Statistics
{
    public partial class SmMainListStatistics : BasePage
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
            if (!IsPostBack)
            {
                if (this.IsDeptManager || this.IsSuperManager)
                {
                    isRoleLimit.Value = "1";
                }
                else
                {
                    isRoleLimit.Value = "0";
                }
            }
        }


        public string ReturnStr()
        {
            SmMainEntity selmodel = new SmMainEntity();
            selmodel.SmId = "18081700001";
            selmodel.ActivityFlag = 1;
            SmMainEntity newmodel = SuperviseMissionBodyBiz.GetSmMainEntity(selmodel);
            newmodel.Index = 1;
            List<SmTargetEntity> tlist = SuperviseMissionBodyBiz.GetSmTargetEntityListBySmId(selmodel.SmId);
            List<SmTargetItemEntity> tilist = SuperviseMissionBodyBiz.GetSmTargetItemEntityListBySmId(selmodel.SmId, true);
            return StatisticHelper.GetSmMainForhtml(newmodel, tlist, tilist,null);
        }


    }
}