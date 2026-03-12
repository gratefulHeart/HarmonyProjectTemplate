import { BaseViewModel, RouterUtils } from 'lib_common';

@ObservedV2
export class AdvancedCoursePageVM extends BaseViewModel {
  backBtnClick() {
    RouterUtils.pop();
  }
}
