import { AppStorageV2 } from '@kit.ArkUI';
import { BreakpointModel, CommonConstants, RouterUtils, WindowModel } from 'lib_common';

/**
 * 通用页面标题栏
 */
@ComponentV2
export struct NavHeaderBar {
  @Param title: ResourceStr = '';
  @Param showBackBtn: boolean = false;
  @Param bgColor: ResourceColor = '#00000000';
  @Param backImg: ResourceStr = $r('app.media.ic_back');
  @Param isSubTitle: boolean = true;
  @Param customPadding: Padding = {};
  @BuilderParam rightPartBuilder: () => void;
  // 自定义返回事件
  @Event onBack: () => void = () => {
    RouterUtils.pop()
  };
  @Local windowModel: WindowModel = AppStorageV2.connect(WindowModel, () => new WindowModel())!;
  @Local breakPointModel: BreakpointModel = AppStorageV2.connect(BreakpointModel, () => new BreakpointModel())!;
  @Consumer() isCommentInModalDialog: boolean = false

  build() {
    Row() {
      Row() {
        Row() {
          // 显示返回按钮：主动设置或者二级标题
          if (this.showBackBtn || this.isSubTitle) {
            Row() {
              Image(this.backImg)
                .width($r('app.float.head_icon_width'))
                .aspectRatio(1)
                .draggable(false)
                .borderRadius(CommonConstants.HALF_PERCENT)
                .stateStyles({
                  normal: { .backgroundColor(Color.Transparent)
                  },
                  pressed: { .backgroundColor($r('sys.color.interactive_pressed'))
                  },
                })
            }
            .accessibilityText('返回按钮')
            .onClick(() => {
              this.onBack();
            })
          }
          if (this.title) {
            Text(this.title)
              .fontSize(this.isSubTitle ? $r('sys.float.Title_S') : $r('sys.float.Title_M'))
              .fontColor($r('sys.color.font_primary'))
              .fontWeight(FontWeight.Bold)
              .margin({ left: CommonConstants.SPACE_S })
              .id('nav_title')
          }
        }

        if (this.rightPartBuilder) {
          this.rightPartBuilder()
        }
      }
      .height($r('app.float.nav_header_height'))
      .justifyContent(FlexAlign.SpaceBetween)
      .width(CommonConstants.FULL_PERCENT)
    }
    .padding({
      left: this.customPadding.left ?? this.breakPointModel.pagePadding,
      right: this.customPadding.right ?? this.breakPointModel.pagePadding,
      top: this.customPadding.top ?? (this.isCommentInModalDialog ? CommonConstants.PADDING_S :
      this.windowModel.windowTopPadding),
      bottom: this.customPadding.bottom ?? 0,
    })
    .width(CommonConstants.FULL_PERCENT)
    .backgroundColor(this.bgColor)
  }
}