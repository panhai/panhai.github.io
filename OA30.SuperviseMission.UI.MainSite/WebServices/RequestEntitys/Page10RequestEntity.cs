using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys
{
    [Serializable]
    public class Page10RequestEntity
    {
        /// <summary>
        /// 年度目标ID
        /// </summary>
        public string TargetId { get; set; }
        /// <summary>
        /// 子措施ID
        /// </summary>
        public string ItemId { get; set; }
        /// <summary>
        /// 完成进度
        /// </summary>
        public string Finsh_Precent { get; set; }
        /// <summary>
        /// 最新反馈
        /// </summary>
        public string Opinion { get; set; }

        /// <summary>
        /// 对应的流程ID
        /// </summary>
        public string FlowId { get; set; }
    }
}