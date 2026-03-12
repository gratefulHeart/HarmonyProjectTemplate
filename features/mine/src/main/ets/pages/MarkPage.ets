import dayjs from 'dayjs';
import { MineServiceApi } from 'lib_api';
import { Course, COURSE_DATA, RouterMap } from 'lib_common';
import { NavHeaderBar } from 'lib_widget';
import { CourseItemComponent } from '../components/CourseItemComponent';
import { LeftSwipeComponent } from '../components/LeftSwipeComponent';
import { CollectionModel } from '../viewmodels/CollectionModel';
import { DeleteDialog } from '../viewmodels/DeleteDialog';
import { MarkViewModel } from '../viewmodels/MarkVM';

@Builder
export function MarkPageBuilder() {
  MarkPage()
}

@ComponentV2
struct MarkPage {
  @Local collectionList: CollectionModel[] = []

  @Local vm: MarkViewModel = new MarkViewModel();

  @Local isEdit: boolean = false
  // 是否左滑
  @Local isLeftSwipe: boolean = false
  // 选中计数
  @Local selectCount: number = 0
  // 左滑删除下标
  @Provider() swipeIndex: number = 0
  // 删除弹框
  deleteDialogController?: CustomDialogController;

  async aboutToAppear() {
    // 我的收藏数据初始化
    this.initCollectionData()
  }

  aboutToDisappear(): void {
    this.saveCollectionData()
  }

