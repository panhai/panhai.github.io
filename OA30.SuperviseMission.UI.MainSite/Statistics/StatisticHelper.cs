using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using OA30.SuperviseMission.Common.Entity.Mission;

namespace OA30.SuperviseMission.UI.MainSite.Statistics
{
    public static class StatisticHelper
    {
        private static string opinion = "";

        #region 报表列表
        /// <summary>
        /// 子措施的表格html
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private static string GetSubSmTargetItemEntityForTdHtml(SmTargetItemEntity model)
        {
            StringBuilder sb = new StringBuilder();
            //if (model == null)
            //{
            //    sb.AppendFormat("<td></td><td></td><td></td><td></td>");
            //}
            //else
            //{
            //    sb.AppendFormat("<td>{0}</td>", model.ItemName);
            //    sb.AppendFormat("<td>{0}</td>", model.FinshPercent == null ? "" : model.FinshPercent.Value.ToString() + "%");
            //    sb.AppendFormat("<td>{0}</td>", opinion);
            //    sb.AppendFormat("<td>{0}</td>", model.ExcutorName);
            //    opinion = "";
            //}
            return sb.ToString();
        }
        /// <summary>
        /// 措施的表格html
        /// </summary>
        /// <param name="model"></param>
        /// <param name="targetItemIndex"></param>
        /// <returns></returns>
        private static string GetSmTargetItemEntityForTdHtml(SmTargetItemEntity model, int targetItemIndex)
        {
            StringBuilder sb = new StringBuilder();
            if (model == null)
            {
                sb.AppendFormat("<td></td><td></td><td></td><td></td><td></td><td></td>");
            }
            else
            {
                //sb.AppendFormat("<td>{0}</td>", targetItemIndex);
                sb.AppendFormat("<td>{0}</td>", model.ItemName);
                sb.AppendFormat("<td>{0}</td>", model.FinshPercent == null ? "" : model.FinshPercent.Value.ToString() + "%");
                sb.AppendFormat("<td>{0}</td>", opinion);
                sb.AppendFormat("<td>{0}</td>", model.DutyDeptName);
                sb.AppendFormat("<td>{0}</td>", model.DeadLineTime == null ? "" : model.DeadLineTime.Value.ToString("yyyy-MM-dd"));
                opinion = "";
            }
            return sb.ToString();
        }
        /// <summary>
        /// 年度任务的表格html
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private static string GetSmTargetEntityForTdHtml(SmTargetEntity model)
        {
            StringBuilder sb = new StringBuilder();
            if (model == null)
            {
                sb.AppendFormat("<td></td><td></td><td></td>");
            }
            else
            {
                sb.AppendFormat("<td>{0}</td>", model.TargetName);
                sb.AppendFormat("<td>{0}</td>", model.TargetPercent == null ? "" : model.TargetPercent.Value.ToString() + "%");
                sb.AppendFormat("<td>{0}</td>", opinion);
                sb.AppendFormat("<td>{0}</td>", model.MainDeptName);
                opinion = "";
            }
            return sb.ToString();
        }
        /// <summary>
        /// 督查任务的表格html
        /// </summary>
        /// <param name="model"></param>
        /// <param name="index"></param>
        /// <returns></returns>
        private static string GetSmMainEntityForTdHtml(SmMainEntity model)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("<td>{0}</td>", model.Index.ToString());
            //sb.AppendFormat("<td>{0}</td>", model.SpNumberName + "【" + model.SpNumberYear + "】" + model.SpNumberCode);
            sb.AppendFormat("<td>{0}</td>", model.TaskContent);
            //sb.AppendFormat("<td>{0}</td>", model.FinshPercent == null ? "" : model.FinshPercent.Value.ToString() + "%");
            //sb.AppendFormat("<td>{0}</td>", opinion);
            //sb.AppendFormat("<td>{0}</td>", model.MainLeaderName);
            //sb.AppendFormat("<td>{0}</td>", model.AssistLeaderName);
            //opinion = "";
            //sb.AppendFormat("<td>{0}</td>", model.MainDeptName);
            //sb.AppendFormat("<td>{0}</td>", model.MissionStatusName);
            return sb.ToString();
        }

