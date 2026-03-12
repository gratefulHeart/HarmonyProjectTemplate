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
    title: '课程',
    activeIcon: $r('app.media.ic_tab_course'),
  },
  {
    id: TabBarType.PLAN,
    title: '计划',
    activeIcon: $r('app.media.ic_tab_plan'),
  },
  {
    id: TabBarType.MINE,
    title: '我的',
    activeIcon: $r('app.media.ic_tab_mine'),
  },
]

/**
 * 依赖登录的页面
 */
export const REQUIRE_LOGIN_PAGE_LIST: RouterMap[] = [
  RouterMap.MINE_MARK_PAGE,
  RouterMap.FEEDBACK_PAGE,
  RouterMap.MINE_HISTORY_PAGE,
  RouterMap.VIP_PAGE,
  RouterMap.RECORD_PAGE
];

export const agreePrivacyKey: string = 'isAgreePrivacy';

export const SOURCE_FORM_CARD: string = 'FormCard';

export const skipGuide: string = 'isSkipGuide';

export class PhoneConstants {
  static readonly LEFT_TAB_BAR_WIDTH: number = 96;
  static readonly LEFT_TAB_BAR_ITEM_HEIGHT: number = 100;
  static readonly BOTTOM_TAB_BAR_HEIGHT: number = 52;
}
