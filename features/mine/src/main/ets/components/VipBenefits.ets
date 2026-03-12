import { BaseCell } from '../components/BaseCell';
import { getDataFromJSON } from '../utils/Utils'
import { Benefits } from '../model/Model';

@ComponentV2
export struct VipBenefits {
  @Local benefitsList: Benefits[] = []

  aboutToAppear(): void {
    this.benefitsList = getDataFromJSON<Benefits>('Vip_Benefits.json', this);
  }

  @Builder
  vipBenefits() {
    Column() {
      Row({ space: 8 }) {
        Image($r('app.media.no_ad'))
          .width(40)
          .height(40)
        Column() {
          Text('免广告')
            .fontSize($r('sys.float.Body_M'))
            .margin({ bottom: 4 })
          Text('去除所有训练教学视频的广告')
            .fontSize($r('sys.float.Body_S'))
            .fontColor('rgba(0, 0, 0, 0.6)')
        }
        .height(40)
        .alignItems(HorizontalAlign.Start)
      }
      .width(328)
      .height(64)
      .padding(12)

      Row({ space: 8 }) {
        Image($r('app.media.video'))
          .width(40)
          .height(40)
        Column() {
          Text('更多专业教学视频')
            .fontSize($r('sys.float.Body_M'))
            .margin({ bottom: 4 })
          Text('专属于你的私人教练')
            .fontSize($r('sys.float.Body_S'))
            .fontColor('rgba(0, 0, 0, 0.6)')
        }
        .height(40)
        .alignItems(HorizontalAlign.Start)
      }
      .width(328)
      .height(60)
      .padding({ top: 8, left: 12, right: 12, bottom: 8 })

      Row({ space: 8 }) {
        Image($r('app.media.icon_course'))
          .width(40)
          .height(40)
        Column() {
          Text('专属定制课程')
            .fontSize($r('sys.float.Body_M'))
            .margin({ bottom: 4 })
          Text('量身定制的训练，使你事半功倍')
            .fontSize($r('sys.float.Body_S'))
            .fontColor('rgba(0, 0, 0, 0.6)')
        }
        .height(40)
        .alignItems(HorizontalAlign.Start)
      }
      .width(328)
      .height(60)
      .padding({ top: 8, left: 12, right: 12, bottom: 8 })
    }
    .width('100%')
    .height(192)
    .border({
      width: 1,
      color: '#E39331',
    })
    .margin({ top: 16 })
    .borderRadius(12)
  }

  build() {
    Column() {
      BaseCell({
        cellTitle: '会员权益',
        customBuilderParam: () => this.vipBenefits(),
      })
    }
  }
}