using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys
{
    /// <summary>
    /// 领导行政例会督查任务措施数据请求实体
    /// </summary>
    [Serializable]
    public class LeaderMeetingMeasureRequestEntity
    {
        /// <summary>
        /// 措施名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 协办单位名称集合
        /// </summary>
        public string AssDeptNames { get; set; }
        /// <summary>
        /// 协办单位ID
        /// </summary>
        public string AssDeptIds { get; set; }
        /// <summary>
        /// 完成时间
        /// </summary>
        public DateTime DeadLineTime { get; set; }
        /// <summary>
        /// 责任处室ID
        /// </summary>
        public string DutyDeptName { get; set; }
        /// <summary>
        /// 责任处室名称
        /// </summary>
        public string DutyDeptId { get; set; }
    }
}