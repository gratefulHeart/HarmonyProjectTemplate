import { NavHeaderBar } from 'lib_widget';
import { CommonKnowledgePageVM } from '../viewmodels/CommonKnowledgePageVM';

@Builder
export function CommonKnowledgeYogaPageBuilder() {
  CommonKnowledgeYogaPage()
}

AppStorage.setOrCreate<boolean>('0017', false)

@ComponentV2
struct CommonKnowledgeYogaPage {
  scroller: Scroller = new Scroller()
  vm: CommonKnowledgePageVM = new CommonKnowledgePageVM();
  @Local isStar: boolean = AppStorage.get('0017') as boolean
  @Local label: string = '普通瑜伽与普拉提的区别其实并不大'

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
            AppStorage.setOrCreate<boolean>('0017', this.isStar)
          }
        } else {
          if (this.vm.deleteAction(this.label)) {
            this.isStar = !this.isStar;
            AppStorage.setOrCreate<boolean>('0017', this.isStar)
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
              Text('普通瑜伽与普拉提的区别其实并不大')
                .fontWeight(FontWeight.Medium)
                .fontSize(20)
            }
            .width(328)
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 16, bottom: 13 })

            Column() {
              Text('本课程通过解剖两大体系的底层逻辑，破除“瑜伽=柔韧，普拉提=力量”的刻板印象。从运动科学角度解析二者在神经肌肉控制、呼吸机制上的共通性，帮助学员根据自身目标（如康复、体态矫正或运动表现提升）选择适配训练方式。适合零基础爱好者及希望跨界融合的健身教练。')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))

              Image($r('app.media.common_knowledge1'))
                .width(328)
                .height(220)
                .borderRadius(16)
                .margin({ top: 16, bottom: 16 })

              Column() {
                Text('以下是瑜伽和普拉提的对比：')
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                Blank()
                Text('核心对比维度')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('1、起源与目标')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('瑜伽：源于古印度哲学，侧重身心平衡与精神修行；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('普拉提：由约瑟夫·普拉提创立，强调核心力量与身体控制。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('2、训练重点')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('瑜伽：通过体式（如拜日式、树式）提升柔韧性和呼吸协调；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('普拉提：以垫上或器械动作（如百次拍击、骨盆卷动）强化深层肌群。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('3、呼吸模式')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('瑜伽：腹式呼吸为主，配合动作节奏；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('普拉提：横向呼吸法，强调核心收紧时的精准换气。')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('4、适用人群')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('瑜伽：适合追求放松、冥想或关节灵活性提升者；')
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)
                Text('普拉提：更适合康复训练、塑形或运动表现优化人群。')
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
