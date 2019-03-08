using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys
{
    [Serializable]
    public class TargetItemLateRequestEntity
    {
        /// <summary>
        /// 措施ID
        /// </summary>
        public string ItemId { get; set; }

        /// <summary>
        /// 延迟时间
        /// </summary>
        public DateTime? LateTime { get; set; }
    }
}