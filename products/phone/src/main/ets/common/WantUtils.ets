import { AbilityConstant, Want } from '@kit.AbilityKit';
import { AppStorageV2 } from '@kit.ArkUI';
import { BreakpointNameEnum, ContinueModel, Logger } from 'lib_common';
import { SOURCE_FORM_CARD } from './Constants';
import { FormCardRouter } from './Types';

const TAG = '[WantUtils]';

/**
 * 应用want处理工具类
 */
export class WantUtils {
  /**
   * 服务卡片事件处理
   * @param want
   */
  public static handleFormCardCall(want: Want) {
    if (want?.parameters?.source === SOURCE_FORM_CARD) {
      const formCardRouter: FormCardRouter =
        AppStorageV2.connect(FormCardRouter, () => new FormCardRouter())!;
      formCardRouter.id = new Date().getTime();
      formCardRouter.pageUrl = want?.parameters?.pageUrl as string ?? '';
      formCardRouter.newsId = want?.parameters?.newsId as string ?? '';
      formCardRouter.newsType = want?.parameters?.newsType as number ?? 0;
    }
  }

  /**
   * 接续事件处理
   * @param want
   * @param launchParam
   */
  public static handleRestoreCall(want: Want, launchParam: AbilityConstant.LaunchParam) {
    if (launchParam.launchReason === AbilityConstant.LaunchReason.CONTINUATION) {
      Logger.info(TAG, 'launchParam.launchReason: CONTINUATION');
      // 将上述的保存的数据取出恢复
      if (want.parameters !== undefined) {
        const continueRouter: ContinueModel = AppStorageV2.connect(ContinueModel, () => new ContinueModel())!;
        continueRouter.id = new Date().getTime();
        continueRouter.newsId = want.parameters?.newsId as string ?? '';
        continueRouter.playerProgress = want.parameters?.playerProgress as number ?? 0;
        continueRouter.scrollOffset = want.parameters?.scrollOffset as number ?? 0;
        continueRouter.breakpoint = want.parameters?.breakpoint as string ?? BreakpointNameEnum.SM;
        continueRouter.isTargetDevice = true;
        Logger.info(TAG, `launch continue, want parameters: ${JSON.stringify(continueRouter)}`);
      }
    }
  }
}