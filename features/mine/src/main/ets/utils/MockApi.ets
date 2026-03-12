import { OrderInfoUtil } from './OrderInfoUtil';

export class MockApi {
  static isShow: boolean = false;

  static WX_APP_ID: string = 'wx05b3e2e9fc730840';

  static getAliPreOrderInfo() {
    // 支付宝预下单
    return new Promise<string>((resolve, reject) => {
      try {
        OrderInfoUtil.getOrderInfo().then((result) => {
          resolve(result);
        });
      } catch (error) {
        reject('');
      }
    });
  }

  static getHuaweiOrderInfo() {
    return '{"app_id":"***","merc_no":"***","prepay_id":"xxx","timestamp":"1680259863114","noncestr":"1487b8a60ed9f9ecc0ba759fbec23f4f","sign":"****","auth_id":"***"}';
  }
}

