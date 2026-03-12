import { RouterMap, RouterUtils, CommonConstants } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { HotCoursePageVM } from '../viewmodels/HotCoursePageVM';

@Builder
export function HotCoursePageBuilder() {
  HotCoursePage()
}

@ComponentV2
export struct HotCourse {
  build() {
    Column() {
      Row() {
        Image($r('app.media.hotCourse1'))
          .width(96)
          .height(54)
          .margin({ top: 19, right: 12 })
        Column() {
          Text('“你真的会跑步吗？”关于跑步机的正确使用训练课程')
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
            Text('50分钟')
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
      .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0003'))

      Row() {
        Image($r('app.media.hotCourse2'))
          .width(96)
          .height(54)
          .margin({ top: 19, right: 12 })
        Column() {
          Text('居家健身的优质动作一览')
            .fontWeight(FontWeight.Medium)
            .fontSize($r('sys.float.Body_L'))
            .height(42)
            .margin({ bottom:2 })
          Row() {
            Text('难度：中级')
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_S'))
              .fontColor('rgba(0, 0, 0, 0.4)')
              .margin({ right: 12 })
            Image($r('app.media.ic_time'))
              .width(12)
              .height(12)
              .margin({ right: 2 })
            Text('1小时10分钟')
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
      .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0002'))

      Row() {
        Image($r('app.media.hotCourse3'))
          .width(96)
          .height(54)
          .margin({ top: 19, right: 12 })
        Column() {
          Text('舒缓腰部，促进血液循环')
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
      .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0005'))

      Row() {
        Image($r('app.media.hotCourse4'))
          .width(96)
          .height(54)
          .margin({ top: 19, right: 12 })
        Column() {
          Text('背部舒展，提高内脏健康活力度')
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
            Text('1小时10分钟')
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
      .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0001'))

      Row() {
        Image($r('app.media.hotCourse5'))
          .width(96)
          .height(54)
          .margin({ top: 19, right: 12 })
        Column() {
          Text('暴汗自重力量训练')
            .fontWeight(FontWeight.Medium)
            .fontSize($r('sys.float.Body_L'))
            .height(42)
            .margin({ bottom:2 })
          Row() {
            Text('难度：中级')
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
      .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0004'))
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .padding({ left: 12, right: 12 })
  }
}

@ComponentV2
struct HotCoursePage {
  vm: HotCoursePageVM = new HotCoursePageVM();

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '热门课程',
        })

        Column() {
          HotCourse()
        }
        .height('100%')
        .margin({ left: 16, right: 16 })
      }
      .width('100%')
      .backgroundColor($r('app.color.course_background'))
    }
    .hideTitleBar(true)
  }
}
