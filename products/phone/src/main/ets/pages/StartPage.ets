import { CommonConstants, PreferenceUtils, RouterMap, RouterUtils } from 'lib_common';
import { agreePrivacyKey } from '../common/Constants';

@Builder
export function StartPageBuilder() {
  StartPage()
}

@ComponentV2
struct StartPage {
  isAgreePrivacy() {
    return PreferenceUtils.getInstance().get(agreePrivacyKey) as boolean;
  }

  aboutToAppear(): void {
    setTimeout(() => {
      if (this.isAgreePrivacy()) {
        // 已同意隐私协议，直接跳转到 Tab 首页
        RouterUtils.replacePathByName(RouterMap.INDEX_PAGE);
      } else {
        // 未同意隐私协议，跳转到安全协议页
        RouterUtils.replacePathByName(RouterMap.SAFE_PAGE);
      }
    }, 500)
  }

  build() {
    NavDestination() {
      Stack() {
        Column() {
          Image($r('app.media.startIcon'))
            .width(116)
            .height(116)
            .draggable(false)
            .margin({ top: 215, bottom: 258 })
          Text('应用名称')
            .fontSize($r('sys.float.Title_M'))
            .fontWeight(FontWeight.Medium)
            .fontColor('rgb(92, 121, 217)')
            .height(32)
          Text('应用 slogan')
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Regular)
            .fontColor('rgba(92, 121, 217, 0.8)')
            .height(21)
        }
        .height(CommonConstants.FULL_PERCENT)
        .width(CommonConstants.FULL_PERCENT)
        .backgroundImage($r('app.media.ic_start_background'))
        .backgroundImageSize({ width: '100%', height: '100%' })
      }
    }
    .hideTitleBar(true)
  }
}
