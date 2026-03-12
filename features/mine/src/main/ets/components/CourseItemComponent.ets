import { RouterMap, RouterUtils } from 'lib_common';
import { NumberUtil } from '../utils/NumberUtil';

@ComponentV2
export struct CourseItemComponent {
  @Require @Param courseId: string;
  // 课程名称
  @Require @Param courseTitle: string;
  // 课程时长
  @Require @Param courseDuration: number;
  // 学习进度
  @Param learnProgress: number = 0;
  // 课程封面
  @Require @Param cover: ResourceStr;
  // 课程时间
  @Require @Param time: string;

  build() {
    Row() {
      Image(this.cover)
        .width(96)
        .height(54)
        .borderRadius(8)
      Column() {
        Row() {
          Text(this.courseTitle)
            .fontSize($r('sys.float.Body_L'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_primary'))
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .wordBreak(WordBreak.BREAK_ALL)
        }
        .height(42)
        .alignItems(VerticalAlign.Top)

        Row() {
          Row() {
            Image($r('app.media.ic_time'))
              .width(16)
              .height(16)
              .margin({ right: 2 })
              .visibility(this.learnProgress > 0 ? Visibility.None : Visibility.Visible)
            Text(this.learnProgress > 0 ? `已学习${this.learnProgress}%` :
              ` ${NumberUtil.getHourAndMinuteFormat(this.courseDuration)}`)
              .fontColor('rgba(0, 0, 0, 0.4)')
              .fontSize($r('sys.float.Body_S'))
              .margin({ right: 20 })
            Text(this.time)
              .fontColor('rgba(0, 0, 0, 0.4)')
              .fontSize($r('sys.float.Body_S'))
          }
        }
        .width(220)
        .justifyContent(FlexAlign.SpaceBetween)

        Divider().color($r('sys.color.comp_divider')).margin({ top: 16 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding({ left: 12, top: 16 })
    }
    .onClick(() => {
      switch (this.courseId) {
        case '0012':
          RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_ACTIVATE, '01');
          break;
        case '0013':
          RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_DRAW, '02');
          break;
        case '0014':
          RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_EQUIP, '03');
          break;
        case '0015':
          RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_STRAIN, '04');
          break;
        case '0016':
          RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_WARM, '05');
          break;
        case '0017':
          RouterUtils.pushPathByName(RouterMap.COMMON_KNOWLEDGE_YOGA, '06');
          break;
        default:
          RouterUtils.pushPathByName(RouterMap.COURSE_DETAIL_PAGE, this.courseId)
      }
    })
    .width('100%')
    .height(92)
  }
}
 