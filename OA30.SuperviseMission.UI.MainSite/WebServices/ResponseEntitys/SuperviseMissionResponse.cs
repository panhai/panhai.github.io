using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    /// <summary>
    /// 返回请求的 结果
    /// </summary>
    [Serializable]
    public class SuperviseMissionResponse
    {
        public string status;//状态 0 失败 1 成功 其他的状态 可以各自在函数里定义
        public string data;//返回的json
        public string message;// 返回的消息提示
    }
}