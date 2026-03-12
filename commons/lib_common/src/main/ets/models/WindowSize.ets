@ObservedV2
export class WindowSize {
  @Trace screenHeight: number = 0;
  @Trace screenWidth: number = 0;
  @Trace statusHeight: number = 0;
  @Trace bottomHeight: number = 0;
  @Trace windowStatusType: number = 1;
}

@ObservedV2
export class UserInfoModel {
  @Trace id: number = 0;
  @Trace avatar: string = '';
  @Trace name: string = '';
  @Trace nickname: string = '';
  @Trace sex: string = '';
  @Trace cellphone: string = '';
  @Trace birthday: string = '';
  @Trace code: string = '';
  @Trace isLogin: boolean = false;
  @Trace isMembership: boolean = false;
}