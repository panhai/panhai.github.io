using OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    //变更记录
    [Serializable]
    public class ChangeRecordResponse : SuperviseMissionResponse
    { 
        public List<ChangeItem> changeItemList { get; set; }
    }
}