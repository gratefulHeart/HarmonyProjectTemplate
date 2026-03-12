export interface MoreItem {
  itemId: string;
  label: string;
  icon: Resource;
}

@ObservedV2
export class ReportItem {
  reason: string
  @Trace isSelected: boolean

  constructor(reason: string, isSelected: boolean) {
    this.reason = reason
    this.isSelected = isSelected
  }
}

@ObservedV2
export class MovieItem {
  movieId: string;
  @Trace movieTitle: string;
  movieUrl: string
  learnProgress: number = 0; // 进度
  constructor(movieId: string, movieTitle: string, learnProgress: number, movieUrl: string) {
    this.movieId = movieId
    this.movieTitle = movieTitle
    this.learnProgress = learnProgress
    this.movieUrl = movieUrl
  }
}
