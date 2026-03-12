import { SearchPage } from 'module_search';
import { RouterMap, RouterUtils, UserInfo } from 'lib_common'
import { Course, COURSE_DATA } from 'lib_common';
import { MyScrollModifier } from 'lib_common';
import { AppStorageV2 } from '@kit.ArkUI';
import { NavHeaderBar } from 'lib_widget';

@ComponentV2
export struct CourseSearch {
  // 模拟后端数据源
  @Local searchSourceData: string[] = []
  @Local scrollModifier: MyScrollModifier = new MyScrollModifier()
  @Local searchCourse: Course[] = []
  @Local loginUser: UserInfo = AppStorageV2.connect(UserInfo, () => new UserInfo())!

  aboutToAppear(): void {
    // 搜索数据源数据
    this.searchCourse = COURSE_DATA
    this.searchSourceData = this.searchCourse.map((item: Course) => {
      return item.courseTitle;
    })
  }

  @Builder
  hotSearchItem() {
    // 热门搜索
    Column() {
      Row() {
        Text('热门搜索')
          .fontSize(18)
          .lineHeight(24)
          .fontColor('#111111')
          .fontWeight(700)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({
        bottom: 12
      })

      Row({ space: 8 }) {
        Text('马甲线')
          .width(58)
          .height(28)
          .fontSize($r('sys.float.Body_M'))
          .textAlign(TextAlign.Center)
          .fontColor('rgba(0, 0, 0, 0.9)')
          .backgroundColor('rgba(0, 0, 0, 0.05)')
          .borderRadius(14)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0010');
          })
        Text('crossfit')
          .width(76)
          .height(28)
          .fontSize($r('sys.float.Body_M'))
          .textAlign(TextAlign.Center)
          .fontColor('rgba(0, 0, 0, 0.9)')
          .backgroundColor('rgba(0, 0, 0, 0.05)')
          .borderRadius(14)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_ACTIVATE);
          })
        Text('背阔肌')
          .width(76)
          .height(28)
          .fontSize($r('sys.float.Body_M'))
          .textAlign(TextAlign.Center)
          .fontColor('rgba(0, 0, 0, 0.9)')
          .backgroundColor('rgba(0, 0, 0, 0.05)')
          .borderRadius(14)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0001');
          })
        Text('如何拉伸')
          .width(72)
          .height(28)
          .fontSize($r('sys.float.Body_M'))
          .textAlign(TextAlign.Center)
          .fontColor('rgba(0, 0, 0, 0.9)')
          .backgroundColor('rgba(0, 0, 0, 0.05)')
          .borderRadius(14)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DRAW);
          })
      }
      .width('100%')

      Row({ space: 8 }) {
        Text('提高握力的方法')
          .width(114)
          .height(28)
          .fontSize($r('sys.float.Body_M'))
          .textAlign(TextAlign.Center)
          .fontColor('rgba(0, 0, 0, 0.9)')
          .backgroundColor('rgba(0, 0, 0, 0.05)')
          .borderRadius(14)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0004');
          })
        Text('腰肌劳损')
          .width(76)
          .height(28)
          .fontSize($r('sys.float.Body_M'))
          .textAlign(TextAlign.Center)
          .fontColor('rgba(0, 0, 0, 0.9)')
          .backgroundColor('rgba(0, 0, 0, 0.05)')
          .borderRadius(14)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_STRAIN);
          })
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .margin({ top: 28, bottom: 12 })
  }

  @Builder
  recommendCourseBuilder() {
    // 推荐课程
    Column() {
      Row() {
        Image($r('app.media.ic_hot'))
          .width(24)
          .height(24)
        Text('推荐课程')
          .fontSize(18)
          .lineHeight(24)
          .fontColor('#111111')
          .fontWeight(700)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({
        top: 12,
        bottom: 12
      })

      Row() {
        Text('1. ')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor($r('sys.color.warning'))
        Text('“你真的会跑步吗？”关于跑步机的正确使用训练...')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor('#111111')
      }
      .onClick(() => {
        RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0003');
      })
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({
        bottom: 12
      })

      Row() {
        Text('2. ')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor($r('sys.color.warning'))
        Text('一对哑铃练遍全身')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor('#111111')
      }
      .onClick(() => {
        RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0006');
      })
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({
        bottom: 12
      })

      Row() {
        Text('3. ')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor($r('sys.color.warning'))
        Text('舒缓腰部，促进血液循环')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor('#111111')
      }
      .onClick(() => {
        RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0005');
      })
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({
        bottom: 12
      })

      Row() {
        Text('4. ')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor('rgba(0, 0, 0, 0.6)')
        Text('暴汗自重力量训练')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor('#111111')
      }
      .onClick(() => {
        RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0004');
      })
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({
        bottom: 12
      })

      Row() {
        Text('5. ')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor('rgba(0, 0, 0, 0.6)')
        Text('提升核心力量')
          .fontSize($r('sys.float.Body_M'))
          .lineHeight(24)
          .fontColor('#111111')
      }
      .onClick(() => {
        RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0010');
      })
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({
        bottom: 12
      })
    }
  }

  build() {
    NavDestination() {
      Column() {
        SearchPage({
          searchSourceData: this.searchSourceData,
          clickSearchResult: (searchData) => {
            let item = this.searchCourse.find(course => course.courseTitle === searchData)
            switch (item?.courseTitle) {
              case '腿部训练前的热身和激活动作，不可忽视':
                RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_ACTIVATE);
                break;
              case '你知道如何在跑后有效拉伸吗？':
                RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DRAW);
                break;
              case '运动装备的重要性，你知道哪些？':
                RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_EQUIP);
                break;
              case '运动完腰椎损伤是什么造成的？':
                RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_STRAIN);
                break;
              case '合理且适当的热身，让你的运动表现更好':
                RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_WARM);
                break;
              case '普通瑜伽与普拉提的区别其实并不大':
                RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_YOGA);
                break;
              case '背部舒展，提高内脏健康活力度':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0001');
                break;
              case '居家健身的优质动作一览':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0002');
                break;
              case '”你真的会跑步吗？“关于跑步机的正确使用训练课程':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0003');
                break;
              case '暴汗自重力量训练':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0004');
                break;
              case '舒缓腰部，促进血液循环':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0005');
                break;
              case '哑铃练手臂“21响礼炮”':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0006');
                break;
              case '双人健身，提高心肺':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0007');
                break;
              case '静心打坐训练':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0008');
                break;
              case '跳绳进阶训练':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0009');
                break;
              case '提升核心力量':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0010');
                break;
              case '腰背体态改善':
                RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, '0011');
                break;
            }
          },
          back: () => {
            RouterUtils.pop()
          },
        })

        this.hotSearchItem()

        this.recommendCourseBuilder()
      }
      .width('100%')
      .padding({ left: $r('app.float.vp_16'), right: $r('app.float.vp_16') , top: $r('app.float.vp_40') })
      .backgroundColor($r('sys.color.background_primary'))
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .hideTitleBar(true)
  }
}

@Builder
export function CourseSearchBuilder() {
  CourseSearch();
}