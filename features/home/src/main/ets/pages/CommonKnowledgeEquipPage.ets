import { NavHeaderBar } from 'lib_widget';
import { CommonKnowledgePageVM } from '../viewmodels/CommonKnowledgePageVM';

@Builder
export function CommonKnowledgeEquipPageBuilder() {
  CommonKnowledgeEquipPage()
}

AppStorage.setOrCreate<boolean>('0014', false)

@ComponentV2
struct CommonKnowledgeEquipPage {
  scroller: Scroller = new Scroller()
  vm: CommonKnowledgePageVM = new CommonKnowledgePageVM();
  @Local isStar: boolean = AppStorage.get('0014') as boolean
  @Local label: string = '运动装备的重要性，你知道哪些？'

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
            AppStorage.setOrCreate<boolean>('0014', this.isStar)
          }
        } else {
          if (this.vm.deleteAction(this.label)) {
            this.isStar = !this.isStar;
            AppStorage.setOrCreate<boolean>('0014', this.isStar)
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
              Text('运动装备的重要性，你知道哪些？')
                .fontWeight(FontWeight.Medium)
                .fontSize(20)
            }
            .width(328)
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 16, bottom: 13 })

            Column() {
              Text('从材料工程学与人体工学双维度，解码运动装备的功能设计原理。课程对比市面主流品牌核心技术（如Nike Air缓震 vs. 李宁䨻科技），教授根据足型、运动场景及伤病历史进行科学选购。特别增加智能穿戴设备数据联动分析模块，助力运动表现精准提升。')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))

              Image($r('app.media.common_knowledge5'))
                .width(328)
                .height(220)
                .borderRadius(16)
                .margin({ top: 16, bottom: 16 })

              Column() {
                Text('运动装备的关键在于适配性和功能性，以下是具体建议：')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                Blank()
                Text('关键装备解析')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('1、跑鞋选择')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('缓震型：适合高足弓/正常足型，降低膝关节冲击；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('稳定型：矫正低足弓外翻，提升步态效率。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('2、压力袜/护具')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('梯度压缩袜促进血液循环，延缓肌肉疲劳；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('髌骨带减轻跑步时膝盖压力，预防髌腱炎。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('3、 智能设备')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('心率带监测训练强度，避免过度负荷；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('肌效贴动态支持薄弱肌群（如踝关节贴扎）。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('选购原则')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('根据运动类型匹配功能属性；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('优先考虑透气性与贴合度。')
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
