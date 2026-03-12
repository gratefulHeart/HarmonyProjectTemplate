import { CommonConstants } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { MineViewModel } from '../viewmodels/MineVM';

@Builder
export function MinePageBuilder() {
  MinePage()
}

@ComponentV2
struct MinePage {
  @Local vm: MineViewModel = new MineViewModel();

  @Builder
  loginCard() {
    Column() {
      if (this.vm.userInfoModel.isLogin) {
        Row({ space: CommonConstants.SPACE_L }) {
          Image($r('app.media.ic_user_unlogin'))
            .width(48)
            .draggable(false)
          Text(this.vm.userInfoModel.authorNickName)
            .fontSize(18)
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
        }
      } else {
        Row({ space: CommonConstants.SPACE_L }) {
          Image($r('app.media.ic_user_unlogin'))
            .width(48)
            .draggable(false)
          Text('去登录')
            .fontSize(18)
            .fontColor($r('sys.color.font_primary'))
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
        }
        .onClick(() => {
          this.vm.jumpLogin();
        })
      }
    }
    .backgroundColor($r('sys.color.comp_background_primary'))
    .width(CommonConstants.FULL_PERCENT)
    .padding(CommonConstants.PADDING_M)
    .borderRadius(12)
  }

  @Builder
  contentBuilder() {
    Column({ space: 16 }) {
      this.loginCard()

      Text('我的页面内容区域')
        .fontSize(16)
        .fontColor($r('sys.color.font_secondary'))

      Text('在此添加您的个人中心组件')
        .fontSize(14)
        .fontColor($r('sys.color.font_tertiary'))
    }
    .width(CommonConstants.FULL_PERCENT)
    .padding(16)
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '我的',
          isSubTitle: false,
        })

        Scroll() {
          this.contentBuilder()
        }
        .layoutWeight(1)
        .align(Alignment.Top)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .padding({
          left: this.vm.breakPointModel.pagePadding,
          right: this.vm.breakPointModel.pagePadding,
          top: CommonConstants.SPACE_M,
        })
      }
      .width(CommonConstants.FULL_PERCENT)
      .height(CommonConstants.FULL_PERCENT)
      .padding({
        bottom: this.vm.pagePaddingBottom,
      })
    }
    .hideTitleBar(true)
    .backgroundColor($r('sys.color.background_secondary'))
  }
}
