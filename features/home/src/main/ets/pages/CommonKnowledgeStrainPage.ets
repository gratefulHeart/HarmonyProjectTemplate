import { NavHeaderBar } from 'lib_widget';
import { CommonKnowledgePageVM } from '../viewmodels/CommonKnowledgePageVM';

@Builder
export function CommonKnowledgeStrainPageBuilder() {
  CommonKnowledgeStrainPage()
}

AppStorage.setOrCreate<boolean>('0015', false)

@ComponentV2
struct CommonKnowledgeStrainPage {
  scroller: Scroller = new Scroller()
  vm: CommonKnowledgePageVM = new CommonKnowledgePageVM();
  @Local isStar: boolean = AppStorage.get('0015') as boolean
  @Local label: string = '运动完腰椎损伤是什么造成的？'

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
            AppStorage.setOrCreate<boolean>('0015', this.isStar)
          }
        } else {
          if (this.vm.deleteAction(this.label)) {
            this.isStar = !this.isStar;
            AppStorage.setOrCreate<boolean>('0015', this.isStar)
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
              Text('运动完腰椎损伤是什么造成的？')
                .fontWeight(FontWeight.Medium)
                .fontSize(20)
            }
            .width(328)
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 16, bottom: 13 })

            Column() {
              Text('聚焦运动后腰部疼痛的根源问题，结合生物力学分析与临床案例，揭示日常训练中易被忽视的损伤风险点。课程涵盖从健身房负重训练到居家徒手运动的防护策略，帮助学员建立“核心-腰椎联动保护机制”。尤其适合长期伏案人群、健身爱好者及产后修复人群。')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))

              Image($r('app.media.common_knowledge2'))
                .width(328)
                .height(220)
                .borderRadius(16)
                .margin({ top: 16, bottom: 16 })

              Column() {
                Text('常见诱因分析')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('1、动作模式错误')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('深蹲/硬拉时腰部代偿发力，导致椎间盘压力激增；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('卷腹类动作过度屈伸腰椎，引发慢性磨损。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('2、核心力量失衡')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('腹肌与竖脊肌力量不足，无法稳定脊柱中立位；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('臀部肌群薄弱，迫使腰部承受额外负荷。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('3、热身与恢复缺失')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('未激活腹横肌与多裂肌直接进行高强度训练；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('运动后缺乏腰部拉伸（如婴儿式、仰卧扭转），肌肉僵硬加剧损伤风险。')
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
                Text('预防建议')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('强化核心稳定性训练（如死虫式、平板支撑）；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('大重量训练时使用护腰带并保持脊柱中立；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text(' 运动后通过猫牛式动态放松腰椎。')
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
