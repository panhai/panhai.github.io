using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys
{
    /// <summary>
    /// 自由流发送请求model
    /// </summary>
    [Serializable]
    public class FreeFlowSendRequestEntity
    {
        /// <summary>
        /// 年度目标ID
        /// </summary>
        public string TargetId { get; set; }

        /// <summary>
        /// 完成进度
        /// </summary>
        public string Percent { get; set; }

        /// <summary>
        /// 意见
        /// </summary>
        public string Opinion { get; set; }

        public NextStepModel NextStep { get; set; }
    }

    /// <summary>
    /// 下一步骤处理信息
    /// </summary>
    [Serializable]
    public class NextStepModel
    {
        public string StepId { get; set; }
        public string StepName { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }

        /// <summary>
        /// 1：个人，2：部门
        /// </summary>
        public string RoleType { get; set; }
    }
}