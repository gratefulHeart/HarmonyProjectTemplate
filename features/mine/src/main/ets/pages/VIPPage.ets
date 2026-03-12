import { VipPackage } from '../components/VipPackage';
import { VipBenefits } from '../components/VipBenefits';
import { VipOperation } from '../components/VipOperation';
import { VipOpen } from '../components/VipOpen';
import { VipPackageItem } from '../model/Model';
import { baseActionSheet } from '../components/ActionSheet';
import { NavHeaderBar } from 'lib_widget';
import { aggregatedPaymentService, CashierPicker, PaymentType } from 'aggregated_payment'
import { promptAction } from '@kit.ArkUI';
import { MockApi } from '../utils/MockApi'
import { MineViewModel } from '../viewmodels/MineVM';
import { deviceInfo } from '@kit.BasicServicesKit';

@Builder
export function VIPPageBuilder() {
  VIPPage()
}

@ComponentV2
export struct VIPPage {
  vm: MineViewModel = new MineViewModel();
  @Param userName: string = ''
  @Param vipType: string = ''
  @Param routerModule: NavPathStack = new NavPathStack()
  hwOrderStr: string = '';
  @Local aliOrderStr: string = '';
  @Local amout: number = 29;
  @Event onVerifyNow: () => void = () => {
  }
  @Event onVipOpen: () => void = () => {
  }
  @Event packageChange: (vipPackage: VipPackageItem) => void = () => {
  }

  private uiContext: UIContext = this.getUIContext();

  private cashierPicker: CashierPicker = new CashierPicker(this.uiContext)
    .onRealPayment(async (type: PaymentType) => {
      // todo: 根据支付类型向服务器请求支付所需参数
      if (type === PaymentType.ALIPAY) {
        /**
         * 请求拉起支付宝
         *
         * 临时测试时，orderInfo 不推荐传入空字符串，这会导致跳转至支付宝行为仅仅是跳转，不会有支付相关的交互
         * 未安装支付宝且参数真实时，SDK 会尝试使用 this.navPathStack 跳转至 H5 页面继续支付，该参数可不传
         */
        aggregatedPaymentService.requestPaymentByAliPay({ orderInfo: 'ORDER_INFO' }, this.routerModule);
      } else if (type === PaymentType.HUAWEI) {
        /**
         * 请求拉起华为支付
         */
        if (deviceInfo.marketName === 'emulator') {
          this.showToast('华为支付在模拟器场景下无任何响应');
          return;
        }
        aggregatedPaymentService.requestPaymentByHuawei(this.uiContext, { orderStr: '' });
      } else if (type === PaymentType.WECHAT) {
        /**
         * 请求拉起微信支付
         *
         * 微信支持获取拉起结果，如果拉起成功，则可以进一步尝试等待支付回调。如果拉起失败，则不会有支付回调。
         */
        const isWeChatOpenSuccess: boolean =
          await aggregatedPaymentService.requestPaymentByWeChat(this.uiContext, {
            partnerId: '',
            prepayId: '',
            nonceStr: '',
            timeStamp: '',
            sign: ''
          });
        if (!isWeChatOpenSuccess) {
          this.showToast('微信拉起失败');
        }
      }
    })
    .onWillDismiss((reason: DismissReason) => {
      if (reason === DismissReason.TOUCH_OUTSIDE) {
        this.showToast('已拦截点击其它区域进行关闭的交互方式');
      } else {
        this.cashierPicker.close();
      }
    });

  private showToast(msg: string): void {
    this.uiContext.getPromptAction().showToast({ message: `Test: ${msg}` });
  }

  aboutToAppear(): void {
    // todo: 端侧支付回调仅可用于参考，以辅助提升支付结果判定效率，不建议完全依赖。如：实际支付成功，但支付回调没有触发。
    aggregatedPaymentService.registerPaymentCallback(
      (type: PaymentType, isSuccess: boolean) => {
        this.showToast(`收到 ${type} 支付回调，支付结果：${(isSuccess ? '成功' : '失败')}`);

        this.vm.isVIP()
        this.onVipOpen()
        baseActionSheet.close('VipOpen')
      }
    );
  }

  public aboutToDisappear(): void {
    aggregatedPaymentService.unregisterAllPaymentCallbacks();
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '会员中心',
        })

        Column() {
          Column() {
            VipPackage({
              userName: this.userName,
              packageChange: (vipPackage: VipPackageItem) => {
                this.packageChange(vipPackage)
                this.amout = vipPackage.amount;
              },
            })
          }

          Column() {
            VipBenefits()
          }

          Column() {
            Column() {
              VipOperation({
                onVerifyNow: () => this.onVerifyNow(),
              })
            }
            Column() {
              VipOpen({
                pageInfo: this.routerModule,
                onVipOpen: () => {
                  this.cashierPicker
                    .reset() // 内部状态重置
                    .setAmount(this.amout * 100) // 支付金额，单位：分
                    .setTradeSummary('这里是一行订单摘要') // 订单摘要 (可选，不填则不显示)
                    .open();
                },
              })
            }
            .justifyContent(FlexAlign.End)
            .layoutWeight(1)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .height('90%')
        .padding({ top: 20 })
      }
      .height('90%')
      .padding({ bottom: Number(AppStorage.get('bottomRectHeight')) })
      .margin({bottom:25})
      .backgroundImage($r('app.media.vip_bg'))
      .backgroundImageSize(ImageSize.Contain)
    }
    .hideTitleBar(true)
  }
}