using OA30.SuperviseMission.Common.Entity.Mission;
using OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    public class SuperviseMissionExcelImportResponseEntity
    {
        public SmMainEntity SmMainEntity { get; set; }
        public SuperviseMissionExcelImportTips SuperviseMissionExcelImportTips { get; set; }

        public string SnDeptId { get; set; }

        public string SnCode { get; set; }
    }
}