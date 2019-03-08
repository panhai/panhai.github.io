using OA30.SuperviseMission.Common.Entity.Mission;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.RequestEntitys
{
    [Serializable]
    public class StatisticsPageListRequestEntity : SmMainEntity
    {

        public int? PageIndex
        {
            get;
            set;
        }

        public int? PageSize
        {
            get;
            set;
        }

        public string KeyWord
        {
            get;
            set;
        }

        public DateTime? BeginDate
        {
            get;
            set;
        }

        public DateTime? EndDate
        {
            get;
            set;
        }
    }
}