using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Entity.Mission.Enum;
using OA30.SuperviseMission.UI.CommonComponents;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class MainPage : BasePage
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
            try
            {

            }
            catch (Exception ex)
            {
                UiLogHelper.InsertSmOpreationLog(new SmOpreationLogEntity()
                {
                    Content = ex.StackTrace,
                    ErrorType = (int?)ErrorTypeEnumEntity.UI,
                    ErrorTypeName = ErrorTypeEnumEntity.UI.ToString(),
                    LayerName = LayerTypeEnumEntity.UI.ToString(),
                    LayerType = (int?)LayerTypeEnumEntity.UI,
                    ModuleName = ModuleTypeEnumEntity.BossMeetingMissionForm.ToString(),
                    ModuleType = (int?)ModuleTypeEnumEntity.BossMeetingMissionForm,
                    OpreateTime = DateTime.Now,
                    OpreatorDeptId = CurrentUserInfo.Dept_ID,
                    OpreatorDeptName = CurrentUserInfo.Dept_Name,
                    OpreatorId = CurrentUserInfo.Employee_ID,
                    OpreatorIp = CurrentUserInfo.IP,
                    OpreatorName = CurrentUserInfo.Name

                });
                //throw;
            }

        }
    }
}