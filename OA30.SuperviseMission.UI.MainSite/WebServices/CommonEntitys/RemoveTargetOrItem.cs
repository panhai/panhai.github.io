using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys
{
    /// <summary>
    /// 移除的年度目标或措施集合
    /// </summary>
    [Serializable]
    public class RemoveTargetOrItem
    {
        public List<string> TargetIds { get; set; }
        public List<string> TargetItemIds { get; set; }
    }
}