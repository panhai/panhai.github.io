using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys
{
    [Serializable]
    public class TargetItem
    {
        public string ItemId { get; set; }
        public string ItemName { get; set; }
        public string AssDeptName { get; set; }
        public string AssDeptId { get; set; }
        public DateTime DeadLine { get; set; }
        public string DeadLineFormat { get; set; }
        public string DutyDeptName { get; set; }
        public string DutyDeptId { get; set; }
        public bool IsSameDept { get; set; }
    }
}