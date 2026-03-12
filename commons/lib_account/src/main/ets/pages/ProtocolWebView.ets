import { AppStorageV2 } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import { BreakpointModel, CommonConstants, GridRowColSetting, WindowModel } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { ProtocolRouterParams } from '../constants/Types';

@Builder
export function ProtocolWebViewBuilder() {
  ProtocolWebView()
}

@ComponentV2
struct ProtocolWebView {
  @Local content: string = '';
  @Local isSheet: boolean = false;
  windowModel: WindowModel = AppStorageV2.connect(WindowModel, () => new WindowModel())!;
  breakPointModel: BreakpointModel = AppStorageV2.connect(BreakpointModel, () => new BreakpointModel())!;
  webViewController: webview.WebviewController = new webview.WebviewController();
  stack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          customPadding: {
            left: 0,
            right: 0,
            top: this.isSheet ? CommonConstants.PADDING_S : undefined,
          },
          onBack: () => {
            this.stack.pop(true);
          },
        })
        if (this.isSheet) {
          this.coreInfo()
        } else {
          GridRow(GridRowColSetting.DEFAULT_GRID_ROW_OPTIONS) {
            GridCol({
              span: GridRowColSetting.DEFAULT_CENTER_COL_SPAN,
              offset: GridRowColSetting.DEFAULT_CENTER_COL_OFFSET,
            }) {
              this.coreInfo()
            }
          }
          .layoutWeight(1)
        }
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
      .backgroundColor($r('sys.color.background_secondary'))
      .padding({
        left: this.breakPointModel.pagePadding,
        right: this.breakPointModel.pagePadding,
        bottom: this.windowModel.windowBottomPadding,
      })
    }
    .hideTitleBar(true)
    .onReady((context) => {
      this.stack = context.pathStack;
      const params = context.pathInfo.param as ProtocolRouterParams;
      if (params) {
        this.content = params.content;
        this.isSheet = params.isSheet ?? false;
      }
    })
  }

  @Builder
  coreInfo() {
    Web({
      src: '',
      controller: this.webViewController,
    })
      .fileAccess(false)
      .geolocationAccess(false)
      .darkMode(WebDarkMode.Auto)
      .forceDarkAccess(true)
      .verticalScrollBarAccess(false)
      .backgroundColor($r('sys.color.background_secondary'))
      .layoutWeight(1)
      .onControllerAttached(() => {
        setTimeout(() => {
          this.webViewController.loadData(
            this.content,
            'text/html',
            'UTF-8',
            '',
            '',
          );
        }, 100)
      })
  }
}
