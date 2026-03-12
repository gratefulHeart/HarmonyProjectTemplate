@Observed
export class CourseDetailModel {
  id: string;
  advImage: string;
  courseName: string;
  avaiCard: string[];
  serviceDetail: string;

  constructor(id: string, advImage: string, courseName: string,
    avaiCard: string[], serviceDetail: string) {
    this.id = id;
    this.advImage = advImage;
    this.courseName = courseName;
    this.avaiCard = avaiCard;
    this.serviceDetail = serviceDetail;
  }
}

@Observed
export class PlanInfo {
  id: string;
  courseId: string;
  date: string;
  weekday: number;

  constructor(id: string, courseId: string, date: string, weekday: number) {
    this.id = id;
    this.courseId = courseId;
    this.date = date;
    this.weekday = weekday;
  }
}
