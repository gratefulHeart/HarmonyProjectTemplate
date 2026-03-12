import { AlertDialog } from '@kit.ArkUI';

@CustomDialog
export struct DeleteDialog {
  customController: CustomDialogController;
  content: ResourceStr = '';
  confirmDelete: () => void = () => {
  }

  build() {
    AlertDialog({
      content: this.content,
      primaryButton: {
        value: '取消',
        fontColor: $r('sys.color.font_primary'),
        action: () => {
          this.customController.close();
        },
      },
      secondaryButton: {
        value: '删除',
        fontColor: $r('sys.color.warning'),
        action: () => {
          this.confirmDelete();
          this.customController.close();
        }
      },
    })
  }
}
 