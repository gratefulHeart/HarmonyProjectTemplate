import { LoginSheetUtils } from 'lib_account';
import { BaseViewModel, RouterUtils } from 'lib_common';
import { MineServiceApi } from 'lib_api';

@ObservedV2
export class CommonKnowledgePageVM extends BaseViewModel {
  backBtnClick() {
    RouterUtils.pop();
  }

  saveAction(label: string): boolean {
    if (!this.userInfoModel.isLogin) {
      LoginSheetUtils.open()
      return false
    }
    MineServiceApi.addMark(label)
    return true
  }

  deleteAction(label: string): boolean {
    if (!this.userInfoModel.isLogin) {
      LoginSheetUtils.open()
      return false
    }
    MineServiceApi.cancelMark(label)
    return true
  }

  flushCollection() {
    if (!this.userInfoModel.isLogin) {
      AppStorage.setOrCreate<boolean>('CommonActivate', false)
      AppStorage.setOrCreate<boolean>('CommonDraw', false)
      AppStorage.setOrCreate<boolean>('CommonEquip', false)
      AppStorage.setOrCreate<boolean>('CommonStrain', false)
      AppStorage.setOrCreate<boolean>('CommonWarm', false)
      AppStorage.setOrCreate<boolean>('CommonYoga', false)
    }
  }

  public addHistory(label: string) {
    MineServiceApi.addToHistory(label)
  }
}
