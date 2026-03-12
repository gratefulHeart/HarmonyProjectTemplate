
@ObservedV2
export class VideoExtraInfoModel {
  private static instance?: VideoExtraInfoModel
  @Trace isDisplayChange: boolean = false
  @Trace videoInfo?: ESObject

  public static getInstance(): VideoExtraInfoModel {
    if (!VideoExtraInfoModel.instance) {
      VideoExtraInfoModel.instance = new VideoExtraInfoModel()
    }
    return VideoExtraInfoModel.instance
  }
}