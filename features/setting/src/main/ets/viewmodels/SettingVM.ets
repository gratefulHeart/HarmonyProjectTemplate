import { promptAction } from '@kit.ArkUI';
import { common, ConfigurationConstant } from '@kit.AbilityKit';
import { notificationManager } from '@kit.NotificationKit';
import { AppGalleryUtils, BaseViewModel, FileUtils, RouterMap, RouterUtils, SystemBarOperation } from 'lib_common';
import { AccountApi } from 'lib_account';
import { ISelectOption, SettingItem } from '../types/Types';

@ObservedV2
export class SettingViewModel extends BaseViewModel {
  private accountInstance: AccountApi = new AccountApi();
  @Trace isFocusOnPage: boolean = true;
  @Trace isLoading: boolean = false;
  @Trace cacheSize: string = '0';
  @Trace cacheSettingItem = new SettingItem({
    label: '清理缓存',
    extraLabel: this.getLocalCacheLabel(),
    onClick: () => {
      this.cacheSize = '0';
      this.cacheSettingItem.extraLabel = this.getLocalCacheLabel();
      FileUtils.clearCache();
      promptAction.showToast({ message: '清除缓存成功' });
    },
  })
  @Trace backPlaySettingItem = new SettingItem({
    typeSelect: true,
    label: '视频后台播放',
    selectTitle: '视频后台播放设置',
    selectOptions: [
      {
        id: 0,
        label: '开启画中画',
      },
      {
        id: 1,
        label: '关闭画中画',
      },
    ],
    selectV: this.settingInfo.player.videoBackPlay,
    onSelect: (option) => {
      this.settingInfo.player.videoBackPlay = (option as ISelectOption).id;
      this.backPlaySettingItem.selectV = this.settingInfo.player.videoBackPlay;
    },
  });
  @Trace resolutionSettingItem = new SettingItem({
    typeSelect: true,
    label: '视频默认清晰度',
    selectTitle: '视频默认清晰度',
    selectOptions: [
      {
        id: 0,
        label: '1080P 原画（高帧率）',
      },
      {
        id: 1,
        label: '1080P 蓝光',
      },
      {
        id: 2,
        label: '720P 超清',
      },
      {
        id: 3,
        label: '480P 高清',
      },
    ],
    selectV: this.settingInfo.player.videoDefaultResolution,
    onSelect: (option) => {
      this.settingInfo.player.videoDefaultResolution = (option as ISelectOption).id;
      this.resolutionSettingItem.selectV = this.settingInfo.player.videoDefaultResolution;
    },
  });
  @Trace pushSettingItem = new SettingItem({
    label: '通知开关',
    typeSwitch: true,
    switchV: this.settingInfo.pushSwitch,
    onClick: (isOn) => {
      this.requestPushPermission(isOn as boolean);
    },
  });
  @Trace list1: SettingItem[] = [
    new SettingItem({
      label: '个人信息',
      routerName: RouterMap.SETTING_PERSONAL,
      onClick: () => {
        if (this.userInfoModel.isLogin) {
          RouterUtils.pushPathByName(RouterMap.SETTING_PERSONAL);
        } else {
          promptAction.showToast({ message: '请先登录' });
        }
      },
    }),
    new SettingItem({
      label: '隐私设置',
      routerName: RouterMap.SETTING_PRIVACY,
    }),
  ];
  @Trace list2: SettingItem[] = [
    this.pushSettingItem,
    this.resolutionSettingItem,
    this.cacheSettingItem,
  ];
  @Trace list3: SettingItem[] = [
    new SettingItem({
      label: '检测版本',
      onClick: () => {
        const context = getContext(this) as common.UIAbilityContext;
        AppGalleryUtils.checkAppUpdate(context).then((resp: boolean) => {
          if (resp) {
            AppGalleryUtils.showUpdateDialog(context);
          } else {
            promptAction.showToast({ message: '已是最新版本' });
          }
        })
      },
    }),
    new SettingItem({
      label: '关于我们',
      routerName: RouterMap.SETTING_ABOUT,
    }),
  ];

  setColorMode(isDark: boolean) {
    const mode =
      isDark ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT;
    getContext().getApplicationContext().setColorMode(mode);
    SystemBarOperation.setWindowSystemBarProp({
      statusBarContentColor: isDark ? '#ffffff' : '#ff090909',
    })
  }

  requestPushPermission(isOn: boolean) {
    notificationManager.openNotificationSettings(getContext(this) as common.UIAbilityContext)
      .then(() => {
        this.isFocusOnPage = false;
      })
  }

  getLatestPushStatus() {
    if (!this.isFocusOnPage) {
      const isOn = notificationManager.isNotificationEnabledSync();
      this.settingInfo.pushSwitch = isOn;
      this.pushSettingItem.switchV = isOn;
      this.isFocusOnPage = true;
    }
  }

  getCache() {
    FileUtils.getCache().then((resp: number) => {
      this.cacheSize = (resp / 1024 / 1024).toFixed(2);
      this.cacheSettingItem.extraLabel = this.getLocalCacheLabel();
    })
  }

  getLocalCacheLabel() {
    return `${this.cacheSize}M`;
  }

  onSignOutBtnClick() {
    this.isLoading = true;
    this.accountInstance.signOut()
      .then(() => {
        promptAction.showToast({ message: '已退出登录' });
      })
      .finally(() => {
        this.isLoading = false;
      });
  }

  @Computed
  get signOutBtnLabel() {
    if (this.isLoading) {
      return '正在退出登录...'
    }
    return '退出登录'
  }
}