        /// <summary>
        /// 一个措施，包含它的子措施的表格html
        /// </summary>
        /// <param name="model">措施</param>
        /// <param name="sublist">子措施列表</param>
        /// <param name="index">措施序号</param>
        /// <param name="rowSpan">返回有tr行数，也就是年度目标需要合并的行数</param>
        /// <returns></returns>
        private static string GetTargetItemForhtml(SmTargetItemEntity model, List<SmTargetItemEntity> sublist, int index, List<SmFlowFinishEntity> flowFinishList, ref int rowSpan)
        {
            int temprowspan = 1;
            StringBuilder sb = new StringBuilder();
            //获取到措施的html
            string TargetItemHtml = GetSmTargetItemEntityForTdHtml(null, index);
            string SubTargetItemHtml = GetSubSmTargetItemEntityForTdHtml(null);
            if (model == null)
            {
                // 没有措施，也就不存在子措施
                sb.Append(SubTargetItemHtml);
                sb.Append("</tr>");
            }
            else
            {
                TargetItemHtml = GetSmTargetItemEntityForTdHtml(model, index);
                // 有措施
                if (sublist != null && sublist.Count > 0)
                {
                    //有子措施
                    if (sublist.Count > 1)
                    {
                        for (int i = 0; i < sublist.Count; i++)
                        {
                            if (i == 0)
                            {
                                //第一条子措施
                                GetTargetItemOpinion(sublist[i], flowFinishList);
                                SubTargetItemHtml = GetSubSmTargetItemEntityForTdHtml(sublist[i]);
                                sb.Append(SubTargetItemHtml);
                                sb.Append("</tr>");
                            }
                            else
                            {
                                temprowspan++;
                                GetTargetItemOpinion(sublist[i], flowFinishList);
                                SubTargetItemHtml = GetSubSmTargetItemEntityForTdHtml(sublist[i]);
                                sb.Append("<tr>");
                                sb.Append(SubTargetItemHtml);
                                sb.Append("</tr>");
                            }
                        }
                    }
                    else
                    {
                        //只有一条子措施
                        GetTargetItemOpinion(sublist[0], flowFinishList);
                        SubTargetItemHtml = GetSubSmTargetItemEntityForTdHtml(sublist[0]);
                        sb.Append(SubTargetItemHtml);
                        sb.Append("</tr>");
                    }
                }
                else
                {
                    //没有子措施
                    sb.Append(SubTargetItemHtml);
                    sb.Append("</tr>");
                }
                rowSpan = temprowspan;
                if (rowSpan > 1)
                {
                    TargetItemHtml = TargetItemHtml.Replace("<td>", "<td rowspan='" + rowSpan + "'>");
                }
            }
            return TargetItemHtml + sb.ToString();
        }
        /// <summary>
        /// 一个年度目标，包含它的措施以及子措施
        /// </summary>
        /// <param name="model">年度目标</param>
        /// <param name="allList">年度目标下的所有措施和子措施</param>
        /// <param name="targetRowSpan">返回的tr总行数，也就是督查任务需要合并的tr行数</param>
        /// <returns></returns>
        private static string GetTargetForhtml(SmTargetEntity model, List<SmTargetItemEntity> allList, List<SmFlowFinishEntity> flowFinishList, ref int targetRowSpan)
        {
            targetRowSpan = 0;
            int tempTargetRowSpan = 1;
            StringBuilder sb = new StringBuilder();
            //获取到年度目标的html
            string TargetHtml = GetSmTargetEntityForTdHtml(null);
            string TargetItemHtml = GetTargetItemForhtml(null, null, 1, flowFinishList, ref tempTargetRowSpan);

            if (model == null)
            {
                //sb.Append(TargetHtml);
                sb.Append(TargetItemHtml);
                targetRowSpan = tempTargetRowSpan;
            }
            else
            {
                //获取年度目标的HTML
                TargetHtml = GetSmTargetEntityForTdHtml(model);

                if (allList != null && allList.Count > 0)
                {
                    //有措施和子措施
                    if (allList.Count > 1)
                    {
                        //获取得到年度目标的措施
                        var firstTargetItem = allList.Where<SmTargetItemEntity>(n => n.ParentTargetItemId == null || n.ParentTargetItemId == "").ToList();
                        if (firstTargetItem != null || firstTargetItem.Count > 0)
                        {
                            if (firstTargetItem.Count > 1)
                            {
                                //措施大于一条
                                for (int i = 0; i < firstTargetItem.Count; i++)
                                {
                                    //获取措施的子措施
                                    var subTargetItem = allList.Where<SmTargetItemEntity>(n => n.ParentTargetItemId == firstTargetItem[i].ItemId).ToList();
                                    if (i == 0)
                                    {
                                        int temprowspan = 1;
                                        GetTargetItemOpinion(firstTargetItem[i], flowFinishList);
                                        TargetItemHtml = GetTargetItemForhtml(firstTargetItem[i], subTargetItem, (i + 1), flowFinishList, ref temprowspan);
                                        targetRowSpan += temprowspan;
                                        sb.Append(TargetItemHtml);
                                    }
                                    else
                                    {
                                        int temprowspan = 1;
                                        GetTargetItemOpinion(firstTargetItem[i], flowFinishList);
                                        TargetItemHtml = GetTargetItemForhtml(firstTargetItem[i], subTargetItem, (i + 1), flowFinishList, ref temprowspan);
                                        targetRowSpan += temprowspan;
                                        sb.Append("<tr>");
                                        sb.Append(TargetItemHtml);
                                    }
                                }
                            }
                            else
                            {
                                //只有一条措施
                                var subTargetItem = allList.Where<SmTargetItemEntity>(n => n.ParentTargetItemId == firstTargetItem[0].ItemId).ToList();
                                int temprowspan = 1;
                                GetTargetItemOpinion(firstTargetItem[0], flowFinishList);
                                TargetItemHtml = GetTargetItemForhtml(firstTargetItem[0], subTargetItem, 1, flowFinishList, ref temprowspan);
                                targetRowSpan += temprowspan;
                                sb.Append(TargetItemHtml);
                            }
                        }
                        else
                        {
                            //没有任何措施，实际上这条分支应该永远走不上，如果走上了，就表明数据库表里面的数据有问题
                            int temprowspan = 1;
                            GetTargetItemOpinion(firstTargetItem[0], flowFinishList);
                            TargetItemHtml = GetTargetItemForhtml(null, null, 1, flowFinishList, ref temprowspan);
                            targetRowSpan += temprowspan;
                            sb.Append(TargetItemHtml);
                        }
                    }
                    else
                    {
                        //年度目标的措施和子措施只有一条，则这一条一定是措施，而不是子措施，如果不是，则数据库表里数据有问题
                        int temprowspan = 1;
                        GetTargetItemOpinion(allList[0], flowFinishList);
                        TargetItemHtml = GetTargetItemForhtml(allList[0], null, 1, flowFinishList, ref temprowspan);
                        targetRowSpan += temprowspan;
                        sb.Append(TargetItemHtml);
                    }
                }
                else
                {
                    //没有任何措施
                    sb.Append(TargetItemHtml);
                    targetRowSpan = tempTargetRowSpan;
                }
                if (targetRowSpan > 1)
                {
                    TargetHtml = TargetHtml.Replace("<td>", "<td rowspan='" + targetRowSpan + "'>");
                }

            }
            return TargetHtml + sb.ToString();
        }

