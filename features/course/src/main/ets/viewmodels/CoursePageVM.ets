import { LoginSheetUtils } from 'lib_account';
import { BaseViewModel, RouterUtils } from 'lib_common';
import { MineServiceApi } from 'lib_api';

@ObservedV2
export class CoursePageVM extends BaseViewModel {
  backBtnClick() {
    RouterUtils.pop();
  }

  isVIP(): boolean {
    if (!this.userInfoModel.isLogin || !this.userInfoModel.isVIP) {
      return false
    }
    return true
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
      AppStorage.setOrCreate<boolean>('AdvancedArm', false)
      AppStorage.setOrCreate<boolean>('AdvancedDouble', false)
      AppStorage.setOrCreate<boolean>('AdvancedSit', false)
      AppStorage.setOrCreate<boolean>('AdvancedStrength', false)
      AppStorage.setOrCreate<boolean>('AdvancedSkip', false)
      AppStorage.setOrCreate<boolean>('AdvancedWaist', false)
      AppStorage.setOrCreate<boolean>('CourseBack', false)
      AppStorage.setOrCreate<boolean>('CourseHome', false)
      AppStorage.setOrCreate<boolean>('CourseRun', false)
      AppStorage.setOrCreate<boolean>('CourseStrength', false)
      AppStorage.setOrCreate<boolean>('CourseWaist', false)
    }
  }

  public deleteHistory(label: string) {
    MineServiceApi.deleteFromHistory(label)
  }
  
  public addHistory(label: string) {
    MineServiceApi.addToHistory(label)
  }
}
