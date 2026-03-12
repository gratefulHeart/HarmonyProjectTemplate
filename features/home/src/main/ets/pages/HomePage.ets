import { RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { AdvancedCourse, HotCourse } from 'course'

@Builder
export function HomePageBuilder() {
  HomePage()
}

interface SwiperItem {
  img: Resource;  // 图片资源（如 $r('app.media.bg')）
  text: string;   // 文字内容
  url: RouterMap;
  id: string;
}

@ComponentV2
export struct HomePage {
  scroller: Scroller = new Scroller()
  homeSwiperImageList: SwiperItem[] = [{ img: $r('app.media.swiperImage1'), text: '“你真的会跑步吗？”关于跑步机的正确使用训练课程', url: RouterMap.COURSE_DETAIL_PAGE, id: '0003' },
    { img: $r('app.media.swiperImage2'), text: '居家健身的优质动作一览', url: RouterMap.COURSE_DETAIL_PAGE, id: '0002' },
    { img: $r('app.media.swiperImage3'), text: '舒缓腰部，促进血液循环', url: RouterMap.COURSE_DETAIL_PAGE, id: '0005' },
    { img: $r('app.media.swiperImage4'), text: '背部舒展，提高内脏健康活力度', url: RouterMap.COURSE_DETAIL_PAGE, id: '0001' },
    { img: $r('app.media.swiperImage5'), text: '暴汗自重力量训练', url: RouterMap.COURSE_DETAIL_PAGE, id: '0004' }];

  @Builder
  homeAdvBuilder() {
    Swiper() {
      ForEach(this.homeSwiperImageList, (item: SwiperItem) => {
        Stack() {
          Image(item.img)
            .width('100%')
            .height('100%')
          Column() {
            Text(item.text)  // 主标题
              .fontSize($r('sys.float.Body_L'))
              .width(196)
              .position({ left: 106, top: 101 })
              .fontColor(Color.White)
          }
        }
        .onClick(() => RouterUtils.pushPathByName(item.url, item.id))
      })
    }
    .indicator(new DotIndicator()
      .selectedColor($r('app.color.app_theme')))
    .loop(true)
    .autoPlay(true)
    .height(184)
    .width('100%')
    .borderRadius(16)
    .curve(Curve.Smooth)
  }

  @Builder
  commonKnowledgeListBuilder() {
    Column() {
      Row() {
        Text('运动健身常识普及')
          .fontWeight(FontWeight.Medium)
          .fontSize(18)
        Image($r('app.media.ic_right'))
          .width(12)
          .height(24)
          .fillColor($r('sys.color.black'))
          .opacity(0.4)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE);
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding({ top: 24, bottom: 8 })

    Row({ space: 8 }) {
      Column() {
        Image($r('app.media.common_knowledge1'))
          .width(144)
          .height(144)
          .padding({ top: 8 })
        Text('普通瑜伽与普拉提的区别其实并不大')
          .fontWeight(FontWeight.Medium)
          .fontSize($r('sys.float.Body_S'))
          .padding({ top: 8, left:8, right: 8 })
      }
      .backgroundColor($r('sys.color.white'))
      .borderRadius(16)
      .width(160)
      .height(200)
      .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_YOGA))

      Column() {
        Image($r('app.media.common_knowledge4'))
          .width(144)
          .height(144)
          .padding({ top: 8 })
        Text('你知道如何在跑后有效拉伸吗？')
          .fontWeight(FontWeight.Medium)
          .fontSize($r('sys.float.Body_S'))
          .padding({ top: 8, left:8, right: 8 })
      }
      .width(160)
      .height(200)
      .backgroundColor($r('sys.color.white'))
      .borderRadius(16)
      .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DRAW))
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  hotCourseListBuilder() {
    Column() {
      Row() {
        Text('热门课程')
          .fontWeight(FontWeight.Medium)
          .fontSize(18)
        Image($r('app.media.ic_right'))
          .width(12)
          .height(24)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.HOT_COURSE_PAGE);
          })
          .opacity(0.4)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
    }
    .padding({ top: 24, bottom: 8 })
    .width('100%')

    HotCourse()
  }

  @Builder
  advancedCourseListBuilder() {
    Column() {
      Row() {
        Text('进阶课程')
          .fontWeight(FontWeight.Medium)
          .fontSize(18)
        Image($r('app.media.ic_right'))
          .fillColor($r('sys.color.black'))
          .width(12)
          .height(24)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.ADVANCED_COURSE_PAGE);
          })
          .opacity(0.4)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .padding({ top: 24, bottom: 8 })
    .width('100%')

    AdvancedCourse()
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '首页',
          isSubTitle: false,
        })

        Scroll(this.scroller) {
          Column() {
            // 轮播图
            this.homeAdvBuilder()

            // 运动健身常识普及
            this.commonKnowledgeListBuilder()

            // 热门课程
            this.hotCourseListBuilder()

            // 进阶课程
            this.advancedCourseListBuilder()
          }
          .margin({ left: 16, right: 16 })
        }
        .edgeEffect(EdgeEffect.Spring)
        .margin({ bottom: 100 })
        .scrollBar(BarState.Off)
      }
      .height('100%')
      .width('100%')
      .backgroundColor($r('app.color.home_background'))
    }
  }
}