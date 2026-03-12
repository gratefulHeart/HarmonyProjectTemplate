import { HotCourse } from 'course';
import { RouterMap, RouterUtils, DateUtil, CommonConstants, Course1, COURSE_DATA1,
  COURSE_CONTENT, CourseContent} from 'lib_common';
import { NavHeaderBar } from 'lib_widget';

class Plan {
  coursePlan: Course1[] = []
}

@Builder
export function PlanPageBuilder() {
  PlanPage()
}

@Component
export struct PlanPage {
  scroller: Scroller = new Scroller()
  private weekNameList: string[] = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
  @State dateList: Date[] = [];
  @State dateSelectIndex: number = 0;
  @State planList: string[] = [];
  @State coursePlan: Course1[] = []
  @State courseContent: CourseContent[] = []
  @State loss: number = 0
  @State target: number = 0
  @State days: number = 0
  @State energy: number = 0
  private listScroller: ListScroller = new ListScroller();
  private month: number = new Date().getMonth();

  aboutToAppear() {
    this.dateList = this.buildDateList();
    getContext().eventHub.on('calculateData', (courseList: string[][]) => {
      this.days = 0
      this.energy = 0
      this.calculateData(courseList)
    })
    this.coursePlan = this.buildPlanList();
    this.calculateData([])
  }

  onPageShow(): void {
    this.dateSelectIndex = 0
  }

  aboutToDisappear(): void {
    getContext().eventHub.off('calculateData')
  }

  calculateData(coursePlan: string[][]) {
    this.getPlanList(this.dateList[this.dateSelectIndex].getDate())
    this.dateList.forEach((date: Date, index) => {
      let courseList: string[] = (coursePlan[index] ?? []) as string[]
      if (courseList.length !== 0) {
        this.days++
      }
      courseList.forEach((courseId: string) => {
        let index: number = Number(courseId) - 1
        this.energy += Number(COURSE_CONTENT[index].energy)
      })
    })
    this.loss = Number((this.energy / 7700).toFixed(2))
    this.target = Number(AppStorage.get('userWeight')) - this.loss
  }

  private buildPlanList(): Course1[] {
    let coursePlan: Course1[] = []
    let courseContent: CourseContent[] = []
    this.planList.forEach((courseId: string) => {
      let index: number = Number(courseId) - 1
      coursePlan.push(COURSE_DATA1[index])
      courseContent.push(COURSE_CONTENT[index])
    })
    this.courseContent = courseContent
    return coursePlan
  }

  private buildDateList(): Date[] {
    let dateSelectList: Date[] = [];
    const today = new Date();
    // 获取当前星期几 (0 = 周日, 1 = 周一, ..., 6 = 周六)
    const dayOfWeek = today.getDay();
    // 计算距离本周一的天数差
    // 如果是周日(0), 需要回退6天; 如果是周一(1), 不需要回退; 其他情况回退(dayOfWeek - 1)天
    const daysToMonday = dayOfWeek === 0 ? 6 : dayOfWeek - 1;
    // 创建本周一的日期对象
    const monday = new Date(today);
    monday.setDate(today.getDate() - daysToMonday);
    // 从周一开始生成连续7天的日期
    for (let i = 0; i < 7; i++) {
      const nextDate = new Date(monday);
      nextDate.setDate(monday.getDate() + i);
      dateSelectList.push(nextDate);
    }
    return dateSelectList;
  }

  getPlanList(date: number) {
    this.planList = (AppStorage.get(String(date)) ?? []) as string[]
    this.coursePlan = this.buildPlanList()
  }