  @Builder
  editBuilder() {
    Text(this.isEdit ? '取消' : '编辑')
      .fontSize($r('sys.float.Body_L'))
      .fontWeight(FontWeight.Medium)
      .fontColor($r('sys.color.font_primary'))
      .backgroundColor($r('sys.color.comp_background_tertiary'))
      .borderRadius(20)
      .width(64)
      .height(40)
      .textAlign(TextAlign.Center)
      .onClick(() => {
        this.onClickEdit()
      })
  }

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '我的收藏',
          rightPartBuilder: () => {
            this.editBuilder();
          },
        })

        Column() {
          // 有数据时显示收藏列表
          List() {
            ForEach(this.collectionList, ((item: CollectionModel, index: number) => {
              ListItem() {
                Row() {
                  Image(item.isDelete ? $r('app.media.selected_on') : $r('app.media.selected_off'))
                    .width(24)
                    .height(24)
                    .margin({ right: 12 })
                    .visibility(this.isEdit ? Visibility.Visible : Visibility.None)
                  // 课程列表子项
                  CourseItemComponent({
                    courseId: item.id,
                    courseTitle: item.courseTitle,
                    courseDuration: item.courseDuration,
                    learnProgress: item.learnProgress,
                    cover: item.cover,
                    time: item.time,
                  })
                }
                .width('100%')
                .onClick(() => {
                  if (this.isEdit) {
                    // 是否勾选数据
                    this.isSelectData(item)
                  }
                })
              }
              .padding({ left: 16, right: 16 })
              .transition({ type: TransitionType.Delete, opacity: 0 })
              .swipeAction({
                edgeEffect: SwipeEdgeEffect.None,
                end: {
                  builder: () => {
                    this.collectionLeftSwipeBuilder(index)
                  },
                  actionAreaDistance: this.isEdit ? 0 : 26,
                  onStateChange: (state: SwipeActionState) => {
                    if (state === SwipeActionState.EXPANDED) {
                      this.isLeftSwipe = true
                    } else if (state === SwipeActionState.COLLAPSED) {
                      this.isLeftSwipe = false
                    }
                  },
                }
              })
            }), (item: CollectionModel, index: number) => item.id + index)
          }
          // 无数据时显示
          Text('当前暂无收藏记录。')
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.icon_secondary'))
            .height('100%')
            .visibility(this.collectionList.length === 0 ? Visibility.Visible : Visibility.None)
        }
        .layoutWeight(1)

        Row() {
          Column() {
            Image($r('app.media.ic_public_eraser'))
              .width(24)
              .height(24)
            Text('一键清空')
              .fontSize($r('sys.float.Caption_M'))
              .fontWeight(FontWeight.Regular)
              .fontColor($r('sys.color.font_primary'))
              .margin({ top: 4 })
          }
          .width('50%')
          .onClick(() => {
            // 删除全部
            this.dialogOpen('是否删除全部收藏？',true)
          })

          Column() {
            Image(this.selectCount > 0 ? $r('app.media.icon_delete_black') : $r('app.media.icon_delete_grey'))
              .width(24)
              .height(24)
            Text('删除')
              .fontSize($r('sys.float.Caption_M'))
              .fontWeight(FontWeight.Regular)
              .fontColor(this.selectCount > 0 ? $r('sys.color.font_primary') : $r('sys.color.font_tertiary'))
              .margin({ top: 4 })
          }
          .width('50%')
          .onClick(() => {
            // 删除选中
            this.dialogOpen(`是否删除${this.selectCount}条收藏？`)
          })
        }
        .margin({ bottom: 20 })
        .width('100%')
        .height(52)
      }
    }
    .hideTitleBar(true)
    .onShown(() => {
      this.collectionList = []
      this.initCollectionData()
    })
  }

  /**
   * 左滑删除
   */
  @Builder
  collectionLeftSwipeBuilder(index: number) {
    LeftSwipeComponent({
      index: index,
      dialogContent: '是否删除此条收藏？',
      confirmLeftSwipeDelete: () => {
        this.confirmLeftSwipeDelete()
      }
    }).visibility(this.isEdit ? Visibility.None : Visibility.Visible)
  }

  /**
   * 我的收藏数据初始化
   */
  initCollectionData() {
    MineServiceApi.queryMyMarks().forEach((title: string) => {
      let courseModel: CollectionModel = new CollectionModel()
      switch (title) {
        case '腿部训练前的热身和激活动作，不可忽视':
          courseModel.id = COURSE_DATA[0].id
          courseModel.isDelete = false
          courseModel.cover = COURSE_DATA[0].cover
          courseModel.courseTitle = COURSE_DATA[0].courseTitle
          courseModel.courseDuration = COURSE_DATA[0].courseDuration
          courseModel.learnProgress = COURSE_DATA[0].learnProgress
          courseModel.time = dayjs(COURSE_DATA[0].time).format('YYYY-MM-DD')
          break;

        case '你知道如何在跑后有效拉伸吗？':
          courseModel.id = COURSE_DATA[1].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[1].courseTitle
          courseModel.courseDuration = COURSE_DATA[1].courseDuration
          courseModel.learnProgress = COURSE_DATA[1].learnProgress
          courseModel.time = dayjs(COURSE_DATA[1].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[1].cover
          break;

        case '运动装备的重要性，你知道哪些？':
          courseModel.id = COURSE_DATA[2].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[2].courseTitle
          courseModel.courseDuration = COURSE_DATA[2].courseDuration
          courseModel.learnProgress = COURSE_DATA[2].learnProgress
          courseModel.time = dayjs(COURSE_DATA[2].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[2].cover
          break;

        case '运动完腰椎损伤是什么造成的？':
          courseModel.id = COURSE_DATA[3].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[3].courseTitle
          courseModel.courseDuration = COURSE_DATA[3].courseDuration
          courseModel.learnProgress = COURSE_DATA[3].learnProgress
          courseModel.time = dayjs(COURSE_DATA[3].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[3].cover
          break;

        case '合理且适当的热身，让你的运动表现更好':
          courseModel.id = COURSE_DATA[4].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[4].courseTitle
          courseModel.courseDuration = COURSE_DATA[4].courseDuration
          courseModel.learnProgress = COURSE_DATA[4].learnProgress
          courseModel.time = dayjs(COURSE_DATA[4].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[4].cover
          break;

        case '普通瑜伽与普拉提的区别其实并不大':
          courseModel.id = COURSE_DATA[5].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[5].courseTitle
          courseModel.courseDuration = COURSE_DATA[5].courseDuration
          courseModel.learnProgress = COURSE_DATA[5].learnProgress
          courseModel.time = dayjs(COURSE_DATA[5].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[5].cover
          break;

        case '背部舒展，提高内脏健康活力度':
          courseModel.id = COURSE_DATA[6].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[6].courseTitle
          courseModel.courseDuration = COURSE_DATA[6].courseDuration
          courseModel.learnProgress = COURSE_DATA[6].learnProgress
          courseModel.time = dayjs(COURSE_DATA[6].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[6].cover
          break;

        case '居家健身的优质动作一览':
          courseModel.id = COURSE_DATA[7].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[7].courseTitle
          courseModel.courseDuration = COURSE_DATA[7].courseDuration
          courseModel.learnProgress = COURSE_DATA[7].learnProgress
          courseModel.time = dayjs(COURSE_DATA[7].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[7].cover
          break;

        case '”你真的会跑步吗？“关于跑步机的正确使用训练课程':
          courseModel.id = COURSE_DATA[8].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[8].courseTitle
          courseModel.courseDuration = COURSE_DATA[8].courseDuration
          courseModel.learnProgress = COURSE_DATA[8].learnProgress
          courseModel.time = dayjs(COURSE_DATA[8].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[8].cover
          break;

        case '暴汗自重力量训练':
          courseModel.id = COURSE_DATA[9].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[9].courseTitle
          courseModel.courseDuration = COURSE_DATA[9].courseDuration
          courseModel.learnProgress = COURSE_DATA[9].learnProgress
          courseModel.time = dayjs(COURSE_DATA[9].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[9].cover
          break;

        case '舒缓腰部，促进血液循环':
          courseModel.id = COURSE_DATA[10].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[10].courseTitle
          courseModel.courseDuration = COURSE_DATA[10].courseDuration
          courseModel.learnProgress = COURSE_DATA[10].learnProgress
          courseModel.time = dayjs(COURSE_DATA[10].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[10].cover
          break;

        case '哑铃练手臂“21响礼炮”':
          courseModel.id = COURSE_DATA[11].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[11].courseTitle
          courseModel.courseDuration = COURSE_DATA[11].courseDuration
          courseModel.learnProgress = COURSE_DATA[11].learnProgress
          courseModel.time = dayjs(COURSE_DATA[11].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[11].cover
          break;

        case '双人健身，提高心肺':
          courseModel.id = COURSE_DATA[12].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[12].courseTitle
          courseModel.courseDuration = COURSE_DATA[12].courseDuration
          courseModel.learnProgress = COURSE_DATA[12].learnProgress
          courseModel.time = dayjs(COURSE_DATA[12].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[12].cover
          break;

        case '静心打坐训练':
          courseModel.id = COURSE_DATA[13].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[13].courseTitle
          courseModel.courseDuration = COURSE_DATA[13].courseDuration
          courseModel.learnProgress = COURSE_DATA[13].learnProgress
          courseModel.time = dayjs(COURSE_DATA[13].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[13].cover
          break;

        case '跳绳进阶训练':
          courseModel.id = COURSE_DATA[14].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[14].courseTitle
          courseModel.courseDuration = COURSE_DATA[14].courseDuration
          courseModel.learnProgress = COURSE_DATA[14].learnProgress
          courseModel.time = dayjs(COURSE_DATA[14].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[14].cover
          break;

        case '提升核心力量':
          courseModel.id = COURSE_DATA[15].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[15].courseTitle
          courseModel.courseDuration = COURSE_DATA[15].courseDuration
          courseModel.learnProgress = COURSE_DATA[15].learnProgress
          courseModel.time = dayjs(COURSE_DATA[15].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[15].cover
          break;

        case '腰背体态改善':
          courseModel.id = COURSE_DATA[16].id
          courseModel.isDelete = false
          courseModel.courseTitle = COURSE_DATA[16].courseTitle
          courseModel.courseDuration = COURSE_DATA[16].courseDuration
          courseModel.learnProgress = COURSE_DATA[16].learnProgress
          courseModel.time = dayjs(COURSE_DATA[16].time).format('YYYY-MM-DD')
          courseModel.cover = COURSE_DATA[16].cover
          break;

        default:
          break;
      }
      this.collectionList.push(courseModel)
    })
    //按照时间顺序由近及远
    this.collectionList.sort((a, b) => dayjs(b.time).valueOf() - dayjs(a.time).valueOf())
  }

  /**
   * 我的收藏数据刷新
   */
  saveCollectionData() {
    MineServiceApi.clearMyMarks()
    COURSE_DATA.forEach((item: Course) => {
      AppStorage.setOrCreate<boolean>(item.id, false)
    })
    this.collectionList.forEach((item: CollectionModel) => {
      MineServiceApi.addMark(item.courseTitle as string)
      AppStorage.setOrCreate<boolean>(item.id, true)
    })
  }

  dialogOpen(content: ResourceStr, isDeleteAll?: boolean) {
    this.deleteDialogController = new CustomDialogController({
      builder: DeleteDialog({
        content: content,
        confirmDelete: () => {
          if (isDeleteAll) {
            this.deleteAllData()
          } else {
            this.deleteSelectData()
          }
        }
      }),
    })
    this.deleteDialogController.open()
  }

  onClickEdit() {
    if (!this.isLeftSwipe && this.collectionList.length > 0) {
      this.isEdit = !this.isEdit
      if (!this.isEdit) {
        this.selectCount = 0
        this.collectionList.forEach((item: CollectionModel) => {
          item.isDelete = false
        })
      }
    }
  }

  /**
   * 确认左滑删除
   */
  confirmLeftSwipeDelete() {
    this.collectionList.splice(this.swipeIndex, 1)
    this.isLeftSwipe = false
  }

  /**
   * 删除选中数据
   */
  deleteSelectData() {
    this.collectionList = this.collectionList.filter((it: CollectionModel) => it.isDelete === false)
    this.isEdit = false
    this.selectCount = 0
  }

  /**
   * 删除全部数据
   */
  deleteAllData() {
    this.collectionList = []
    this.isEdit = false
  }

  /**
   * 是否勾选数据
   * @param item
   */
  isSelectData(item: CollectionModel) {
    item.isDelete = !item.isDelete
    if (item.isDelete) {
      this.selectCount++;
    } else {
      this.selectCount--;
    }
  }
}


