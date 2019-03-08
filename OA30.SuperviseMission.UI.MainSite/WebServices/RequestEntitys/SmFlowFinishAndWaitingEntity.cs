using OA30.SuperviseMission.Common.Entity.Mission;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys
{
    public class SmFlowFinishAndWaitingEntity
    {
        public int? FlowId { get; set; }
        public SmFlowFinishEntity SmFlowFinishEntity { get; set; }

        public SmFlowWaitingEntity SmFlowWaitingEntity { get; set; }
    }
}