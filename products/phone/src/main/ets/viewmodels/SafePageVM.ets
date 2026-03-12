import { BaseViewModel, PreferenceUtils, RouterMap, RouterUtils } from 'lib_common';
import { agreePrivacyKey } from '../common/Constants';

@ObservedV2
export class SafePageVM extends BaseViewModel {
  privacyClick() {
    RouterUtils.pushPathByName(RouterMap.PRIVACY_PAGE);
  }

  agreeBtnClick() {
    PreferenceUtils.getInstance().put(agreePrivacyKey, true);
    RouterUtils.clearStack();
    // 直接跳转到 Tab 首页，不再经过引导页
    const targetPage = RouterMap.INDEX_PAGE;
    RouterUtils.pushPathByName(targetPage, null, undefined, false);
  }

  cancelBtnClick() {
    RouterUtils.pushPathByName(RouterMap.AGREE_PRIVACY_PAGE);
  }

  quitApp() {
    getContext().getApplicationContext().killAllProcesses();
  }
}
