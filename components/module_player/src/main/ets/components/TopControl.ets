import { image } from '@kit.ImageKit';
import { PlayerVM } from '../viewModels/PlayerVM';
import { ResolutionSheet } from './ResolutionSheet';
import { PlayerSettingSheet } from './PlayerSettingSheet';
import { batteryInfo, BusinessError, commonEventManager } from '@kit.BasicServicesKit';
import { ReportSheet } from './ReportSheet';
import { ReportItem } from '../models/Type';
import { window } from '@kit.ArkUI';
import { COURSE_DATA1, RouterUtils } from 'lib_common';

// 定义订阅者，用于保存创建成功的订阅者对象，后续使用其完成订阅及退订的动作
let subscriber: commonEventManager.CommonEventSubscriber;
// 订阅者信息
let subscribeInfo: commonEventManager.CommonEventSubscribeInfo = {
  events: ['usual.event.POWER_CONNECTED', 'usual.event.POWER_DISCONNECTED']
};

@CustomDialog
struct quitDialog {
  controller?: CustomDialogController;

  build() {
    Column() {
      Text('退出训练？')
        .fontSize(18)
        .height(54)
        .width(328)
        .textAlign(TextAlign.Center)
        .padding({ top: 15, bottom: 15, left: 24, right: 24 })
      Text('运动贵在坚持，您确定要退出训练吗？')
        .fontSize(12)
        .height(16)
        .width(328)
        .textAlign(TextAlign.Center)
        .padding({ left: 24, right: 24 })
        .margin({ bottom: 24 })
      Row({ space: 16 }) {
        Button('确定退出')
          .width(140)
          .height(40)
          .borderRadius(20)
          .fontColor($r('sys.color.font_on_primary'))
          .backgroundColor('rgba(0, 0, 0, 0.05)')
          .onClick(() => {
            RouterUtils.pop()
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })

        Button('继续训练')
          .width(140)
          .height(40)
          .borderRadius(20)
          .backgroundColor($r('app.color.app_theme'))
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
      }
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .alignItems(HorizontalAlign.Center)
    .borderRadius(32)
    .width(328)
    .height(150)
  }
}

@ComponentV2
export struct TopControl {
  @Param courseId: string = ''
  @Param playerTitle: string = '01 课程章节目录名称';
  @Param isLock: boolean = false;
  @Param isLayoutFullScreen: boolean = false;
  @Param currentTime: string = '';
  // 横竖屏切换事件
  @Param fullScreen: (isLayoutFullScreen: boolean) => void = () => {
  }
  // 更多事件
  @Param moreEvent: () => void = () => {
  }
  // 倍速切换事件
  @Param speedEvent: (speed: string) => void = () => {
  }
  // 分辨率切换事件
  @Param resolutionEvent: (resolution: string) => void = () => {
  }
  // 画中画事件
  @Param pipWindowEvent: () => void = () => {
  }
  // 举报事件
  @Param onReport: (reasons: string[], reason: string) => void = () => {
  }
  // 清晰度
  @Local isShowDefinitionSheet: boolean = false;
  // 设置
  @Local isShowSettingSheet: boolean = false;
  @Local isShowReport: boolean = false;
  @Local playerVM: PlayerVM = PlayerVM.instance;
  @Local speedIcon: Resource = $r('app.media.icon_speed_100percent');
  @Local reportPixmap: image.PixelMap | undefined = undefined
  @Local keyboardHeight: number = 0;

  cancelDialogController: CustomDialogController = new CustomDialogController({
    builder: quitDialog({

    }),
    alignment: DialogAlignment.Center,
    autoCancel: false  // 允许点击蒙层关闭
  })

  @Monitor('playerVM.speed','playerVM.resolution')
  onChange(monitor: IMonitor) {
    monitor.dirty.forEach((path: string) => {
      if (path === 'playerVM.speed') {
        let speed = monitor.value(path)?.now as string
        this.speedIcon = this.setSpeedIcon(speed)
      } else if (path === 'playerVM.resolution') {
      }
    })
  }

  @Builder
  landscapeTop() {
    if (this.isLock) {
      Row() {
        Image($r('app.media.icon_chevron_backward_dark'))
          .width(40)
          .height(40)
          .onClick(() => {
            this.cancelDialogController.open()
          })
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .height('100%')
      .padding({ top: 20, left: 24 })
    } else {
      Row() {
        Image($r('app.media.icon_chevron_backward_dark'))
          .width(40)
          .height(40)
          .margin({ right: 8 })
          .onClick(() => {
            this.cancelDialogController.open()
          })
        // Text(this.playerVM.movieItem.movieTitle)
        Text(COURSE_DATA1[Number(this.courseId) - 1].courseTitle)
          .fontSize($r('sys.float.Title_S'))
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
        Blank()
          .layoutWeight(1)
        Image(this.speedIcon)
          .width(40)
          .height(40)
          .onClick(() => {
            this.speedEvent('')
          })
        Image(this.playerVM.isCharge ? $r('app.media.battery_bolt') : $r('app.media.battery_60percent'))
          .width(24)
          .height(12)
          .margin({ left: 18 })
        Text(this.currentTime)
          .fontSize($r('sys.float.Body_S'))
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 5, right: 24 })
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .height('100%')
      .padding({ top: 20, left: 24, right: 24 })
      .linearGradient({
        direction: GradientDirection.Top,
        colors: [['#00990000', 0.0], ['#80000000', 1.0]]
      })
      .visibility(this.isLayoutFullScreen ? Visibility.Visible : Visibility.Hidden)
    }
  }

