import { CommonConstants, RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { GuidePageVM } from '../viewmodels/GuidePageVM';

@Builder
export function GuidePageBodyBuilder() {
  GuidePage()
}

@ComponentV2
struct GuidePage {
  vm: GuidePageVM = new GuidePageVM();
  @Local clickedStates: boolean[] = [false, false, false, false, false, false];
  @Local body: string[] = []

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
          Text('您想锻炼的部位？')
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
              .fontSize($r('sys.float.Body_S'))
              .fontColor($r('sys.color.font_secondary'))
          }
        }
        .margin({ bottom: 47 })
        .alignItems(HorizontalAlign.Start)
        .width(328)

        Column() {
          Row({ space: CommonConstants.SPACE_S }) {
            Image($r('app.media.body'))
              .width(189)
              .draggable(false)
              .margin({ left: 16, right: 14 })
            Column() {
              Button('全身')
                .width(120)
                .height(40)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[0] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .borderRadius(20)
                .backgroundColor(this.clickedStates[0] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                .onClick(() => {
                  this.clickedStates[0] = !this.clickedStates[0]
                  if (this.body.includes('全身')) {
                    const index = this.body.findIndex(item => item === '全身');
                    this.body.splice(index, 1);
                  } else {
                    this.body.push('全身');
                  }
                })
                .margin({ bottom: CommonConstants.PADDING_M })
              Button('手臂')
                .width(120)
                .height(40)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[1] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .borderRadius(20)
                .backgroundColor(this.clickedStates[1] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                .onClick(() => {
                  this.clickedStates[1] = !this.clickedStates[1]
                  if (this.body.includes('手臂')) {
                    const index = this.body.findIndex(item => item === '手臂');
                    this.body.splice(index, 1);
                  } else {
                    this.body.push('手臂');
                  }
                })
                .margin({ bottom: CommonConstants.PADDING_M })
              Button('胸肌')
                .width(120)
                .height(40)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[2] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .borderRadius(20)
                .backgroundColor(this.clickedStates[2] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                .onClick(() => {
                  this.clickedStates[2] = !this.clickedStates[2]
                  if (this.body.includes('胸肌')) {
                    const index = this.body.findIndex(item => item === '胸肌');
                    this.body.splice(index, 1);
                  } else {
                    this.body.push('胸肌');
                  }
                })
                .margin({ bottom: CommonConstants.PADDING_M })
              Button('腹部')
                .width(120)
                .height(40)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[3] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .borderRadius(20)
                .backgroundColor(this.clickedStates[3] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                .onClick(() => {
                  this.clickedStates[3] = !this.clickedStates[3]
                  if (this.body.includes('腹部')) {
                    const index = this.body.findIndex(item => item === '腹部');
                    this.body.splice(index, 1);
                  } else {
                    this.body.push('腹部');
                  }
                })
                .margin({ bottom: CommonConstants.PADDING_M })
              Button('背部')
                .width(120)
                .height(40)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[4] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .borderRadius(20)
                .backgroundColor(this.clickedStates[4] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                .onClick(() => {
                  this.clickedStates[4] = !this.clickedStates[4]
                  if (this.body.includes('背部')) {
                    const index = this.body.findIndex(item => item === '背部');
                    this.body.splice(index, 1);
                  } else {
                    this.body.push('背部');
                  }
                })
                .margin({ bottom: CommonConstants.PADDING_M })
              Button('腿部')
                .width(120)
                .height(40)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.clickedStates[5] ? Color.White : 'rgba(0, 0, 0, 0.9)')
                .borderRadius(20)
                .backgroundColor(this.clickedStates[5] ? $r('app.color.app_theme') : $r('sys.color.comp_background_tertiary'))
                .onClick(() => {
                  this.clickedStates[5] = !this.clickedStates[5]
                  if (this.body.includes('腿部')) {
                    const index = this.body.findIndex(item => item === '腿部');
                    this.body.splice(index, 1);
                  } else {
                    this.body.push('腿部');
                  }
                })
                .margin({ bottom: CommonConstants.PADDING_M })
            }
            .width(120)
            .height(300)
          }
        }
        .width(336)
        .margin({ left: 16, right: 16 })
      }
      .height('60%')
      .width(336)

      Column() {
        // 只在非第一页显示下一步按钮
        Button('下一步', { type: ButtonType.Capsule })
          .width(328)
          .height(40)
          .fontColor($r('sys.color.font_on_primary'))
          .backgroundColor($r('app.color.app_theme'))
          .onClick(() => {
            this.vm.saveBody(this.body); // 调用ViewModel保存数据
            RouterUtils.pushPathByName(RouterMap.GUIDE_PAGE_Injury)
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
