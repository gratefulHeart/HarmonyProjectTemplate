import { BaseViewModel, RouterUtils } from 'lib_common';

@ObservedV2
export class PlanPageVM extends BaseViewModel {
  backBtnClick() {
    RouterUtils.pop();
  }
}
