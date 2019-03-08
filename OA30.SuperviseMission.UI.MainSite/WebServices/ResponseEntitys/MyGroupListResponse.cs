using OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    [Serializable]
    public class MyGroupListResponse: SuperviseMissionResponse
    {      
        public List<DeptNameIdList> List { get; set; }
        
    }
}