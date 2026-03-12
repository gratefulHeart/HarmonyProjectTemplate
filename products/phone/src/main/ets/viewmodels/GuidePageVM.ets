import { BaseViewModel, PreferenceUtils, RouterMap, RouterUtils } from 'lib_common';
import { skipGuide } from '../common/Constants';

@ObservedV2
export class GuidePageVM extends BaseViewModel {
  currentPageIndex: number = 0;

  backBtnClick() {
    this.currentPageIndex--;
    RouterUtils.pop();
  }

  skipBtnClick() {
    PreferenceUtils.getInstance().put(skipGuide, true);
    RouterUtils.clearStack();
    RouterUtils.pushPathByName(RouterMap.INDEX_PAGE);
  }

  skipGuide() {
    PreferenceUtils.getInstance().put(skipGuide, true);
    RouterUtils.replacePathByName(RouterMap.INDEX_PAGE);
  }

  saveAge(age: string) {
    AppStorage.setOrCreate<string>('userAge', age);
  }

  saveGender(gender: string) {
    AppStorage.setOrCreate<string>('userGender', gender);
  }

  saveBody(body: string[]) {
    AppStorage.setOrCreate<string[]>('userBody', body);
  }

  savePurpose(purpose: string[]) {
    AppStorage.setOrCreate<string[]>('userPurpose', purpose);
  }

  saveHeight(height: string) {
    AppStorage.setOrCreate<string>('userHeight', height);
  }

  saveWeight(weight: string) {
    AppStorage.setOrCreate<string>('userWeight', weight);
  }

  saveTargetWeight(target: string) {
    AppStorage.setOrCreate<string>('userTargetWeight', target);
  }
}