  @Builder
  planBuilder() {
    // 日期选择
    Column() {
      Row() {
        Column() {
          Text((this.month + 1 < 10 ? '0' + (this.month + 1) : this.month + 1 + ''))
            .fontSize($r('sys.float.Body_M'))
            .width(17)
            .height(19)
            .margin({ bottom: 2 })

          Text('月')
            .fontSize(10)
            .width(10)
            .height(14)
        }
        .padding(4)
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .margin({ right: 8 })
        .borderRadius(12)
        .height(43)
        .width(24)

        List({ space: 8, scroller: this.listScroller }) {
          ForEach(this.dateList, (item: Date, index: number) => {
            ListItem() {
              Column() {
                Text(this.weekNameList[item.getDay()])
                  .fontSize($r('sys.float.Body_M'))
                  .fontColor(index === this.dateSelectIndex ? '#FFFFFF' :
                    '#333333')
                Text((item.getMonth() + 1 < 10 ? '0' + (item.getMonth() + 1) :
                  item.getMonth() + 1 + '') + '.' +
                  (item.getDate() < 10 ? '0' + item.getDate() : item.getDate() + ''))
                  .fontSize(10)
                  .fontColor(index === this.dateSelectIndex ? '#FFFFFF' :
                    '#333333')
              }
              .backgroundColor(index === this.dateSelectIndex ? $r('app.color.app_theme') :
                '#FFFFFF')
              .height(43)
              .width(36)
              .padding(4)
              .justifyContent(FlexAlign.SpaceAround)
              .borderRadius(8)
              .onClick(() => {
                this.dateSelectIndex = index;
                this.getPlanList(item.getDate())
              })
            }
          }, (item: Date) => DateUtil.formatDate(item))
        }
        .listDirection(Axis.Horizontal)
        .alignListItem(ListItemAlign.Center)
        .scrollBar(BarState.Off)
        .width(300)
        .height(43)
      }
      .width(CommonConstants.FULL_PERCENT)
      .padding({ left: 16, top: 12, right: 16, bottom: 12 })
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(67)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ top: 8, bottom: 12 })
  }

  @Builder
  courseBuilder(plan: Plan) {
    Column() {
      ForEach(plan.coursePlan, (course: Course1, index: number) => {
        Row() {
          Image(course.cover)
            .width(96)
            .height(54)
            .margin({ top: 19, right: 12 })
          Column() {
            Row() {
              Image(this.dateList[this.dateSelectIndex].getDate() === new Date().getDate() &&
              AppStorage.get(course.label) ? $r('app.media.ic_finish') : $r('app.media.ic_unfinish'))
                .margin({ right: 2 })
                .width(12)
                .height(12)
              Text(this.dateList[this.dateSelectIndex].getDate() === new Date().getDate() &&
              AppStorage.get(course.label) ? '课程已完成' : '课程未完成')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
                .fontColor('rgba(0, 0, 0, 0.4)')
            }
            .width(196)
            .justifyContent(FlexAlign.End)
            Text(course.courseTitle)
              .fontSize($r('sys.float.Body_L'))
              .margin({ bottom:2 })
              .fontWeight(FontWeight.Medium)
            Row() {
              Text(`难度：${this.courseContent[index].difficulty}`)
                .fontSize($r('sys.float.Body_S'))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .margin({ right: 12 })
                .fontWeight(FontWeight.Medium)
              Image($r('app.media.ic_time'))
                .margin({ right: 2 })
                .width(12)
                .height(12)
              Text(`${this.courseContent[index].duration}分钟`)
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
                .fontColor('rgba(0, 0, 0, 0.4)')
            }
            Text(`预计消耗热量：${this.courseContent[index].energy}kcal`)
              .fontSize($r('sys.float.Body_S'))
              .fontColor('rgba(0, 0, 0, 0.4)')
              .margin({ right: 12 })
              .fontWeight(FontWeight.Medium)
          }
          .width(196)
          .padding({ top: 16, bottom: 16 })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, course.id))
      })

      if (this.dateList[this.dateSelectIndex].getDate() < new Date().getDate() &&
        this.dateList[this.dateSelectIndex].getMonth() === new Date().getMonth()) {
        Row() {
          Image($r('app.media.addplan'))
            .margin({ top: 4, bottom: 4 })
            .width(16)
            .height(16)
          Text('添加计划')
            .width(64)
            .height(21)
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Regular)
            .fontColor('rgba(0, 0, 0, 0.4)')
            .margin({ top: 1.5, bottom: 1.5 })
        }
        .width(216)
        .height(40)
        .padding({ top: 8, left: 24, right: 24, bottom: 8 })
        .borderRadius(24)
        .backgroundColor($r('app.color.app_theme'))
        .justifyContent(FlexAlign.Center)
      } else {
        Row() {
          Image($r('app.media.addplan'))
            .margin({ top: 4, bottom: 4 })
            .width(16)
            .height(16)
          Text('添加计划')
            .width(64)
            .height(21)
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Regular)
            .fontColor(Color.White)
            .margin({ top: 1.5, bottom: 1.5 })
        }
        .width(216)
        .height(40)
        .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_PAGE_PLAN))
        .padding({ top: 8, left: 24, right: 24, bottom: 8 })
        .borderRadius(24)
        .backgroundColor($r('app.color.app_theme'))
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('90%')
    .padding(12)
    .borderRadius(16)
    .backgroundColor(Color.White)
  }

  @Builder
  noCoursebuild() {
    Column() {
      Image($r('app.media.noplan'))
        .width(120)
        .height(120)

      Text('暂无计划，赶快去添加吧~')
        .fontSize($r('sys.float.Body_M'))
        .fontWeight(FontWeight.Regular)
        .fontColor('rgba(0, 0, 0, 0.6)')
        .margin({ top: 8, bottom: 8 })

      if (this.dateList[this.dateSelectIndex].getDate() < new Date().getDate()) {
        Row() {
          Image($r('app.media.addplan'))
            .width(16)
            .height(16)
            .margin({ top: 4, bottom: 4 })
          Text('添加计划')
            .width(64)
            .height(21)
            .fontColor('rgba(0, 0, 0, 0.4)')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Regular)
            .margin({ top: 1.5, bottom: 1.5 })
        }
        .width(216)
        .height(40)
        .borderRadius(24)
        .justifyContent(FlexAlign.Center)
        .backgroundColor($r('app.color.app_theme'))
        .padding({ top: 8, left: 24, right: 24, bottom: 8 })
      } else {
        Row() {
          Image($r('app.media.addplan'))
            .width(16)
            .height(16)
            .margin({ top: 4, bottom: 4 })
          Text('添加计划')
            .fontSize($r('sys.float.Body_L'))
            .width(64)
            .height(21)
            .fontWeight(FontWeight.Regular)
            .fontColor(Color.White)
            .margin({ top: 1.5, bottom: 1.5 })
        }
        .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_PAGE_PLAN))
        .justifyContent(FlexAlign.Center)
        .backgroundColor($r('app.color.app_theme'))
        .padding({ top: 8, left: 24, right: 24, bottom: 8 })
        .width(216)
        .height(40)
        .borderRadius(24)
      }
    }
    .backgroundColor(Color.White)
    .borderRadius(16)
    .padding(12)
    .width('90%')
    .height(219)
  }

  @Builder
  async purposeBuild() {
    Column() {
      Row() {
        Image($r('app.media.purpose'))
          .width(16)
          .height(16)
          .margin({ top: 2.5, bottom: 2.5, right: 8 })
        Text('本周目标')
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Regular)
          .fontColor('rgba(0, 0, 0, 0.9)')
      }
      .width(88)
      .height(21)
      .margin({ bottom: 12 })

      Row({space: 8}) {
        Column() {
          Row() {
            Text(String(this.loss))
              .fontSize(18)
            Text('（kg）')
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
              .fontColor('#999999')
          }
          .height(24)
          .margin({ bottom: 8 })

          Text('预计减重')
            .fontSize($r('sys.float.Body_S'))
            .fontWeight(FontWeight.Regular)
            .fontColor('#999999')
        }
        .justifyContent(FlexAlign.Center)
        .width(76)
        .height(48)

        Column() {
          Row() {
            Text(this.target > 0 ? String(this.target) : '---')
              .fontSize(18)
            Text('（kg）')
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
              .fontColor('#999999')
          }
          .height(24)
          .margin({ bottom: 8 })

          Text('目标体重')
            .fontSize($r('sys.float.Body_S'))
            .fontWeight(FontWeight.Regular)
            .fontColor('#999999')
        }
        .justifyContent(FlexAlign.Center)
        .width(76)
        .height(48)

        Column() {
          Row() {
            Text(String(this.days))
              .fontSize(18)
          }
          .height(24)
          .margin({ bottom: 8 })

          Text('训练天数')
            .fontSize($r('sys.float.Body_S'))
            .fontWeight(FontWeight.Regular)
            .fontColor('#999999')
        }
        .justifyContent(FlexAlign.Center)
        .width(76)
        .height(48)

        Column() {
          Row() {
            Text(String(this.energy))
              .fontSize(18)
            Text('（kcal）')
              .fontSize($r('sys.float.Body_S'))
              .fontWeight(FontWeight.Regular)
              .fontColor('#999999')
          }
          .height(24)
          .margin({ bottom: 8 })

          Text('消耗热量')
            .fontSize($r('sys.float.Body_S'))
            .fontWeight(FontWeight.Regular)
            .fontColor('#999999')
        }
        .justifyContent(FlexAlign.Center)
        .width(76)
        .height(48)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
    .padding(12)
    .margin({ top: 12 })
    .borderRadius(16)
    .width('90%')
    .height(105)
  }

  @Builder
  recommendCourseListBuilder() {
    Column() {
      Row() {
        Text('推荐课程')
          .fontWeight(FontWeight.Medium)
          .fontSize(18)
        Image($r('app.media.ic_right'))
          .width(12)
          .height(24)
          .opacity(0.4)
          .onClick(() => {
            RouterUtils.pushPathByName(RouterMap.RECOMMENDATION_COURSE_PAGE)
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
    }
    .width('90%')
    .padding({ top: 24, bottom: 8 })

    Column() {
      HotCourse()
    }
    .margin({ left: 16, right: 16 })
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '计划',
          isSubTitle: false,
        })

        Scroll(this.scroller) {
          Column() {
            // 日期
            this.planBuilder()
            // 计划
            if (this.coursePlan) {
              this.courseBuilder({ coursePlan: this.coursePlan })
            } else {
              this.noCoursebuild()
            }
            // 本周目标
            this.purposeBuild()
            // 推荐课程
            this.recommendCourseListBuilder()
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)
        .width('100%')
      }
      .height('100%')
      .width('100%')
      .backgroundColor($r('app.color.plan_background'))
    }
    .onShown(() => {
      this.dateSelectIndex = 0
    })
    .onWillShow(() => {
      this.dateSelectIndex = 0
    })
  }
}

