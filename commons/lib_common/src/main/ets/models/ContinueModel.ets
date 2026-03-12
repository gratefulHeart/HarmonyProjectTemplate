import { BreakpointNameEnum } from '../constants/GridRowColSetting';

/**
 * 自由流转-应用接续模型
 */
@ObservedV2
export class ContinueModel {
  @Trace id: number = 0;
  @Trace newsId: string = '';
  @Trace playerProgress: number = 0;
  @Trace scrollOffset: number = 0;
  @Trace breakpoint: string = BreakpointNameEnum.SM;
  @Trace isTargetDevice: boolean = false;
}