namespace OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys
{
    using System;

    /// <summary>
    /// 请求参数基类。
    /// </summary>
    [Serializable]
    public class BaseRequestParameter
    {
        /// <summary>
        /// 任务Id。
        /// </summary>
        public string SmId { get; set; }

        /// <summary>
        /// 被发送对象的流程Id(也可能是当前URL的流程Id)。
        /// </summary>
        public int FlowId { get; set; }

        /// <summary>
        /// 文档类型。
        /// </summary>
        public string SmType { get; set; }
    }

    /// <summary>
    /// 自由流发送请求参数。
    /// </summary>
    [Serializable]
    public class FreeFlowRequestParameter:BaseRequestParameter
    {
        /// <summary>
        /// 目标Id。
        /// </summary>
        public string TargetId { get; set; }

        /// <summary>
        /// 措施或子措施Id。
        /// </summary>
        public string ItemId { get; set; }

        /// <summary>
        /// 步骤Id。
        /// </summary>
        public string StepId { get; set; }

        /// <summary>
        /// 步骤名称。
        /// </summary>
        public string StepName { get; set; }

        /// <summary>
        /// 流程部门Id。
        /// </summary>
        public string FlowDeptId { get; set; }

        /// <summary>
        /// 部门名称。
        /// </summary>
        public string DeptName { get; set; }

        /// <summary>
        /// 用户Id。
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// 用户名称。
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        /// 角色类型。
        /// </summary>
        public string RoleType { get; set; }

        /// <summary>
        /// 意见内容。
        /// </summary>
        public string Opinion { get; set; }

        private string _opinionType = null;
        /// <summary>
        /// 意见类型(默认值为4)。
        /// </summary>
        public string OpinionType {
            get {
                if (String.IsNullOrEmpty(_opinionType)) return "4";
                return _opinionType;
            }
            set
            {
                _opinionType = value;
            }
        }

        /// <summary>
        /// 完成率。
        /// </summary>
        public int FinishPercent { get; set; }
    }

    /// <summary>
    /// 保存进度请求参数。
    /// </summary>
    [Serializable]
    public class SavePercentRequestParameter : BaseRequestParameter
    {
        /// <summary>
        /// 目标Id。
        /// </summary>
        public string TargetId { get; set; }

        /// <summary>
        /// 措施或子措施Id。
        /// </summary>
        public string ItemId { get; set; }

        /// <summary>
        /// 意见内容。
        /// </summary>
        public string Opinion { get; set; }

        private string _opinionType = null;
        /// <summary>
        /// 意见类型(默认值为4)。
        /// </summary>
        public string OpinionType
        {
            get
            {
                if (String.IsNullOrEmpty(_opinionType)) return "4";
                return _opinionType;
            }
            set
            {
                _opinionType = value;
            }
        }

        /// <summary>
        /// 完成率。
        /// </summary>
        public int FinishPercent { get; set; }

        /// <summary>
        /// 是否发送保存。
        /// </summary>
        public bool IsSendSave { get; set; }
    }

    /// <summary>
    /// 退回请求参数。
    /// </summary>
    [Serializable]
    public class BackRequestParameter : BaseRequestParameter
    {
        /// <summary>
        /// 目标Id。
        /// </summary>
        public string TargetId { get; set; }

        /// <summary>
        /// 措施或子措施Id。
        /// </summary>
        public string ItemId { get; set; }

        /// <summary>
        /// 意见内容。
        /// </summary>
        public string Opinion { get; set; }

        private string _opinionType = null;
        /// <summary>
        /// 意见类型(默认值为4)。
        /// </summary>
        public string OpinionType
        {
            get
            {
                if (String.IsNullOrEmpty(_opinionType)) return "4";
                return _opinionType;
            }
            set
            {
                _opinionType = value;
            }
        }
    }

    /// <summary>
    /// 步骤请求参数。
    /// </summary>
    [Serializable]
    public class StepRequestParameter:BaseRequestParameter
    {
        /// <summary>
        /// 目标Id。
        /// </summary>
        public string TargetId { get; set; }

        /// <summary>
        /// 措施或子措施Id。
        /// </summary>
        public string ItemId { get; set; }

        /// <summary>
        /// 步骤Id。
        /// </summary>
        public string StepId { get; set; }

        /// <summary>
        /// 步骤名称。
        /// </summary>
        public string StepName { get; set; }

        /// <summary>
        /// 部门Id。
        /// </summary>
        public string DeptId { get; set; }
    }
}