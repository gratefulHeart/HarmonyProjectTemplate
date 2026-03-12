import { RouterMap, RouterUtils, CommonConstants } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { AdvancedCoursePageVM } from '../viewmodels/AdvancedCoursePageVM';

@Builder
export function AdvancedCoursePageBuilder() {
  AdvancedCoursePage()
}

@ComponentV2
export struct AdvancedCourse {
  build() {
    Column() {
      Row({ space: 8 }) {
        Column() {
          Image($r('app.media.advancedCourse1'))
            .width('100%')
            .height(90)
            .borderRadius({ topLeft: 8, topRight: 8 })
          Column() {
            Text('腰背体态改善')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_M'))
              .margin({ bottom: 8 })
            Text('难度：高级')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_S'))
              .fontColor('rgba(0, 0, 0, 0.4)')
            Row() {
              Image($r('app.media.ic_time'))
                .width(12)
                .height(12)
                .margin({ right: 9 })
              Text('2小时')
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
          }
          .alignItems(HorizontalAlign.Start)
          .padding({
            left: 8,
            right: 8,
            top: 8,
            bottom: 8
          })
        }
        .alignItems(HorizontalAlign.Start)
        .width('50%')
        .height(166)
        .backgroundColor($r('sys.color.white'))
        .borderRadius(8)
        .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0011'))

        Column() {
          Image($r('app.media.advancedCourse2'))
            .width('100%')
            .height(90)
            .backgroundColor($r('sys.color.comp_background_tertiary'))
            .borderRadius({ topLeft: 8, topRight: 8 })
          Column() {
            Text('哑铃练手臂“21响礼炮”')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_M'))
              .margin({ bottom: 8 })
            Text('难度：高级')
              .fontColor('rgba(0, 0, 0, 0.4)')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_S'))
            Row() {
              Image($r('app.media.ic_time'))
                .width(12)
                .height(12)
                .margin({ right: 9 })
              Text('2小时')
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
          }
          .padding({
            left: 8,
            right: 8,
            top: 8,
            bottom: 8
          })
          .alignItems(HorizontalAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)
        .width('50%')
        .height(166)
        .backgroundColor($r('sys.color.white'))
        .borderRadius(8)
        .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0006'))
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Row({ space: 8 }) {
        Column() {
          Image($r('app.media.advancedCourse3'))
            .width('100%')
            .height(90)
            .backgroundColor($r('sys.color.comp_background_tertiary'))
            .borderRadius({ topLeft: 8, topRight: 8 })
          Column() {
            Text('提升核心力量')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_M'))
              .margin({ bottom: 8 })
            Text('难度：高级')
              .fontColor('rgba(0, 0, 0, 0.4)')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_S'))
            Row() {
              Image($r('app.media.ic_time'))
                .width(12)
                .height(12)
                .margin({ right: 9 })
              Text('2小时')
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
          }
          .alignItems(HorizontalAlign.Start)
          .padding({
            left: 8,
            right: 8,
            top: 8,
            bottom: 8
          })
        }
        .alignItems(HorizontalAlign.Start)
        .width('50%')
        .height(166)
        .backgroundColor($r('sys.color.white'))
        .borderRadius(8)
        .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0010'))

        Column() {
          Image($r('app.media.advancedCourse4'))
            .width('100%')
            .height(90)
            .backgroundColor($r('sys.color.comp_background_tertiary'))
            .borderRadius({ topLeft: 8, topRight: 8 })
          Column() {
            Text('双人健身，提高心肺')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_M'))
              .margin({ bottom: 8 })
            Text('难度：零基础')
              .fontColor('rgba(0, 0, 0, 0.4)')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_S'))
            Row() {
              Image($r('app.media.ic_time'))
                .width(12)
                .height(12)
                .margin({ right: 9 })
              Text('2小时')
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
          }
          .alignItems(HorizontalAlign.Start)
          .padding({
            left: 8,
            right: 8,
            top: 8,
            bottom: 8
          })
        }
        .alignItems(HorizontalAlign.Start)
        .width('50%')
        .height(166)
        .backgroundColor($r('sys.color.white'))
        .borderRadius(8)
        .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0007'))
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom:8, top:8 })

      Row({ space: 8 }) {
        Column() {
          Image($r('app.media.advancedCourse5'))
            .width('100%')
            .height(90)
            .backgroundColor($r('sys.color.comp_background_tertiary'))
            .borderRadius({ topLeft: 8, topRight: 8 })
          Column() {
            Text('跳绳进阶训练')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_M'))
              .margin({ bottom: 8 })
            Text('难度：初级')
              .fontColor('rgba(0, 0, 0, 0.4)')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_S'))
            Row() {
              Image($r('app.media.ic_time'))
                .width(12)
                .height(12)
                .margin({ right: 9 })
              Text('2小时')
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
          }
          .alignItems(HorizontalAlign.Start)
          .padding({
            left: 8,
            right: 8,
            top: 8,
            bottom: 8
          })
        }
        .alignItems(HorizontalAlign.Start)
        .width('50%')
        .height(166)
        .backgroundColor($r('sys.color.white'))
        .borderRadius(8)
        .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0009'))

        Column() {
          Image($r('app.media.advancedCourse6'))
            .width('100%')
            .height(90)
            .backgroundColor($r('sys.color.comp_background_tertiary'))
            .borderRadius({ topLeft: 8, topRight: 8 })
          Column() {
            Text('静心打坐训练')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_M'))
              .margin({ bottom: 8 })
            Text('难度：零基础')
              .fontColor('rgba(0, 0, 0, 0.4)')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_S'))
            Row() {
              Image($r('app.media.ic_time'))
                .width(12)
                .height(12)
                .margin({ right: 9 })
              Text('2小时')
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
          }
          .alignItems(HorizontalAlign.Start)
          .padding({
            left: 8,
            right: 8,
            top: 8,
            bottom: 8
          })
        }
        .alignItems(HorizontalAlign.Start)
        .width('50%')
        .height(166)
        .backgroundColor($r('sys.color.white'))
        .borderRadius(8)
        .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0008'))
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
  }
}

@ComponentV2
struct AdvancedCoursePage {
  vm: AdvancedCoursePageVM = new AdvancedCoursePageVM();

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '进阶课程',
        })

        Column() {
          AdvancedCourse()
        }
        .margin({ left: 16, right: 16 })
      }
      .height('100%')
      .width('100%')
      .backgroundColor($r('app.color.course_background'))
    }
    .hideTitleBar(true)
  }
}
