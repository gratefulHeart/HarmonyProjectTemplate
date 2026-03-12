import { BaseViewModel, RouterUtils } from 'lib_common';

@ObservedV2
export class MarkViewModel extends BaseViewModel {
  backBtnClick() {
    RouterUtils.pop();
  }
}