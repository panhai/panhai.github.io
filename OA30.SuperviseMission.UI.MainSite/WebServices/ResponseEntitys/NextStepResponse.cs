namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    using System;
    using OA30.SuperviseMission.Common.Entity.Mission;

    /// <summary>
    /// 下一步响应流。
    /// </summary>
    [Serializable]
    public class NextStepResponse
    {
        /// <summary>
        /// 下一步。
        /// </summary>
        public NextStepEntity NextStep { get; set; }

        /// <summary>
        /// 所有子措施的叠加意见。
        /// </summary>
        public string Opinion { get; set; }

        /// <summary>
        /// 流程部门Id。
        /// </summary>
        public string FlowDeptId { get; set; }

    }
}