        //获取目标 最新反馈
        private static void GetTargetOpinion(SmTargetEntity targetEntity, List<SmFlowFinishEntity> flowFinishList)
        {

            // 取目标最新意见的条件为主办单位+主办单位目标反馈步骤。
            // 先取出目标的主办单位。&& e.StepId == "ZBDWMBFK"&& e.FlowDeptId.StartsWith(targetEntity.MainDeptId)
            if (targetEntity != null)
            {
                SmFlowFinishEntity ff = flowFinishList.Where(e => e.TargetId == targetEntity.TargetId && e.Opinion != null && e.Opinion != "" && (e.StepId == "ZBDWMBFK" || e.StepId == "CSFK" || e.StepId == "BGTRWFK")).OrderByDescending(e => e.FlowId).FirstOrDefault();

                if (ff != null)
                {
                    opinion = Convert.ToDateTime(ff.FinishTime).ToString("yyyy-MM-dd") + " " + ff.UserName + ":" + ff.Opinion;
                }
            }

        }

        //获取任务 最新反馈
        private static void GetSMMainOpinion(SmMainEntity model, List<SmFlowFinishEntity> flowFinishList)
        {

            // 取目标最新意见的条件为主办单位+主办单位目标反馈步骤。
            // 先取出目标的主办单位。&& e.StepId == "ZBDWMBFK"&& e.FlowDeptId.StartsWith(targetEntity.MainDeptId)
            if (model != null)
            {
                SmFlowFinishEntity ff = flowFinishList.Where(e => e.SmId == model.SmId && e.SmType == model.SmType && e.Opinion != null && e.OpinionType != "8" && e.Opinion != "" && (e.StepId == "ZBDWRWFK" || e.StepId == "BGTRWFK")).OrderByDescending(e => e.FlowId).FirstOrDefault();

                if (ff != null)
                {
                    opinion = Convert.ToDateTime(ff.FinishTime).ToString("yyyy-MM-dd") + " " + ff.UserName + ":" + ff.Opinion;
                }
            }

        }

