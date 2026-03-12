import { CalendarItem, CalendarUtils } from './Calendar';

@CustomDialog
export struct addDialog {
  controller?: CustomDialogController;

  build() {
    Column() {
      Text('添加日历成功！')
        .fontSize(20)
        .height(56)
        .width(244)
        .textAlign(TextAlign.Center)
      Image($r('app.media.ic_date_success'))
        .width(244)
        .height(192)
        .margin({ bottom: 20 })
      Text('好的，我知道了')
        .width(216)
        .height(40)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .borderRadius(24)
        .backgroundColor($r('app.color.app_theme'))
        .padding({ top: 8, bottom: 8, left: 24, right: 24 })
        .onClick(() => {
          if (this.controller !== undefined) {
            this.controller.close();
          }
        })
    }
    .alignItems(HorizontalAlign.Center)
    .padding({ left: 42, right: 42, bottom: 24 })
    .borderRadius(32)
    .width(328)
    .height(332)
  }
}

@CustomDialog
export struct addPlanDialog {
  controller?: CustomDialogController;

  build() {
    Column() {
      Text('添加计划成功！')
        .fontSize(20)
        .height(56)
        .width(244)
        .textAlign(TextAlign.Center)
      Image($r('app.media.icon_plan_on'))
        .width(244)
        .height(192)
        .margin({ bottom: 20 })
      Button('好的，我知道了')
        .width(216)
        .height(40)
        .borderRadius(24)
        .backgroundColor($r('sys.color.comp_background_emphasize'))
        .padding({ top: 8, bottom: 8, left: 24, right: 24 })
        .onClick(() => {
          if (this.controller !== undefined) {
            this.controller.close();
          }
        })
    }
    .alignItems(HorizontalAlign.Center)
    .padding({ left: 42, right: 42, bottom: 24 })
    .borderRadius(32)
    .width(328)
    .height(332)
  }
}

@CustomDialog
export struct cancelDialog {
  controller?: CustomDialogController;

  build() {
    Column() {
      Text('是否取消计划？')
        .fontSize(20)
        .height(56)
        .width(244)
        .textAlign(TextAlign.Center)
      Image($r('app.media.icon_plan_off'))
        .width(244)
        .height(192)
        .margin({ bottom: 20 })
      Row({ space: 16 }) {
        Button('确认取消')
          .width(140)
          .height(40)
          .borderRadius(20)
          .fontColor($r('sys.color.font_on_primary'))
          .backgroundColor('rgba(0, 0, 0, 0.05)')
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })

        Button('我再想想')
          .width(140)
          .height(40)
          .borderRadius(20)
          .backgroundColor($r('sys.color.comp_background_emphasize'))
          .onClick(() => {
            if (this.controller !== undefined) {
              this.controller.close();
            }
          })
      }
    }
    .alignItems(HorizontalAlign.Center)
    .padding({ left: 16, right: 16, bottom: 24 })
    .borderRadius(32)
    .width(328)
    .height(332)
  }
}

@ComponentV2
export struct CustomButton {
  @Local isOn: boolean = false  // 独立状态存储
  @Param label: string = ''    // 按钮文本
  @Param isCurrent: boolean = false
  @Param dateList: string[] = [];
  @Param private themeColor: Resource = $r('app.color.app_theme')  // 主题色
  @Param private darkColor: string = 'rgba(0, 0, 0, 0.4)'
  @Param private foreColor: string = 'rgba(0, 0, 0, 0.9)'

  build() {
    if (this.isCurrent) {
      Text(this.label)
        .fontSize($r('sys.float.Body_M'))
        .height(40)
        .width(40)
        .borderRadius(12)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isOn ? Color.White : this.foreColor)
        .backgroundColor(this.isOn ? this.themeColor : Color.White)
        .onClick(() => {
          this.isOn = !this.isOn  // 状态自动切换
          this.dateList.push(this.label);
        })
    } else{
      Text(this.label)
        .fontSize($r('sys.float.Body_M'))
        .height(40)
        .width(40)
        .borderRadius(12)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.darkColor)
        .backgroundColor(Color.White)
    }
  }
}

