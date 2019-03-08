using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    /// <summary>
    /// 任务反馈情况
    /// </summary>
    [Serializable]
    public class MissionFeedbackResponeseEntity
    {
        /// <summary>
        /// 领导表单子表ID
        /// </summary>
        public string LmmId { get; set; }

        /// <summary>
        /// 主办单位名称
        /// </summary>
        public string DeptName { get; set; }

        /// <summary>
        /// 完成时间
        /// </summary>
        public string DeadLineTime { get; set; }

        /// <summary>
        /// 完成进度
        /// </summary>
        public int? FinishPercent { get; set; }

        /// <summary>
        /// 意见
        /// </summary>
        public string Opinion { get; set; }
    }
}