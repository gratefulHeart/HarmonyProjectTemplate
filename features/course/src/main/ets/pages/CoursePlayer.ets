import { AppStorageV2, window } from '@kit.ArkUI';
import {
  Course1,
  COURSE_DATA1, MyCourseParam,
  RouterMap,
  RouterModule,
  UserInfo,
  WindowSize
} from 'lib_common';
import { MovieItem, PlayerComponent, PlayerVM } from 'module_player';
import { CommentModel, CourseCatalogModel, CourseModel, ConvertTool } from 'lib_common';

@Builder
export function CoursePlayerBuilder() {
  CoursePlayer();
}

@ComponentV2
export struct CoursePlayer {
  @Local courseId: string = ''
  @Local arr: number[] = [50, 40, 30, 20, 10]
  @Local isShow: boolean = false
  @Local keyboardHeight: number = 0;
  // 窗口状态
  @Local windowStatusType: number = 0;
  @Local isLayoutFullScreen: boolean = false;
  @Local courseDetail: CourseModel = new CourseModel()
  @Local loginUser: UserInfo = AppStorageV2.connect(UserInfo, () => new UserInfo())!
  // 课程目录
  @Local isShowCatalog: boolean = false
  @Local selectSelection: string = '';
  // 课程目录当前选中
  @Local indexNumber: number = 0;
  @Local comments: CommentModel[] = [];
  @Local playerVM: PlayerVM = PlayerVM.instance;
  @Local learnProgress: number = 0;
  @Local param: MyCourseParam = MyCourseParam.instance()
  @Local windowSize: WindowSize = AppStorageV2.connect(WindowSize, () => new WindowSize())!
  private scroller: ListScroller = new ListScroller();
  private movieItems: MovieItem[] = [];

  aboutToAppear() {
    let course: Course1 = COURSE_DATA1[0]
    switch (this.courseId) {
      case '0001':
        course = COURSE_DATA1[0];
        break;
      case '0002':
        course = COURSE_DATA1[1];
        break;
      case '0003':
        course = COURSE_DATA1[2];
        break;
      case '0004':
        course = COURSE_DATA1[3];
        break;
      case '0005':
        course = COURSE_DATA1[4];
        break;
      case '0006':
        course = COURSE_DATA1[5];
        break;
      case '0007':
        course = COURSE_DATA1[6];
        break;
      case '0008':
        course = COURSE_DATA1[7];
        break;
      case '0009':
        course = COURSE_DATA1[8];
        break;
      case '0010':
        course = COURSE_DATA1[9];
        break;
      case '0011':
        course = COURSE_DATA1[10];
        break;
      default:
        break;
    }
    let courseModel = ConvertTool.convertCourseModel(course) as CourseModel
    if (courseModel) {
      this.courseDetail = courseModel
      if (this.courseDetail.isPay || this.courseDetail.isFree) {
        this.playerVM.isSelections = true
      } else {
        this.playerVM.isSelections = false
      }
      this.courseDetail.courseCatalog?.forEach((item: CourseCatalogModel) => {
        this.movieItems.push(new MovieItem(item.id, item.catalogTitle, item.learnProgress, item.videoUrl!))
      })
      this.indexNumber = this.courseDetail.catalogIndex
      this.selectSelection = this.movieItems[this.indexNumber].movieTitle
      this.learnProgress = this.courseDetail.courseCatalog[this.indexNumber].isStudyEnd ? 100 :
        this.courseDetail.courseCatalog[this.indexNumber].learnProgress
      this.comments = this.courseDetail.courseCatalog[this.indexNumber].comments
      this.comments.sort((a, b) => b.time - a.time)
      this.courseDetail.isWatch = true
      this.courseDetail.isStudy = true
      this.courseDetail.studyTime = Date.now()
      this.courseDetail.watchTime = Date.now()
    }

    window.getLastWindow(getContext(this)).then((currentWindow: window.Window) => {
      // 获取窗口属性
      let properties = currentWindow.getWindowProperties();
      let rect = properties.windowRect;
      if (this.getUIContext().px2vp(rect.height) <= 680) {
        this.windowStatusType = 5
      }
      currentWindow.on('windowStatusChange', (windowStatusType) => {
        this.windowStatusType = windowStatusType
      });
      currentWindow.on('avoidAreaChange', data => {
        if (data.type === window.AvoidAreaType.TYPE_KEYBOARD) {
          if (data.area.bottomRect.height === 0) {
            this.keyboardHeight = 0
          } else {
            this.keyboardHeight = this.windowStatusType === 5 ? 0 : 100;
          }
        }
      })
    })
  }

  aboutToDisappear(): void {
    let learnProgress: number = 0
    this.courseDetail.courseCatalog.forEach((item: CourseCatalogModel) => {
      if (item.isStudyEnd) {
        learnProgress += 100
      } else {
        learnProgress += item.learnProgress
      }
    })
    if (learnProgress >= this.courseDetail.courseCatalog.length * 100) {
      this.courseDetail.isStudyEnd = true
    } else {
      this.courseDetail.learnProgress = Math.floor(learnProgress / (this.courseDetail.courseCatalog.length * 100) * 100)
    }
    this.param.isLearn = true
  }

  @Builder
  playerBuilder() {
    Row() {
      PlayerComponent({
        courseId: this.courseId,
        movieItems: this.movieItems,
        playerIndex: this.indexNumber,
        fullScreen: (isLayoutFullScreen: boolean) => {
          this.isLayoutFullScreen = isLayoutFullScreen
        },
        selectionEvent: (idx: number) => {
          this.indexNumber = idx
          this.selectSelection = this.movieItems[idx].movieTitle
          this.comments = this.courseDetail.courseCatalog[this.indexNumber].comments
          this.learnProgress = this.courseDetail.courseCatalog[this.indexNumber].isStudyEnd ? 100 :
            this.courseDetail.courseCatalog[this.indexNumber].learnProgress
        },
        callbackTimeUpdate: (vol: number, total: number) => {
          if (this.courseDetail.courseCatalog[this.indexNumber].learnProgress >= 100) {
            this.courseDetail.courseCatalog[this.indexNumber].isStudyEnd = true
          }
          this.courseDetail.courseCatalog[this.indexNumber].learnProgress = Math.floor(vol / total * 100)
        }
      })
        .width('100%')
        .height(this.isLayoutFullScreen ? '100%' :
          (this.getUIContext().px2vp(this.windowSize.screenWidth) - 32) * 9 / 16)
        .borderRadius(this.isLayoutFullScreen ? 0 : 16)
        .clip(true)
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
    .padding(this.isLayoutFullScreen ? 0 : {
      top: 10,
      bottom: 10,
      left: 16,
      right: 16
    })
  }

  build() {
    NavDestination() {
      Column() {
          Column() {
            this.playerBuilder()
          }
          .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(this.isLayoutFullScreen ? 'rgba(0,0,0,1)' : Color.White)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.courseId = context.pathInfo?.param as string
    })
  }
}