import { NavHeaderBar } from 'lib_widget';
import { CommonKnowledgePageVM } from '../viewmodels/CommonKnowledgePageVM';

@Builder
export function CommonKnowledgeDrawPageBuilder() {
  CommonKnowledgeDrawPage()
}

AppStorage.setOrCreate<boolean>('0013', false)

@ComponentV2
struct CommonKnowledgeDrawPage {
  scroller: Scroller = new Scroller()
  vm: CommonKnowledgePageVM = new CommonKnowledgePageVM();
  @Local isStar: boolean = AppStorage.get('0013') as boolean
  @Local label: string = '你知道如何在跑后有效拉伸吗？'

  async aboutToAppear() {
    this.vm.addHistory(this.label)
  }

  @Builder
  starBuilder() {
    Image(this.isStar ? $r('app.media.star') : $r('app.media.no_star'))
      .width(40)
      .height(40)
      .onClick(() => {
        if (!this.isStar) {
          if (this.vm.saveAction(this.label)) {
            this.isStar = !this.isStar;
            AppStorage.setOrCreate<boolean>('0013', this.isStar)
          }
        } else {
          if (this.vm.deleteAction(this.label)) {
            this.isStar = !this.isStar;
            AppStorage.setOrCreate<boolean>('0013', this.isStar)
          }
        }
      })
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '详情',
          rightPartBuilder: () => {
            this.starBuilder();
          },
        })

        Scroll(this.scroller) {
          Column() {
            Column() {
              Text('你知道如何在跑后有效拉伸吗？')
                .fontWeight(FontWeight.Medium)
                .fontSize(20)
            }
            .width(328)
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 16, bottom: 13 })

            Column() {
              Text('拉伸，是放松紧绷肌肉以及维持或提高灵活性的重要方式。根据此前的研究结果表明，拉伸可以提高肌肉灵活性，从而带来一系列好处，包括提高锻炼表现、降低受伤风险以及提高完成日常训练项目的能力。')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))

              Image($r('app.media.common_knowledge4'))
                .width(328)
                .height(220)
                .borderRadius(16)
                .margin({ top: 16, bottom: 16 })

              Column() {
                Text('跑步后有效拉伸的关键在于针对性动作和规范操作，以下是具体建议：')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                Blank()
                Text('核心拉伸动作')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('1、大腿后侧拉伸')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('站立，一脚弯曲置于另一腿后方，保持背部直立，身体前倾至大腿后侧有轻微拉伸感，保持15-30秒，每侧重复2-3次。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('2、小腿拉伸')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('面对墙壁站立，一脚向前迈出，前脚掌贴墙，后腿伸直脚跟贴地，保持15-30秒，双腿交替进行。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('3、臀部拉伸')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('坐姿，一腿交叉置于另一腿膝盖外侧，双手撑地身体前倾，臀部一侧有拉伸感时保持15-30秒，换边重复。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('4、腰部拉伸')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('四肢着地，手腕在肩下方，膝盖在髋关节下方，配合呼吸做“猫牛式”动作（背部下沉抬头为“牛式”，拱背低头为“猫式”），重复8-12次。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('5、注意事项')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('呼吸配合‌：拉伸时保持深呼吸，避免憋气。‌动作强度‌：以轻微牵拉感为宜，避免过度用力导致拉伤。热身建议‌：跑后先快走5-10分钟促进血液循环，再系统拉伸效果更佳。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width(328)
            .alignItems(HorizontalAlign.Start)
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)
        .width('100%')
      }
      .height('100%')
      .width('100%')
    }
    .hideTitleBar(true)
    .padding({bottom: 15})
    .backgroundColor($r('app.color.home_background'))
  }
}
