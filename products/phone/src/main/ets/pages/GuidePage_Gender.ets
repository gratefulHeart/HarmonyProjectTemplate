import { CommonConstants, RouterMap, RouterUtils } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { GuidePageVM } from '../viewmodels/GuidePageVM';

@Builder
export function GuidePageGenderBuilder() {
  GuidePage()
}

@ComponentV2
struct GuidePage {
  vm: GuidePageVM = new GuidePageVM();
  @Local gender: string = '';
  @Local selectedValue: string = '' // 记录选中值

  async aboutToAppear() {
    this.selectedValue = ''
    this.gender = ''
  }

  async aboutToDisappear() {
    this.selectedValue = ''
    this.gender = ''
  }

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
          isSubTitle: false,
          rightPartBuilder: () => {
            this.skipBuilder();
          },
        })
      }

      Column() {
        Column() {
          Text('您的性别？')
            .fontSize(30)
            .height(40)
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
        .width(308)

        Row() {
          // 第一列
          Column() {
            Image($r('app.media.ImMan'))
              .width(128)
              .margin({ left:12, bottom: 24 })
              .visibility(this.selectedValue === 'man' ? Visibility.Visible : Visibility.Hidden)

            Image($r('app.media.man'))
              .margin({ bottom: 18 })
              .size({ width: 153, height: 190 })
              .borderRadius(32)

            Radio({
              group: 'genderGroup',
              value: 'man'
            })
              .radioStyle({
              checkedBackgroundColor: $r('app.color.app_theme')
            })
              .checked(this.selectedValue === 'man')
              .onClick(() => {
                this.selectedValue = 'man'
                this.gender = '男';
                this.vm.saveGender(this.gender); // 调用ViewModel保存数据
                RouterUtils.pushPathByName(RouterMap.GUIDE_PAGE_Age)
              })
          }
          .margin({ right: 10 })

          // 第二列
          Column() {
            Image($r('app.media.ImWoman'))
              .width(128)
              .margin({ right:12, bottom: 24 })
              .visibility(this.selectedValue === 'woman' ? Visibility.Visible : Visibility.Hidden)

            Image($r('app.media.woman'))
              .margin({ bottom: 18 })
              .size({ width: 153, height: 190 })
              .borderRadius(32)

            Radio({
              group: 'genderGroup',
              value: 'woman'
            })
              .radioStyle({
                checkedBackgroundColor: $r('app.color.app_theme')
              })
              .checked(this.selectedValue === 'woman')
              .onClick(() => {
                this.selectedValue = 'woman'
                this.gender = '女';
                this.vm.saveGender(this.gender); // 调用ViewModel保存数据
                RouterUtils.pushPathByName(RouterMap.GUIDE_PAGE_Age)
              })
          }
        }
        .width(328)
        .margin({ top: 24 })
      }
      .backgroundColor($r('sys.color.ohos_id_color_background'))
    }
    .hideTitleBar(true)
    .onShown(() => {
      this.selectedValue = ''
      this.gender = ''
    })
  }
}
