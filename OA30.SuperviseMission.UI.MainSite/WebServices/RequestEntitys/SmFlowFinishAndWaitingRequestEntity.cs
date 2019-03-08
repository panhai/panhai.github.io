using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys
{
    public class SmFlowFinishAndWaitingRequestEntity
    {
        public string SmId { get; set; }
        public int? FlowId { get; set; }
        public string FlowType { get; set; }
        public int? ActivityFlag { get; set; }
    }
}