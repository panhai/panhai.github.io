using OA30.SuperviseMission.Common.Entity.Mission;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    /// <summary>
    /// 用于page10（子措施处理）页面输出子措施相关
    /// </summary>
    [Serializable]
    public class SubMeasureResponseEntity: SmTargetItemEntity
    {
        /// <summary>
        /// 最新的意见
        /// </summary>
        public string Opinion { get; set; }

        /// <summary>
        /// 完成时间
        /// </summary>
        public string FinishTime { get; set; }

        /// <summary>
        /// 子措施对应的流程ID
        /// </summary>
        public string FlowId { get; set; }

        /// <summary>
        /// 子措施详情ID索引
        /// </summary>
        public string SubMeasureDetailIdIndex { get; set; }

        /// <summary>
        /// 子措施反馈内容ID索引
        /// </summary>
        public string SubMeasureOperateIdIndex { get; set; }
    }
}