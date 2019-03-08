using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.Common.Entity.MissionBase;
using OA30.SuperviseMission.Common.Interface.Mission;
using OA30.SuperviseMission.RemoteAccess.Client;
using OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys;
using OA30.SuperviseMission.UI.WebSiteInfo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OA30.SuperviseMission.UI.MainSite
{
    public partial class NewYear : BasePage
    {
        private const int TASK_CONTENT_MAX_LENGTH = 400;    // 任务内容数最大限长量。
        protected override void OnPreInit(EventArgs e)
        {
            //判断是否收到CSRF攻击
            if (this.IsPostBack && OA30.Common.Security.CSRFTools.IsAttackByCSRF(this.Request.UrlReferrer, this.Request.Url))
            {
                throw new OA30.Common.Exception.UIExceptions.IsCSRFException(OA30.Common.Exception.UIExceptions.UIExceptionDescriptionCollection.CSRF);
            }

            base.OnPreInit(e);
        }

        #region 属性
        private AppRCObjectActivatorV2 objCreator = new AppRCObjectActivatorV2();

        private ISuperviseMissionBasicData _SMBasicDataBiz = null;
        private ISuperviseMissionBasicData SMBasicDataBiz
        {
            get
            {
                if (_SMBasicDataBiz == null)
                {
                    _SMBasicDataBiz = objCreator.CreateObject<ISuperviseMissionBasicData>();
                }
                return _SMBasicDataBiz;
            }
        }

        private ISuperviseMissionWorkFlow _SMWorkFlow = null;
        private ISuperviseMissionWorkFlow SMWorkFlow
        {
            get
            {
                if (_SMWorkFlow == null)
                {
                    _SMWorkFlow = objCreator.CreateObject<ISuperviseMissionWorkFlow>();
                }
                return _SMWorkFlow;
            }
        }

        #endregion
        #region 变量
        //类型
        public string SmType
        {
            get
            {
                string smType = Request.QueryString["smtype"];
                if (string.IsNullOrEmpty(smType))
                {
                    throw new Exception("smType关键参数不能为空");
                }
                return smType;
            }
        }

        public string LbHeader
        {
            get
            {
                string str = "未知任务类型";
                if (SmType == "ND")
                {
                    str = "新建年度重点工作任务";
                }
                else if (SmType == "QT")
                {
                    str = "其他重要工作任务";
                }
                return str;
            }
        }
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadSP_NUMBER_NAME();
        }

        protected void BtSave_Click(object sender, EventArgs e)
        {
            SaveNewYearSM();
        }

        private void LoadSP_NUMBER_NAME()
        {
            try
            {
                SmBasicDataSuperviseNumberEntity condition = new SmBasicDataSuperviseNumberEntity();
                condition.ActivityFlag = 1;
                //获取该员工所在部门的第一个可见部门，比如管理研发部的部门号，可见部门是信息中心
                string visualDept = SMWorkFlow.GetFlowDeptIdByDeptId(CurrentUserInfo.Dept_ID);
                if (string.IsNullOrEmpty(visualDept))
                    return;
                List<string> deptids = new List<string>();
                deptids.Add(visualDept);
                List<SmBasicDataSuperviseNumberEntity> spList = SMBasicDataBiz.GetSuperviseNumberEntityList(condition, deptids);
                List<SuperviseNumberResponseEntity> spListByDistinct = new List<SuperviseNumberResponseEntity>();
                spListByDistinct.Add(new SuperviseNumberResponseEntity() { DeptId = "", Name = "请选择" });
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
                DDL_SP_NUMBER_NAME.DataValueField = "DeptId";
                DDL_SP_NUMBER_NAME.DataTextField = "Name";
                DDL_SP_NUMBER_NAME.DataSource = spListByDistinct;
                DDL_SP_NUMBER_NAME.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        private void SaveNewYearSM()
        {
            if (!CheckInput())
            {
                return;
            }
            try
            {
                SmMainEntity sme = new SmMainEntity();
                sme.SmId = "";
                sme.ActivityFlag = 1;
                sme.SmType = SmType;//"ND";
                sme.Title = "";
                //sme.WorkFlowId = "DEFAULT";
                sme.CreatorId = CurrentUserInfo.Employee_ID;
                sme.CreatorName = CurrentUserInfo.Name;
                sme.CreatorDeptId = CurrentUserInfo.Dept_ID;
                sme.CreatorDeptName = CurrentUserInfo.Dept_Name;
                sme.CreateTime = DateTime.Now;
                //sme.SpNumberName = DDL_SP_NUMBER_NAME.SelectedItem.Text;
                sme.SpNumberName = hdCurSelectedNumberName.Value.Trim();// 不要取DDL_SP_NUMBER_NAME.SelectedItem.Text，因为option的value存在重复时取不到正确的值。
                sme.SpNumberYear = hdYear.Value;
                sme.SpNumberCode = int.Parse(hdCode.Value);
                sme.TaskContent = Tb_TASK_CONTENT.Text.Trim();
                if (sme.TaskContent.Length > TASK_CONTENT_MAX_LENGTH)
                {
                    throw new InvalidOperationException("任务内容字符数不能大于" + TASK_CONTENT_MAX_LENGTH + "个字符。");
                }
                sme.MainLeaderId = hdMainLeaderIds.Value.Replace(",", ";");
                sme.MainLeaderName = hdMainLeaderNames.Value.Replace(",", ";");
                sme.AssistLeaderId = hdAssLeaderIds.Value.Replace(",", ";");
                sme.AssistLeaderName = hdAssLeaderNames.Value.Replace(",", ";");
                sme.MainDeptId = hdMainDeptIds.Value.Replace(",", ";");
                sme.MainDeptName = hdMainDeptNames.Value.Replace(",", ";");
                sme.AssistDeptId = hdAssDeptIds.Value.Replace(",", ";");
                sme.AssistDeptName = hdAssDeptNames.Value.Replace(",", ";");
                SmFlowWaitingEntity sfwe = new SmFlowWaitingEntity();
                sfwe.UserId = CurrentUserInfo.Employee_ID;
                sfwe.UserName = CurrentUserInfo.Name;
                sfwe.UserDeptId = CurrentUserInfo.Dept_ID;
                sfwe.UserDeptName = CurrentUserInfo.Dept_Name;
                sfwe.Opinion = "";
                sfwe.OpinionType = "4";
                sfwe.UserIdPrev = "";
                sfwe.UserNamePrev = "";
                sfwe.SmType = SmType;
                sfwe.AllowFlag = 1;

                //SMWorkFlow.SaveSmMainForFirstTime(sme, sfwe);
                SMWorkFlow.Send(sme, sfwe, new SmFlowWaitingEntity());
                AlertAndClosePage(this, "创建成功", true);
            }
            catch (Exception ex)
            {
                LbMessage.Text = "保存发生错误:" + ex.Message;
            }
        }

        private bool CheckInput()
        {
            LbMessage.Text = "";
            StringBuilder sb = new StringBuilder();
            if (DDL_SP_NUMBER_NAME.SelectedValue == "" || string.IsNullOrEmpty(hdYear.Value) || string.IsNullOrEmpty(hdCode.Value))
            {
                sb.Append("请选择“南航集团督”；");
            }
            if (string.IsNullOrEmpty(Tb_TASK_CONTENT.Text))
            {
                sb.Append("请填写“任务内容”；");
            }
            if (string.IsNullOrEmpty(hdMainLeaderIds.Value))
            {
                sb.Append("请选择“主管领导”；");
            }
            if (string.IsNullOrEmpty(hdMainDeptIds.Value))
            {
                sb.Append("请选择“主办单位”；");
            }
            if (sb.Length > 0)
            {
                LbMessage.Text = sb.ToString();
                return false;
            }
            else
            {
                return true;
            }

        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            base.OnPreRenderComplete(e);
            // 如果报错了，不要清空表单域数据。
            if (!String.IsNullOrEmpty(LbMessage.Text.Trim()))
            {
                string zgld = "";// 主管领导。
                string xgld = "";// 协管领导。
                string zbdw = "";// 主办单位。
                string xbdw = "";// 协办单位。

                string[] mlnNames = hdMainLeaderNames.Value.Split(',');
                string[] mlnIds = hdMainLeaderIds.Value.Split(',');
                for (int i = 0; i < mlnNames.Length && i < mlnIds.Length; i++)
                {
                    zgld += mlnNames[i] + "（" + mlnIds[i] + "）;";
                }

                string[] alNames = hdAssLeaderNames.Value.Split(',');
                string[] alIds = hdAssLeaderIds.Value.Split(',');
                for (int i = 0; i < alNames.Length && i < alIds.Length; i++)
                {
                    xgld += alNames[i] + "（" + alIds[i] + "）;";
                }

                string[] mdNames = hdMainDeptNames.Value.Split(',');
                string[] adNames = hdAssDeptNames.Value.Split(',');
                for (int i = 0; i < mdNames.Length; i++)
                {
                    zbdw += mdNames[i] + ";";
                }

                for (int i = 0; i < adNames.Length; i++)
                {
                    xbdw += adNames[i] + ";";
                }

                Tb_MainLeader.Text = zgld;
                Tb_AssLeader.Text = xgld;
                Tb_MainDept.Text = zbdw;
                Tb_AssDept.Text = xbdw;

                // 设置当前选定项。
                for (int i = 0; i < DDL_SP_NUMBER_NAME.Items.Count; i++)
                {
                    if (DDL_SP_NUMBER_NAME.Items[i].Text.Trim() == hdCurSelectedNumberName.Value.Trim())
                    {
                        DDL_SP_NUMBER_NAME.Items[i].Selected = true;
                    }
                    else
                    {
                        DDL_SP_NUMBER_NAME.Items[i].Selected = false;
                    }
                }
            }
        }
    }
}