  @Builder
  verticalTop() {
    Row() {
      Row() {
        Image($r('app.media.icon_public_ellipsis'))
          .width(24)
          .height(24)
      }
      .padding(5)
      .bindSheet(this.isShowSettingSheet, this.playerSettingBuilder(), {
        // 半模态高度
        height: 350,
        dragBar: true, // 是否显示控制条
        backgroundColor: Color.White,
        showClose: true, // 是否显示关闭图标
        shouldDismiss: ((sheetDismiss: SheetDismiss) => { // 半模态页面交互式关闭回调函数
          sheetDismiss.dismiss();
          this.isShowSettingSheet = false
        })
      })
      .onClick(() => {
        this.isShowSettingSheet = true
      })

      Row()
        .bindSheet(this.isShowDefinitionSheet, this.definitionBuilder(), {
          // 半模态高度
          height: 350,
          dragBar: true, // 是否显示控制条
          backgroundColor: Color.White,
          showClose: true, // 是否显示关闭图标
          shouldDismiss: ((sheetDismiss: SheetDismiss) => {
            sheetDismiss.dismiss();
            this.isShowDefinitionSheet = false
          })
        })

      Row()
        .bindSheet(this.isShowReport, this.reportBuilder(), {
          // 半模态高度
          height: 600 + this.keyboardHeight,
          dragBar: true, // 是否显示控制条
          backgroundColor: Color.White,
          showClose: true, // 是否显示关闭图标
          shouldDismiss: ((sheetDismiss: SheetDismiss) => {
            sheetDismiss.dismiss();
            this.isShowReport = false
          })
        })
    }
    .justifyContent(FlexAlign.End)
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .height('100%')
    .padding({ top: 5, right: 12 })
    .linearGradient({
      direction: GradientDirection.Top,
      colors: [['#00990000', 0.0], ['#80000000', 1.0]]
    })
    .visibility(this.isLayoutFullScreen ? Visibility.Hidden : Visibility.Visible)
  }

  @Builder
  playerSettingBuilder() {
    Column() {
      PlayerSettingSheet({
        defaultSpeed: this.playerVM.speed,
        onChangeSpeed: (selectSpeed: string) => {
          this.speedEvent(selectSpeed)
        },
        settingItem: (selectItem: string) => {
          if (selectItem === '清晰度') {
            this.isShowDefinitionSheet = true
          } else if (selectItem === '画中画') {
            this.pipWindowEvent()
          } else if (selectItem === '举报') {
            this.getUIContext().getComponentSnapshot().get('XComponent01', (error: Error, pixmap: image.PixelMap) => {
              if (error) {
                return;
              }
              this.reportPixmap = pixmap
              this.isShowReport = true
              this.playerVM.reasonList.forEach((item: ReportItem) => {
                item.isSelected = false
              })
            })
          } else {
          }
        }
      })
        .width('90%')
        .height(350)
    }
    .width('100%')
    .height(350)
  }

  @Builder
  definitionBuilder() {
    Column() {
      ResolutionSheet({
        defaultResolution: this.playerVM.resolution,
        onChangeResolution: (selectResolution: string) => {
          this.resolutionEvent(selectResolution)
        }
      })
        .width('90%')
        .height(350)
    }
    .width('100%')
    .height(350)
  }

  @Builder
  reportBuilder() {
    Column() {
      ReportSheet({
        reportPixmap: this.reportPixmap,
        onReport: (reasons: string[], reason: string) => {
          this.onReport(reasons, reason)
          this.isShowReport = false
        }
      })
        .width('90%')
        .height(500)
    }
    .width('100%')
    .height(500)
  }

  setSpeedIcon(speed: string): Resource {
    if (speed === '0.75') {
      return $r('app.media.icon_speed_75percent');
    } else if (speed === '1.0') {
      return $r('app.media.icon_speed_100percent');
    } else if (speed === '1.25') {
      return $r('app.media.icon_speed_125percent');
    } else if (speed === '1.5') {
      return $r('app.media.icon_speed_150percent');
    } else if (speed === '2.0') {
      return $r('app.media.icon_speed_200percent');
    }
    return $r('app.media.icon_speed_100percent');
  }

  aboutToAppear(): void {
    try {
      commonEventManager.createSubscriber(subscribeInfo, createCB);
    } catch (error) {
    }
    getBatteryInfo()
    this.speedIcon = this.setSpeedIcon(this.playerVM.speed)
    window.getLastWindow(getContext(this)).then((currentWindow: window.Window) => {
      currentWindow.on('avoidAreaChange', data => {
        if (data.type === window.AvoidAreaType.TYPE_KEYBOARD) {
          if (data.area.bottomRect.height === 0) {
            this.keyboardHeight = 0
          } else {
            this.keyboardHeight = 100;
          }
        }
      })
    })


  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 横屏
      this.landscapeTop()
      // 竖屏
      this.verticalTop()
    }
    .width('100%')
    .height(this.isLayoutFullScreen ? 80 : 48)
  }
}

function getBatteryInfo() {
  let batterySOCInfo: number = batteryInfo.batterySOC;
  let chargingStatusInfo = batteryInfo.chargingStatus;
  if (chargingStatusInfo === 1 || chargingStatusInfo === 3) {
    PlayerVM.instance.isCharge = true
  } else {
    PlayerVM.instance.isCharge = false
  }
  PlayerVM.instance.charge = batterySOCInfo
}

function createCB(err: BusinessError, commonEventSubscriber: commonEventManager.CommonEventSubscriber) {
  if (!err) {
    subscriber = commonEventSubscriber;
    try {
      commonEventManager.subscribe(subscriber, subscribeCB);
    } catch (error) {
    }
  }
}

// 订阅公共事件回调
function subscribeCB(err: BusinessError, data: commonEventManager.CommonEventData) {
  getBatteryInfo()
}

