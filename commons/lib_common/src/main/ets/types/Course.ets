export interface Course {
  id: string;
  courseTitle: string;
  description?: string; // 课程描述
  isCollection?: boolean; // 是否收藏
  isStudy?: boolean; // 是否学习
  videoUrl?: string; // 视频url
  cover?: ResourceStr; // 封面
  courseDuration?: number; // 课程时长 单位为秒
  learnProgress?: number; //进度
  time: number; // 发布时间
  courseCatalog?: CourseCatalog[]; // 课程章节
}

export interface CourseCatalog {
  id: string;
  courseTitle: string; // 标题
  catalogTitle: string; // 目录标题
  description?: string; //
  videoUrl?: string; // 视频url
  cover?: ResourceStr; // 封面
  totalTime?: number; // 视频时长 单位为秒
  learnProgress: number //进度
  time?: number; // 发布时间
}