        //获取措施最新反馈
        private static void GetTargetItemOpinion(SmTargetItemEntity itemEntity, List<SmFlowFinishEntity> flowFinishList)
        {
            SmFlowFinishEntity ff = null;
            // 如果ParentTargetItemId为null此ItemId为父措施，否则为子措施。
            if (itemEntity.ParentTargetItemId == null)
            {
                // 父措施取责任处室为条件。
                // 父措施先从待办表获取，因为ZRDWCSFK和CSFK是保留待办的。
                var fw = flowFinishList.Where(e => e.TargetItemId == itemEntity.ItemId && e.Opinion != null && e.Opinion != "" && (e.StepId == "ZRCSCSFK" || e.StepId == "ZRDWCSFK" || e.StepId == "CSFK" || e.StepId == "ZBDWMBTJ" || e.StepId == "ZRCSCSTJ")).OrderByDescending(e => e.FlowId).FirstOrDefault();
                if (fw != null)
                {
                    opinion = Convert.ToDateTime(fw.FinishTime).ToString("yyyy-MM-dd") + " " + fw.UserName + ":" + fw.Opinion;
                }
                else
                {
                    // 若待办没有则去已办找。
                    ff = flowFinishList.Where(e => e.TargetItemId == itemEntity.ItemId && e.Opinion != null && e.Opinion != "" && (e.StepId == "ZRCSCSFK" || e.StepId == "ZRDWCSFK" || e.StepId == "CSFK" || e.StepId == "ZBDWMBTJ" || e.StepId == "ZRCSCSTJ")).OrderByDescending(e => e.FlowId).FirstOrDefault();
                }
            }
            else
            {
                // 子措施条件为责任人。
                ff = flowFinishList.Where(e => e.TargetItemId == itemEntity.ItemId && e.Opinion != null && e.Opinion != "" && e.UserId == itemEntity.ExcutorId && (e.StepId == "ZCSFK")).OrderByDescending(e => e.FinishTime).FirstOrDefault();
            }

            if (ff != null)
            {
                opinion = Convert.ToDateTime(ff.FinishTime).ToString("yyyy-MM-dd") + " " + ff.UserName + ":" + ff.Opinion;
            }
        }

