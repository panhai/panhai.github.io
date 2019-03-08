using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.CommonComponents;
using OA30.SuperviseMission.UI.CommonComponents.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class DownLoadAttachment : DownFileBase
    {
        private ISuperviseMissionBody _SuperviseMissionBodyBiz = null;
        private ISuperviseMissionBody SuperviseMissionBodyBiz
        {
            get
            {
                if (_SuperviseMissionBodyBiz == null)
                {
                    AppRCObjectActivatorV2 obj = new AppRCObjectActivatorV2();
                    _SuperviseMissionBodyBiz = obj.CreateObject<ISuperviseMissionBody>();
                }
                return _SuperviseMissionBodyBiz;
            }
        }

        protected override void OnPreInit(EventArgs e)
        {
            //判断是否收到CSRF攻击
            if (this.IsPostBack && OA30.Common.Security.CSRFTools.IsAttackByCSRF(this.Request.UrlReferrer, this.Request.Url))
            {
                throw new OA30.Common.Exception.UIExceptions.IsCSRFException(OA30.Common.Exception.UIExceptions.UIExceptionDescriptionCollection.CSRF);
            }

            base.OnPreInit(e);
        }

        protected new void  Page_Load(object sender, EventArgs e)
        {
            
                SendDocAttachment();
             
        }

        private void SendDocAttachment()
        {
            //需要的参数有 SmId, AttachmentId
            string SmId = Request.QueryString["SmId"];
            string AttachmentId = Request.QueryString["AttachmentId"];
            if (string.IsNullOrEmpty(SmId) || string.IsNullOrEmpty(AttachmentId))
            {
                WriteErrorMsg("对不起：未指定要下载的文件！");
                return;
            }

            //检索附件列表
            var attachmentList = SuperviseMissionBodyBiz.GetSmAttachmentEntityList(new SmAttachmentEntity() { SmId=SmId } );
            SmAttachmentEntity attachmentEntity = null;
            if (attachmentList != null && attachmentList.Count > 0)
                attachmentEntity = attachmentList.FirstOrDefault(n => n.AttachmentId == Convert.ToInt32(AttachmentId));
            if (attachmentEntity == null)
            {
                WriteErrorMsg("(1)对不起：未找到指定的附件！");
                return;
            }

            string downloadMode = Request.QueryString["mode"];
            if (downloadMode == null || downloadMode.Trim().ToLower() != "show")
            {
                SendFileAsAttachment(SuperviseMissionConfig.SuperviseMissionAttachmentUrl, attachmentEntity.AttachmentUrl, false, UISecurityUtilitys.RemoveSpecialCharsForAttachmentName(attachmentEntity.AttachmentName));
            }
            else
            {
                //直接发送，不作为附件。
                SendFileData(SuperviseMissionConfig.SuperviseMissionAttachmentUrl, attachmentEntity.AttachmentUrl, false, UISecurityUtilitys.RemoveSpecialCharsForAttachmentName(attachmentEntity.AttachmentName));
            }
        }
    }
}