import { Course1, CourseContent, COURSE_CONTENT, COURSE_DATA1, RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { CoursePageVM } from '../viewmodels/CoursePageVM';
import { addDialog, addPlanDialog, cancelDialog, DateDialog, explain,
  explainVIP, PlanDialog } from '../viewmodels/CustomDialog';
import { emitter } from '@kit.BasicServicesKit';
import { calendarManager } from '@kit.CalendarKit';
import { abilityAccessCtrl, common, PermissionRequestResult, Permissions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';

@Builder
export function CourseDetailPageBuilder() {
  CourseDetailPage()
}

@ComponentV2
struct CourseDetailPage {
  @Local courseId: string = '';
  vm: CoursePageVM = new CoursePageVM();
  scroller: Scroller = new Scroller()
  @Local isShowAddPlanDialog: boolean = false;
  @Local isShowAddDateDialog: boolean = false;
  @Local isShowExplain: boolean[] = [];
  @Local isShowExplain1: boolean = false;
  @Local isShowExplain2: boolean = false;
  @Local isShowExplain3: boolean = false;
  @Local isShowExplain4: boolean = false;
  @Local isShowExplain5: boolean = false;
  @Local sheetHeight: number = 470;
  @Local clickedStates: boolean[] = [false, false, false, false, false, false, false]
  @Local label: string = '';
  @Local planList: number[] = [];
  @Local courseDateList: string[] = [];
  @Local dateList: string[] = [];
  @Local course: Course1 = COURSE_DATA1[0]
  @Local courseContent: CourseContent = COURSE_CONTENT[0]
  @Local isStar: boolean = AppStorage.get(this.courseId) as boolean
  @Local calendar: calendarManager.Calendar | undefined = undefined;
  @Local calendarMgr: calendarManager.CalendarManager | null = null;
  @Local titleList: string[] = []

  buildDateList(): string[] {
    let planDateList: string[] = [];
    const today = new Date();
    const dayOfWeek = today.getDay();
    const daysToMonday = dayOfWeek === 0 ? 6 : dayOfWeek - 1;
    const monday = new Date(today);
    monday.setDate(today.getDate() - daysToMonday);
    for (let i = 0; i < 7; i++) {
      const nextDate = new Date(monday);
      nextDate.setDate(monday.getDate() + i);
      planDateList.push(String(nextDate.getDate()));
    }
    return planDateList;
  }

  aboutToAppear() {
    this.isStar = AppStorage.get(this.courseId) as boolean
    this.titleList = this.courseContent.contentCategory
    this.vm.addHistory(this.label)
    this.courseDateList = this.buildDateList()

    // 3.创建日历账户
    this.calendarMgr?.createCalendar(this.calendarAccount).then((data: calendarManager.Calendar) => {
      console.info(`Succeeded in creating calendar data->${JSON.stringify(data)}`);
      this.calendar = data;
      // 设置日历配置信息
      this.calendar.setConfig(this.calendarConfig).then(() => {
        console.info(`Succeeded in setting config, data->${JSON.stringify(this.calendarConfig)}`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to set config. Code: ${err.code}, message: ${err.message}`);
      });
    }).catch((error: BusinessError) => {
      console.error(`Failed to create calendar. Code: ${error.code}, message: ${error.message}`);
    });
  }

  // 1.配置日历账户信息
  private calendarAccount: calendarManager.CalendarAccount = {
    // 日历账户名称（面向开发者）
    name: '运动健康',
    // 日历账户类型（LOCAL，本地账号；EMAIL，邮箱账号；BIRTHDAY，生日账号；BIRTHDAY，支持CalDAV协议账户；SUBSCRIBED，订阅账户）
    type: calendarManager.CalendarType.LOCAL,
    // 日历账户显示名称，该字段如果不填，创建的日历账户在界面显示为空字符串。
    displayName: '运动健康'
  };

  // 2.配置日历配置信息
  private calendarConfig: calendarManager.CalendarConfig = {
    // 是否打开Calendar下所有Event提醒能力
    enableReminder: true,
    // 设置日历账户颜色
    color: '#aabbcc'
  };

  public getCalendarPermission(): Promise<string> {
    let context = getContext(this) as common.UIAbilityContext;

    const permissions: Permissions[] = ['ohos.permission.READ_CALENDAR', 'ohos.permission.WRITE_CALENDAR'];
    let atManager = abilityAccessCtrl.createAtManager();
    return new Promise((resolve, reject) => {
      atManager.requestPermissionsFromUser(context, permissions).then((result: PermissionRequestResult) => {
        if (result.authResults[0] === -1 && result.authResults[1] === -1) {
          resolve('failed')
        } else {
          resolve('success')
        }
      }).catch((error: BusinessError) => {
        reject('failed')
        console.error(`get Permission error, error. Code: ${error.code}, message: ${error.message}`);
      })
    })
  }

  addPlanDialogController: CustomDialogController = new CustomDialogController({
    builder: addPlanDialog({
    }),
    alignment: DialogAlignment.Center
  })

  cancelDialogController: CustomDialogController = new CustomDialogController({
    builder: cancelDialog({

    }),
    alignment: DialogAlignment.Center,
    autoCancel: true  // 允许点击蒙层关闭
  })

  addDialogController: CustomDialogController = new CustomDialogController({
    builder: addDialog({
    }),
    alignment: DialogAlignment.Center
  })

  isVIPCourse(): boolean {
    if ((this.courseId === '0006' || this.courseId === '0007' || this.courseId === '0008' ||
      this.courseId === '0009' || this.courseId === '0010' || this.courseId === '0011') && !this.vm.isVIP()) {
      return true
    }
    return false
  }

  @Builder
  addPlanDialogBuilder() {
    Column() {
      PlanDialog({ planList: this.planList, clickedStates: this.clickedStates })

      Row() {
        Text('保存计划')
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
          .fontSize($r('sys.float.Body_L'))
      }
      .margin({ top: 10})
      .width(328)
      .height(40)
      .borderRadius(20)
      .backgroundColor($r('app.color.app_theme'))
      .onClick(() => {
        let courseList: string[][] = []
        this.courseDateList.forEach((date: string) => {
          let coursePlan: string[] = (AppStorage.get(date) ?? []) as string[]
          if (!coursePlan.includes(this.courseId) && this.planList.includes(Number(date))) {
            coursePlan = [...coursePlan, this.courseId];
            // coursePlan.push(this.courseId);
          }
          AppStorage.setOrCreate<string[]>(date, coursePlan)
          courseList.push(coursePlan)
        })
        getContext().eventHub.emit('calculateData', courseList);
        this.isShowAddPlanDialog = false;
        if(this.planList.length !== 0) {
          this.addPlanDialogController.open();
        }
      })
      .justifyContent(FlexAlign.Center)
      .padding({ left: 16, right: 16, top: 9, bottom: 9 })
    }
    .backgroundColor('rgba(255, 255, 255, 0.9)')
    .width('100%')
  }

  @Builder
  addDateDialogBuilder() {
    Column() {
      DateDialog({ dateList: this.dateList })

      Row() {
        Text('保存日程')
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
          .fontSize($r('sys.float.Body_L'))
      }
      .justifyContent(FlexAlign.Center)
      .padding({ left: 16, right: 16, top: 9, bottom: 9 })
      .width(328)
      .height(40)
      .borderRadius(20)
      .backgroundColor($r('app.color.app_theme'))
      .onClick(async () => {
        this.isShowAddDateDialog = false;
        if(this.dateList.length !== 0) {
          // 加日程
          let permission = await this.getCalendarPermission()

          if (permission === 'success') {
            this.calendarMgr = calendarManager.getCalendarManager(getContext() as common.UIAbilityContext);

            for (let i = 0; i < this.dateList.length; i++) {
              if (this.dateList[i]) {
                const date = new Date();
                date.setDate(Number.parseInt(this.dateList[i]));

                // 日历提醒信息，可根据需要自定义配置
                const event: calendarManager.Event = {
                  // 日程标题
                  title: this.course.courseTitle,
                  // 日程类型，不推荐三方开发者使用calendarManager.EventType.IMPORTANT，重要日程类型不支持一键服务跳转功能及无法自定义提醒时间
                  type: calendarManager.EventType.NORMAL,
                  // 是否为全天日程
                  isAllDay: true,
                  // 日程开始时间
                  startTime: date.getTime(),
                  // 日程结束时间
                  endTime: date.getTime() + 60 * 60 * 1000,
                };

                let calendar: calendarManager.Calendar | undefined = undefined;

                this.calendarMgr?.getCalendar((err: BusinessError, data:calendarManager.Calendar) => {
                  if (err) {
                    console.error(`Failed to get calendar. Code: ${err.code}, message: ${err.message}`);
                  } else {
                    console.info(`Succeeded in getting calendar, data -> ${JSON.stringify(data)}`);
                    calendar = data;
                    calendar.addEvent(event).then((data: number) => {
                      console.info(`Succeeded in adding event, id -> ${data}`);
                    }).catch((err: BusinessError) => {
                      console.error(`Failed to addEvent. Code: ${err.code}, message: ${err.message}`);
                    });
                  }
                });
              }
            }

            this.addDialogController.open();
          }else {
            promptAction.showToast({message: '没有日历权限，请去设置页面授权'});
          }
        }
      })
    }
    .width('100%')
    .margin({bottom: 10})
    .backgroundColor('rgba(255, 255, 255, 0.9)')
  }

  @Builder
  explainBuilder(index: number, titleList: string[]) {
    Column() {
      Scroll() {
        explain(titleList[index])
      }

      Column() {
        Row({ space: 16 }) {
          Image(index === 0 ? $r('app.media.explain_left') : $r('app.media.ic_left_on'))
            .width(40)
            .onClick(() => {
              this.isShowExplain[index] = false;
              this.isShowExplain[index-1] = true;
            })
          Text('我已了解')
            .width(216)
            .height(40)
            .fontColor(Color.White)
            .borderRadius(24)
            .textAlign(TextAlign.Center)
            .padding({ left: 24, right: 24, top: 8, bottom: 8 })
            .backgroundColor($r('app.color.app_theme'))
            .onClick(() => {
              this.isShowExplain[index] = false;
            })
          Image(index !== titleList.length - 1 ? $r('app.media.explain_right') : $r('app.media.ic_right_off'))
            .width(40)
            .onClick(() => {
              this.isShowExplain[index] = false;
              this.isShowExplain[index+1] = true;
            })
        }
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height(64)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .position({ y: '85%' }) // 关键定位属性
      .alignSelf(ItemAlign.Center)
    }
    .backgroundColor('rgba(255, 255, 255, 0.9)')
    .width('100%')
    .height('100%')
  }

  @Builder
  explainVIPBuilder(index: number, titleList: string[]) {
    Column() {
      Scroll() {
        explainVIP(titleList[index])
      }

      Column() {
        Row() {
          Image($r('app.media.ic_vip'))
            .width(24)
            .height(24)
            .margin({ right: 4 })
          Text('开通会员解锁课程？')
            .fontColor(Color.White)
            .fontWeight(FontWeight.Medium)
            .fontSize($r('sys.float.Body_L'))
        }
      }
      .alignItems(HorizontalAlign.Center)
      .padding({ left: 16, right: 16, top: 9, bottom: 9 })
      .margin({ left: 16, right: 16 })
      .position({ y: '85%' }) // 关键定位属性
      .backgroundColor($r('app.color.app_theme'))
      .borderRadius(20)
      .justifyContent(FlexAlign.Center)
      .width('90%')
      .height(40)
      .onClick(() => {
        this.isShowExplain[index] = false;
        RouterUtils.pushPathByName(RouterMap.VIP_PAGE);
      })
    }
    .width('100%')
    .height('100%')
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '课程详情',
        })

        Scroll(this.scroller) {
          Column() {
            Stack() {
              Image(this.course.cover)
                .width(328)
                .height(184)
                .borderRadius(16)

              Image(this.isStar ? $r('app.media.star') : $r('app.media.no_star'))
                .position({ x: 276, y: 132 }) // 基于图片左上角的坐标
                .width(40)
                .height(40)
                .onClick(() => {
                  if (!this.isStar) {
                    if (this.vm.saveAction(this.label)) {
                      this.isStar = true;
                      AppStorage.setOrCreate<boolean>(this.courseId, true)
                    }
                  } else {
                    if (this.vm.deleteAction(this.label)) {
                      this.isStar = false;
                      AppStorage.setOrCreate<boolean>(this.courseId, false)
                    }
                  }
                })
            }
            .margin({ top: 12, bottom: 12 })

            Column() {
              Text(this.course.courseTitle)
                .fontWeight(FontWeight.Medium)
                .fontSize(18)
              Text(`难度：${this.courseContent.difficulty}`)
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_M'))
                .margin({ top: 12, bottom: 12 })
              Text(`预计时长：${this.courseContent.duration}分钟`)
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_M'))
              Text('课程介绍')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_M'))
                .margin({ top: 25, bottom: 4 })
              Text(this.course.description)
                .fontWeight(FontWeight.Medium)
                .fontColor('rgba(0, 0, 0, 0.6)')
                .fontSize($r('sys.float.Body_M'))
              Text('注意事项')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_M'))
                .margin({ top: 25, bottom: 4 })
              Column() {
                ForEach(this.courseContent.careAbout, (item: string) => {
                  Text(item)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('rgba(0, 0, 0, 0.6)')
                    .fontSize($r('sys.float.Body_M'))
                    .margin({ bottom: 8 })
                    .width('90%')
                    .textAlign(TextAlign.Start)
                })
              }
            }
            .alignItems(HorizontalAlign.Start)
            .width(332)
            .padding(12)
            .borderRadius(16)
            .backgroundColor(Color.White)


            Column() {
              Text('课程内容')
                .fontWeight(FontWeight.Medium)
                .fontSize(18)
            }
            .width(316)
            .height(24)
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 12, bottom: 8 })

            Column() {
              ForEach(this.courseContent.contentCategory, (item: string, index) => {
                Row() {
                  Row() {
                    Text(item)
                      .fontWeight(FontWeight.Medium)
                      .fontSize($r('sys.float.Body_L'))
                      .margin({ right: 8 })
                    Text(this.courseContent.contentDuration[index])
                      .fontWeight(FontWeight.Medium)
                      .fontSize($r('sys.float.Body_M'))
                  }

                  Text('查看讲解')
                    .fontColor(Color.White)
                    .backgroundColor($r('app.color.app_theme'))
                    .width(80)
                    .height(28)
                    .borderRadius(14)
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                      this.isShowExplain[index] = true;
                    })
                    .bindSheet(this.isShowExplain[index], (!this.vm.isVIP() && this.isVIPCourse()) ?
                      this.explainVIPBuilder(index, this.titleList) : this.explainBuilder(index, this.titleList), {
                      height: '90%',
                      dragBar: false,
                      showClose: true,
                      preferType: SheetType.BOTTOM,
                      backgroundColor: '#fff',
                      onDisappear: () => {
                        this.isShowExplain[index] = false;
                      }
                    })
                }
                .width(304)
                .padding({ top: 12, bottom: 12 })
                .justifyContent(FlexAlign.SpaceBetween)
              })
            }
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding({ left: 12, right: 12 })
            .width(328)
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)
        .width('100%')

        Column() {
          if (this.isVIPCourse()) {
              Row() {
                Image($r('app.media.ic_vip'))
                  .width(24)
                  .height(24)
                  .margin({ right: 4 })
                Text('开通会员解锁课程？')
                  .fontColor(Color.White)
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
              }
              .padding({ left: 16, right: 16, top: 9, bottom: 9 })
              .justifyContent(FlexAlign.Center)
              .width(328)
              .height(40)
              .backgroundColor($r('app.color.app_theme'))
              .borderRadius(20)
              .onClick(() => {
                RouterUtils.pushPathByName(RouterMap.VIP_PAGE);
              })
          } else {
            Row() {
              Column() {
                Image(this.planList.includes(new Date().getDate()) ? $r('app.media.ic_plan_on')
                : $r('app.media.ic_plan_off'))
                  .width(24)
                  .height(24)
                  .margin({ bottom: 2 })
                Text(this.planList.includes(new Date().getDate()) ? '已加计划' : '加计划')
                  .width(40)
                  .fontWeight(FontWeight.Medium)
                  .fontSize(10)
              }
              .width(54)
              .height(48)
              .padding({ top: 4, left: 12, right: 12, bottom: 4 })
              .onClick(() => {
                this.isShowAddPlanDialog = true;
              })
              .bindSheet($$this.isShowAddPlanDialog, this.addPlanDialogBuilder(), {
                height: '40%',
                dragBar: false,
                showClose: true,
                title: { title: '添加计划' },
                backgroundColor: '#fff',
                preferType: SheetType.BOTTOM,
                onDisappear: () => {
                  this.isShowAddPlanDialog = false;
                }
              })

              Column() {
                Image(this.dateList.includes(String(new Date().getDate())) ? $r('app.media.ic_date_on')
                  : $r('app.media.ic_date_off'))
                  .width(24)
                  .height(24)
                  .margin({ bottom: 2 })
                Text(this.dateList.includes(String(new Date().getDate())) ? '已加日程' : '加日程')
                  .width(40)
                  .fontWeight(FontWeight.Medium)
                  .fontSize(10)
              }
              .width(50)
              .height(48)
              .padding({ top: 4, left: 8, right: 12, bottom: 4 })
              .onClick(() => {
                this.isShowAddDateDialog = true;
              })
              .bindSheet($$this.isShowAddDateDialog, this.addDateDialogBuilder(), {
                height: '70%',
                dragBar: false,
                showClose: true,
                preferType: SheetType.BOTTOM,
                title: { title: '添加日历' },
                backgroundColor: '#fff',
                onDisappear: () => {
                  this.isShowAddDateDialog = false;
                }
              })

              Row() {
                Text('准备好了吗？')
                  .fontColor(Color.White)
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                  .margin({ right: 4 })
                Image($r('app.media.icon_go'))
                  .width(24)
                  .height(24)
              }
              .justifyContent(FlexAlign.Center)
              .padding({ left: 16, right: 16, top: 9, bottom: 9 })
              .width(223)
              .height(40)
              .borderRadius(20)
              .backgroundColor($r('app.color.app_theme'))
              .onClick(() => RouterUtils.pushPathByName(RouterMap.COURSE_VIDEO, this.courseId))
            }
          }
        }
        .width('100%')
        .backgroundColor(Color.White)
        .height(80)
        .padding({ top: 4, bottom: 20 }) // 安全区域处理
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .height('100%')
      .backgroundColor($r('app.color.course_background'))
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.courseId = context.pathInfo?.param as string
      switch (this.courseId) {
        case '0001':
          this.course = COURSE_DATA1[0];
          this.courseContent = COURSE_CONTENT[0]
          break;
        case '0002':
          this.course = COURSE_DATA1[1];
          this.courseContent = COURSE_CONTENT[1]
          break;
        case '0003':
          this.course = COURSE_DATA1[2];
          this.courseContent = COURSE_CONTENT[2]
          break;
        case '0004':
          this.course = COURSE_DATA1[3];
          this.courseContent = COURSE_CONTENT[3]
          break;
        case '0005':
          this.course = COURSE_DATA1[4];
          this.courseContent = COURSE_CONTENT[4]
          break;
        case '0006':
          this.course = COURSE_DATA1[5];
          this.courseContent = COURSE_CONTENT[5]
          break;
        case '0007':
          this.course = COURSE_DATA1[6];
          this.courseContent = COURSE_CONTENT[6]
          break;
        case '0008':
          this.course = COURSE_DATA1[7];
          this.courseContent = COURSE_CONTENT[7]
          break;
        case '0009':
          this.course = COURSE_DATA1[8];
          this.courseContent = COURSE_CONTENT[8]
          break;
        case '0010':
          this.course = COURSE_DATA1[9];
          this.courseContent = COURSE_CONTENT[9]
          break;
        case '0011':
          this.course = COURSE_DATA1[10];
          this.courseContent = COURSE_CONTENT[10]
          break;
        default:
          break;
      }
      this.label = this.course.courseTitle
      this.aboutToAppear()
    })
  }
}
