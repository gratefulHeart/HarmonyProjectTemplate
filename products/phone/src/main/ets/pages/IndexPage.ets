import { CommonConstants } from 'lib_common';
import { HomePageBuilder } from 'home';
import { MinePageBuilder } from 'mine';
import { CoursePageBuilder } from 'course';
import { PlanPageBuilder } from 'plan';
import { CustomTabBar } from '../components/CustomTabBar';
import { IndexPageViewModel } from '../viewmodels/IndexPageVM';
import { TabBarItem, TABS_INFO } from '../common/Constants';

@Builder
export function IndexPageBuilder() {
  IndexPage()
}

@ComponentV2
struct IndexPage {
  @Local vm: IndexPageViewModel = new IndexPageViewModel();
  @Provider() selectedIndex: number = 0;

  @Monitor('selectedIndex')
  onChangeTabIndex() {
    this.vm.tabModel.selectedIndex = this.selectedIndex;
  }

  build() {
    NavDestination() {
      Column() {
        Tabs({ index: $$this.selectedIndex }) {
          TabContent() {
            HomePageBuilder()
          }
          .tabBar(this.tabBuilder(TABS_INFO[0]))

          TabContent() {
            CoursePageBuilder()
          }
          .tabBar(this.tabBuilder(TABS_INFO[1]))

          TabContent() {
            PlanPageBuilder()
          }
          .tabBar(this.tabBuilder(TABS_INFO[2]))

          TabContent() {
            MinePageBuilder()
          }
          .tabBar(this.tabBuilder(TABS_INFO[3]))
        }
        .barWidth(this.vm.tabWidth)
        .barHeight(this.vm.tabHeight)
        .vertical(this.vm.tabModel.isTabVertical)
        .barPosition(this.vm.barPosition)
        .scrollable(false)
        .divider(this.vm.showDivider)
        .animationDuration(0)
        .onChange((index) => {
          this.selectedIndex = index;
        })
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
      .backgroundColor(this.vm.getBgColor)
      .padding({
        bottom: this.vm.paddingBottom,
      })
    }
    .hideTitleBar(true)
    .onBackPressed(() => {
      return this.vm.onBackPressed();
    })
  }

  @Builder
  tabBuilder(item: TabBarItem) {
    CustomTabBar({ item: item })
      .translate({ x: 0, y: this.vm.translateY })
      .animation({ duration: 200, curve: Curve.EaseInOut })
      .onAreaChange((ov: Area, nv: Area) => {
        this.vm.tabModel.tabHeight = nv.height
      })
  }
}
