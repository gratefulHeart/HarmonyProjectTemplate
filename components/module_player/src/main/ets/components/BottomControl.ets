import { PipManager } from '../tools/PipManager';
import { getTimeString } from '../tools/TimeTools'
import { PlayerVM } from '../viewModels/PlayerVM';

const TAKE_SURPLUS = 100;

@ComponentV2
export struct BottomControl {
  @Param isLock: boolean = false;
  @Param isLayoutFullScreen: boolean = false;
  @Param fullScreen: (isLayoutFullScreen: boolean) => void = () => {
  }
  @Param selectionsEvent: () => void = () => {
  }
  @Param nextSelectionsEvent: () => void = () => {
  }
  @Local playerVM: PlayerVM = PlayerVM.instance;

  @Builder
  landscapeBottom() {
    Column() {
      Row() {
        Text(getTimeString(PipManager.getInstance().player.currentTime))
          .fontSize($r('sys.float.Caption_M'))
          .fontColor(Color.White)
          .fontWeight(FontWeight.Regular)

        Slider({
          value: Math.round(PipManager.getInstance().player.currentTime /
          PipManager.getInstance().player.totalDuration * TAKE_SURPLUS),
          min: 0,
          max: 100
        })
          .trackThickness(4)
          .selectedColor($r('app.color.app_theme'))
          .layoutWeight(1)
          .trackColor('rgba(255,255,255,0.4)')
          .onChange((value: number, mode: SliderChangeMode) => {
            if (mode === SliderChangeMode.End) {
              PipManager.getInstance().player.isPlaying = true
            } else {
              PipManager.getInstance().player.isPlaying = false
            }
            PipManager.getInstance().player.currentTime =
              PipManager.getInstance().player.totalDuration * value / TAKE_SURPLUS
            PipManager.getInstance().player.changeSeek(PipManager.getInstance().player.currentTime, 2)
          })
        Text(getTimeString(PipManager.getInstance().player.totalDuration))
          .fontSize($r('sys.float.Caption_M'))
          .fontColor(Color.White)
          .fontWeight(FontWeight.Regular)
      }
      .width('100%')
      .height(20)

      Row() {
        Image(PipManager.getInstance().player.isPlaying ? $r('app.media.pip_window_icon_play') :
        $r('app.media.pip_window_icon_pause'))
          .id('playing01')
          .width(24)
          .height(24)
          .margin({ right: 26 })
          .onClick(() => {
            PipManager.getInstance().player.isPlaying = !PipManager.getInstance().player.isPlaying;
          })
        Blank()
          .layoutWeight(1)
      }
      .margin({ top: 5 })
      .layoutWeight(1)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .height('100%')
    .padding({
      left: 24,
      right: 50,
      top: 10,
      bottom: 20
    })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#00990000', 0.0], ['#80000000', 1.0]]
    })
    .visibility(this.isLayoutFullScreen ? Visibility.Visible : Visibility.Hidden)
  }

  @Builder
  verticalBottom() {
    Row() {
      Image(PipManager.getInstance().player.isPlaying ? $r('app.media.pip_window_icon_play') :
      $r('app.media.pip_window_icon_pause'))
        .id('playing02')
        .width(24)
        .height(24)
        .margin({ left: 12, right: 8 })
        .onClick(() => {
          PipManager.getInstance().player.isPlaying = !PipManager.getInstance().player.isPlaying;
        })
      Row() {
        Text(getTimeString(PipManager.getInstance().player.currentTime))
          .fontSize($r('sys.float.Caption_M'))
          .fontColor(Color.White)
          .fontWeight(FontWeight.Regular)
        Slider({
          value: Math.round(PipManager.getInstance().player.currentTime /
          PipManager.getInstance().player.totalDuration * TAKE_SURPLUS),
          min: 0,
          max: 100
        })
          .trackThickness(4)
          .selectedColor($r('app.color.app_theme'))
          .layoutWeight(1)
          .trackColor('rgba(255,255,255,0.4)')
          .onChange((value: number, mode: SliderChangeMode) => {
            if (mode === SliderChangeMode.End) {
              PipManager.getInstance().player.isPlaying = true
            } else {
              PipManager.getInstance().player.isPlaying = false
            }
            PipManager.getInstance().player.currentTime =
              PipManager.getInstance().player.totalDuration * value / TAKE_SURPLUS
            PipManager.getInstance().player.changeSeek(PipManager.getInstance().player.currentTime, 2)
          })
        Text(getTimeString(PipManager.getInstance().player.totalDuration))
          .fontSize($r('sys.float.Caption_M'))
          .fontColor(Color.White)
          .fontWeight(FontWeight.Regular)
      }
      .layoutWeight(1)
      .height(25)

      Image($r('app.media.icon_multi_screen_collaboration'))
        .width(24)
        .height(24)
        .margin({ left: 8, right: 12 })
        .onClick(() => {
          if (this.playerVM.windowStatusType === 5) {
            this.getUIContext().getPromptAction().showToast({ message: '分屏下不支持切换' })
            return
          }
          this.fullScreen(this.isLayoutFullScreen ? false : true)
        })
    }
    .alignItems(this.isLayoutFullScreen ? VerticalAlign.Top : VerticalAlign.Bottom)
    .width('100%')
    .height('100%')
    .padding({ bottom: 5 })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#00990000', 0.0], ['#80000000', 1.0]]
    })
    .visibility(this.isLayoutFullScreen ? Visibility.Hidden : Visibility.Visible)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      this.landscapeBottom()
      this.verticalBottom()
    }
    .visibility(this.isLock ? Visibility.Hidden : Visibility.Visible)
    .width('100%')
    .height('100%')
  }
}
