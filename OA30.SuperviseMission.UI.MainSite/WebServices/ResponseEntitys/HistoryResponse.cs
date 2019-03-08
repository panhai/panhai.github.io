using OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    //操作记录
    [Serializable]
    public class HistoryResponse: SuperviseMissionResponse
    { 
        public List<HistoryFlow> historyFlow { get; set; }
    }
}