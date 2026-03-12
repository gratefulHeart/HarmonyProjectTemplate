import { RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';

@Builder
export function RecommendationCoursePageBuilder() {
  RecommendationCoursePage()
}

@ComponentV2
struct RecommendationCoursePage {
  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '推荐课程',
        })

        Column({ space: 16 }) {
          Row() {
            Row() {
              Image($r('app.media.ic_search'))
                .width(16)
                .margin({ right: 6 })
              Text('搜索')
                .fontSize($r('sys.float.Body_L'))
                .lineHeight(21)
                .fontColor($r('sys.color.dialog_outer_border_color'))
            }
            .backgroundColor('#0d000000')
            .borderRadius(24)
            .layoutWeight(1)
            .padding({
              left: 12,
              right: 54,
              top: 7,
              bottom: 10
            })
            .margin({ right: 8 })
            .onClick(() => {
              RouterUtils.pushPathByName(RouterMap.COURSE_PAGE)
            })

            Column() {
              Image($r('app.media.ic_filter'))
                .width(40)
            }
            .backgroundColor('#0d000000')
            .borderRadius('50%')
            .onClick(() => {
              RouterUtils.pushPathByName(RouterMap.COURSE_PAGE)
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
          .margin({ bottom: 12 })

          Text('推荐课程内容区域')
            .fontSize(16)
            .fontColor($r('sys.color.font_secondary'))
        }
        .height('100%')
        .margin({ left: 16, right: 16 })
      }
      .height('100%')
      .backgroundColor($r('app.color.plan_background'))
    }
    .hideTitleBar(true)
  }
}
