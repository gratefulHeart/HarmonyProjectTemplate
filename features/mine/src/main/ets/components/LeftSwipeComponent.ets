import { DeleteDialog } from '../viewmodels/DeleteDialog';

@ComponentV2
export struct LeftSwipeComponent {
  @Consumer() swipeIndex: number = 0;
  @Require @Param index: number;
  // 弹框内容
  @Param dialogContent: string = '';
  // 确认左滑删除
  @Event confirmLeftSwipeDelete: () => void = () => {
  };
  // 删除弹框
  deleteDialogController: CustomDialogController = new CustomDialogController({
    builder: DeleteDialog({
      content: this.dialogContent,
      confirmDelete: () => {
        this.confirmLeftSwipeDelete()
      }
    }),
  });

  build() {
    Row() {
      Image($r('app.media.icon_delete_red'))
        .height(40)
        .width(40)
        .margin({ left: 12 })
        .onClick(() => {
          this.swipeIndex = this.index
          this.deleteDialogController.open()
        })
    }
    .padding(4)
    .justifyContent(FlexAlign.SpaceEvenly)
    .height('100%')
  }
}
 