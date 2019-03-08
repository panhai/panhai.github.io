using OA30.SuperviseMission.Common.Entity.Mission;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    /// <summary>
    /// 用于绑定领导行政例会主办单位
    /// </summary>
    [Serializable]
    public class LeaderMeetingMainDeptResponeEntity : SmLeaderMeetingMissionEntity
    {
        /// <summary>
        /// 主办单位流程ID
        /// </summary>
        public string FlowId { get; set; }
    }
}