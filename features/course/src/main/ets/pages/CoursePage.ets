import { RouterMap, RouterUtils, PlanInfo, CourseDetailModel, DateUtil } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { CourseFilterDialog } from '../viewmodels/CustomDialog';
import { AdvancedCourse } from './AdvancedCoursePage';
import { HotCourse } from './HotCoursePage';

let filter: string[] = [];

@Builder
export function CoursePageBuilder() {
  CoursePage()
}

AppStorage.setOrCreate<boolean>('0001', false)
AppStorage.setOrCreate<boolean>('0002', false)
AppStorage.setOrCreate<boolean>('0003', false)
AppStorage.setOrCreate<boolean>('0004', false)
AppStorage.setOrCreate<boolean>('0005', false)
AppStorage.setOrCreate<boolean>('0006', false)
AppStorage.setOrCreate<boolean>('0007', false)
AppStorage.setOrCreate<boolean>('0008', false)
AppStorage.setOrCreate<boolean>('0009', false)
AppStorage.setOrCreate<boolean>('0010', false)
AppStorage.setOrCreate<boolean>('0011', false)

@ComponentV2
export struct CoursePage {
  @Local isShowCourseFilterDialog: boolean = false
  scroller: Scroller = new Scroller()

  async aboutToAppear() {
    AppStorage.setOrCreate<String[]>('FilterList', [])
    filter = []
  }

  @Builder
  CourseFilterDialogBuilder() {
    Column() {
      Column() {
        Scroll() {
          Column() {
            CourseFilterDialog({ filter: filter })

            Row() {
              Text('筛选课程')
                .fontColor(Color.White)
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
            }
            .justifyContent(FlexAlign.Center)
            .margin({ top: 10 })
            .padding({ left: 16, right: 16, top: 9, bottom: 9 })
            .width(328)
            .height(40)
            .borderRadius(20)
            .backgroundColor($r('app.color.app_theme'))
            .onClick(() => {
              if (filter.length === 0) {
                AppStorage.setOrCreate<String[]>('FilterList', [])
                this.isShowCourseFilterDialog = false;
              } else {
                this.isShowCourseFilterDialog = false;
                AppStorage.setOrCreate<String[]>('FilterList', filter)
                RouterUtils.pushPathByName(RouterMap.FILTER_PAGE)
              }
            })
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .height('100%')
      .padding({
        bottom: 18
      })
    }
    .padding({
      bottom: 30
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  hotCourseListBuilder() {
    Column() {
      Row() {
        Text('热门课程')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        Image($r('app.media.ic_right'))
          .opacity(0.4)
          .width(12)
          .height(24)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.HOT_COURSE_PAGE)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding({ top: 24, bottom: 8 })

    HotCourse()
  }

  @Builder
  advancedCourseListBuilder() {
    Column() {
      Row() {
        Text('进阶课程')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        Image($r('app.media.ic_right'))
          .fillColor($r('sys.color.black'))
          .width(12)
          .height(24)
          .opacity(0.4)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.ADVANCED_COURSE_PAGE);
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
    }
    .width('100%')
    .padding({ top: 24, bottom: 8 })

    AdvancedCourse()
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '课程',
          isSubTitle: false,
        })

        Row() {
          Row() {
            Image($r('app.media.ic_search'))
              .margin({ right: 6 })
              .width(16)
            Text('搜索')
              .fontSize($r('sys.float.Body_L'))
              .fontColor($r('sys.color.dialog_outer_border_color'))
              .lineHeight(21)
          }
          .backgroundColor('#0d000000')
          .borderRadius(20)
          .layoutWeight(1)
          .margin({
            right: 8
          })
          .padding({
            left: 12,
            right: 54,
            top: 7,
            bottom: 10
          })
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.COURSE_SEARCH)
          })

          Column() {
            Image($r('app.media.ic_filter'))
              .width(40)
              .height(40)
          }
          .onClick(() => {
            this.isShowCourseFilterDialog = true
          })
          .bindSheet($$this.isShowCourseFilterDialog, this.CourseFilterDialogBuilder(), {
            dragBar: false,
            showClose: true,
            preferType: SheetType.BOTTOM,
            title: { title: '筛选' },
            height: '90%',
            backgroundColor: '#fff',
            onDisappear: () => {
              this.isShowCourseFilterDialog = false;
            }
          })
        }
        .width('100%')
        .margin({
          bottom: 12
        })
        .padding({ left: 16, right: 16 })

        Scroll(this.scroller) {
          Column() {
            // 热门课程
            this.hotCourseListBuilder()

            // 进阶课程
            this.advancedCourseListBuilder()
          }
          .margin({ left: 16, right: 16 })
        }
        .margin({ bottom: 150 })
        .scrollBar(BarState.Off)
      }
      .height('100%')
      .width('100%')
      .backgroundColor($r('app.color.course_background'))
    }
  }
}
