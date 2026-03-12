import { CommonContent, COMMON_CONTENT, Course, COURSE_DATA } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { CommonKnowledgePageVM } from '../viewmodels/CommonKnowledgePageVM';

@Builder
export function CommonKnowledgeDetailPageBuilder() {
  CommonKnowledgeDetailPage()
}

@ComponentV2
struct CommonKnowledgeDetailPage {
  scroller: Scroller = new Scroller()
  vm: CommonKnowledgePageVM = new CommonKnowledgePageVM();
  @Local courseId: string = ''
  @Local label: string = ''
  @Local isStar: boolean = AppStorage.get(this.courseId) as boolean
  @Local course: Course = COURSE_DATA[Number(this.courseId) - 1]
  @Local commonContent: CommonContent = COMMON_CONTENT[Number(this.courseId) - 1]

  async aboutToAppear() {
    this.label = COURSE_DATA[Number(this.courseId) - 1].courseTitle
    this.isStar = AppStorage.get(this.courseId) as boolean
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
            this.isStar = true;
            AppStorage.setOrCreate<boolean>(this.courseId, true)
          }
        } else {
          if (this.vm.deleteAction(this.label)) {
            this.isStar = false;
            AppStorage.setOrCreate<boolean>(this.courseId, false)
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
              Text(this.course.courseTitle)
                .fontWeight(FontWeight.Medium)
                .fontSize(20)
            }
            .width(328)
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 16, bottom: 13 })

            Column() {
              Text(this.course.description)
                .fontWeight(FontWeight.Medium)
                .fontSize($r('sys.float.Body_L'))

              Image(this.course.cover)
                .width(328)
                .height(220)
                .borderRadius(16)
                .margin({ top: 16, bottom: 16 })

              Column() {
                Text(this.commonContent.intro)
                  .fontWeight(FontWeight.Medium)
                  .fontSize($r('sys.float.Body_L'))
                Blank()
                Text(this.commonContent.contentType)
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)

                ForEach(this.commonContent.content, (content: string) => {
                  Text(content)
                    .fontSize($r('sys.float.Body_L'))
                    .fontWeight(FontWeight.Medium)
                })

                Text(this.commonContent.type)
                  .fontSize($r('sys.float.Body_L'))
                  .fontWeight(FontWeight.Medium)

                ForEach(this.commonContent.advice, (content: string) => {
                  Text(content)
                    .fontSize($r('sys.float.Body_L'))
                    .fontWeight(FontWeight.Medium)
                })
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
    .onReady((context: NavDestinationContext) => {
      this.courseId = context.pathInfo?.param as string
      this.course = COURSE_DATA[Number(this.courseId) - 1]
      this.commonContent = COMMON_CONTENT[Number(this.courseId) - 1]
      this.aboutToAppear()
    })
  }
}
