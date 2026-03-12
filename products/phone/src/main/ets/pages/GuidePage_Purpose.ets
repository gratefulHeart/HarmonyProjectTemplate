import { CommonConstants, RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { GuidePageVM } from '../viewmodels/GuidePageVM';

@Builder
export function GuidePagePurposeBuilder() {
  GuidePage()
}

@ComponentV2
struct GuidePage {
  vm: GuidePageVM = new GuidePageVM();
  @Local clickedStates: boolean[] = [false, false, false, false, false]
  @Local purpose: string[] = []

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
          Text('您想锻炼的目的？')
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
            Text('信息仅用于制定更好的训练计划，我们将会严格加密！')
              .fontSize($r('sys.float.Body_S'))
              .fontColor($r('sys.color.font_secondary'))
          }
        }
        .margin({ bottom: 24 })
        .alignItems(HorizontalAlign.Start)
        .width(328)

        Column() {
          Stack() {
            Image($r('app.media.purpose1'))
              .width(240)
              .height(80)
              .borderRadius(16) // 可选：设置圆角
              .border({
                width: {
                  left: 2,
                  right: 2,
                  top: 2,
                  bottom: 2
                }, // 设置四边宽度
                color: this.clickedStates[0] ? $r('app.color.app_theme') :
                  $r('sys.color.ohos_id_color_background')     // 动态颜色绑定
              })
            Column() {
              Text('增肌塑形')  // 主标题
                .fontSize($r('sys.float.Body_L'))
                .width(72)
                .position({ left: 144, top: 29 })
                .fontColor('rgba(237, 111, 33, 1)')
            }
          }
        }
        .onClick(() => {
          this.clickedStates[0] = !this.clickedStates[0]
          if (this.purpose.includes('增肌塑形')) {
            const index = this.purpose.findIndex(item => item === '增肌塑形');
            this.purpose.splice(index, 1);
          } else {
            this.purpose.push('增肌塑形');
          }
        })

        Column() {
          Stack() {
            Image($r('app.media.purpose2'))
              .width(240)
              .height(80)
              .borderRadius(16) // 可选：设置圆角
              .border({
                width: {
                  left: 2,
                  right: 2,
                  top: 2,
                  bottom: 2
                }, // 设置四边宽度
                color: this.clickedStates[1] ? $r('app.color.app_theme') :
                  $r('sys.color.ohos_id_color_background')     // 动态颜色绑定
              })
            Column() {
              Text('减重瘦身')  // 主标题
                .fontSize($r('sys.float.Body_L'))
                .width(72)
                .position({ left: 144, top: 29 })
                .fontColor('rgba(237, 111, 33, 1)')
            }
          }
        }
        .onClick(() => {
          this.clickedStates[1] = !this.clickedStates[1]
          if (this.purpose.includes('减重瘦身')) {
            const index = this.purpose.findIndex(item => item === '减重瘦身');
            this.purpose.splice(index, 1);
          } else {
            this.purpose.push('减重瘦身');
          }
        })

        Column() {
          Stack() {
            Image($r('app.media.purpose3'))
              .width(240)
              .height(80)
              .borderRadius(16) // 可选：设置圆角
              .border({
                width: {
                  left: 2,
                  right: 2,
                  top: 2,
                  bottom: 2
                }, // 设置四边宽度
                color: this.clickedStates[2] ? $r('app.color.app_theme') :
                  $r('sys.color.ohos_id_color_background')     // 动态颜色绑定
              })
            Column() {
              Text('保持健康')  // 主标题
                .fontSize($r('sys.float.Body_L'))
                .width(72)
                .position({ left: 144, top: 29 })
                .fontColor('rgba(237, 111, 33, 1)')
            }
          }
        }
        .onClick(() => {
          this.clickedStates[2] = !this.clickedStates[2]
          if (this.purpose.includes('保持健康')) {
            const index = this.purpose.findIndex(item => item === '保持健康');
            this.purpose.splice(index, 1);
          } else {
            this.purpose.push('保持健康');
          }
        })

        Column() {
          Stack() {
            Image($r('app.media.purpose4'))
              .width(240)
              .height(80)
              .borderRadius(16) // 可选：设置圆角
              .border({
                width: {
                  left: 2,
                  right: 2,
                  top: 2,
                  bottom: 2
                }, // 设置四边宽度
                color: this.clickedStates[3] ? $r('app.color.app_theme') :
                  $r('sys.color.ohos_id_color_background')     // 动态颜色绑定
              })
            Column() {
              Text('增强身体素质')  // 主标题
                .fontSize($r('sys.float.Body_L'))
                .width(72)
                .position({ left: 144, top: 29 })
                .fontColor('rgba(237, 111, 33, 1)')
            }
          }
        }
        .onClick(() => {
          this.clickedStates[3] = !this.clickedStates[3]
          if (this.purpose.includes('增强身体素质')) {
            const index = this.purpose.findIndex(item => item === '增强身体素质');
            this.purpose.splice(index, 1);
          } else {
            this.purpose.push('增强身体素质');
          }
        })

        Column() {
          Stack() {
            Image($r('app.media.purpose5'))
              .width(240)
              .height(80)
              .borderRadius(16) // 可选：设置圆角
              .border({
                width: {
                  left: 2,
                  right: 2,
                  top: 2,
                  bottom: 2
                }, // 设置四边宽度
                color: this.clickedStates[4] ? $r('app.color.app_theme') :
                  $r('sys.color.ohos_id_color_background')     // 动态颜色绑定
              })
            Column() {
              Text('随便练练')  // 主标题
                .fontSize($r('sys.float.Body_L'))
                .width(72)
                .position({ left: 144, top: 29 })
                .fontColor('rgba(237, 111, 33, 1)')
            }
          }
        }
        .onClick(() => {
          this.clickedStates[4] = !this.clickedStates[4]
          if (this.purpose.includes('随便练练')) {
            const index = this.purpose.findIndex(item => item === '随便练练');
            this.purpose.splice(index, 1);
          } else {
            this.purpose.push('随便练练');
          }
        })
      }
      .width(328)
      .height('60%')

      Column() {
        // 只在非第一页显示下一步按钮
        Button('下一步', { type: ButtonType.Capsule })
          .width(328)
          .height(40)
          .fontColor($r('sys.color.font_on_primary'))
          .backgroundColor($r('app.color.app_theme'))
          .onClick(() => {
            this.vm.savePurpose(this.purpose); // 调用ViewModel保存数据
            RouterUtils.pushPathByName(RouterMap.GUIDE_PAGE_Body)
          })
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
