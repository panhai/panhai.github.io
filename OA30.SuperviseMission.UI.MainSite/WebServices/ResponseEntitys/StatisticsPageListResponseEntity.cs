using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    [Serializable]
    public class StatisticsPageListResponseEntity : SuperviseMissionResponse
    {

        public int PageIndex
        {
            get;
            set;
        }
        public int TotalCount
        {
            get;
            set;
        }
    }
}