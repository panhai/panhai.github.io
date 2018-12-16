﻿//0名称 1父级编号 2编号 3别名
var positionArray = [
["销售|市场|淘宝|客服", "0", "100000", "xssckf"],
["销售业务", "100000", "101000", "xsyw"],
["销售代表", "101000", "101010", "xsdb"],
["销售工程师", "101000", "101011", "xsgcs"],
["客户代表/大客户代表", "101000", "101012", "khdb"],
["业务拓展专员/助理", "101000", "101013", "ywtz"],
["电话销售", "101000", "101014", "dhxs"],
["网络/在线销售", "101000", "101015", "zxxs"],
["渠道分销专员/助理", "101000", "101017", "qdfx"],
["团购销售", "101000", "101018", "tgzy"],
["医药代表", "101000", "101019", "yydb"],
["商务助理", "101000", "101020", "swzl"],
["其他", "101000", "101021", "xsqt"],
["销售管理", "100000", "101100", "xsgl"],
["销售经理/主管", "101100", "101110", "xsjl"],
["渠道/分销总监", "101100", "101111", "fxzj"],
["渠道/分销经理/主管", "101100", "101112", "qdjl"],
["客户总监/经理", "101100", "101113", "khzj"],
["大客户经理", "101100", "101114", "dkh"],
["团购经理/主管", "101100", "101115", "tgjl"],
["业务拓展经理/主管", "101100", "101116", "ywjl"],
["商务经理", "101100", "101117", "swjl"],
["其他", "101100", "101118", "xsglqt"],
["市场", "100000", "101200", "sc"],
["市场经理/主管", "101200", "101210", "scjl"],
["市场专员/助理", "101200", "101211", "sczy"],
["产品、品牌经理/主管", "101200", "101212", "cpjl"],
["产品、品牌专员/助理", "101200", "101213", "ppzy"],
["市场策划、企划经理/主管", "101200", "101214", "scch"],
["市场策划、企划专员/助理", "101200", "101215", "qhzy"],
["其他", "101200", "101217", "scqt"],
["客服", "100000", "101400", "kefu"],
["客服经理/主管", "101400", "101410", "kfjl"],
["客服专员/助理", "101400", "101411", "kfzy"],
["电话客服", "101400", "101412", "dhkf"],
["网络/在线客服", "101400", "101413", "wlkf"],
["客户关系/投诉协调人员", "101400", "101414", "khgx"],
["售前/售后服务", "101400", "101415", "sqsh"],
["其他", "101400", "101416", "kfqt"],
["计算机|互联网|通信", "0", "110000", "hlwtx"],
["互联网技术", "110000", "111000", "hlwjs"],
["Android", "111000", "111010", "android"],
["IOS", "111000", "111011", "ios"],
["Html5", "111000", "111012", "html"],
["web前端", "111000", "111013", "web"],
["java", "111000", "111014", "java"],
["PHP", "111000", "111015", "php"],
["C/C++", "111000", "111017", "cjj"],
["其他后端开发", "111000", "111019", "hlwqt"],
["项目经理/主管", "111000", "111020", "xmjlzg"],
["技术经理/主管", "111000", "111021", "jsjl"],
["硬件工程师", "111000", "111022", "yjgcs"],
["测试工程师/测试员", "111000", "111023", "csgcs"],
["数据库管理/DBA", "111000", "111024", "dba"],
["语音/视频/图形开发", "111000", "111025", "txkf"],
["其他", "111000", "111026", "hlqt"],
["产品/运营/策划/设计", "110000", "111100", "cpsj"],
["产品经理", "111100", "111110", "cpzy"],
["产品专员/助理", "111100", "111111", "cpzl"],
["运营", "111100", "111112", "yunying"],
["网站编辑", "111100", "111113", "wangbian"],
["SEO/SEM", "111100", "111114", "seo"],
["产品策划", "111100", "111115", "cpch"],
["游戏策划", "111100", "111116", "yxch"],
["用户体验(UE)/交互设计", "111100", "111117", "ue"],
["UI设计/美工", "111100", "111118", "ui"],
["其他", "111100", "111119", "mssjqt"],
["运维/技术支持", "110000", "111200", "ywjs"],
["信息技术专员/IT专员", "111200", "111211", "xxjs"],
["网络与信息安全工程师", "111200", "111212", "wlxx"],
["网络管理员", "111200", "111213", "wlgy"],
["技术支持与维护", "111200", "111214", "jszc"],
["实施工程师", "111200", "111215", "ssgcs"],
["其他", "111200", "111216", "jsqt"],
["通信", "110000", "111300", "tx"],
["通信技术工程师", "111300", "111310", "txjs"],
["其他", "111300", "111312", "txqt"],
["生活服务", "0", "120000", "shfw"],
["餐饮", "120000", "121000", "cy"],
["服务员", "121000", "121010", "fwy"],
["送餐员", "121000", "121011", "scy"],
["厨师/厨师长", "121000", "121012", "cs"],
["传菜员", "121000", "121013", "ccy"],
["后厨/配菜/打荷", "121000", "121014", "hc"],
["洗碗工", "121000", "121015", "xwg"],
["面点师", "121000", "121016", "mds"],
["茶艺师", "121000", "121017", "cys"],
["大堂经理/领班", "121000", "121019", "dtjl"],
["餐饮管理", "121000", "121020", "cygl"],
["学徒", "121000", "121021", "xt"],
["杂工", "121000", "121022", "xz"],
["咖啡师", "121000", "121023", "kfs"],
["预订员", "121000", "121024", "ydy"],
["其他", "121000", "121025", "cyqt"],
["超市/百货/零售", "120000", "121100", "csbh"],
["店员/营业员", "121100", "121110", "yyy"],
["收银主管/收银员", "121100", "121111", "syy"],
["促销/导购", "121100", "121112", "cxdg"],
["理货员/陈列员", "121100", "121113", "lhy"],
["防损员/内保", "121100", "121114", "fsy"],
["店长/卖场经理", "121100", "121115", "dzzc"],
["招商经理/主管", "121100", "121116", "zszg"],
["奢侈品销售", "121100", "121117", "scpxs"],
["品类管理", "121100", "121118", "lpgl"],
["生熟食品加工/处理", "121100", "121119", "scsp"],
["其他", "121100", "121121", "ddqtd"],
["家政保洁/安保/司机", "120000", "121200", "jzbm"],
["保洁", "121200", "121210", "bjy"],
["保姆", "121200", "121211", "baomu"],
["月嫂", "121200", "121212", "yueshao"],
["育婴师/保育员", "121200", "121213", "byy"],
["保安", "121200", "121216", "baoan"],
["司机", "121200", "121218", "siji"],
["驾校教练/陪练", "121200", "121226", "jxjl"],
["其他", "121200", "121227", "jxqt"],
["美容/美发", "120000", "121300", "mrmf"],
["发型师", "121300", "121310", "fxs"],
["美发助理/学徒", "121300", "121311", "mfxt"],
["美容师/美容导师", "121300", "121314", "mrs"],
["美容助理/学徒", "121300", "121315", "mrxt"],
["化妆师", "121300", "121316", "hzs"],
["美甲师", "121300", "121317", "mjs"],
["美容店长", "121300", "121318", "mrdz"],
["瘦身顾问", "121300", "121319", "ssgw"],
["彩妆培训师", "121300", "121320", "czpx"],
["美体师", "121300", "121321", "cts"],
["其他", "121300", "121323", "cqt"],
["酒店/旅游", "120000", "121400", "jdlv"],
["酒店前台", "121400", "121410", "jdqt"],
["客房服务员", "121400", "121411", "kffwy"],
["楼面经理", "121400", "121412", "lmjl"],
["行李员", "121400", "121413", "xly"],
["救生员", "121400", "121414", "jsy"],
["酒店管理", "121400", "121415", "jdgl"],
["订票员", "121400", "121416", "dpy"],
["导游", "121400", "121417", "dy"],
["计调", "121400", "121418", "jd"],
["签证专员", "121400", "121419", "qzy"],
["其他", "121400", "121421", "lyqt"],
["娱乐/休闲/保健/按摩", "120000", "121500", "ylxx"],
["酒吧服务员", "121500", "121510", "jbfyy"],
["娱乐厅服务员", "121500", "121511", "ylty"],
["礼仪/迎宾", "121500", "121512", "lyyb"],
["调酒师/待酒师/吧台员", "121500", "121514", "tjs"],
["按摩师/足疗师", "121500", "121515", "ams"],
["其他", "121500", "121519", "zqt"],
["护理/医疗", "120000", "121600", "hlyl"],
["理疗师", "121600", "121610", "lls"],
["营养师", "121600", "121611", "yys"],
["护士/护理人员", "121600", "121612", "hghl"],
["药剂师", "121600", "121613", "yjs"],
["心理医生", "121600", "121614", "xlys"],
["牙科医生", "121600", "121615", "ylys"],
["保健医生", "121600", "121616", "bjys"],
["医生", "121600", "121617", "yisheng"],
["眼科医生/验光师", "121600", "121618", "ykys"],
["美容整形师", "121600", "121619", "mrzxys"],
["宠物护理/兽医", "121600", "121620", "cwmrhl"],
["医疗管理", "121600", "121622", "ylgl"],
["其他", "121600", "121623", "yyqt"],
["运动/健身", "120000", "121700", "ydjs"],
["健身教练", "121700", "121710", "ksjl"],
["瑜伽教练/舞蹈老师", "121700", "121711", "yjjl"],
["其他", "121700", "121716", "gqt"],
["生产|制造|汽车|电子", "0", "130000", "sczz"],
["普工/技工", "130000", "131000", "ptjg"],
["普工", "131000", "131010", "pugong"],
["综合维修工", "131000", "131011", "wxg"],
["制冷/水暖工", "131000", "131012", "zlsn"],
["电工", "131000", "131013", "diangong"],
["木工", "131000", "131014", "mugong"],
["钳工", "131000", "131015", "qiangong"],
["切割/焊工", "131000", "131016", "hangong"],
["钣金工", "131000", "131017", "banjin"],
["油漆工", "131000", "131018", "youqi"],
["锅炉工", "131000", "131019", "guolu"],
["车工/铣工", "131000", "131020", "chegong"],
["铲车/叉车工", "131000", "131021", "chache"],
["铸造/注塑/模具工", "131000", "131022", "zhusu"],
["操作工", "131000", "131023", "caozuo"],
["电梯工", "131000", "131024", "dianti"],
["包装工", "131000", "131025", "baozhuang"],
["手机维修", "131000", "131026", "sjwx"],
["水泥工", "131000", "131027", "sng"],
["钢筋工", "131000", "131028", "gjg"],
["管道工", "131000", "131029", "gdg"],
["瓦工", "131000", "131030", "wg"],
["组装工", "131000", "131031", "zzg"],
["其他", "131000", "131032", "llqt"],
["生产管理/机械制造/维修", "130000", "131100", "scgl"],
["工厂厂长/副厂长", "131100", "131110", "gccz"],
["生产经理/车间主任", "131100", "131111", "cjzr"],
["生产主管/组长/督导", "131100", "131112", "sczg"],
["总工程师/副总工程师", "131100", "131113", "zgcs"],
["技术研发经理/工程师", "131100", "131114", "jsyf"],
["工业工程师", "131100", "131115", "gygcs"],
["工艺工程师", "131100", "131116", "gygc"],
["结构工程师", "131100", "131117", "jggc"],
["材料工程师", "131100", "131118", "clgc"],
["管理/维护/保养", "131100", "131119", "whby"],
["生产物料管理(PMC)", "131100", "131120", "scwl"],
["机械工程师", "131100", "131121", "jxgc"],
["CNC/数控工程师", "131100", "131122", "cnc"],
["夹具工程师", "131100", "131123", "jjgcs"],
["注塑/锻造/模具工程师", "131100", "131124", "zsgcs"],
["其他", "131100", "131125", "zsqt"],
["服装/纺织/皮革", "130000", "131200", "fzfz"],
["服装/纺织品设计", "131200", "131210", "fzsjfz"],
["服装打样/制版", "131200", "131211", "fzzys"],
["电脑放码员", "131200", "131212", "dnfms"],
["裁床", "131200", "131213", "caichuang"],
["样衣工", "131200", "131214", "yy"],
["板房/底格出格师", "131200", "131215", "dgccs"],
["样纸师/车板工", "131200", "131216", "cbg"],
["染工", "131200", "131217", "rg"],
["纺织工", "131200", "131218", "fzg"],
["印花工", "131200", "131219", "yhg"],
["压熨工", "131200", "131220", "yyg"],
["缝纫工", "131200", "131221", "frg"],
["轮胎工", "131200", "131222", "ltg"],
["其他", "131200", "131223", "jnqt"],
["汽车制造/服务", "130000", "131300", "qczz"],
["汽车设计工程师", "131300", "131310", "qcsj"],
["装配工艺工程师", "131300", "131311", "zpgy"],
["汽车机械工程师", "131300", "131312", "qcjx"],
["汽车电子工程师", "131300", "131313", "qcdz"],
["总装工程师", "131300", "131314", "zzgcs"],
["安全性能工程师", "131300", "131315", "aqxns"],
["汽车工程项目管理", "131300", "131316", "qcaq"],
["4S店管理", "131300", "131317", "sdgl"],
["汽车检验/检测", "131300", "131318", "qcjcjy"],
["汽车维修", "131300", "131319", "qcwx"],
["汽车保养/装饰美容", "131300", "131320", "qcby"],
["二手车评估师", "131300", "131321", "escpg"],
["洗车工", "131300", "131322", "xcg"],
["停车管理员", "131300", "131323", "tcg"],
["其他", "131300", "131325", "qcqt"],
["质量安全/消防", "130000", "131400", "zlaq"],
["质量管理/测试经理", "131400", "131410", "zlgl"],
["质量检测员/测试员", "131400", "131411", "zljc"],
["安全消防/安全管理", "131400", "131412", "aqxf"],
["认证/体系工程师/审核员", "131400", "131414", "rztx"],
["其他", "131400", "131415", "aqt"],
["制药/生物工程/化工", "130000", "131500", "zygc"],
["医药研发/生产/注册", "131500", "131510", "yyyf"],
["临床研究/协调", "131500", "131511", "lcyj"],
["生物工程/生物制药", "131500", "131512", "swgczy"],
["医疗器械研发/维修", "131500", "131513", "yljx"],
["化工研发工程师", "131500", "131514", "hgyf"],
["化学分析", "131500", "131515", "hxfx"],
["化学技术应用", "131500", "131516", "hxjs"],
["化学操作", "131500", "131517", "hxcz"],
["化学实验技术员/研究员", "131500", "131518", "hxsy"],
["其他", "131500", "131519", "hxqt"],
["电子/电器/半导体/仪表仪器", "130000", "131600", "dzbdt"],
["自动化工程师", "131600", "131610", "zdh"],
["电子/电气工程师", "131600", "131611", "dqgcs"],
["电路工程师/技术员", "131600", "131612", "dlgcs"],
["无线电工程师", "131600", "131613", "wxgcs"],
["测试/可靠性工程师", "131600", "131614", "kkxgcs"],
["音频/视频工程师", "131600", "131616", "ypgcs"],
["灯光/照明设计工程师", "131600", "131617", "dgzm"],
["研发工程师", "131600", "131618", "yfgcs"],
["其他", "131600", "131620", "dzqt"],
["房产|建筑|装修|物业", "0", "140000", "fcjz"],
["房地产开发/中介", "140000", "141000", "fzkf"],
["房地产开发/策划", "141000", "141010", "fcch"],
["房地产项目管理", "141000", "141011", "fdcxm"],
["房地产置业顾问", "141000", "141012", "fdczy"],
["房产评估师", "141000", "141013", "fcpg"],
["房产经纪人", "141000", "141014", "fcjjr"],
["房产店长/经理", "141000", "141016", "fcdz"],
["房产店员/助理", "141000", "141017", "fcdy"],
["房产客服", "141000", "141018", "fckf"],
["房产内勤", "141000", "141019", "fcnq"],
["其他", "141000", "141020", "fcqt"],
["建筑/装潢/景观", "140000", "141100", "jzzh"],
["建筑工程师/总工", "141100", "141110", "jzgcs"],
["建筑设计师", "141100", "141111", "jzsj"],
["土木/土建/结构工程师", "141100", "141112", "tmtj"],
["测绘/测量", "141100", "141113", "chcl"],
["道路/桥梁/港口/隧道工程技术", "141100", "141114", "lqql"],
["给排水/暖通/空调工程", "141100", "141115", "gps"],
["智能大厦/综合布线/弱电/安防", "141100", "141116", "zmds"],
["幕墙工程师", "141100", "141117", "pqgcs"],
["园林/景观设计", "141100", "141118", "jgsj"],
["城市规划与设计", "141100", "141119", "csgh"],
["市政工程师", "141100", "141120", "szgcs"],
["工程监理/质量管理", "141100", "141121", "gckl"],
["工程项目管理", "141100", "141122", "gcxm"],
["工程造价/预结算", "141100", "141123", "gczj"],
["安全管理/安全员", "141100", "141124", "aqy"],
["其他", "141100", "141125", "gcqt"],
["物业", "140000", "141200", "wuye"],
["物业经理/主管", "141200", "141210", "wyjl"],
["物业管理员", "141200", "141211", "wyzg"],
["物业招商/租赁/租售", "141200", "141212", "wyzs"],
["物业顾问", "141200", "141213", "wygw"],
["物业维修", "141200", "141214", "wywx"],
["其他", "141200", "141215", "wyqt"],
["财会|金融|保险", "0", "150000", "ckjr"],
["财务/审计/统计", "150000", "151000", "cwsj"],
["财务经理/主管", "151000", "151010", "cwjl"],
["财务/会计助理", "151000", "151011", "cwkjzl"],
["财务分析师", "151000", "151012", "cwfx"],
["财务顾问", "151000", "151013", "cwgw"],
["会计经理/主管", "151000", "151014", "kjjl"],
["会计", "151000", "151015", "kuaiji"],
["出纳", "151000", "151016", "chuna"],
["审计经理/主管", "151000", "151017", "sjjl"],
["审计专员/助理", "151000", "151018", "sjzy"],
["税务经理/主管", "151000", "151019", "swjlzg"],
["税务专员/助理", "151000", "151020", "swzy"],
["成本管理", "151000", "151021", "cbgl"],
["统计员", "151000", "151022", "tjy"],
["资产/资金管理", "151000", "151023", "zcgl"],
["其他", "151000", "151024", "zcqt"],
["银行", "150000", "151100", "yinghang"],
["银行客户经理", "151100", "151111", "yhkh"],
["银行会计/柜员", "151100", "151112", "yhkj"],
["信贷管理/资信评估", "151100", "151113", "xdgl"],
["信用卡销售", "151100", "151115", "xxkxs"],
["其他", "151100", "151114", "xdqt"],
["保险", "150000", "151200", "baoxian"],
["保险项目经理/主管", "151200", "151210", "bxxm"],
["保险代理/经纪人/客户经理", "151200", "151211", "bxdl"],
["保险培训师", "151200", "151213", "bxpxs"],
["保险核保/理赔专员", "151200", "151214", "bxhs"],
["保险精算师", "151200", "151215", "bxjs"],
["保险客服服务", "151200", "151216", "bxkf"],
["保险内勤", "151200", "151217", "bxnq"],
["其他", "151200", "151219", "cbqt"],
["金融", "150000", "151300", "jinrong"],
["证券/期货/外汇经纪人", "151300", "151310", "zqqh"],
["证券/投资客户经理/总监", "151300", "151311", "zqtz"],
["证券分析/金融研究", "151300", "151312", "zqfx"],
["资产评估", "151300", "151313", "zcpg"],
["投资/理财", "151300", "151314", "tzlc"],
["融资总监/经理", "151300", "151315", "rzzj"],
["融资专员/助理", "151300", "151316", "rzzy"],
["风险管理/控制/稽查", "151300", "151317", "fxgl"],
["储备经理人", "151300", "151318", "cbjlr"],
["股票/期货操盘手", "151300", "151319", "gpcps"],
["信托/担保/拍卖/典当", "151300", "151320", "xtdb"],
["其他", "151300", "151322", "pqt"],
["人力/行政/管理", "0", "160000", "rlxz"],
["人事/行政/后勤", "160000", "161000", "rsxz"],
["人事经理/主管", "161000", "161010", "rsjl"],
["人事专员", "161000", "161011", "rszy"],
["行政经理/主管", "161000", "161012", "xzjl"],
["行政专员", "161000", "161013", "xzzy"],
["助理/秘书", "161000", "161014", "zlms"],
["招聘经理/主管", "161000", "161015", "zpjl"],
["招聘专员/助理", "161000", "161016", "zpzy"],
["文员", "161000", "161017", "wenyuan"],
["前台/总机/接待", "161000", "161018", "qtzj"],
["后勤", "161000", "161019", "houqin"],
["猎头顾问", "161000", "161020", "ltgw"],
["薪酬/绩效/员工关系", "161000", "161021", "xcjx"],
["培训师/讲师", "161000", "161022", "pxs"],
["其他", "161000", "161023", "xzqt"],
["项目管理/协调", "160000", "161100", "xmglxt"],
["项目经理/主管", "161100", "161110", "xmjl"],
["项目专员/助理", "161100", "161111", "xmzy"],
["项目执行/协调人员", "161100", "161112", "xmzx"],
["高级管理", "160000", "161200", "gjgl"],
["CEO/总裁/总经理", "161200", "161210", "ceo"],
["首席运营官COO", "161200", "161211", "coo"],
["首席财务官CFO", "161200", "161212", "cfo"],
["CTO/CIO", "161200", "161213", "cto"],
["副总裁/副总经理", "161200", "161214", "fzc"],
["总裁助理/总经理助理", "161200", "161215", "zczl"],
["总监", "161200", "161216", "zj"],
["分公司经理", "161200", "161217", "fgsjl"],
["合伙人", "161200", "161218", "hhr"],
["其他", "161200", "161219", "hhqt"],
["贸易|采购|物流|仓储", "0", "170000", "mywl"],
["贸易/采购", "170000", "171000", "mycg"],
["外贸/贸易经理", "171000", "171010", "wmjl"],
["外贸/贸易专员/助理", "171000", "171011", "wmzy"],
["贸易跟单", "171000", "171012", "mygd"],
["报关员", "171000", "171013", "bgy"],
["采购经理", "171000", "171014", "cgjl"],
["采购专员/助理", "171000", "171015", "cgzy"],
["供应商开发", "171000", "171016", "gyskf"],
["供应链管理", "171000", "171017", "gylgl"],
["买手", "171000", "171018", "ms"],
["其他", "171000", "171019", "msqt"],
["物流/仓储", "170000", "171100", "wlcc"],
["物流经理/主管", "171100", "171110", "wljl"],
["物流专员/助理", "171100", "171111", "wlzy"],
["物流/仓储调度", "171100", "171112", "wldd"],
["快递员", "171100", "171113", "kdy"],
["水运/空运/陆运操作", "171100", "171114", "syky"],
["单证员", "171100", "171115", "dzy"],
["仓库经理/主管", "171100", "171116", "ckjl"],
["仓库管理员", "171100", "171117", "ckzg"],
["项目经理/主管", "171100", "171118", "ckxmjl"],
["理货/分拣/打包", "171100", "171119", "lhfl"],
["装卸/搬运工", "171100", "171120", "zxby"],
["其他", "171100", "171121", "zxqt"],
["广告|艺术|影视|媒体", "0", "180000", "ggys"],
["广告/会展", "180000", "181000", "gghz"],
["创意指导/设计经理", "181000", "181010", "cyzd"],
["广告创意/设计师", "181000", "181011", "ggcy"],
["广告文案策划", "181000", "181012", "ggwa"],
["美术指导", "181000", "181013", "mszd"],
["会展策划/设计", "181000", "181014", "hzch"],
["其他", "181000", "181015", "hzqt"],
["公关/媒介", "180000", "181100", "ggmj"],
["公关经理/主管", "181100", "181110", "ggjl"],
["公关专员/助理", "181100", "181111", "ggzy"],
["媒介经理/主管", "181100", "181112", "mjjl"],
["媒介专员/助理", "181100", "181113", "mjzy"],
["会务会展专员/经理", "181100", "181114", "hwzy"],
["其他", "181100", "181116", "mjqt"],
["艺术/设计", "180000", "181200", "yssj"],
["艺术设计经理/总监", "181200", "181210", "ysjl"],
["美编/美术设计", "181200", "181211", "mbsj"],
["工业/产品设计", "181200", "181212", "gycp"],
["多媒体/动画设计", "181200", "181213", "dmtdh"],
["包装设计", "181200", "181214", "bzsj"],
["家具/家居产品设计", "181200", "181215", "jjcpsj"],
["平面设计", "181200", "181216", "pmsj"],
["店面/陈列/展览设计", "181200", "181217", "dmcl"],
["工艺/珠宝设计", "181200", "181218", "gyzb"],
["室内设计", "181200", "181219", "snsj"],
["CAD制图", "181200", "181220", "cad"],
["玩具设计", "181200", "181221", "wjsj"],
["其他", "181200", "181222", "sjmsqt"],
["影视/媒体", "180000", "181300", "ysmt"],
["导演/编导", "181300", "181310", "dybd"],
["艺术指导/舞美指导", "181300", "181311", "yszd"],
["摄影师/摄像师", "181300", "181312", "syssxs"],
["化妆/造型/服装/道具师", "181300", "181313", "hzzx"],
["演员/模特/主持", "181300", "181314", "yymt"],
["配音/音效员", "181300", "181315", "pyyx"],
["后期制作", "181300", "181316", "hqzz"],
["放映管理", "181300", "181317", "fygl"],
["经纪人/星探", "181300", "181318", "jjr"],
["其他", "181300", "181319", "dyqt"],
["出版/印刷", "180000", "181400", "cbys"],
["总编/副总编/主编", "181400", "181410", "zbzb"],
["作家/编剧/撰稿人", "181400", "181411", "zjbj"],
["编辑", "181400", "181412", "bianji"],
["记者/采编", "181400", "181413", "jzcb"],
["校对/录入", "181400", "181414", "jdlr"],
["出版/发行", "181400", "181415", "cbfx"],
["印刷排版/制版", "181400", "181416", "yspb"],
["印刷操作", "181400", "181417", "yscz"],
["其他", "181400", "181418", "ysqt"],
["法律|咨询|教育|其他", "0", "190000", "flzx"],
["法律/法务/合规", "190000", "191000", "flfw"],
["法务经理/主管", "191000", "191010", "fwjl"],
["法务专员/助理", "191000", "191011", "fwzy"],
["律师/律师顾问", "191000", "191012", "lsgw"],
["律师助理", "191000", "191013", "lszl"],
["合规管理", "191000", "191014", "hggl"],
["产权/专利顾问", "191000", "191015", "cqzl"],
["其他", "191000", "191016", "flqt"],
["咨询/调研/数据分析", "190000", "191100", "zxdy"],
["咨询总监/经理", "191100", "191110", "zxzj"],
["咨询顾问", "191100", "191111", "zxgw"],
["调研员", "191100", "191112", "dyy"],
["数据分析师", "191100", "191113", "sjfx"],
["情报信息分析", "191100", "191114", "qbxx"],
["其他", "191100", "191115", "sjqt"],
["教育/培训", "190000", "191200", "jypx"],
["校长", "191200", "191210", "xiaozhang"],
["教师", "191200", "191211", "jiaoshi"],
["家教", "191200", "191212", "jiajiao"],
["幼教", "191200", "191213", "youshi"],
["教学/教务管理", "191200", "191214", "jxjw"],
["教育/培训产品开发", "191200", "191215", "jypxcp"],
["学术研究/科研", "191200", "191216", "xsyj"],
["培训师/讲师", "191200", "191217", "pxjs"],
["招生/课程顾问", "191200", "191218", "zsgw"],
["培训策划/督导", "191200", "191219", "pxch"],
["其他", "191200", "191220", "pxqt"],
["能源/农业/环保/其他职位", "190000", "191300", "nyny"],
["能源/矿产/地质工程师", "191300", "191310", "nykc"],
["能源/矿产/地质技术员", "191300", "191311", "nydz"],
["养殖人员", "191300", "191312", "yzry"],
["农艺师/园艺师", "191300", "191313", "nys"],
["环境工程技术", "191300", "191314", "hjjs"],
["环境管理/保护", "191300", "191315", "hjgl"],
["翻译", "191300", "191316", "fanyi"],
["其他", "191300", "191317", "hbqt"],
["其他职位", "191300", "191318", "qtzw"]
];

