import { MoreItem } from '../models/Type';
import { PlayerVM } from '../viewModels/PlayerVM';

@ComponentV2
export struct FullScreenMore {
  @Local playerVM: PlayerVM = PlayerVM.instance;
  @Param moreItemEvent: (item: string) => void = () => {
  }

  build() {
    Column() {
      Text('更多')
        .fontSize($r('sys.float.Title_S'))
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })
      Column() {
        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.Start,
          wrap: FlexWrap.Wrap,
        }) {
          ForEach(this.playerVM.moreItemList, (item: MoreItem) => {
            Column() {
              Image(item.icon)
                .width(32)
                .height(32)
                .margin({ bottom: 2, top: 4 })
              Text(item.label)
                .fontSize(12)
                .fontColor('#fff')
                .fontWeight(500)
                .textAlign(TextAlign.Center)
                .margin({ bottom: 4 })
            }
            .width(82)
            .height(58)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.moreItemEvent(item.label)
            })
          }, (item: MoreItem) => JSON.stringify(item))
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 12, right: 12 })
  }
}