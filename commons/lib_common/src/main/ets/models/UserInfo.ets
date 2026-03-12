@ObservedV2
export class UserInfo {
  @Trace id: number = 0;
  @Trace avatar: ResourceStr = '';
  @Trace name: string = '';
  @Trace cellphone: string = '';
  @Trace address: string = '';
  @Trace isLogin: boolean = false;
}