        /// <summary>
        /// 获取一个督查任务统计表格的html
        /// </summary>
        /// <param name="model">督查任务</param>
        /// <param name="subList">督查任务的年度目标列表</param>
        /// <param name="allList">督查任务的所有措施和子措施</param>
        /// <param name="index">督查任务的序号</param>
        /// <returns></returns>
        public static string GetSmMainForhtml(SmMainEntity model, List<SmTargetEntity> subList, List<SmTargetItemEntity> allList, List<SmFlowFinishEntity> flowFinishList)
        {
            int rowspan = 0;
            int temprowspan = 1;
            StringBuilder sb = new StringBuilder();
            //获取到督查任务HTML
            GetSMMainOpinion(model, flowFinishList);
            string smMainHtml = GetSmMainEntityForTdHtml(model);
            string TargetHtml = GetTargetForhtml(null, null, flowFinishList, ref temprowspan);
            if (subList != null && subList.Count > 0)
            {
                //有年度目标
                if (subList.Count > 1)
                {
                    //年度目标有多条
                    for (int i = 0; i < subList.Count; i++)
                    {
                        //获取年度目标额所有措施和子措施
                        var TargetItem = allList.Where<SmTargetItemEntity>(n => n.TargetId == subList[i].TargetId).ToList();


                        if (i == 0)
                        {
                            GetTargetOpinion(subList[i], flowFinishList);
                            int temprowspan1 = 1;
                            TargetHtml = GetTargetForhtml(subList[i], TargetItem, flowFinishList, ref temprowspan1);
                            rowspan += temprowspan1;
                            sb.Append(TargetHtml);
                        }
                        else
                        {
                            GetTargetOpinion(subList[i], flowFinishList);
                            int temprowspan1 = 1;
                            TargetHtml = GetTargetForhtml(subList[i], TargetItem, flowFinishList, ref temprowspan1);
                            rowspan += temprowspan1;
                            sb.Append("<tr>");
                            sb.Append(TargetHtml);
                        }
                    }
                }
                else
                {
                    //督查任务的年度目标只有一条，措施和子措施全部都是此年度目标的
                    int temprowspan1 = 1;
                    GetTargetOpinion(subList[0], flowFinishList);
                    TargetHtml = GetTargetForhtml(subList[0], allList, flowFinishList, ref temprowspan1);
                    rowspan += temprowspan1;
                    sb.Append(TargetHtml);
                }
            }
            else
            {
                //没有任何年度目标，当然也就没有任何的措施或者子措施
                sb.Append(TargetHtml);
            }

            if (rowspan > 1)
            {
                smMainHtml = smMainHtml.Replace("<td>", "<td rowspan='" + rowspan + "'>");
            }
            return "<tr>" + smMainHtml + sb.ToString();
        }
        #endregion



        #region 报表详情列表


