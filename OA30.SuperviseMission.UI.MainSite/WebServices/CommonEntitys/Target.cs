using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys
{
    [Serializable]
    public class Target
    {
        public string TargetId { get; set; }
        public string TargetName { get; set; }
        public bool IsSameDept { get; set; }
        public List<TargetItem> Item { get; set; }
    }
}