import { CommonConstants, PreferenceUtils, RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { skipGuide } from '../common/Constants';
import { GuidePageVM } from '../viewmodels/GuidePageVM';

@Builder
export function GuidePageStartBuilder() {
  GuidePage()
}

@ComponentV2
struct GuidePage {
  vm: GuidePageVM = new GuidePageVM();

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
        })
      }

      Column() {
        Image($r('app.media.running'))
          .width(350)
          .height(350)
          .draggable(false)
          .margin({
            left: 9,
            right: 9,
            top: 58,
          })
      }
      .width(350)
      .height('60%')

      Column() {
        // 只在非第一页显示下一步按钮
        Button('开启您的运动之旅', { type: ButtonType.Capsule })
          .width(328)
          .height(40)
          .fontColor($r('sys.color.font_on_primary'))
          .backgroundColor($r('app.color.app_theme'))
          .onClick(() => {
            PreferenceUtils.getInstance().put(skipGuide, true);
            RouterUtils.pushPathByName(RouterMap.INDEX_PAGE)
          })
          .margin({ bottom: CommonConstants.PADDING_M })
      }
      .height('40%')
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ bottom: 20 })
      .layoutWeight(1)
    }
    .backgroundColor($r('sys.color.ohos_id_color_background'))
    .hideTitleBar(true)
  }
}