function GetPosition(id) {
    for (var i = 0; i < positionArray.length; i++) {
        if (positionArray[i][2] == id) {
            return positionArray[i];
            break;
        }
    }
    return null;
}

function GetPositions(pid) {
    var positions = new Array();
    for (var i = 0; i < positionArray.length; i++) {
        if (positionArray[i][1] == pid) {
            positions.push(positionArray[i]);
        }
    }
    return positions;
}

function GetTopPositions() {
    var positions = new Array();
    for (var i = 0; i < positionArray.length; i++) {
        if (positionArray[i][1] == "0") {
            positions.push(positionArray[i]);
        }
    }
    return positions;
}

function GetPositionsByIds(ids, containBig) {
    var positions = new Array();
    for (var i = 0; i < positionArray.length; i++) {
        var pt = new RegExp(positionArray[i][2]);
        if ((containBig || positionArray[i][1] != "0") && pt.test(ids)) {
            positions.push(positionArray[i]);
        }
    }
    return positions;
}

function GetPositionsByKeywords(keyword, containBig, containMid) {
    var positions = new Array();
    var containBig = containBig || false;
    var containMid = containMid || false;
    var regular = new RegExp(keyword, 'i');
    for (var i = 0; i < positionArray.length; i++) {
        //if (positionArray[i][0].indexOf(keyword) >= 0) {
        if (positionArray[i][0].match(regular)) {
            if (!containBig && positionArray[i][1] == "0") continue;
            if (!containMid && positionArray[i][2].substr(4,2) == "00") continue;
            positions.push(positionArray[i]);
        }
    }
    return positions;
}
function GetPositionsSuggest(keywd, containBig, containMid) {
    var poss = GetPositionsByKeywords(keywd, containBig, containMid);
    var str = "["
    for (var i = 0; i < poss.length; i++) {
        str += (str == "[" ? "" : ",") + "{t:'" + poss[i][0] + "',v:'" + poss[i][2] + "'}";
    }
    return str + "]";
}
function GetPositionId(keyword) {
    keyword = keyword.toLowerCase();
    for (var i = 0; i < positionArray.length; i++) {
        if (positionArray[i][0].toLowerCase() == keyword) {
            return positionArray[i][2];
        }
    }
    return "";
}
function GetPositionUrlKey(keyword) {
    keyword = keyword.toLowerCase();
    for (var i = 0; i < positionArray.length; i++) {
        if (positionArray[i][0].toLowerCase() == keyword && positionArray[i][2].substring(4) != "00") {
            return positionArray[i][3];
        }
    }
    return "";
}

