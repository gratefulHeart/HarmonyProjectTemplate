import { BaseViewModel, RouterMap, RouterUtils } from 'lib_common';
import { MineGridItem } from '../types/Types';

@ObservedV2
export class MineViewModel extends BaseViewModel {
  jumpLogin() {
    RouterUtils.pushPathByName(RouterMap.HUAWEI_LOGIN_PAGE);
  }

  jumpVIP() {
    RouterUtils.pushPathByName(RouterMap.VIP_PAGE);
  }

  jumpRecord() {
    RouterUtils.pushPathByName(RouterMap.RECORD_PAGE);
  }

  gridClick(v: MineGridItem) {
    RouterUtils.pushPathByName(v.routerName);
  }

  isVIP() {
    this.userInfoModel.isVIP = true
  }

  @Computed
  get userIcon() {
    return this.userInfoModel.authorIcon || $r('app.media.ic_user_default');
  }

  @Computed get pagePaddingBottom() {
    if (this.tabModel.isTabVertical) {
      return this.windowModel.windowBottomPadding;
    }
    return 0;
  }
}