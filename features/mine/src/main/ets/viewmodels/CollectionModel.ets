@ObservedV2
export class CollectionModel {
  id: string = '';
  // 课程标题
  courseTitle?: string;
  // 课程时长
  courseDuration?: number;
  // 学习进度
  learnProgress?: number;
  // 课程封面
  cover?: ResourceStr;
  // 收藏时间
  time: string = '';
  // 是否删除
  @Trace isDelete?: boolean;
}


export const COLLECTION_DATA: CollectionModel[] = []