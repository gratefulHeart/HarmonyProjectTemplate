import { RouterMap } from '../constants/RouterMap';
import { Logger } from './Logger';

const TAG: string = '[RouterModule]';

interface NavRouterInfo {
  url: string; // 跳转路由名
  mode?: NavDestinationMode; // NavDestination类型
  param?: Object; // 传递参数
  onPop?: Callback<PopInfo>; // 回调事件
}

class RouterModule {
  static stack: NavPathStack = new NavPathStack();

  static getStack() {
    return RouterModule.stack;
  }

  static push(info: NavRouterInfo, animated?: boolean) {
    try {
      RouterModule.stack.pushPathByName(info.url, info.param, info.onPop, animated);
    } catch (err) {
      Logger.error(TAG, 'navigation stack push failed::' + JSON.stringify(err));
    }
  }

  // 页面替换(指定页面)
  public static replace(info: NavRouterInfo) {
    try {
      RouterModule.stack.replacePathByName(info.url, info.param);
    } catch (err) {
      Logger.error(TAG, 'navigation stack replace failed::' + JSON.stringify(err));
    }
  }

  // 页面回退(上个页面)
  public static pop<T = boolean>(result?: T, animated?: boolean) {
    try {
      RouterModule.stack.pop(result, animated);
    } catch (err) {
      Logger.error(TAG, 'navigation stack pop failed::' + JSON.stringify(err));
    }
  }

  // 页面回退(携带参数)
  public static popWithRes(res: ESObject, animated?: boolean) {
    try {
      RouterModule.stack.pop(res, animated);
    } catch (err) {
      Logger.error(TAG, 'navigation stack pop failed::' + JSON.stringify(err));
    }
  }

  // 页面回退(至对应页面名)
  public static popToName(name: string, animated?: boolean) {
    try {
      RouterModule.stack.popToName(name, animated);
    } catch (err) {
      Logger.error(TAG, 'navigation stack pop to name failed::' + JSON.stringify(err));
    }
  }

  // 页面栈清空(回Navigation)
  public static clear(animated?: boolean) {
    try {
      RouterModule.stack.clear(animated);
    } catch (err) {
      Logger.error(TAG, 'navigation stack clear failed::' + JSON.stringify(err));
    }
  }

  // 获取页面栈大小
  public static size(): number {
    return RouterModule.stack.size();
  }

  // 获取参数(指定页面)
  public static getNavParam<T = Object>(info: NavRouterInfo): T | undefined {
    try {
      const paramsArr = RouterModule.stack.getParamByName(info.url) as T[] | undefined[];
      return paramsArr.pop();
    } catch (err) {
      Logger.error(TAG, 'navigation stack get params failed::' + JSON.stringify(err));
    }
    return undefined;
  }
}

export { NavRouterInfo, RouterModule, RouterMap }