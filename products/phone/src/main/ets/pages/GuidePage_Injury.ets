import { CommonConstants, RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { GuidePageVM } from '../viewmodels/GuidePageVM';

@Builder
export function GuidePageInjuryBuilder() {
  GuidePage()
}

@ComponentV2
struct GuidePage {
  vm: GuidePageVM = new GuidePageVM();
  @Local clickedStates: boolean[] = [false, false, false, false, false, false]
  @Local selectedValue: string = '' // 记录选中值

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
              .width($r('app.float.medium_img_width'))
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
          Text('是否存在伤病困扰？')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .margin({
              top: 40,
              bottom: 21,
            })
            .width(168)

          Row() {
            // 是按钮
            Radio({
              group: 'Group',
              value: 'yes'
            })
              .radioStyle({
                checkedBackgroundColor: $r('app.color.app_theme')
              })
              .checked(this.selectedValue === 'yes')
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.selectedValue = 'yes'
                }
              })
            Text('是')
              .margin({ left: 12, right: 64 })

            // 否按钮
            Radio({
              group: 'Group',
              value: 'no'
            })
              .radioStyle({
                checkedBackgroundColor: $r('app.color.app_theme')
              })
              .checked(this.selectedValue === 'no')
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.selectedValue = 'no'
                }
              })
            Text('否')
              .margin({ left: 12 })
          }
          .width(168)

          Column() {
            // 当选择"是"时显示的内容
            Text('选择受伤部位')
              .fontSize($r('sys.float.Body_L'))
              .fontWeight(FontWeight.Medium)
              .margin({
                top: 40,
                bottom: 24,
              })

            Column() {
              Row({ space: 12 }) {
                Button('手腕')
                  .width(104)
                  .height(28)
                  .fontSize($r('sys.float.Body_M'))
                  .fontColor(this.clickedStates[0] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                  .borderRadius(14)
                  .backgroundColor(this.clickedStates[0] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                  .onClick(() => {
                    this.clickedStates[0] = !this.clickedStates[0]
                  })

                Button('膝盖')
                  .width(104)
                  .height(28)
                  .fontSize($r('sys.float.Body_M'))
                  .fontColor(this.clickedStates[1] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                  .borderRadius(14)
                  .backgroundColor(this.clickedStates[1] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                  .onClick(() => {
                    this.clickedStates[1] = !this.clickedStates[1]
                  })

                Button('脚踝')
                  .width(104)
                  .height(28)
                  .fontSize($r('sys.float.Body_M'))
                  .fontColor(this.clickedStates[2] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                  .borderRadius(14)
                  .backgroundColor(this.clickedStates[2] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                  .onClick(() => {
                    this.clickedStates[2] = !this.clickedStates[2]
                  })
              }
              .margin({ bottom: 12 })

              Row({ space: 12 }) {
                Button('背部')
                  .width(104)
                  .height(28)
                  .fontSize($r('sys.float.Body_M'))
                  .fontColor(this.clickedStates[3] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                  .borderRadius(14)
                  .backgroundColor(this.clickedStates[3] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                  .onClick(() => {
                    this.clickedStates[3] = !this.clickedStates[3]
                  })

                Button('颈椎')
                  .width(104)
                  .height(28)
                  .fontSize($r('sys.float.Body_M'))
                  .fontColor(this.clickedStates[4] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                  .borderRadius(14)
                  .backgroundColor(this.clickedStates[4] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                  .onClick(() => {
                    this.clickedStates[4] = !this.clickedStates[4]
                  })

                Button('腰部')
                  .width(104)
                  .height(28)
                  .fontSize($r('sys.float.Body_M'))
                  .fontColor(this.clickedStates[5] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                  .borderRadius(14)
                  .backgroundColor(this.clickedStates[5] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                  .onClick(() => {
                    this.clickedStates[5] = !this.clickedStates[5]
                  })
              }
            }
          }
          .alignItems(HorizontalAlign.Start)
          .width(336)
          .visibility(this.selectedValue === 'yes' ? Visibility.Visible : Visibility.Hidden)
        }
        .alignItems(HorizontalAlign.Start)
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
          .onClick(() => RouterUtils.pushPathByName(RouterMap.GUIDE_PAGE_Sports))
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
