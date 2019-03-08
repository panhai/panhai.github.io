using OA30.SuperviseMission.Common.Entity.Mission;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    /// <summary>
    /// 用于page11(措施处理)页面输出措施相关
    /// 领导行政例会督查任务->措施反馈
    /// </summary>
    [Serializable]
    public class MeasureResponseEntity: SmTargetItemEntity
    {
        /// <summary>
        /// 措施详情ID索引
        /// </summary>
        public string MeasureDetailIdIndex { get; set; }

        /// <summary>
        /// 措施反馈内容ID索引
        /// </summary>
        public string MeasureOperateIdIndex { get; set; }

        /// <summary>
        /// 措施对应的流程ID
        /// </summary>
        public string FlowId { get; set; }

        /// <summary>
        /// 措施对应的意见
        /// </summary>
        public string Opinion { get; set; }
    }
}