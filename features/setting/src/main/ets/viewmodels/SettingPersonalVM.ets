import { promptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import {
  BaseViewModel,
  FileUtils,
  Logger,
  PhoneNumberUtils,
  RouterUtils,
  CommonConstants,
  CommonTipDialog,
} from 'lib_common';
import { MineServiceApi } from 'lib_api';
import { getAccountErrorMsg, ErrorCode } from 'lib_account';

const TAG = '[SettingPersonalVM]';

@ObservedV2
export class SettingPersonalVM extends BaseViewModel {
  @Trace nickName: string = this.userInfoModel.authorNickName;
  @Trace gender: string = this.userInfoModel.authorGender;
  @Trace age: string = this.userInfoModel.authorAge;
  @Trace height: string = this.userInfoModel.authorHeight;
  @Trace weight: string = this.userInfoModel.authorWeight;
  @Trace purpose: string[] = this.userInfoModel.purpose;
  @Trace body: string[] = this.userInfoModel.body;
  @Trace contactPhone: string = this.userInfoModel.authorPhone;
  @Trace personalDesc: string = this.userInfoModel.authorDesc;
  @Trace showNickNameSheet: boolean = false;
  @Trace showAgeSheet: boolean = false;
  @Trace showHeightSheet: boolean = false;
  @Trace showGenderSheet: boolean = false;
  @Trace showWeightSheet: boolean = false;
  @Trace showPurposeSheet: boolean = false;
  @Trace showBodySheet: boolean = false;
  @Trace showPersonDescSheet: boolean = false;
  @Trace showPhoneSheet: boolean = false;
  @Trace hasModify: boolean = false;
  @Trace sheetType: SheetType = SheetType.BOTTOM;
  readonly defaultSheetH: SheetSize | Length = SheetSize.LARGE;

  modifyNickName() {
    if (!this.nickName) {
      promptAction.showToast({ message: '昵称不能为空' });
      return
    }
    MineServiceApi.modifyPersonalInfo({ authorNickName: this.nickName });
    this.userInfoModel.authorNickName = this.nickName;
    this.showNickNameSheet = false;
    this.hasModify = true;
  }

  modifyGender(gender: string) {
    this.gender = gender
    MineServiceApi.modifyPersonalInfo({ authorGender: this.gender });
    this.userInfoModel.authorGender = this.gender;
    this.showGenderSheet = false;
    this.hasModify = true;
  }

  modifyAge(age: string) {
    this.age = age
    MineServiceApi.modifyPersonalInfo({ authorAge: this.age });
    this.userInfoModel.authorAge = this.age;
    this.showAgeSheet = false;
    this.hasModify = true;
  }

  modifyHeight() {
    MineServiceApi.modifyPersonalInfo({ authorHeight: this.height });
    this.userInfoModel.authorHeight = this.height;
    this.showHeightSheet = false;
    this.hasModify = true;
  }

  modifyWeight() {
    MineServiceApi.modifyPersonalInfo({ authorWeight: this.weight });
    this.userInfoModel.authorWeight = this.weight;
    this.showWeightSheet = false;
    this.hasModify = true;
  }

  modifyPurpose(purpose: string[]) {
    this.purpose = purpose
    MineServiceApi.modifyPersonalInfo({ authorPurpose: this.purpose });
    this.userInfoModel.purpose = this.purpose;
    this.showPurposeSheet = false;
    this.hasModify = true;
  }

  modifyBody(body: string[]) {
    this.body = body
    MineServiceApi.modifyPersonalInfo({ authorBody: this.body });
    this.userInfoModel.body = this.body;
    this.showBodySheet = false;
    this.hasModify = true;
  }

  modifyContactPhone() {
    if (!this.contactPhone) {
      promptAction.showToast({ message: '手机号码不能为空' });
      return;
    }
    if (!PhoneNumberUtils.isPhoneNumberValid(this.contactPhone)) {
      promptAction.showToast({ message: '请输入正确的手机号码' });
      return;
    }
    MineServiceApi.modifyPersonalInfo({ authorPhone: this.contactPhone });
    this.userInfoModel.authorPhone = PhoneNumberUtils.encryptPhone(this.contactPhone);
    this.showPhoneSheet = false;
    this.hasModify = true;
  }

  modifyPersonalDesc() {
    MineServiceApi.modifyPersonalInfo({ authorDesc: this.personalDesc });
    this.userInfoModel.authorDesc = this.personalDesc;
    this.showPersonDescSheet = false;
    this.hasModify = true;
  }

  saveUserIcon(uri: string) {
    if (!uri) {
      return;
    }
    const resp = FileUtils.handleUri(uri);
    Logger.info(TAG, 'user icon saved success, url:' + resp);
    MineServiceApi.modifyPersonalInfo({ authorIcon: resp });
    this.userInfoModel.authorIcon = resp;
    this.hasModify = true;
  }

  handleAvatarError(error: BusinessError) {
    Logger.error(TAG, 'onChooseAvatar failed, error: ' + JSON.stringify(error));
    if (error.code === ErrorCode.ERROR_CODE_CANCEL) {
      return;
    }
    let errorMsg: string = getAccountErrorMsg(error.code);

    CommonTipDialog.show({
      primaryTitle: '温馨提示',
      content: errorMsg,
      priBtnV: '确定',
    })
  }

  customBack() {
    RouterUtils.pop(this.hasModify ? 'modify-flag' : undefined);
  }

  setSheetType(sheetType: SheetType) {
    this.sheetType = sheetType;
  }

  getSheetPaddingBottom() {
    if (this.sheetType === SheetType.BOTTOM) {
      return Math.max(this.windowModel.windowBottomPadding, CommonConstants.PADDING_L);
    }
    return CommonConstants.PADDING_L;
  }
}