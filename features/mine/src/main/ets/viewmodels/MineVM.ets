import { BaseViewModel, RouterMap, RouterUtils } from 'lib_common';

@ObservedV2
export class MineViewModel extends BaseViewModel {
  jumpLogin() {
    RouterUtils.pushPathByName(RouterMap.HUAWEI_LOGIN_PAGE);
  }

  @Computed get pagePaddingBottom() {
    if (this.tabModel.isTabVertical) {
      return this.windowModel.windowBottomPadding;
    }
    return 0;
  }
}