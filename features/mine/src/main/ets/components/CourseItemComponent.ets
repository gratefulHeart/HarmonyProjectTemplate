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
      RouterUtils.pushPathByName(RouterMap.COURSE_PAGE, this.courseId)
    })
    .width('100%')
    .height(92)
  }
}
 