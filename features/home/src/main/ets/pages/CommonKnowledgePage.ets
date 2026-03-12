import { RouterMap, RouterUtils, CommonConstants } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { CommonKnowledgePageVM } from '../viewmodels/CommonKnowledgePageVM';

@Builder
export function CommonKnowledgePageBuilder() {
  CommonKnowledgePage()
}

@ComponentV2
struct CommonKnowledgePage {
  vm: CommonKnowledgePageVM = new CommonKnowledgePageVM();

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '运动健身常识普及',
        })

        Column() {
          Row({ space: 8 }) {
            Column() {
              Image($r('app.media.common_knowledge1'))
                .width(144)
                .height(144)
                .padding({ top: 8 })
                .borderRadius(8)
              Text('普通瑜伽与普拉提的区别其实并不大')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
                .padding({ top: 8, left:8, right: 8 })
            }
            .backgroundColor($r('sys.color.white'))
            .borderRadius(16)
            .width(160)
            .height(200)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_YOGA))
            // .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DETAIL, '06'))

            Column() {
              Image($r('app.media.common_knowledge2'))
                .width(144)
                .height(144)
                .borderRadius(8)
                .padding({ top: 8 })
              Text('运动完腰椎损伤是什么造成的？')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
                .padding({ top: 8, left:8, right: 8 })
            }
            .backgroundColor($r('sys.color.white'))
            .borderRadius(16)
            .width(160)
            .height(200)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_STRAIN))
            // .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DETAIL, '04'))
          }

          Row({ space: 8 }) {
            Column() {
              Image($r('app.media.common_knowledge3'))
                .width(144)
                .height(144)
                .borderRadius(8)
                .padding({ top: 8 })
              Text('腿部训练前的热身和激活动作，不可忽视')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
                .padding({ top: 8, left:8, right: 8 })
            }
            .backgroundColor($r('sys.color.white'))
            .borderRadius(16)
            .width(160)
            .height(200)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_ACTIVATE))
            // .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DETAIL, '01'))

            Column() {
              Image($r('app.media.common_knowledge4'))
                .width(144)
                .height(144)
                .borderRadius(8)
                .padding({ top: 8 })
              Text('你知道如何在跑后有效拉伸吗？')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
                .padding({ top: 8, left:8, right: 8 })
            }
            .backgroundColor($r('sys.color.white'))
            .borderRadius(16)
            .width(160)
            .height(200)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DRAW))
            // .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DETAIL, '02'))
          }
          .margin({ bottom:8, top:8 })

          Row({ space: 8 }) {
            Column() {
              Image($r('app.media.common_knowledge5'))
                .width(144)
                .height(144)
                .borderRadius(8)
                .padding({ top: 8 })
              Text('运动装备的重要性，你知道哪些？')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
                .padding({ top: 8, left:8, right: 8 })
            }
            .backgroundColor($r('sys.color.white'))
            .borderRadius(16)
            .width(160)
            .height(200)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_EQUIP))
            // .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DETAIL, '03'))

            Column() {
              Image($r('app.media.common_knowledge6'))
                .width(144)
                .height(144)
                .borderRadius(8)
                .padding({ top: 8 })
              Text('合理且适当的热身，可以让你的运动表现更好')
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_S'))
                .padding({ top: 8, left:8, right: 8 })
            }
            .backgroundColor($r('sys.color.white'))
            .borderRadius(16)
            .width(160)
            .height(200)
            .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_WARM))
            // .onClick(() => RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DETAIL, '05'))
          }
        }
        .width('100%')
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
      .backgroundColor($r('app.color.home_background'))
    }
    .hideTitleBar(true)
  }
}
