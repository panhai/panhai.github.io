using OA30.SuperviseMission.UI.MainSite.WebServices.CommonEntitys;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OA30.SuperviseMission.UI.MainSite.WebServices.ResponseEntitys
{
    //反馈记录
    [Serializable]
    public class HistoryFeedbackResponse : SuperviseMissionResponse
    {
        public List<HistoryFlow> LeaderFeedbackFlow { get; set; }
        public List<HistoryFlow> MainDeptFeedbackFlow { get; set; }
    }

    /// <summary>
    /// 反馈记录响应流。
    /// </summary>
    [Serializable]
    public class FeedbackResponse : SuperviseMissionResponse
    {
        public List<FeedbackItem> Items { get; set; }
    }
}