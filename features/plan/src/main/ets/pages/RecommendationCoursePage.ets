import { RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { CourseFilterDialog, HotCourse } from 'course'
import { PlanPageVM } from '../viewmodels/PlanPageVM';

@Builder
export function RecommendationCoursePageBuilder() {
  RecommendationCoursePage()
}

let filter: string[] = [];

@ComponentV2
struct RecommendationCoursePage {
  vm: PlanPageVM = new PlanPageVM();
  @Local isShowCourseFilterDialog: boolean = false

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
            .margin({ top: 10 })
            .padding({ left: 16, right: 16, top: 9, bottom: 9 })
            .width(328)
            .height(40)
            .borderRadius(20)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              if (filter.length === 0) {
                this.isShowCourseFilterDialog = false;
              } else {
                this.isShowCourseFilterDialog = false;
                RouterUtils.pushPathByName(RouterMap.FILTER_PAGE)
              }
            })
            .backgroundColor($r('app.color.app_theme'))
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .padding({
        bottom: 18
      })
      .height('100%')
    }
    .padding({
      bottom: 30
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '推荐课程',
        })

        Column() {
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
            .margin({
              right: 8
            })
            .onClick(() => {
              RouterUtils.pushPathByName(RouterMap.COURSE_SEARCH)
            })

            Column() {
              Image($r('app.media.ic_filter'))
                .width(40)
            }
            .backgroundColor('#0d000000')
            .borderRadius('50%')
            .onClick(() => {
              this.isShowCourseFilterDialog = true
            })
            .bindSheet($$this.isShowCourseFilterDialog, this.CourseFilterDialogBuilder(), {
              height: '90%',
              dragBar: false,
              showClose: true,
              preferType: SheetType.BOTTOM,
              title: { title: '筛选' },
              backgroundColor: '#fff',
              onDisappear: () => {
                this.isShowCourseFilterDialog = false;
              }
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
          .margin({
            bottom: 12
          })
        }

        Column() {
          HotCourse()
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
