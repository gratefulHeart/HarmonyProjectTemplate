import { AppStorageV2 } from '@kit.ArkUI'

@ComponentV2
export struct SearchPage {
  @Local searchValue: string = ''
  @Local historySearch: string[] = AppStorageV2.connect(HistoryClass, () => new HistoryClass())!.historySearch
  // 模拟后端数据源
  @Param searchSourceData: string[] = []
  //搜索结果数据存放
  @Local searchResultList: string[] = []
  // 返回
  @Event back: () => void = () => {
  }
  @Event clickSearchResult: (searchData: string) => void;

  build() {
    Column() {
      // 顶部搜索框
      this.topSearchBuilder()
      if (this.searchValue.trim() !== '') {
        this.searchListBuilder()
      } else {
        this.historySearchItem()
      }
    }
  }

  @Builder
  searchListBuilder() {
    List() {
      ListItem() {
        Column() {
          Image($r('app.media.search_no_result'))
            .width($r('app.float.vp_40'))
            .height($r('app.float.vp_40'))
          Text('未找到相关课程')
            .fontSize($r('sys.float.Caption_L'))
            .fontColor($r('sys.color.font_secondary'))
            .fontWeight(FontWeight.Regular)
            .margin({ top: $r('app.float.vp_24') })
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .visibility(this.searchResultList.length <= 0 ? Visibility.Visible : Visibility.None)
      .width('100%')

      ForEach(this.searchResultList, (item: string) => {
        ListItem() {
          Column() {
            Row() {
              Image($r('app.media.search'))
                .width($r('app.float.vp_14'))
                .height($r('app.float.vp_14'))
                .margin({ right: $r('app.float.vp_18') })
                .fillColor($r('sys.color.font_primary'))
              Text() {
                Span(item.substring(0, item.indexOf(this.searchValue)))
                // 高亮文字
                Span(this.searchValue).fontColor($r('sys.color.multi_color_01'))
                Span(item.substring(item.indexOf(this.searchValue) + this.searchValue.length,
                  item.length))
              }
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_L'))
              .fontWeight(FontWeight.Medium)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .wordBreak(WordBreak.BREAK_ALL)
              .layoutWeight(1)
            }
            .width('100%')
            .height($r('app.float.vp_48'))

            Divider().color($r('sys.color.comp_divider'))
              .margin({ left: $r('app.float.vp_32') })
          }
          .width('100%')
          .height($r('app.float.vp_48'))
          .layoutWeight(1)
        }
        .width('100%').height($r('app.float.vp_48'))
        .onClick(() => {
          this.clickSearchResult(item)
        })
        .visibility(this.searchResultList.length <= 0 ? Visibility.None : Visibility.Visible)

      }, (item: string) => JSON.stringify(item))
    }
    .scrollBar(BarState.Off)
    .cachedCount(1)
    .width('100%')
    .height('auto')
  }

  @Builder
  historySearchItem() {
    Column() {
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Text('历史搜索')
          .fontSize($r('sys.float.Body_M'))
          .fontColor($r('sys.color.font_secondary'))
          .fontWeight(FontWeight.Regular)
        Row({ space: 5 }) {
          Image($r('app.media.clear'))
            .width($r('app.float.vp_16'))
            .height($r('app.float.vp_16'))
          Text('清空')
            .fontColor($r('sys.color.font_secondary'))
            .fontSize($r('sys.float.Body_M'))
            .fontWeight(FontWeight.Regular)
            .onClick(() => {
              this.historySearch = []
              AppStorageV2.connect(HistoryClass, () => new HistoryClass())!.historySearch = this.historySearch
            })
        }
      }

      Flex({ justifyContent: FlexAlign.Start, wrap: FlexWrap.Wrap }) {
        Row() {
          Text('暂无历史搜索')
            .fontSize($r('sys.float.Caption_L'))
            .fontWeight(FontWeight.Regular)
            .fontColor($r('sys.color.font_secondary'))
        }
        .visibility(this.historySearch.length <= 0 ? Visibility.Visible : Visibility.None)
        .width('100%')
        .justifyContent(FlexAlign.Center)

        ForEach(this.historySearch, (item: string) => {
          Row() {
            Text(item)
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Body_M'))
              .fontWeight(FontWeight.Medium)
          }
          .padding({
            left: $r('app.float.vp_12'),
            right: $r('app.float.vp_12'),
            top: $r('app.float.vp_4'),
            bottom: $r('app.float.vp_4'),
          })
          .onClick(() => {
            this.searchValue = item
            this.searchText()
          })
          .margin({ right: $r('app.float.vp_12'), bottom: $r('app.float.vp_12') })
          .borderRadius(14)
          .backgroundColor($r('sys.color.comp_background_tertiary'))
          .visibility(this.historySearch.length <= 0 ? Visibility.None : Visibility.Visible)
        }, (item: string, index: number) => item + index)
      }
      .margin({ top: $r('app.float.vp_12'), bottom: $r('app.float.vp_12') })
    }
    .margin({ top: $r('app.float.vp_16') })
  }

  // 顶部搜索框
  @Builder
  topSearchBuilder() {
    Row() {
      Image($r('app.media.chevron_backward_search'))
        .height($r('app.float.vp_40'))
        .width($r('app.float.vp_40'))
        .margin({ right: $r('app.float.vp_8') })
        .onClick(() => {
          this.back()
        })
      // 搜索文本框
      Search({ placeholder: '搜索', value: this.searchValue })
        .layoutWeight(1)
        .backgroundColor($r('sys.color.comp_background_tertiary'))
        .defaultFocus(true)
        .fontColor($r('sys.color.font_primary'))
        .textFont({ size: $r('sys.float.Body_L'), weight: FontWeight.Medium })
        .onChange((value: string) => {
          if (value === '') {
            this.searchResultList = [];
            this.searchValue = value
          }
        })
        .onSubmit((value: string) => {
          this.searchValue = value.replace(/^\s+|\s+$/g, '');
          this.searchText()
        })
    }
    .height($r('app.float.vp_56'))
    .width('100%')
  }

  // 搜索功能匹配数据源
  searchText() {
    let tmp: string[] = [];
    this.searchValue = this.searchValue.replace(/^\s+|\s+$/g, '');
    this.searchSourceData.forEach((item: string) => {
      if (item.indexOf(this.searchValue) !== -1) {
        tmp.push(item)
      }
    })
    this.searchResultList = tmp;
    if (this.searchValue) {
      if (this.historySearch.length) {
        let repeatFlage = false
        this.historySearch.forEach((item) => {
          if (item === this.searchValue) {
            repeatFlage = true
          }
        })
        if (repeatFlage) {
          return
        } else {
          this.historySearch.push(this.searchValue)
        }
      } else {
        this.historySearch.push(this.searchValue)
      }
    }
  }
}

@ObservedV2
export class HistoryClass {
  @Trace historySearch: string[] = []
}