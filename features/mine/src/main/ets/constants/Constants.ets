import { RouterMap } from 'lib_common';
import { MineGridItem } from '../types/Types';

export const mineGridList: MineGridItem[] = [
  {
    icon: $r('app.media.ic_grid_star'),
    label: '我的收藏',
    routerName: RouterMap.MINE_MARK_PAGE,
  },
  {
    icon: $r('app.media.ic_grid_trace'),
    label: '我的足迹',
    routerName: RouterMap.MINE_HISTORY_PAGE,
  },
  {
    icon: $r('app.media.ic_grid_public'),
    label: '意见反馈',
    routerName: RouterMap.FEEDBACK_PAGE,
  },
  {
    icon: $r('app.media.ic_grid_setting'),
    label: '设置',
    routerName: RouterMap.SETTING_PAGE,
  },
];

/**
 * 离线WebID映射表
 */
export enum WebIdMap {
  ChatWebId = 'webId1',
}

export class Constants {
  public static readonly NEWS_IMAGE_WIDTH: number = 96;
  public static readonly NEWS_IMAGE_HEIGHT: number = 72;
  public static readonly NORMAL_BTN_H: number = 40;
  public static readonly SMALL_BTN_W: number = 72;
  public static readonly SMALL_BTN_H: number = 28;
}
