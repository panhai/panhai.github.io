using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys
{
    [Serializable]
    public class HistoryFlow
    {
        public string OperatorId { get; set; }
        public string OperatorName { get; set; }
        public string OperaTime { get; set; }
        public string Opintion { get; set; }
        public string StepName { get; set; }
        public string OpintionType { get; set; }

    }

    /// <summary>
    /// 反馈项。
    /// </summary>
    [Serializable]
    public class FeedbackItem
    {
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string HandlerTime { get; set; }
        public string Opinion { get; set; }
        public string OpinionType { get; set; }
        public string StepName { get; set; }
    }

    /// <summary>
    /// 变更项。
    /// </summary>
    [Serializable]
    public class ChangeItem
    {
        public string ChangeId { get; set; }
        public string ChangeTypeName { get; set; }
        public string SubType { get; set; }
        public string Status { get; set; }
        public string Reason { get; set; }
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
        public string CreatorDeptName { get; set; }
        public string CreateTime { get; set; }
        public string SmType { get; set; }
    }
}