import { BaseViewModel, RouterUtils } from 'lib_common';

@ObservedV2
export class HistoryPageVM extends BaseViewModel {
  backBtnClick() {
    RouterUtils.pop();
  }
}
