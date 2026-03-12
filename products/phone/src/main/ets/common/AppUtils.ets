import { common, ConfigurationConstant } from '@kit.AbilityKit';
import { PersistenceV2, ThemeControl } from '@kit.ArkUI';
import { Logger, SettingModel, SystemBarOperation } from 'lib_common';
import { gAppTheme } from './AppTheme';

const TAG = 'AppUtils';

/**
 * 应用设置工具类
 */
export class AppUtils {
  /**
   * 设置应用主题色
   */
  public static setAppTheme() {
    ThemeControl.setDefaultTheme(gAppTheme);
  }

  /**
   * 设置应用深浅色
   */
  public static setColorMode() {
    Logger.info(TAG, 'setColorMode PersistenceV2 keys: ' + JSON.stringify(PersistenceV2.keys()));
    const context = getContext() as common.UIAbilityContext;
    const settingInfo: SettingModel = PersistenceV2.connect(SettingModel, () => new SettingModel())!;
    const mode = settingInfo.darkSwitch ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK :
    ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT;
    context.getApplicationContext().setColorMode(mode);
    SystemBarOperation.setWindowSystemBarProp({
      statusBarContentColor: settingInfo.darkSwitch ? '#ffffff' : '#ff090909',
    });
  }
}