@Builder
export function explain(title: string) {
  Column() {
    Row() {
      Text(title)
        .fontWeight(FontWeight.Medium)
        .fontSize(18)
      Text('10分钟')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
    }
    .width('100%')
    .height(24)
    .margin({ bottom: 12 })
    .justifyContent(FlexAlign.Start)

    Scroll() {
      Row({ space: 12 }) {
        Image($r('app.media.explain1'))
          .width(90)
          .height(184)
          .backgroundColor($r('sys.color.comp_background_tertiary'))
        Image($r('app.media.explain2'))
          .width(90)
          .height(184)
          .backgroundColor($r('sys.color.comp_background_tertiary'))
        Image($r('app.media.explain3'))
          .width(90)
          .height(184)
          .backgroundColor($r('sys.color.comp_background_tertiary'))
        Image($r('app.media.explain4'))
          .width(90)
          .height(184)
          .backgroundColor($r('sys.color.comp_background_tertiary'))
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .width('100%')  // 设置滚动区域宽度

    Column() {
      Text('动作讲解')
        .fontWeight(FontWeight.Medium)
        .fontSize(18)
    }
    .width('100%')
    .height(24)
    .margin({ top: 12, bottom: 12 })
    .alignItems(HorizontalAlign.Start)

    Column() {
      Text('·保持头部中立位，目视前方，避免低头或仰头造成颈椎压力。')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')

      Text('·收紧核心肌群，肩胛骨微收，手臂自然屈曲90°前后摆动，减少躯干晃动。')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')

      Text('·全脚掌滚动式着地（脚跟→前掌），步频建议保持180步/分钟以减少关节冲击。')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
    }
    .height(114)
    .width('100%')
    .justifyContent(FlexAlign.Start)

    Column() {
      Text('训练要点')
        .fontWeight(FontWeight.Medium)
        .fontSize(18)
    }
    .height(24)
    .width('100%')
    .margin({ top: 12, bottom: 12 })
    .alignItems(HorizontalAlign.Start)

    Column() {
      Text('·在使用跑步机前，充分活动关节，如踝关节、膝关节、髋关节等，拉伸腿部、腰部肌肉，高抬腿过程中避免激烈跳动，以热身为主，能减少运动损伤。')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
    }
    .height(57)
    .width('100%')
    .justifyContent(FlexAlign.Start)

    Column() {
      Text('常见错误')
        .fontWeight(FontWeight.Medium)
        .fontSize(18)
    }
    .height(24)
    .width('100%')
    .margin({ top: 12, bottom: 12 })
    .alignItems(HorizontalAlign.Start)

    Column() {
      Text('·心率上升速度太快导致呼吸紊乱；')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
      Text('·落地脚踝不稳导致受伤风险提高；')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
      Text('·开合跳没有收紧腹部导致肠胃不适；')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
      Text('·快跑阶段没有控制时速。')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
    }
    .height(76)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
  .margin({ top: 68 })
  .padding({ left: 16, right: 16 })
  .width('100%')
  .height('100%')
}

@Builder
export function explainVIP(title: string) {
  Column() {
    Row() {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
      Text('10分钟')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
    }
    .height(24)
    .width('100%')
    .margin({ bottom: 12 })
    .justifyContent(FlexAlign.Start)

    Scroll() {
      Row({ space: 12 }) {
        Image($r('app.media.explain1'))
          .width(90)
          .height(184)
          .backgroundColor($r('sys.color.comp_background_tertiary'))
        Image($r('app.media.explain2'))
          .width(90)
          .height(184)
          .backgroundColor($r('sys.color.comp_background_tertiary'))
        Image($r('app.media.explain3'))
          .width(90)
          .height(184)
          .backgroundColor($r('sys.color.comp_background_tertiary'))
        Image($r('app.media.explain4'))
          .width(90)
          .height(184)
          .backgroundColor($r('sys.color.comp_background_tertiary'))
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .width('100%')  // 设置滚动区域宽度

    Column() {
      Text('动作讲解')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .height(24)
    .margin({ top: 12, bottom: 12 })

    Column() {
      Text('·保持头部中立位，目视前方，避免低头或仰头造成颈椎压力。')
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
        .fontWeight(FontWeight.Medium)

      Text('·收紧核心肌群，肩胛骨微收，手臂自然屈曲90°前后摆动，减少躯干晃动。')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')

      Text('·全脚掌滚动式着地（脚跟→前掌），步频建议保持180步/分钟以减少关节冲击。')
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
        .fontWeight(FontWeight.Medium)
    }
    .height(114)
    .width('100%')
    .justifyContent(FlexAlign.Start)

    Column() {
      Text('训练要点')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
    }
    .height(24)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 12, bottom: 12 })

    Column() {
      Text('·在使用跑步机前，充分活动关节，如踝关节、膝关节、髋关节等，拉伸腿部、腰部肌肉，高抬腿过程中避免激烈跳动，以热身为主，能减少运动损伤。')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
    }
    .width('100%')
    .height(57)
    .justifyContent(FlexAlign.Start)

    Column() {
      Text('常见错误')
        .fontWeight(FontWeight.Medium)
        .fontSize(18)
    }
    .width('100%')
    .height(24)
    .margin({ top: 12, bottom: 12 })
    .alignItems(HorizontalAlign.Start)

    Column() {
      Text('·心率上升速度太快导致呼吸紊乱；')
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
        .fontWeight(FontWeight.Medium)
      Text('·落地脚踝不稳导致受伤风险提高；')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
      Text('·开合跳没有收紧腹部导致肠胃不适；')
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
        .fontWeight(FontWeight.Medium)
      Text('·快跑阶段没有控制时速。')
        .fontWeight(FontWeight.Medium)
        .fontSize($r('sys.float.Body_M'))
        .fontColor('rgba(0, 0, 0, 0.6)')
    }
    .width('100%')
    .height(76)
    .alignItems(HorizontalAlign.Start)
  }
  .width('100%')
  .height('100%')
  .margin({ top: 68 })
  .padding({ left: 16, right: 16 })
  .blur(10)
}

@ComponentV2
export struct CustomFilterButton {
  @Param label: string = ''    // 按钮文本
  @Param filter: String[] = []
  @Local isOn: boolean = this.filter.includes(this.label)  // 独立状态存储
  @Param private backColor: Resource = $r('sys.color.comp_background_tertiary')
  @Param private foreColor: string = 'rgba(0, 0, 0, 0.9)'
  @Param private themeColor: Resource = $r('app.color.app_theme')  // 主题色

  build() {
    Button(this.label)
      .width(80)
      .height(28)
      .borderRadius(14)
      .fontSize($r('sys.float.Body_S'))
      .fontColor(this.isOn ? Color.White : this.foreColor)
      .backgroundColor(this.isOn ? this.themeColor : this.backColor)
      .onClick(() => {
        this.isOn = !this.isOn  // 状态自动切换
        if (this.filter.includes(this.label)) {
          const index = this.filter.findIndex(item => item === this.label);
          this.filter.splice(index, 1);
        } else {
          this.filter.push(this.label);
        }
      })
  }
}

@ComponentV2
export struct CourseFilterDialog {
  @Param filter: String[] = []

  build() {
    Column() {
      Column() {
        Text('目标')
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .height(45)
          .padding({
            top: 16,
            bottom: 8,
          })

        Column() {
          Row({ space: 8 }) {
            CustomFilterButton({label: '增肌塑形', filter: this.filter})

            CustomFilterButton({label: '减重瘦身', filter: this.filter})

            CustomFilterButton({label: '强化心肺', filter: this.filter})

            CustomFilterButton({label: '保持健康', filter: this.filter})
          }
          .margin({ top: 4, bottom: 8 })

          Row({ space: 8 }) {
            CustomFilterButton({label: '力量训练', filter: this.filter})

            CustomFilterButton({label: '马甲线', filter: this.filter})

            CustomFilterButton({label: '增加柔韧', filter: this.filter})

            CustomFilterButton({label: '随便练练', filter: this.filter})
          }
          .margin({ bottom: 4 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .width(328)

      Column() {
        Text('身体部位')
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .height(45)
          .padding({
            top: 16,
            bottom: 8,
          })

        Column() {
          Row({ space: 8 }) {
            CustomFilterButton({label: '手臂', filter: this.filter})

            CustomFilterButton({label: '大腿', filter: this.filter})

            CustomFilterButton({label: '腹部', filter: this.filter})

            CustomFilterButton({label: '臀部', filter: this.filter})
          }
          .margin({ top: 4, bottom: 8 })

          Row({ space: 8 }) {
            CustomFilterButton({label: '胸肌', filter: this.filter})

            CustomFilterButton({label: '背部', filter: this.filter})

            CustomFilterButton({label: '肩部', filter: this.filter})

            CustomFilterButton({label: '随便练练', filter: this.filter})
          }
          .margin({ bottom: 4 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .width(328)

      Column() {
        Text('难度')
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .height(45)
          .padding({
            top: 16,
            bottom: 8,
          })

        Column() {
          Row({ space: 8 }) {
            CustomFilterButton({label: '零基础', filter: this.filter})

            CustomFilterButton({label: '初级', filter: this.filter})

            CustomFilterButton({label: '中级', filter: this.filter})

            CustomFilterButton({label: '高级', filter: this.filter})
          }
          .margin({ top: 4, bottom: 4 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .width(328)

      Column() {
        Text('种类')
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .height(45)
          .padding({
            top: 16,
            bottom: 8,
          })

        Column() {
          Row({ space: 8 }) {
            CustomFilterButton({label: '燃脂', filter: this.filter})

            CustomFilterButton({label: '普拉提', filter: this.filter})

            CustomFilterButton({label: '瑜伽', filter: this.filter})

            CustomFilterButton({label: '力量训练', filter: this.filter})
          }
          .margin({ top: 4, bottom: 4 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .width(328)

      Column() {
        Text('课程性质')
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .height(45)
          .padding({
            top: 16,
            bottom: 8,
          })

        Column() {
          Row({ space: 8 }) {
            CustomFilterButton({label: '免费', filter: this.filter})

            CustomFilterButton({label: '会员', filter: this.filter})
          }
          .margin({ top: 4, bottom: 4 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .width(328)

      Column() {
        Text('课程时长（分钟）')
          .fontSize($r('sys.float.Body_L'))
          .fontWeight(FontWeight.Medium)
          .height(45)
          .padding({
            top: 16,
            bottom: 8,
          })

        Column() {
          Row({ space: 8 }) {
            CustomFilterButton({label: '30以下', filter: this.filter})

            CustomFilterButton({label: '31-50', filter: this.filter})

            CustomFilterButton({label: '51-100', filter: this.filter})

            CustomFilterButton({label: '100以上', filter: this.filter})
          }
          .margin({ top: 4, bottom: 4 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .width(328)
    }
    .width('100%')
  }
}


@ComponentV2
export struct PlanDialog {
  private weekNameList: string[] = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
  private month: number = new Date().getMonth();
  private year: number = new Date().getFullYear();
  @Local dateList: Date[] = [];
  @Local today: number = new Date().getDate()
  @Param planList: number[] = [];
  @Param clickedStates: boolean[] = [false, false, false, false, false, false, false]

  buildDateList(): Date[] {
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

  aboutToAppear(): void {
    this.dateList = this.buildDateList();
  }

  build() {
    Column() {
      Column() {
        Text((this.year + '年 ') + (this.month + 1 + '月'))
          .fontWeight(FontWeight.Medium)
          .fontSize($r('sys.float.Body_L'))
          .width('90%')
          .height(21)
          .margin({ left: 12, bottom: 12 })
          .textAlign(TextAlign.Start)

        Row({ space: 8 }) {
          if (this.today > this.dateList[0].getDate() && this.month === this.dateList[0].getMonth()) {
            Column() {
              Text(this.weekNameList[this.dateList[0].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[0].getMonth() + 1 < 10 ? '0' + (this.dateList[0].getMonth() + 1) :
                this.dateList[0].getMonth() + 1 + '') + '.' +
                (this.dateList[0].getDate() < 10 ? '0' + this.dateList[0].getDate() : this.dateList[0].getDate() + ''))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(Color.White)
          } else {
            Column() {
              Text(this.weekNameList[this.dateList[0].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[0] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[0].getMonth() + 1 < 10 ? '0' + (this.dateList[0].getMonth() + 1) :
                this.dateList[0].getMonth() + 1 + '') + '.' +
                (this.dateList[0].getDate() < 10 ? '0' + this.dateList[0].getDate() : this.dateList[0].getDate() + ''))
                .fontColor(this.clickedStates[0] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(this.clickedStates[0] ? $r('app.color.app_theme') : Color.White)
            .onClick(() => {
              this.clickedStates[0] = !this.clickedStates[0]
              if (this.planList.includes(this.dateList[0].getDate())) {
                const index = this.planList.findIndex(item => item === this.dateList[0].getDate());
                this.planList.splice(index, 1);
              } else {
                this.planList.push(this.dateList[0].getDate());
              }
            })
          }

          if (this.today > this.dateList[1].getDate() && this.month === this.dateList[1].getMonth()) {
            Column() {
              Text(this.weekNameList[this.dateList[1].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[1].getMonth() + 1 < 10 ? '0' + (this.dateList[1].getMonth() + 1) :
                this.dateList[1].getMonth() + 1 + '') + '.' +
                (this.dateList[1].getDate() < 10 ? '0' + this.dateList[1].getDate() : this.dateList[1].getDate() + ''))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(Color.White)
          } else {
            Column() {
              Text(this.weekNameList[this.dateList[1].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[1] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[1].getMonth() + 1 < 10 ? '0' + (this.dateList[1].getMonth() + 1) :
                this.dateList[1].getMonth() + 1 + '') + '.' +
                (this.dateList[1].getDate() < 10 ? '0' + this.dateList[1].getDate() : this.dateList[1].getDate() + ''))
                .fontColor(this.clickedStates[1] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(this.clickedStates[1] ? $r('app.color.app_theme') : Color.White)
            .onClick(() => {
              this.clickedStates[1] = !this.clickedStates[1]
              if (this.planList.includes(this.dateList[1].getDate())) {
                const index = this.planList.findIndex(item => item === this.dateList[1].getDate());
                this.planList.splice(index, 1);
              } else {
                this.planList.push(this.dateList[1].getDate());
              }
            })
          }

          if (this.today > this.dateList[2].getDate() && this.month === this.dateList[2].getMonth()) {
            Column() {
              Text(this.weekNameList[this.dateList[2].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[2].getMonth() + 1 < 10 ? '0' + (this.dateList[2].getMonth() + 1) :
                this.dateList[2].getMonth() + 1 + '') + '.' +
                (this.dateList[2].getDate() < 10 ? '0' + this.dateList[2].getDate() : this.dateList[2].getDate() + ''))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(Color.White)
          } else {
            Column() {
              Text(this.weekNameList[this.dateList[2].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[2] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[2].getMonth() + 1 < 10 ? '0' + (this.dateList[2].getMonth() + 1) :
                this.dateList[2].getMonth() + 1 + '') + '.' +
                (this.dateList[2].getDate() < 10 ? '0' + this.dateList[2].getDate() : this.dateList[2].getDate() + ''))
                .fontColor(this.clickedStates[2] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(this.clickedStates[2] ? $r('app.color.app_theme') : Color.White)
            .onClick(() => {
              this.clickedStates[2] = !this.clickedStates[2]
              if (this.planList.includes(this.dateList[2].getDate())) {
                const index = this.planList.findIndex(item => item === this.dateList[2].getDate());
                this.planList.splice(index, 1);
              } else {
                this.planList.push(this.dateList[2].getDate());
              }
            })
          }

          if (this.today > this.dateList[3].getDate() && this.month === this.dateList[3].getMonth()) {
            Column() {
              Text(this.weekNameList[this.dateList[3].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[3].getMonth() + 1 < 10 ? '0' + (this.dateList[3].getMonth() + 1) :
                this.dateList[3].getMonth() + 1 + '') + '.' +
                (this.dateList[3].getDate() < 10 ? '0' + this.dateList[3].getDate() : this.dateList[3].getDate() + ''))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(Color.White)
          } else {
            Column() {
              Text(this.weekNameList[this.dateList[3].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[3] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[3].getMonth() + 1 < 10 ? '0' + (this.dateList[3].getMonth() + 1) :
                this.dateList[3].getMonth() + 1 + '') + '.' +
                (this.dateList[3].getDate() < 10 ? '0' + this.dateList[3].getDate() : this.dateList[3].getDate() + ''))
                .fontColor(this.clickedStates[3] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(this.clickedStates[3] ? $r('app.color.app_theme') : Color.White)
            .onClick(() => {
              this.clickedStates[3] = !this.clickedStates[3]
              if (this.planList.includes(this.dateList[3].getDate())) {
                const index = this.planList.findIndex(item => item === this.dateList[3].getDate());
                this.planList.splice(index, 1);
              } else {
                this.planList.push(this.dateList[3].getDate());
              }
            })
          }

          if (this.today > this.dateList[4].getDate() && this.month === this.dateList[4].getMonth()) {
            Column() {
              Text(this.weekNameList[this.dateList[4].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[4].getMonth() + 1 < 10 ? '0' + (this.dateList[4].getMonth() + 1) :
                this.dateList[4].getMonth() + 1 + '') + '.' +
                (this.dateList[4].getDate() < 10 ? '0' + this.dateList[4].getDate() : this.dateList[4].getDate() + ''))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(Color.White)
          } else {
            Column() {
              Text(this.weekNameList[this.dateList[4].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[4] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[4].getMonth() + 1 < 10 ? '0' + (this.dateList[4].getMonth() + 1) :
                this.dateList[4].getMonth() + 1 + '') + '.' +
                (this.dateList[4].getDate() < 10 ? '0' + this.dateList[4].getDate() : this.dateList[4].getDate() + ''))
                .fontColor(this.clickedStates[4] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(this.clickedStates[4] ? $r('app.color.app_theme') : Color.White)
            .onClick(() => {
              this.clickedStates[4] = !this.clickedStates[4]
              if (this.planList.includes(this.dateList[4].getDate())) {
                const index = this.planList.findIndex(item => item === this.dateList[4].getDate());
                this.planList.splice(index, 1);
              } else {
                this.planList.push(this.dateList[4].getDate());
              }
            })
          }
        }
        .margin({ bottom: 12 })

        Row({ space: 8 }) {
          if (this.today > this.dateList[5].getDate() && this.month === this.dateList[5].getMonth()) {
            Column() {
              Text(this.weekNameList[this.dateList[5].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[5].getMonth() + 1 < 10 ? '0' + (this.dateList[5].getMonth() + 1) :
                this.dateList[5].getMonth() + 1 + '') + '.' +
                (this.dateList[5].getDate() < 10 ? '0' + this.dateList[5].getDate() : this.dateList[5].getDate() + ''))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(Color.White)
          } else {
            Column() {
              Text(this.weekNameList[this.dateList[5].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[5] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[5].getMonth() + 1 < 10 ? '0' + (this.dateList[5].getMonth() + 1) :
                this.dateList[5].getMonth() + 1 + '') + '.' +
                (this.dateList[5].getDate() < 10 ? '0' + this.dateList[5].getDate() : this.dateList[5].getDate() + ''))
                .fontColor(this.clickedStates[5] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(this.clickedStates[5] ? $r('app.color.app_theme') : Color.White)
            .onClick(() => {
              this.clickedStates[5] = !this.clickedStates[5]
              if (this.planList.includes(this.dateList[5].getDate())) {
                const index = this.planList.findIndex(item => item === this.dateList[5].getDate());
                this.planList.splice(index, 1);
              } else {
                this.planList.push(this.dateList[5].getDate());
              }
            })
          }

          if (this.today > this.dateList[6].getDate() && this.month === this.dateList[6].getMonth()) {
            Column() {
              Text(this.weekNameList[this.dateList[6].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[6].getMonth() + 1 < 10 ? '0' + (this.dateList[6].getMonth() + 1) :
                this.dateList[6].getMonth() + 1 + '') + '.' +
                (this.dateList[6].getDate() < 10 ? '0' + this.dateList[6].getDate() : this.dateList[6].getDate() + ''))
                .fontColor('rgba(0, 0, 0, 0.4)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(Color.White)
          } else {
            Column() {
              Text(this.weekNameList[this.dateList[6].getDay()])
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[6] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .margin({ top: 4, bottom: 2 })
              Text((this.dateList[6].getMonth() + 1 < 10 ? '0' + (this.dateList[6].getMonth() + 1) :
                this.dateList[6].getMonth() + 1 + '') + '.' +
                (this.dateList[6].getDate() < 10 ? '0' + this.dateList[6].getDate() : this.dateList[6].getDate() + ''))
                .fontColor(this.clickedStates[6] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
            }
            .width(59.2)
            .height(47)
            .borderRadius(8)
            .backgroundColor(this.clickedStates[6] ? $r('app.color.app_theme') : Color.White)
            .onClick(() => {
              this.clickedStates[6] = !this.clickedStates[6]
              if (this.planList.includes(this.dateList[6].getDate())) {
                const index = this.planList.findIndex(item => item === this.dateList[6].getDate());
                this.planList.splice(index, 1);
              } else {
                this.planList.push(this.dateList[6].getDate());
              }
            })
          }
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
    .backgroundColor(Color.White)
    .padding({ top: 8, left: 16, right: 16 })
    .width('100%')
    .height(139)
  }
}

@ComponentV2
export struct DateDialog {
  @Param dateList: string[] = [];
  @Local currentCalendar: CalendarItem[] = [];
  @Local weekHeaders: string[] = [];
  @Local groupedWeeks: CalendarItem[][] = [];

  loadCalendar() {
    this.currentCalendar = CalendarUtils.getCurrentMonthCalendar();
    this.groupedWeeks = CalendarUtils.groupByWeek(this.currentCalendar);
    this.weekHeaders = CalendarUtils.getWeekHeaders();
  }

  async aboutToAppear() {
    this.loadCalendar()
  }

  build() {
    Column() {
      Row() {
        Text((new Date().getFullYear() + '年 ') + (new Date().getMonth() + 1 + '月'))
          .fontWeight(FontWeight.Medium)
          .fontSize($r('sys.float.Body_L'))
      }
      .width(294)
      .height(36)
      .justifyContent(FlexAlign.Start)

      Column() {
        Row({ space: 14 }) {
          ForEach(CalendarUtils.getWeekHeaders(), (header: string) => {
            Text(header)
              .fontWeight(FontWeight.Medium)
              .fontSize($r('sys.float.Body_M'))
              .width(42)
              .height(18)
          })
        }
        .width(294)
        .height(19)
        .margin({ top: 4, bottom: 3 })
        .justifyContent(FlexAlign.SpaceBetween)

        Column({ space: 2 }) {
          // 日历内容
          Column({ space: 2 }) {
            ForEach(this.groupedWeeks, (week: CalendarItem[], weekIndex: number) => {
              Row({ space: 2 }) {
                ForEach(week, (day: CalendarItem, dayIndex: number) => {
                  if (day.isPastDate) {
                    CustomButton({ label: String(day.day) })
                  } else {
                    if (day.isCurrentMonth) {
                      CustomButton({ label: String(day.day), isCurrent: true, dateList: this.dateList })
                    } else {
                      CustomButton({ label: String(day.day) })
                    }
                  }
                })
              }
              .height(42)
              .width(294)
              .justifyContent(FlexAlign.SpaceBetween)
            })
          }
          .width('100%')
          .padding(10)
        }
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('rgb(255, 255, 255, 0.4)')
        .borderRadius(12)
        .width(328)
        .height(334)
      }
    }
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('rgb(255, 255, 255, 0.4)')
    .borderRadius(12)
    .width(328)
    .height(334)
  }
}