function GetPositionUrlKeyById(ids) {
    var idArr = ids.split(',');
    var res = "";
    for (var j = 0; j < idArr.length; j++) {
        for (var i = 0; i < positionArray.length; i++) {
            if (positionArray[i][2] == idArr[j]) {
                res += positionArray[i][3] + ",";
            }
        }
    }
    return res.length > 0 ? res.substring(0, res.length - 1) : "";
}

function CreatePositionSelector(option) {
    //option {positionIds,lsPos1,lsPos2,lsPos3,titleProv,titleCity,titlePosition,value,afterchange}
    var _this = this;
    if (option == null) return;
    var sl1 = option.lsPos1;
    var sl2 = option.lsPos2;
    var sl3 = option.lsPos3;
    var positionIds = option.positionIds;
    if (typeof (sl1) == "string") sl1 = document.getElementById(sl1);
    if (typeof (sl2) == "string") sl2 = document.getElementById(sl2);
    if (typeof (sl3) == "string") sl3 = document.getElementById(sl3);
    var _positionsArray = null;
    var _isContainPosition = function (id) {
        if (_positionsArray == null) return false;
        for (var i = 0; i < _positionsArray.length; i++) if (_positionsArray[i][2] == id) return true;
        return false;
    }
    if (positionIds) {
        while (positionIds.indexOf("'") >= 0) positionIds = positionIds.replace("'", "");
        var ids = positionIds.split(',');
        for (var i = 0; i < ids.length; i++) {
            if (ids[i].length <= 1 || _isContainPosition(ids[i])) continue;
            var aPosition = GetPosition(ids[i]);
            if (!(aPosition && aPosition.push && aPosition.pop)) continue;
            if (_positionsArray == null) _positionsArray = new Array();
            _positionsArray.push(aPosition);

            //子对象
            if (ids[i].substr(4, 2) == "00") {
                var childs = GetPositions(ids[i]);
                for (var j = 0; j < childs.length; j++) {
                    if (_isContainPosition(childs[j][2])) continue;
                    _positionsArray.push(childs[j]);
                    if (ids[i].substr(4, 2) == "00") {
                        var childs2 = GetPositions(childs[j][2]);
                        for (var k = 0; k < childs2.length; k++) {
                            if (_isContainPosition(childs2[k][2])) continue;
                            _positionsArray.push(childs2[k]);
                        }
                    }
                }
            }

            if (aPosition[1].length <= 1 || _isContainPosition(aPosition[1])) continue;
            aPosition = GetPosition(aPosition[1]);
            if (!(aPosition && aPosition.push && aPosition.pop)) continue;
            _positionsArray.push(aPosition);

            if (aPosition[1].length <= 1 || _isContainPosition(aPosition[1])) continue;
            aPosition = GetPosition(aPosition[1]);
            if (!(aPosition && aPosition.push && aPosition.pop)) continue;
            _positionsArray.push(aPosition);
        }
    }
    //alert(JB.objToStr(_positionsArray));
    if (_positionsArray == null) _positionsArray = positionArray; //全局对象
    var _getPositions = function (id) {
        var positions = new Array();
        for (var i = 0; i < _positionsArray.length; i++) {
            if (_positionsArray[i][1] == id) {
                positions.push(_positionsArray[i]);
            }
        }
        return positions;
    }
    var _relateChanged = function (slA_value, slB, title) {
        var arr = _getPositions(slA_value);
        slB.length = 0;
        if (title) slB.options[0] = new Option(title, "");
        var selected = false;
        for (var i = 0; i < arr.length; i++) {
            slB.options[slB.length] = new Option(arr[i][0], arr[i][2]);
            if (option.value &&
                (arr[i][2] == option.value
                    || (option.value.length >= 4 && arr[i][2].substr(4, 2) == "00" && arr[i][2].substr(0, 4) == option.value.substr(0, 4))
                    || (option.value.length >= 2 && arr[i][2].substr(2, 4) == "0000" && arr[i][2].substr(0, 2) == option.value.substr(0, 2))
                 )
                ) {
                slB.options[slB.length - 1].selected = true;
                selected = true;
            }
        }
        if (!selected && slB.options[0]) slB.options[0].selected = true;
    }
    this.valueChanged = function () {
        var v = (sl3 && sl3.value != "") ? sl3.value : (sl2 && sl2.value != "") ? sl2.value : (sl1 && sl1.value) ? sl1.value : "";
        if (option.afterchange) option.afterchange(v);
    }
    this.cityChanged = function (e, vv) {
        if (sl3) { _relateChanged(vv || sl2.value, sl3, option.titlePosition); }
        _this.valueChanged();
    }
    this.proviceChanged = function (e, vv) {
        if (sl2) { _relateChanged(vv || sl1.value, sl2, option.titleCity); _this.cityChanged(); }
        else _this.valueChanged();
    }
    if (sl1) {
        _relateChanged("0", sl1, option.titleProv);
        _this.proviceChanged();
    } else if (sl2) {
        if (!option.value || option.value.length < 2 || option.value.substr(0, 2) == "00") { alert("区域初始信息错误"); return; }
        _this.proviceChanged(null, option.value.substr(0, 2) + "0000");
    } else if (sl3) {
        if (!option.value || option.value.length < 4 || option.value.substr(2, 2) == "00") { alert("区域初始信息错误"); return; }
        _this.cityChanged(null, option.value.substr(0, 4) + "00");
    }
    if (sl1) JB.attach(sl1, "change", _this.proviceChanged);
    if (sl2) JB.attach(sl2, "change", _this.cityChanged);
    if (sl3) JB.attach(sl3, "change", _this.valueChanged);
}