using OA30.SuperviseMission.Common.Entity.Mission;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    [Serializable]
    public class MyGroupDeptListResponse: SuperviseMissionResponse
    {    
        public List<DeptGroupListEntity> List { get; set; }
       
    }
}