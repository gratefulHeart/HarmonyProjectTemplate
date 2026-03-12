import { AdvancedCourse, HotCourse } from 'course';
import { RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';

@Builder
export function CoursePlanPageBuilder() {
  CoursePlanPage()
}

@ComponentV2
struct CoursePlanPage {
  scroller: Scroller = new Scroller()

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '课程',
        })

        Scroll(this.scroller) {
          Column() {
            HotCourse()

            Row() {
              Image($r('app.media.advancedCourse1'))
                .width(96)
                .height(54)
                .margin({ top: 19, right: 12 })
              Column() {
                Text('腰背体态改善')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                  .height(42)
                  .margin({ bottom:2 })
                Row() {
                  Text('难度：高级')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                    .margin({ right: 12 })
                  Image($r('app.media.ic_time'))
                    .width(12)
                    .height(12)
                    .margin({ right: 2 })
                  Text('2小时')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                }
                .height(16)
              }
              .alignItems(HorizontalAlign.Start)
              .width(196)
              .padding({ top: 16, bottom: 16 })
            }
            .width(304)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0011'))

            Row() {
              Image($r('app.media.advancedCourse2'))
                .width(96)
                .height(54)
                .margin({ top: 19, right: 12 })
              Column() {
                Text('哑铃练手臂“21响礼炮”')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                  .height(42)
                  .margin({ bottom:2 })
                Row() {
                  Text('难度：高级')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                    .margin({ right: 12 })
                  Image($r('app.media.ic_time'))
                    .width(12)
                    .height(12)
                    .margin({ right: 2 })
                  Text('2小时')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                }
                .height(16)
              }
              .alignItems(HorizontalAlign.Start)
              .width(196)
              .padding({ top: 16, bottom: 16 })
            }
            .width(304)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0006'))

            Row() {
              Image($r('app.media.advancedCourse3'))
                .width(96)
                .height(54)
                .margin({ top: 19, right: 12 })
              Column() {
                Text('提升核心力量')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                  .height(42)
                  .margin({ bottom:2 })
                Row() {
                  Text('难度：高级')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                    .margin({ right: 12 })
                  Image($r('app.media.ic_time'))
                    .width(12)
                    .height(12)
                    .margin({ right: 2 })
                  Text('2小时')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                }
                .height(16)
              }
              .alignItems(HorizontalAlign.Start)
              .width(196)
              .padding({ top: 16, bottom: 16 })
            }
            .width(304)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0010'))

            Row() {
              Image($r('app.media.advancedCourse4'))
                .width(96)
                .height(54)
                .margin({ top: 19, right: 12 })
              Column() {
                Text('双人健身，提高心肺')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                  .height(42)
                  .margin({ bottom:2 })
                Row() {
                  Text('难度：零基础')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                    .margin({ right: 12 })
                  Image($r('app.media.ic_time'))
                    .width(12)
                    .height(12)
                    .margin({ right: 2 })
                  Text('2小时')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                }
                .height(16)
              }
              .alignItems(HorizontalAlign.Start)
              .width(196)
              .padding({ top: 16, bottom: 16 })
            }
            .width(304)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0007'))

            Row() {
              Image($r('app.media.advancedCourse5'))
                .width(96)
                .height(54)
                .margin({ top: 19, right: 12 })
              Column() {
                Text('跳绳进阶训练')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                  .height(42)
                  .margin({ bottom:2 })
                Row() {
                  Text('难度：初级')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                    .margin({ right: 12 })
                  Image($r('app.media.ic_time'))
                    .width(12)
                    .height(12)
                    .margin({ right: 2 })
                  Text('2小时')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                }
                .height(16)
              }
              .alignItems(HorizontalAlign.Start)
              .width(196)
              .padding({ top: 16, bottom: 16 })
            }
            .width(304)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0009'))

            Row() {
              Image($r('app.media.advancedCourse6'))
                .width(96)
                .height(54)
                .margin({ top: 19, right: 12 })
              Column() {
                Text('静心打坐训练')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                  .height(42)
                  .margin({ bottom:2 })
                Row() {
                  Text('难度：零基础')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                    .margin({ right: 12 })
                  Image($r('app.media.ic_time'))
                    .width(12)
                    .height(12)
                    .margin({ right: 2 })
                  Text('2小时')
                    .fontWeight(FontWeight.Medium)
                    .fontSize($r('sys.float.Body_S'))
                    .fontColor('rgba(0, 0, 0, 0.4)')
                }
                .height(16)
              }
              .alignItems(HorizontalAlign.Start)
              .width(196)
              .padding({ top: 16, bottom: 16 })
            }
            .width(304)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0008'))
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(16)
          .padding({ left: 12, right: 12 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)
        .width('100%')
        .margin({ left: 12, right: 12 })
      }
      .height('100%')
      .backgroundColor($r('app.color.course_background'))
    }
    .hideTitleBar(true)
  }
}
