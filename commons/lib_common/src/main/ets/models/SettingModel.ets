/**
 * 全局设置
 */
@ObservedV2
export class SettingModel {
  // 通知开关
  @Trace pushSwitch: boolean = false;
  // 深色模式
  @Trace darkSwitch: boolean = false;
  // 字体大小
  @Trace fontSizeRatio: number = 1;
  // 隐私设置-个性化推荐
  @Trace personalizedPush: boolean = true;
  // 播放与网络设置
  @Trace network: SettingNetworkModel = new SettingNetworkModel();
  // 视频播放设置
  @Trace player: SettingPlayerModel = new SettingPlayerModel();
}

@ObservedV2
export class SettingNetworkModel {
  // 非WLAN网络流量
  @Trace downloadWithoutWlan: number = 0;
  // 非WLAN网络播放提醒
  @Trace remindWithoutWlan: number = 0;
  // 非WLAN网络下自动播放直播
  @Trace liveAutoplayWithoutWlan: boolean = true;
  // 使用移动网络改善内容浏览体验
  @Trace optimizeWith4G: boolean = true;
  // 视频自动下滑
  @Trace autoPlayNext: boolean = true;
  // 推荐频道自动播放视频
  @Trace autoPlayTabRecommend: boolean = true;
}

@ObservedV2
export class SettingPlayerModel {
  // 视频后台播放
  @Trace videoBackPlay: number = 0;
  // 视频默认清晰度
  @Trace videoDefaultResolution: number = 0;
}