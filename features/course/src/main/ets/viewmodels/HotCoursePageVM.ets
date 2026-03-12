import { BaseViewModel, RouterUtils } from 'lib_common';

@ObservedV2
export class HotCoursePageVM extends BaseViewModel {
  backBtnClick() {
    RouterUtils.pop();
  }
}
