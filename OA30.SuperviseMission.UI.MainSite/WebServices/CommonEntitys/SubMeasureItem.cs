using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys
{

    /// <summary>
    /// 子措施集合
    /// </summary>
    [Serializable]
    public class SubMeasureItem
    {
        /// <summary>
        /// 年度目标ID
        /// </summary>
        public string TargetId { get; set; }
        /// <summary>
        /// 对应的措施ID
        /// </summary>
        public string MeasureId { get; set; }
        /// <summary>
        /// 子措施名称
        /// </summary>
        public string ItemName { get; set; }
        /// <summary>
        /// 协办单位名称
        /// </summary>
        public string AssDeptName { get; set; }
        /// <summary>
        /// 协办单位ID
        /// </summary>
        public string AssDeptId { get; set; }
        /// <summary>
        /// 完成时限
        /// </summary>
        public DateTime DeadLine { get; set; }
        /// <summary>
        /// 责任人名称
        /// </summary>
        public string DutyUserName { get; set; }
        /// <summary>
        /// 责任人工号
        /// </summary>
        public string DutyUserId { get; set; }
    }
}