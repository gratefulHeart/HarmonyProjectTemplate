import { CommonConstants, RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { GuidePageVM } from '../viewmodels/GuidePageVM';

@Builder
export function GuidePageSportsBuilder() {
  GuidePage()
}

@ComponentV2
export struct CustomButton {
  @Param label: string = ''    // 按钮文本
  @Param private themeColor: Resource = $r('app.color.app_theme')  // 主题色
  @Param private backColor: Resource = $r('sys.color.comp_background_tertiary')
  @Param private foreColor: string = 'rgba(0, 0, 0, 0.9)'
  @Param selected: boolean = false

  build() {
    Button(this.label)
      .width(104)
      .height(28)
      .fontSize($r('sys.float.Body_M'))
      .borderRadius(14)
      .fontColor(this.selected ? Color.White : this.foreColor)
      .backgroundColor(this.selected ? this.themeColor : this.backColor)
  }
}

@ComponentV2
export struct CustomButton1 {
  @Local isOn: boolean = false  // 独立状态存储
  @Param label: string = ''    // 按钮文本
  @Param private themeColor: Resource = $r('app.color.app_theme')  // 主题色
  @Param private backColor: Resource = $r('sys.color.comp_background_tertiary')
  @Param private foreColor: string = 'rgba(0, 0, 0, 0.9)'

  build() {
    Button(this.label)
      .width(78)
      .height(28)
      .fontSize($r('sys.float.Body_M'))
      .borderRadius(14)
      .fontColor(this.isOn ? Color.White : this.foreColor)
      .backgroundColor(this.isOn ? this.themeColor : this.backColor)
      .onClick(() => {
        this.isOn = !this.isOn  // 状态自动切换
      })
  }
}

@ComponentV2
struct GuidePage {
  vm: GuidePageVM = new GuidePageVM();
  @Local selectedFrequency: string = '';

  @Builder
  skipBuilder() {
    Text('跳过')
      .width(104)
      .height(40)
      .borderRadius(20)
      .fontColor($r('sys.color.font_secondary'))
      .textAlign(TextAlign.Center)
      .backgroundColor($r('sys.color.comp_background_tertiary'))
      .onClick(() => this.vm.skipBtnClick())
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          rightPartBuilder: () => {
            this.skipBuilder();
          },
        })
      }

      Column() {
        Column() {
          Text('关于您')
            .fontSize($r('sys.float.Title_L'))
            .fontWeight(FontWeight.Medium)
            .margin({
              bottom: 24,
            })
          Row({ space: CommonConstants.SPACE_S }) {
            Image($r('app.media.ic_privacy'))
              .width(16)
              .draggable(false)
              .margin({ right: 4 })
            Text('选择目标部位，获得更精确的课程推荐！')
              .fontSize($r('sys.float.Body_M'))
              .fontColor($r('sys.color.font_secondary'))
          }
        }
        .alignItems(HorizontalAlign.Start)
        .width(336)

        Column() {
          Text('您喜欢的运动类型')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .margin({
              top: 40,
              bottom: 24,
            })

          Column() {
            Row({ space: 12 }) {
              CustomButton1({ label: '跑步' })

              CustomButton1({ label: '跳绳' })

              CustomButton1({ label: '游泳' })
            }
            .margin({ bottom: 12 })

            Row({ space: 12 }) {
              CustomButton1({ label: '瑜伽' })

              CustomButton1({ label: '器械' })

              CustomButton1({ label: '爬楼' })
            }
            .justifyContent(FlexAlign.Start)
          }
        }
        .alignItems(HorizontalAlign.Start)
        .width(336)

        Column() {
          Text('您的运动频次')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .margin({
              top: 40,
              bottom: 24,
            })

          Column() {
            Row({ space: 12 }) {
              CustomButton({ label: '一周1次', selected: this.selectedFrequency === '一周1次' })
                .onClick(() => {
                  this.selectedFrequency = '一周1次'
                })

              CustomButton({ label: '一周2~3次', selected: this.selectedFrequency === '一周2~3次' })
                .onClick(() => {
                  this.selectedFrequency = '一周2~3次'
                })

              CustomButton({ label: '一周3次以上', selected: this.selectedFrequency === '一周3次以上' })
                .onClick(() => {
                  this.selectedFrequency = '一周3次以上'
                })
            }
          }
        }
        .alignItems(HorizontalAlign.Start)
        .width(336)

        Column() {
          Text('期望练习难度')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .margin({
              top: 40,
              bottom: 24,
            })

          Column() {
            Row({ space: 8 }) {
              CustomButton1({ label: '零基础' })

              CustomButton1({ label: '初级' })

              CustomButton1({ label: '中级' })

              CustomButton1({ label: '高级' })
            }
          }
        }
        .alignItems(HorizontalAlign.Start)
        .width(336)
      }
      .width(336)
      .height('60%')

      Column() {
        // 只在非第一页显示下一步按钮
        Button('下一步', { type: ButtonType.Capsule })
          .width(328)
          .height(40)
          .fontColor($r('sys.color.font_on_primary'))
          .backgroundColor($r('app.color.app_theme'))
          .onClick(() => RouterUtils.pushPathByName(RouterMap.GUIDE_PAGE_Start))
          .margin({ bottom: CommonConstants.PADDING_M })
      }
      .height('40%')
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ bottom: 20 })
      .layoutWeight(1)
    }
    .backgroundColor($r('sys.color.ohos_id_color_background'))
    .hideTitleBar(true)
  }
}
