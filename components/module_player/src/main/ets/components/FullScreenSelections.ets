import { MovieItem } from '../models/Type';
import { PlayerVM } from '../viewModels/PlayerVM';

@ComponentV2
export struct FullScreenSelections {
  @Param backClick: () => void = () => {
  }
  @Param selectionEvent: (item: MovieItem) => void = () => {
  }
  @Local playerVM: PlayerVM = PlayerVM.instance;

  build() {
    Column() {
      Row() {
        Image($r('app.media.icon_chevron_backward_dark'))
          .width(40)
          .height(40)
          .margin({ right: 8 })
          .onClick(() => {
            this.backClick()
          })
        Text('选集')
          .fontSize($r('sys.float.Title_S'))
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .margin({ top: 20, bottom: 10 })

      List({ space: 8 }) {
        ForEach(this.playerVM.movieItemList, (item: MovieItem) => {
          ListItem() {
            Column() {
              Text(item.movieTitle)
                .fontSize($r('sys.float.Body_L'))
                .fontColor(this.playerVM.movieItem.movieTitle === item.movieTitle ? '#7C73FF' : '#fff')
                .fontWeight(FontWeight.Regular)
                .textAlign(TextAlign.Center)
            }
            .backgroundColor($r('sys.color.mask_secondary'))
            .width('100%')
            .borderRadius(8)
            .height(50)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              if (this.playerVM.movieItem.movieTitle === item.movieTitle) {
                return
              }
              this.selectionEvent(item)
            })
          }
        }, (item: string) => JSON.stringify(item))
      }
      .padding({ bottom: 10 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 24, right: 24 })
  }
}