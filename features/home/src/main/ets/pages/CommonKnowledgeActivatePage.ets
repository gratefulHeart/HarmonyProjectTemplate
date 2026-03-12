import { NavHeaderBar } from 'lib_widget';
import { CommonKnowledgePageVM } from '../viewmodels/CommonKnowledgePageVM';

@Builder
export function CommonKnowledgeActivatePageBuilder() {
  CommonKnowledgeActivatePage()
}

AppStorage.setOrCreate<boolean>('0012', false)

@ComponentV2
struct CommonKnowledgeActivatePage {
  scroller: Scroller = new Scroller()
  vm: CommonKnowledgePageVM = new CommonKnowledgePageVM();
  @Local isStar: boolean = AppStorage.get('0012') as boolean
  @Local label: string = '腿部训练前的热身和激活动作，不可忽视'

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
            AppStorage.setOrCreate<boolean>('0012', this.isStar)
          }
        } else {
          if (this.vm.deleteAction(this.label)) {
            this.isStar = !this.isStar;
            AppStorage.setOrCreate<boolean>('0012', this.isStar)
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
              Text('腿部训练前的热身和激活动作，不可忽视')
                .fontWeight(FontWeight.Medium)
                .fontSize(20)
            }
            .width(328)
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 16, bottom: 13 })

            Column() {
              Text('突破传统热身认知，提出“神经-肌肉预同步”概念。课程设计基于运动链理论，通过针对性动作序列激活下肢动力链（髋-膝-踝协同），解决训练中力量传导断层问题。包含职业运动员常用的动态评估方法，适用于跑步、篮球、CrossFit等下肢主导型运动人群。')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))

              Image($r('app.media.common_knowledge3'))
                .width(328)
                .height(220)
                .borderRadius(16)
                .margin({ top: 16, bottom: 16 })

              Column() {
                Text('腿部训练前的热身和激活关键在于针对性动作和规范操作，以下是具体建议：')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                Blank()
                Text('科学热身流程')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('1、动态拉伸（5分钟）')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('高抬腿行走：激活髋屈肌与大腿前侧；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('侧弓步触脚：拉伸内收肌并提升髋关节灵活度。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('2、神经肌肉激活（3分钟）')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('弹力带螃蟹步：强化臀中肌，预防膝盖内扣；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('单腿硬拉（无负重）：唤醒腘绳肌与平衡控制能力。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('3、专项预加载（2分钟）')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('徒手深蹲10次：模拟正式动作模式；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('跳箱浅试触（30cm高度）：提升下肢爆发力神经募集。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('注意事项')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('避免静态拉伸（如压腿）降低肌肉弹性；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('激活顺序遵循“从单关节到多关节”原则。')
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
