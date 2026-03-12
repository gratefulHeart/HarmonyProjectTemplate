import { AppStorageV2, promptAction } from '@kit.ArkUI';
import {
  BaseViewModel,
  CommonConstants,
  ContinueModel,
} from 'lib_common';
import { FormCardRouter } from '../common/Types';
import { PhoneConstants, TabBarType, TABS_INFO } from '../common/Constants';

@ObservedV2
export class IndexPageViewModel extends BaseViewModel {
  @Trace translateY: string | number = '';
  @Trace firstBackTime: number = 0;
  @Trace formCardModel: FormCardRouter = AppStorageV2.connect(FormCardRouter, () => new FormCardRouter())!;
  @Trace continueModel: ContinueModel = AppStorageV2.connect(ContinueModel, () => new ContinueModel())!;

  @Monitor('tabModel.showTabBar')
  onChangeShowTabBar(monitor: IMonitor) {
    if (this.tabModel.isTabVertical) {
      return;
    }
    let isShowCustomTabBar = monitor.value()?.now as boolean;
    if (isShowCustomTabBar) {
      this.translateY = '';
    } else {
      this.translateY = '100%';
    }
  }
  @Monitor('tabModel.isTabVertical')
  onShowChangeTabBar(monitor: IMonitor) {
    let isShowCustomTabBar = monitor.value()?.now as boolean
    if (isShowCustomTabBar) {
      this.translateY = '';
    }
  }

  onBackPressed() {
    let nowTime = Date.now();
    if (nowTime - this.firstBackTime < 1500) {
      return false;
    } else {
      this.firstBackTime = nowTime;
      promptAction.showToast({ message: '再按一次退出' });
      return true;
    }
  }

  @Computed
  get barPosition() {
    if (this.tabModel.isTabVertical) {
      return BarPosition.Start;
    }
    return BarPosition.End;
  }

  @Computed
  get tabWidth(): Length {
    if (this.tabModel.isTabVertical) {
      return PhoneConstants.LEFT_TAB_BAR_WIDTH;
    }
    return CommonConstants.FULL_PERCENT;
  }

  @Computed
  get tabHeight(): Length {
    if (this.tabModel.isTabVertical) {
      return PhoneConstants.LEFT_TAB_BAR_ITEM_HEIGHT * TABS_INFO.length;
    }
    return 'auto';
  }

  @Computed
  get showDivider(): DividerStyle | null {
    if (!this.tabModel.isTabVertical) {
      return null;
    }
    if ([TabBarType.HOME, TabBarType.COURSE, TabBarType.PLAN].includes(this.tabModel.selectedIndex)) {
      return null;
    }
    return {
      strokeWidth: '1px',
      color: $r('sys.color.comp_divider'),
      startMargin: 0,
      endMargin: 0,
    } as DividerStyle
  }

  @Computed
  get getBgColor(): ResourceColor {
    return $r('sys.color.background_secondary');
  }

  @Computed
  get paddingBottom() {
    if (this.tabModel.isTabVertical) {
      return 0;
    }
    return this.windowModel.windowBottomPadding;
  }
}