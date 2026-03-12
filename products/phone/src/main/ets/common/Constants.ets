import { RouterMap } from 'lib_common';

export interface TabBarItem {
  id: TabBarType;
  title: ResourceStr;
  activeIcon: ResourceStr;
}

export enum TabBarType {
  HOME = 0,
  COURSE,
  PLAN,
  MINE
}

export const TABS_INFO: TabBarItem[] = [
  {
    id: TabBarType.HOME,
    title: '首页',
    activeIcon: $r('app.media.ic_tab_home'),
  },
  {
    id: TabBarType.COURSE,
    title: '发现',
    activeIcon: $r('app.media.ic_tab_course'),
  },
  {
    id: TabBarType.PLAN,
    title: '清单',
    activeIcon: $r('app.media.ic_tab_plan'),
  },
  {
    id: TabBarType.MINE,
    title: '我的',
    activeIcon: $r('app.media.ic_tab_mine'),
  },
]

/**
 * 依赖登录的页面列表
 * 模板保留示例配置，可根据实际项目需求添加
 */
export const REQUIRE_LOGIN_PAGE_LIST: RouterMap[] = [
  // 示例：RouterMap.MINE_SETTINGS_PAGE,
];

export const agreePrivacyKey: string = 'isAgreePrivacy';

export const SOURCE_FORM_CARD: string = 'FormCard';

export class PhoneConstants {
  static readonly LEFT_TAB_BAR_WIDTH: number = 96;
  static readonly LEFT_TAB_BAR_ITEM_HEIGHT: number = 100;
  static readonly BOTTOM_TAB_BAR_HEIGHT: number = 52;
}
