using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Data;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class Pending : BasePage
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
        #region 接口属性
        private AppRCObjectActivatorV2 objCreator = new AppRCObjectActivatorV2();

        private ISuperviseMissionBody _SMBodyBiz = null;
        private ISuperviseMissionBody SMBodyBiz
        {
            get
            {
                if (_SMBodyBiz == null)
                {
                    _SMBodyBiz = objCreator.CreateObject<ISuperviseMissionBody>();
                }
                return _SMBodyBiz;
            }
        }

        private ISuperviseMissionWorkFlow _SuperviseMissionWorkFlow;
        private ISuperviseMissionWorkFlow SuperviseMissionWorkFlow
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

        public string DisplayType
        {
            get
            {
                string str = "display:block";
                try
                {
                    bool isLeader = SMBodyBiz.CheckUserIsLeader(this.CurrentUserInfo.Employee_ID);
                    if (!isLeader)
                        str = "display:none";
                }
                catch (Exception ex)
                {

                }
                return str;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = SMBodyBiz.GetMyBox(CurrentUserInfo.Employee_ID);              
                InitNDJob(dt);
                InitLDJob(dt);
                InitZJJob(dt);
                InitQTJob(dt);
            }
        }

        private DataTable SelectDataTable(string type, DataTable dt)
        {
            DataTable newDt = dt.Clone();
            var selectDr = dt.Select("SM_TYPE = '" + type + "'", "RECEIVE_TIME desc");
            for (int i = 0; i < selectDr.Length; i++)
            {
                //if (i == 10)
                //{
                //    break;
                //}else
                //{
                //拿前面10条数据
                newDt.Rows.Add(selectDr[i].ItemArray);
                //}
            }
            newDt.AcceptChanges();
            return newDt;
        }

        private DataTable SelectDataTableByChange(string type, DataTable dt)
        {
            DataTable newDt = dt.Clone();
            var selectDr = dt.Select("SM_TYPE = '" + type + "'", "RECEIVE_TIME desc");
            for (int i = 0; i < selectDr.Length; i++)
            {
                //if (i == 10)
                //{
                //    break;
                //}else
                //{
                //拿前面10条数据
                newDt.Rows.Add(selectDr[i].ItemArray);
                //}
            }
            newDt.AcceptChanges();
            return newDt;
        }
        private void InitNDJob(DataTable dt)
        {
            RpNDJob.DataSource = SelectDataTable("ND", dt);
            RpNDJob.DataBind();
        }
        private void InitLDJob(DataTable dt)
        {
            RpLDJob.DataSource = SelectDataTable("LD", dt);
            RpLDJob.DataBind();
        }

        private void InitZJJob(DataTable dt)
        {
            RpZJJob.DataSource = SelectDataTable("ZJ", dt);
            RpZJJob.DataBind();
        }

        private void InitQTJob(DataTable dt)
        {
            RpQTJob.DataSource = SelectDataTable("QT", dt);
            RpQTJob.DataBind();
        }

        protected string MissionStatusStr(string code)
        {
            string str = "未知状态";
            switch (code)
            {
                case "NG":
                    str = "拟稿";
                    break;
                case "FJ":
                    str = "任务分解中";
                    break;
                case "SP":
                    str = "分解审批中";
                    break;
                case "QR":
                    str = "任务确认中";
                    break;
                case "TJ":
                    str = "任务推进中";
                    break;
                case "BJ":
                    str = "任务办结";
                    break;
                default:
                    break;
            }
            return str;
        }
    }

}