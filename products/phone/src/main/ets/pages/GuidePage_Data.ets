import { CommonConstants, RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { GuidePageVM } from '../viewmodels/GuidePageVM';
import { promptAction } from '@kit.ArkUI';

@Builder
export function GuidePageDataBuilder() {
  GuidePage()
}

@ComponentV2
struct GuidePage {
  vm: GuidePageVM = new GuidePageVM();
  @Local dataHeight: string = '';
  @Local dataWeight: string = '';

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

  inputBodyData() {
    if (Number.parseFloat(this.dataWeight) < 30 || Number.parseFloat(this.dataWeight) > 300) {
      promptAction.showToast({ message: '体重需要在30-300kg之间' });
      return
    }
    if (Number.parseFloat(this.dataHeight) < 100 || Number.parseFloat(this.dataHeight) > 250) {
      promptAction.showToast({ message: '身高需要在100-250cm之间' });
      return
    }
    this.vm.saveWeight(this.dataWeight); // 调用ViewModel保存数据
    this.vm.saveHeight(this.dataHeight); // 调用ViewModel保存数据
    RouterUtils.pushPathByName(RouterMap.GUIDE_PAGE_Target)
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
          Text('您的身体基本数据？')
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
        .alignItems(HorizontalAlign.Start)
        .width(328)

        Column() {
          Text('您的身高')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .margin({
              bottom: 12,
            })
          TextInput({
            placeholder: '请在此输入您的身高                    (cm)',
            text: this.dataHeight // 绑定状态变量
          })
            .type(InputType.Number)
            .onChange((value: string) => { // 监听输入变化
              this.dataHeight = value.replace(/[^0-9]/g, '') // 过滤非数字字符
            })
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .margin({
              bottom: 24,
            })
          Text('您的体重')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .margin({
              bottom: 12,
            })
          TextInput({
            placeholder: '请在此输入您的体重                    (kg)',
            text: this.dataWeight // 绑定状态变量
          })
            .type(InputType.Number)
            .onChange((value: string) => { // 监听输入变化
              this.dataWeight = value.replace(/[^0-9]/g, '') // 过滤非数字字符
            })
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .margin({
              bottom: 40,
            })
        }
        .alignItems(HorizontalAlign.Start)
        .width(328)
        .margin({ left: 16, right: 16, top: 40 })
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
            this.inputBodyData()
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
