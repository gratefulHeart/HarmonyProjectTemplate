import { BaseViewModel, RouterUtils } from 'lib_common';

@ObservedV2
export class RecordPageVM extends BaseViewModel {
  backBtnClick() {
    RouterUtils.pop();
  }
}