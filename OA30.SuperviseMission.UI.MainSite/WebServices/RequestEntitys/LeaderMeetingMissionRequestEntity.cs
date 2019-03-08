using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys
{
    /// <summary>
    /// 领导行政例会督查任务
    /// </summary>
    [Serializable]
    public class LeaderMeetingMissionRequestEntity
    {
        public string snName { get; set; }
        public int? snYear { get; set; }
        public DateTime snEndTime { get; set; }
        public DateTime snStartTime { get; set; }
        public string snText { get; set; }
        public string snCompany { get; set; }
        public string snOtherCompany { get; set; }
        public string snCompanyIds { get; set; }
        public string snOtherCompanyIds { get; set; }
        public string snDeptId { get; set; }
        public string snCode { get; set; }
    }
}