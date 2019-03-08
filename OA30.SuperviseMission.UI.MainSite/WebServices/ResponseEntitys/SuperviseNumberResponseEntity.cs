using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    /// <summary>
    /// 返回督查字号选择的实体
    /// </summary>
    [Serializable]
    public class SuperviseNumberResponseEntity: SuperviseMissionResponse
    {
        /// <summary>
        /// 部门ID
        /// </summary>
        public string DeptId { get; set; }
        /// <summary>
        /// 督查字号名称
        /// </summary>
        public string Name { get; set; }
    }
}