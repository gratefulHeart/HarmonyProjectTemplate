import { CommonConstants, GridRowColSetting } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { SettingCard } from '../components/SettingCard';
import { SettingNetworkVM } from '../viewmodels/SettingNetworkVM';

@Builder
export function SettingNetworkBuilder() {
  SettingNetwork()
}

@ComponentV2
struct SettingNetwork {
  @Local vm: SettingNetworkVM = new SettingNetworkVM();

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '播放与网络设置',
        })
        GridRow(GridRowColSetting.DEFAULT_GRID_ROW_OPTIONS) {
          GridCol({
            span: GridRowColSetting.DEFAULT_CENTER_COL_SPAN,
            offset: GridRowColSetting.DEFAULT_CENTER_COL_OFFSET,
          }) {
            Scroll() {
              Column({ space: CommonConstants.SPACE_M }) {
                Text('网络设置')
                  .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
                  .fontColor($r('sys.color.font_primary'))
                  .fontWeight(FontWeight.Medium)
                SettingCard({ list: this.vm.list1 })
                Text('视频播放设置')
                  .fontSize(16 * this.vm.settingInfo.fontSizeRatio)
                  .fontColor($r('sys.color.font_primary'))
                  .fontWeight(FontWeight.Medium)
                SettingCard({ list: this.vm.list2 })
              }
              .alignItems(HorizontalAlign.Start)
              .padding({
                left: this.vm.breakPointModel.pagePadding,
                right: this.vm.breakPointModel.pagePadding,
                top: CommonConstants.PADDING_M,
                bottom: this.vm.windowModel.windowBottomPadding,
              })
            }
            .layoutWeight(1)
            .scrollBar(BarState.Off)
            .align(Alignment.Top)
            .edgeEffect(EdgeEffect.Spring)
          }
        }
        .layoutWeight(1)
      }
      .width(CommonConstants.FULL_PERCENT)
      .height(CommonConstants.FULL_PERCENT)
    }
    .hideTitleBar(true)
    .backgroundColor($r('sys.color.background_secondary'))
  }
}