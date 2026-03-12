import { CommonConstants } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';

@Builder
export function CoursePageBuilder() {
  CoursePage()
}

@ComponentV2
export struct CoursePage {
  @Builder
  contentBuilder() {
    Column({ space: 16 }) {
      Text('内容展示区域')
        .fontSize(16)
        .fontColor($r('sys.color.font_secondary'))

      Text('在此添加业务组件')
        .fontSize(14)
        .fontColor($r('sys.color.font_tertiary'))
    }
    .width('100%')
    .padding(16)
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '发现',
          isSubTitle: false,
        })

        Scroll() {
          this.contentBuilder()
        }
        .edgeEffect(EdgeEffect.Spring)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
      .backgroundColor($r('sys.color.background_secondary'))
    }
    .hideTitleBar(true)
  }
}