        /// <summary>
        /// 子措施的表格html
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private static string GetSubSmTargetItemDetailEntityForTdHtml(SmTargetItemEntity model)
        {
            StringBuilder sb = new StringBuilder();
            if (model == null)
            {
                sb.AppendFormat("<td></td><td></td><td></td><td></td>");
            }
            else
            {
                sb.AppendFormat("<td>{0}</td>", model.ItemName);
                sb.AppendFormat("<td>{0}</td>", model.FinshPercent == null ? "" : model.FinshPercent.Value.ToString() + "%");
                sb.AppendFormat("<td>{0}</td>", opinion);
                sb.AppendFormat("<td>{0}</td>", model.ExcutorName);
                opinion = "";
            }
            return sb.ToString();
        }
        /// <summary>
        /// 措施的表格html
        /// </summary>
        /// <param name="model"></param>
        /// <param name="targetItemIndex"></param>
        /// <returns></returns>
        private static string GetSmTargetItemDetailEntityForTdHtml(SmTargetItemEntity model, int targetItemIndex)
        {
            StringBuilder sb = new StringBuilder();
            if (model == null)
            {
                sb.AppendFormat("<td></td><td></td><td></td><td></td><td></td><td></td><td></td>");
            }
            else
            {
                sb.AppendFormat("<td>{0}</td>", targetItemIndex);
                sb.AppendFormat("<td>{0}</td>", model.ItemName);
                sb.AppendFormat("<td>{0}</td>", model.DeadLineTime == null ? "" : model.DeadLineTime.Value.ToString("yyyy-MM-dd"));
                sb.AppendFormat("<td>{0}</td>", model.FinshPercent == null ? "" : model.FinshPercent.Value.ToString() + "%");
                sb.AppendFormat("<td>{0}</td>", opinion);
                sb.AppendFormat("<td>{0}</td>", model.DutyDeptName);
                opinion = "";
            }
            return sb.ToString();
        }
        /// <summary>
        /// 年度任务的表格html
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private static string GetSmTargetDetailEntityForTdHtml(SmTargetEntity model)
        {
            StringBuilder sb = new StringBuilder();
            if (model == null)
            {
                sb.AppendFormat("<td></td><td></td><td></td>");
            }
            else
            {
                sb.AppendFormat("<td>{0}</td>", model.MainDeptName);
                sb.AppendFormat("<td>{0}</td>", model.TargetName);
                sb.AppendFormat("<td>{0}</td>", model.TargetPercent == null ? "" : model.TargetPercent.Value.ToString() + "%");
                sb.AppendFormat("<td>{0}</td>", opinion);
                opinion = "";
            }
            return sb.ToString();
        }
        /// <summary>
        /// 督查任务的表格html
        /// </summary>
        /// <param name="model"></param>
        /// <param name="index"></param>
        /// <returns></returns>
        private static string GetSmMainDetailEntityForTdHtml(SmMainEntity model)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("<td>{0}</td>", model.Index.ToString());
            sb.AppendFormat("<td>{0}</td>", model.SpNumberName + "【" + model.SpNumberYear + "】" + model.SpNumberCode);
            sb.AppendFormat("<td>{0}</td>", model.TaskContent);
            sb.AppendFormat("<td>{0}</td>", model.FinshPercent == null ? "" : model.FinshPercent.Value.ToString() + "%");
            sb.AppendFormat("<td>{0}</td>", opinion);
            sb.AppendFormat("<td>{0}</td>", model.MainLeaderName);
            sb.AppendFormat("<td>{0}</td>", model.AssistLeaderName);
            opinion = "";
            //sb.AppendFormat("<td>{0}</td>", model.MainDeptName);
            //sb.AppendFormat("<td>{0}</td>", model.MissionStatusName);
            return sb.ToString();
        }

        /// <summary>
        /// 一个措施，包含它的子措施的表格html
        /// </summary>
        /// <param name="model">措施</param>
        /// <param name="sublist">子措施列表</param>
        /// <param name="index">措施序号</param>
        /// <param name="rowSpan">返回有tr行数，也就是年度目标需要合并的行数</param>
        /// <returns></returns>
        private static string GetTargetItemDetailForhtml(SmTargetItemEntity model, List<SmTargetItemEntity> sublist, int index, List<SmFlowFinishEntity> flowFinishList, ref int rowSpan)
        {
            int temprowspan = 1;
            StringBuilder sb = new StringBuilder();
            //获取到措施的html
            string TargetItemHtml = GetSmTargetItemDetailEntityForTdHtml(null, index);
            string SubTargetItemHtml = GetSubSmTargetItemDetailEntityForTdHtml(null);
            if (model == null)
            {
                // 没有措施，也就不存在子措施
                sb.Append(SubTargetItemHtml);
                sb.Append("</tr>");
            }
            else
            {
                TargetItemHtml = GetSmTargetItemDetailEntityForTdHtml(model, index);
                // 有措施
                if (sublist != null && sublist.Count > 0)
                {
                    //有子措施
                    if (sublist.Count > 1)
                    {
                        for (int i = 0; i < sublist.Count; i++)
                        {
                            if (i == 0)
                            {
                                //第一条子措施
                                GetTargetItemOpinion(sublist[i], flowFinishList);
                                SubTargetItemHtml = GetSubSmTargetItemDetailEntityForTdHtml(sublist[i]);
                                sb.Append(SubTargetItemHtml);
                                sb.Append("</tr>");
                            }
                            else
                            {
                                temprowspan++;
                                GetTargetItemOpinion(sublist[i], flowFinishList);
                                SubTargetItemHtml = GetSubSmTargetItemDetailEntityForTdHtml(sublist[i]);
                                sb.Append("<tr>");
                                sb.Append(SubTargetItemHtml);
                                sb.Append("</tr>");
                            }
                        }
                    }
                    else
                    {
                        //只有一条子措施
                        GetTargetItemOpinion(sublist[0], flowFinishList);
                        SubTargetItemHtml = GetSubSmTargetItemDetailEntityForTdHtml(sublist[0]);
                        sb.Append(SubTargetItemHtml);
                        sb.Append("</tr>");
                    }
                }
                else
                {
                    //没有子措施
                    sb.Append(SubTargetItemHtml);
                    sb.Append("</tr>");
                }
                rowSpan = temprowspan;
                if (rowSpan > 1)
                {
                    TargetItemHtml = TargetItemHtml.Replace("<td>", "<td rowspan='" + rowSpan + "'>");
                }
            }
            return TargetItemHtml + sb.ToString();
        }

        /// <summary>
        /// 一个年度目标，包含它的措施以及子措施
        /// </summary>
        /// <param name="model">年度目标</param>
        /// <param name="allList">年度目标下的所有措施和子措施</param>
        /// <param name="targetRowSpan">返回的tr总行数，也就是督查任务需要合并的tr行数</param>
        /// <returns></returns>
        private static string GetTargetDetailForhtml(SmTargetEntity model, List<SmTargetItemEntity> allList, List<SmFlowFinishEntity> flowFinishList, ref int targetRowSpan)
        {
            targetRowSpan = 0;
            int tempTargetRowSpan = 1;
            StringBuilder sb = new StringBuilder();
            //获取到年度目标的html
            string TargetHtml = GetSmTargetDetailEntityForTdHtml(null);
            string TargetItemHtml = GetTargetItemDetailForhtml(null, null, 1, flowFinishList, ref tempTargetRowSpan);

            if (model == null)
            {
                //sb.Append(TargetHtml);
                sb.Append(TargetItemHtml);
                targetRowSpan = tempTargetRowSpan;
            }
            else
            {
                //获取年度目标的HTML
                TargetHtml = GetSmTargetDetailEntityForTdHtml(model);

                if (allList != null && allList.Count > 0)
                {
                    //有措施和子措施
                    if (allList.Count > 1)
                    {
                        //获取得到年度目标的措施
                        var firstTargetItem = allList.Where<SmTargetItemEntity>(n => n.ParentTargetItemId == null || n.ParentTargetItemId == "").ToList();
                        if (firstTargetItem != null || firstTargetItem.Count > 0)
                        {
                            if (firstTargetItem.Count > 1)
                            {
                                //措施大于一条
                                for (int i = 0; i < firstTargetItem.Count; i++)
                                {
                                    //获取措施的子措施
                                    var subTargetItem = allList.Where<SmTargetItemEntity>(n => n.ParentTargetItemId == firstTargetItem[i].ItemId).ToList();
                                    if (i == 0)
                                    {
                                        int temprowspan = 1;
                                        GetTargetItemOpinion(firstTargetItem[i], flowFinishList);
                                        TargetItemHtml = GetTargetItemDetailForhtml(firstTargetItem[i], subTargetItem, (i + 1), flowFinishList, ref temprowspan);
                                        targetRowSpan += temprowspan;
                                        sb.Append(TargetItemHtml);
                                    }
                                    else
                                    {
                                        int temprowspan = 1;
                                        GetTargetItemOpinion(firstTargetItem[i], flowFinishList);
                                        TargetItemHtml = GetTargetItemDetailForhtml(firstTargetItem[i], subTargetItem, (i + 1), flowFinishList, ref temprowspan);
                                        targetRowSpan += temprowspan;
                                        sb.Append("<tr>");
                                        sb.Append(TargetItemHtml);
                                    }
                                }
                            }
                            else
                            {
                                //只有一条措施
                                var subTargetItem = allList.Where<SmTargetItemEntity>(n => n.ParentTargetItemId == firstTargetItem[0].ItemId).ToList();
                                int temprowspan = 1;
                                GetTargetItemOpinion(firstTargetItem[0], flowFinishList);
                                TargetItemHtml = GetTargetItemDetailForhtml(firstTargetItem[0], subTargetItem, 1, flowFinishList, ref temprowspan);
                                targetRowSpan += temprowspan;
                                sb.Append(TargetItemHtml);
                            }
                        }
                        else
                        {
                            //没有任何措施，实际上这条分支应该永远走不上，如果走上了，就表明数据库表里面的数据有问题
                            int temprowspan = 1;
                            GetTargetItemOpinion(firstTargetItem[0], flowFinishList);
                            TargetItemHtml = GetTargetItemDetailForhtml(null, null, 1, flowFinishList, ref temprowspan);
                            targetRowSpan += temprowspan;
                            sb.Append(TargetItemHtml);
                        }
                    }
                    else
                    {
                        //年度目标的措施和子措施只有一条，则这一条一定是措施，而不是子措施，如果不是，则数据库表里数据有问题
                        int temprowspan = 1;
                        GetTargetItemOpinion(allList[0], flowFinishList);
                        TargetItemHtml = GetTargetItemDetailForhtml(allList[0], null, 1, flowFinishList, ref temprowspan);
                        targetRowSpan += temprowspan;
                        sb.Append(TargetItemHtml);
                    }
                }
                else
                {
                    //没有任何措施
                    sb.Append(TargetItemHtml);
                    targetRowSpan = tempTargetRowSpan;
                }
                if (targetRowSpan > 1)
                {
                    TargetHtml = TargetHtml.Replace("<td>", "<td rowspan='" + targetRowSpan + "'>");
                }

            }
            return TargetHtml + sb.ToString();
        }

        /// <summary>
        /// 获取一个督查任务详情统计表格的html
        /// </summary>
        /// <param name="model">督查任务</param>
        /// <param name="subList">督查任务的年度目标列表</param>
        /// <param name="allList">督查任务的所有措施和子措施</param>
        /// <param name="index">督查任务的序号</param>
        /// <returns></returns>
        public static string GetSmMainDetailForhtml(SmMainEntity model, List<SmTargetEntity> subList, List<SmTargetItemEntity> allList, List<SmFlowFinishEntity> flowFinishList)
        {
            int rowspan = 0;
            int temprowspan = 1;
            StringBuilder sb = new StringBuilder();
            //获取到督查任务HTML
            GetSMMainOpinion(model, flowFinishList);
            string smMainHtml = GetSmMainDetailEntityForTdHtml(model);
            string TargetHtml = GetTargetDetailForhtml(null, null, flowFinishList, ref temprowspan);
            if (subList != null && subList.Count > 0)
            {
                //有年度目标
                if (subList.Count > 1)
                {
                    //年度目标有多条
                    for (int i = 0; i < subList.Count; i++)
                    {
                        //获取年度目标额所有措施和子措施
                        var TargetItem = allList.Where<SmTargetItemEntity>(n => n.TargetId == subList[i].TargetId).ToList();


                        if (i == 0)
                        {
                            GetTargetOpinion(subList[i], flowFinishList);
                            int temprowspan1 = 1;
                            TargetHtml = GetTargetDetailForhtml(subList[i], TargetItem, flowFinishList, ref temprowspan1);
                            rowspan += temprowspan1;
                            sb.Append(TargetHtml);
                        }
                        else
                        {
                            GetTargetOpinion(subList[i], flowFinishList);
                            int temprowspan1 = 1;
                            TargetHtml = GetTargetDetailForhtml(subList[i], TargetItem, flowFinishList, ref temprowspan1);
                            rowspan += temprowspan1;
                            sb.Append("<tr>");
                            sb.Append(TargetHtml);
                        }
                    }
                }
                else
                {
                    //督查任务的年度目标只有一条，措施和子措施全部都是此年度目标的
                    int temprowspan1 = 1;
                    GetTargetOpinion(subList[0], flowFinishList);
                    TargetHtml = GetTargetDetailForhtml(subList[0], allList, flowFinishList, ref temprowspan1);
                    rowspan += temprowspan1;
                    sb.Append(TargetHtml);
                }
            }
            else
            {
                //没有任何年度目标，当然也就没有任何的措施或者子措施
                sb.Append(TargetHtml);
            }

            if (rowspan > 1)
            {
                smMainHtml = smMainHtml.Replace("<td>", "<td rowspan='" + rowspan + "'>");
            }
            return "<tr>" + smMainHtml + sb.ToString();
        }

        #endregion



    }
}