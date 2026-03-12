# 运动健康（运动）应用模板快速入门

## 目录

- [功能介绍](#功能介绍)
- [约束和限制](#约束和限制)
- [快速入门](#快速入门)
- [开源许可协议](#开源许可协议)


## 功能介绍

您可以基于此模板直接定制应用，也可以挑选此模板中提供的多种组件使用，从而降低您的开发难度，提高您的开发效率。

此模板提供如下组件，所有组件存放在工程根目录的components下，如果您仅需使用组件，可参考对应组件的指导链接；如果您使用此模板，请参考本文档。

| 组件                          | 描述                                   | 使用指导                                                                                                                                                                                                            |
|:----------------------------| :------------------------------------- |:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 通用支付组件（aggregated_payment） | 本组件聚合了多方的支付能力       | [使用指导](components/aggregated_payment/README.md)                                                                                                                                                                                   |
| 图表组件（module_chart）          | 支持按照日、周、月、年统计运动记录     | [使用指导](components/module_chart/README.md)         |
| 意见反馈组件（module_feedback）     | 支持提交问题反馈、查看反馈记录         | [使用指导](components/module_feedback/README.md)      |
| 图片预览组件（module_imagepreview） | 支持预览图片、双指放大、缩小，滑动预览 | [使用指导](components/module_imagepreview/README.md)  |
| 播放组件（module_player）         | 视频播放支持加解锁、画中画、倍速、分辨率等功能   | [使用指导](components/module_player/README.md)        |
| 搜索组件（module_search）         | 搜索能力   | [使用指导](components/module_search/README.md)        |
| 一镜到底组件（module_transition）   | 支持卡片展开、搜索、查看大图一镜到底   | [使用指导](components/module_transition/README.md)    |

本模板为运动健身类应用提供了常用功能的开发样例，模板主要分首页、课程、计划和我的四大模块：

* 首页：提供运动健身常识普及、热门课程、进阶课程等功能。
* 课程：提供搜索筛选、课程详情、添加日历、VIP课程、课程视频等功能。
* 计划：提供一周计划、本周目标、推荐课程、制定计划等功能。
* 我的：提供个人信息查看、运动记录、意见反馈、设置等功能。

本模板已集成华为账号等服务，只需做少量配置和定制即可快速实现华为账号的登录、媒体播放等功能。

| 首页                                                    | 课程                                                      | 计划                                                    | 我的                                                    |
| ------------------------------------------------------- | --------------------------------------------------------- | ------------------------------------------------------- | ------------------------------------------------------- |
| <img src="screenshots/home.png" alt="首页" width="300"> | <img src="screenshots/course.png" alt="课程" width="300"> | <img src="screenshots/plan.png" alt="计划" width="300"> | <img src="screenshots/mine.png" alt="我的" width="300"> |

本模板主要页面及核心功能如下所示：

```ts
运动健身模板
  ├──引导页                           
  │   ├──目标  
  │   │   ├── 性别                          
  │   │   ├── 目标                             
  │   │   └── 想锻炼的部位                   
  │   │         
  │   ├──身体数据        
  │   │   ├── 年龄                          
  │   │   ├── 身高                             
  │   │   └── 体重和目标体重  
  │   │                    
  │   └──关于你  
  │       ├── 是否存在伤病困扰                     
  │       └── 喜欢哪类运动、运动频次、期望练习难度 
  │
  ├──首页                           
  │   ├──轮播页  
  │   │   ├── 课程封面  
  │   │   └── 课程详情页     
  │   │                    
  │   ├──常识普及  
  │   │   ├── 运动健身常识普及  
  │   │   └── 常识普及详情页 
  │   │
  │   ├──热门课程    
  │   │   ├── 课程封面、练习难度、练习时长  
  │   │   └── 热门课程详情页 
  │   │
  │   └──进阶课程    
  │       ├── 课程封面、练习难度、练习时长  
  │       └── 进阶课程详情页 
  │
  ├──课程                           
  │   ├──顶部栏  
  │   │   ├── 搜索 
  │   │   └── 课程筛选                   
  │   │         
  │   ├──热门课程    
  │   │   ├── 课程封面、练习难度、练习时长  
  │   │   └── 热门课程详情页 
  │   │
  │   ├──进阶课程    
  │   │   ├── 课程封面、练习难度、练习时长  
  │   │   └── 进阶课程详情页 
  │   │
  │   └──课程详情页         
  │       ├── 课程内容
  │       ├── 添加日历
  │       ├── 课程视频
  │       └── 会员课程                        
  │                        
  ├──计划                           
  │   └──周计划日期                      
  │   │         
  │   ├──计划课程         
  │   │   ├── 课程封面、练习难度、练习时长                              
  │   │   └── 计划课程详情页                            
  │   │                  
  │   ├──本周目标         
  │   │   ├── 预计减重
  │   │   ├── 目标体重
  │   │   ├── 训练天数
  │   │   └── 消耗热量                         
  │   │                   
  │   └──推荐课程    
  │       ├── 课程封面、练习难度、练习时长
  │       ├── 推荐课程详情页                                             
  │       ├── 课程内容                                  
  │       └── 添加计划                       
  │
  └──我的                           
      ├──登录  
      │   ├── 华为账号一键登录                          
      │   ├── 微信登录                                                   
      │   ├── 账密登录
      │   └── 用户隐私协议同意                       
      │         
      ├──会员中心         
      │   ├── 会员套餐
      │   ├── 会员权益
      │   └── 会员服务协议
      │                    
      ├──个人信息         
      │   ├── 头像、昵称、简介
      │   ├── 性别、年龄、身高、体重
      │   └── 目标、想锻炼的部位
      │
      ├──运动记录         
      │   ├── 日运动时长、总消耗
      │   ├── 周运动时长、总消耗、累计训练天数
      │   ├── 月运动时长、总消耗、累计训练天数
      │   └── 年运动时长、总消耗、累计训练天数
      │
      └──常用服务    
          ├── 我的足迹    
          ├── 我的收藏                                    
          ├── 意见反馈                   
          └── 设置
               ├── 编辑个人信息             
               ├── 隐私设置           
               ├── 通知开关  
               ├── 视频后台播放             
               ├── 视频默认清晰度           
               ├── 清理缓存 
               ├── 检测版本 
               ├── 关于我们 
               └── 退出登录                           
```

本模板工程代码结构如下所示：

```ts
ExerciseAndFitness  
├──commons
│  ├──lib_account/src/main/ets                            // 账号登录模块             
│  │    ├──components
│  │    │   └──AgreePrivacyBox.ets                        // 隐私同意勾选            
│  │    ├──constants                                      // 常量                      
│  │    ├──pages  
│  │    │   ├──HuaweiLoginPage.ets                        // 华为账号登录页面
│  │    │   ├──OtherLoginPage.ets                         // 其他方式登录页面
│  │    │   └──ProtocolWebView.ets                        // 协议H5        
│  │    ├──services                                       // 服务api            
│  │    ├──utils  
│  │    │   ├──ErrorCodeHelper.ets                        // 错误码处理工具类
│  │    │   ├──HuaweiAuthUtils.ets                        // 华为认证工具类
│  │    │   ├──LoginSheetUtils.ets                        // 统一登录半模态弹窗
│  │    │   └──WXApiUtils.ets                             // 微信登录事件处理类       
│  │    └──viewmodels                                     // 视图模型
│  │
│  ├──lib_api/src/main/ets                           	  // 服务端api模块  
│  │    ├──database                                       // 数据库 
│  │    ├──params                                         // 请求响应参数 
│  │    └──services                                       // 服务api  
│  │
│  ├──lib_common/src/main/ets                             // 基础模块             
│  │    ├──components                                     // 通用组件             
│  │    ├──constants                                      // 通用常量
│  │    ├──dialogs                                        // 通用弹窗 
│  │    ├──mocks                                          // 模拟数据
│  │    ├──models                                         // 状态观测模型 
│  │    ├──types                                          // 类型
│  │    └──utils                                          // 通用方法                       
│  │ 
│  └──lib_widget/src/main/ets                             // 通用UI模块             
│       └──components
│           └──NavHeaderBar.ets                           // 自定义标题栏
│
├──components
│  ├──aggregated_payment                                  // 通用支付组件
│  ├──module_chart                                        // 图表组件 
│  ├──module_feedback                                     // 意见反馈组件 
│  ├──module_imagepreview                                 // 图片预览组件 
│  ├──module_player                                       // 播放组件 
│  ├──module_search                                       // 搜索组件
│  └──module_transition                                   // 动画组件         
│      
├──features
│  ├──home/src/main/ets                                   // 首页模块                   
│  │    ├──pages
│  │    │   ├──CommonKnowledgeActivatePage.ets            // 激活页
│  │    │   ├──CommonKnowledgeDrawPage.ets                // 拉伸页
│  │    │   ├──CommonKnowledgeEquipPage.ets               // 装备页
│  │    │   ├──CommonKnowledgePage.ets                    // 常识页面
│  │    │   ├──CommonKnowledgeStrainPage.ets              // 避免受伤页
│  │    │   ├──CommonKnowledgeWarmPage.ets                // 热身页
│  │    │   ├──CommonKnowledgeYogaPage.ets                // 瑜伽页
│  │    │   └──HomePage.ets                               // 首页页面
│  │    └──viewmodels  
│  │        └──CommonKnowledgePageVM.ets                  // 常识页面视图模块
│  ├──course/src/main/ets                                 // 课程模块    
│  │    ├──pages
│  │    │   ├──AdvancedCoursePage.ets                     // 进阶课程页面
│  │    │   ├──CourseDetailPage.ets                       // 课程详情页面
│  │    │   ├──CoursePage.ets                             // 课程页面 
│  │    │   ├──CoursePlayer.ets                           // 课程视频
│  │    │   ├──CourseSearch.ets                           // 课程搜索
│  │    │   ├──FilterPage.ets                             // 课程筛选
│  │    │   └──HotCoursePage.ets                          // 热门课程 
│  │    └──viewmodels 
│  │        ├──AddDateDialog.ets                          // 添加日程
│  │        ├──AdvancedCoursePageVM.ets                   // 进阶课程视图模型
│  │        ├──Calendar.ets                               // 日历
│  │        ├──CoursePageVM.ets                           // 课程视图模型
│  │        ├──CustomDialog.ets                           // 自定义弹窗
│  │        └──HotCoursePageVM.ets                        // 热门课程视图模型                  
│  │
│  ├──mine/src/main/ets                                   // 我的模块             
│  │    ├──components
│  │    │   ├──CourseItemComponent.ets                    // 课程组件
│  │    │   ├──LeftSwipeComponent.ets                     // 左滑组件
│  │    │   ├──VipBenefits.ets                            // VIP权益
│  │    │   ├──VipOpen.ets                                // 开通VIP
│  │    │   ├──VipOperation.ets                           // VIP操作
│  │    │   └──VipPackage.ets                             // VIP套餐包             
│  │    ├──constants                                      // 常量        
│  │    ├──model                                          // 模型        
│  │    ├──preview                                        // 预览          
│  │    ├──types                                          // 类型        
│  │    ├──utils                                          // 工具类        
│  │    ├──viewmodels                                     // 视图模型
│  │    └──pages 
│  │        ├──HistoryPage.ets                            // 我的足迹
│  │        ├──MarkPage.ets                               // 我的收藏
│  │        ├──RecordPage.ets                             // 运动记录
│  │        ├──VIPPage.ets                                // 会员页面
│  │        └──MinePage.ets                               // 我的页面              
│  │
│  ├──plan/src/main/ets                                   // 计划模块                  
│  │    ├──pages
│  │    │   ├──CoursePlanPage.ets                         // 课程计划详情页面
│  │    │   ├──PlanPage.ets                               // 计划主页
│  │    │   └──RecommendationCoursePage.ets               // 推荐课程页面       
│  │    └──viewmodels                                     
│  │        └──PlanPageVM.ets                             // 计划视图模块
│  │
│  └──setting/src/main/ets                                // 设置模块             
│       ├──components
│       │   ├──SettingCard.ets                            // 设置卡片
│       │   └──SettingSelectDialog.ets                    // 设置选项弹窗               
│       │──pages
│       │   ├──SettingAbout.ets                           // 关于页面
│       │   ├──SettingH5.ets                              // H5页面
│       │   ├──SettingNetwork.ets                         // 视频播放设置页面
│       │   ├──SettingPage.ets                            // 设置页面
│       │   ├──SettingPersonal.ets                        // 编辑个人信息页面
│       │   └──SettingPrivacy.ets                         // 隐私设置页面        
│       ├──types                                          // 类型          
│       └──viewmodels                                     // 视图模型
│
└──products
   └──phone/src/main/ets                                  // phone模块
        ├──common                        
        │   ├──AppTheme.ets                               // 应用主题色
        │   ├──AppUtils.ets                               // 应用设置工具类
        │   ├──Constants.ets                              // 业务常量
        │   ├──NetworkUtils.ets                           // 网络工具类
        │   ├──Types.ets                                  // 数据模型
        │   ├──WantUtils.ets                              // want工具类
        │   └──WindowUtils.ets                            // 窗口工具类
        ├──components                    
        │   └──CustomTabBar.ets                           // 应用底部Tab
        │──pages   
        │   ├──AgreeDialogPage.ets                        // 隐私同意弹窗
        │   ├──GuidePage_*.ets                            // 引导页面
        │   ├──Index.ets                                  // 入口页面
        │   ├──IndexPage.ets                              // 应用主页面
        │   ├──PrivacyPage.ets                            // 查看隐私协议页面
        │   ├──SafePage.ets                               // 隐私同意页面
        │   └──SplashPage.ets                             // 开屏广告页面      
        └──viewmodels                                     // 视图模型
```
## 约束和限制

### 环境
* DevEco Studio版本：DevEco Studio 5.1.1 Release及以上
* HarmonyOS SDK版本：HarmonyOS 5.0.3 Release SDK及以上
* 设备类型：华为手机（包括双折叠和阔折叠）
* 系统版本：HarmonyOS 5.0.3 (15)及以上
### 权限
* 网络权限: ohos.permission.INTERNET, ohos.permission.GET_NETWORK_INFO, ohos.permission.GET_WIFI_INFO


## 快速入门

在运行此模板前，需要完成以下配置：

1. 在AppGallery Connect创建应用，将包名配置到模板中。

   a. 参考[创建HarmonyOS应用](https://developer.huawei.com/consumer/cn/doc/app/agc-help-create-app-0000002247955506)为应用创建APP ID，并将APP ID与应用进行关联。

   b. 返回应用列表页面，查看应用的包名。

   c. 将模板工程根目录下AppScope/app.json5文件中的bundleName替换为创建应用的包名。

2. 配置华为账号服务。

   a. 将应用的Client ID配置到products/phone/src/main路径下的module.json5文件中，详细参考：[配置Client ID](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/account-client-id)。

   b. 申请华为账号一键登录所需的quickLoginMobilePhone权限，详细参考：[配置scope权限](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/account-config-permissions)。

3. 接入微信SDK。
   前往微信开放平台申请AppID并配置鸿蒙应用信息，详情参考：[鸿蒙接入指南](https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Access_Guide/ohos.html)。

4. 对应用进行[手工签名](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/ide-signing#section297715173233)。

5. 添加手工签名所用证书对应的公钥指纹，详细参考：[配置应用签名证书指纹](https://developer.huawei.com/consumer/cn/doc/app/agc-help-cert-fingerprint-0000002278002933)。

###  运行调试工程
1. 连接调试手机和PC。
2. 菜单选择“Run > Run 'product' ”或者“Run > Debug 'product' ”，运行或调试模板工程。

## 开源许可协议

该代码经过[Apache 2.0 授权许可](http://www.apache.org/licenses/LICENSE-2.0)。