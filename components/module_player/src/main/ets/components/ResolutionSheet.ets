@ComponentV2
export struct ResolutionSheet {
  @Param @Require defaultResolution: string
  @Param onChangeResolution: (selectResolution: string) => void = () => {
  }
  private resolution: string[] = ['1080P 原画（高帧率）', '1080P 蓝光', '720P超清', '480P高清']
  @Local nowResolution: string = '1080P 原画（高帧率）'

  aboutToAppear(): void {
    this.nowResolution = this.defaultResolution
  }

  build() {
    Column() {
      Row() {
        Text('清晰度')
          .width('100%')
          .height(27)
          .fontSize($r('sys.float.Title_S'))
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.font_primary'))
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 8 })

      Column() {
        ForEach(this.resolution, (item: string) => {
          Row() {
            Text(item)
              .fontSize(16)
              .fontWeight(500)
              .fontColor(this.nowResolution === item ? $r('sys.color.multi_color_01') : '#e6000000')
          }
          .width('100%')
          .height(48)
          .onClick(() => {
            if (this.nowResolution === item) {
              return
            }
            this.onChangeResolution(item)
            this.nowResolution = item
          })
          .margin({ top: 16 })

          Divider()
        }, (item: string) => item)
      }
    }
  }
}