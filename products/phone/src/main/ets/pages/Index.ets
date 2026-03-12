import { RouterUtils } from 'lib_common'
import { LoneTakeAnimationsTransition } from 'module_transition';
import { IndexVM } from '../viewmodels/IndexVM';

@Entry
@ComponentV2
struct Index {
  vm: IndexVM = new IndexVM();
  @Local isEnabled: boolean = true;
  aboutToAppear(): void {
    this.vm.setInterception();
    this.vm.redirect();
    this.vm.navDestinationListener()
    this.vm.windowStageEventListener()
    this.vm.registerBreakpointListener(this.getUIContext());
    this.vm.displayOrientationListener()
  }

  aboutToDisappear(): void {
    this.vm.unregisterBreakpointListener();
  }

  build() {
    Navigation(RouterUtils.getStack()) {
    }
    .hideNavBar(true)
    .enabled(this.isEnabled)
    .hideTitleBar(true)
    .customNavContentTransition((from: NavContentInfo, to: NavContentInfo, operation: NavigationOperation) => {
      return LoneTakeAnimationsTransition.customNavContentTransition(from, to, operation, {
        // 自定义转场过程中禁用手势，避免出现体验问题
        onTransitionStart: () => {
          this.isEnabled = false;
        },
        onTransitionEnd: () => {
          this.isEnabled = true;
        }
      });
    })
  }
}