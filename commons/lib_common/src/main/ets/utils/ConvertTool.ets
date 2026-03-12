import { CourseCatalogModel, CourseModel } from '../models/CourseModel'
import { Course1, CourseCatalog1 } from '../types/Course1'

export class ConvertTool {
  static convertCourseModel(course: Course1): CourseModel {
    let courseModel: CourseModel = new CourseModel()
    courseModel.id = course.id
    courseModel.courseTitle = course.courseTitle
    courseModel.description = course.description
    courseModel.videoUrl = course.videoUrl
    courseModel.cover = course.cover
    courseModel.courseDuration = course.courseDuration
    courseModel.learnProgress = 0
    courseModel.time = course.time
    if (course.courseCatalog) {
      courseModel.courseCatalog = ConvertTool.convertCatalogModel(course.courseCatalog, courseModel.id)
    }
    return courseModel
  }

  static convertCatalogModel(courseCatalog: CourseCatalog1[], courseId: string): CourseCatalogModel[] {
    let arr: CourseCatalogModel[] = []
    courseCatalog.forEach((item: CourseCatalog1) => {
      let model: CourseCatalogModel = new CourseCatalogModel()
      model.id = item.id
      model.courseId = courseId
      model.catalogTitle = item.catalogTitle
      model.learnProgress = 0
      model.videoUrl = item.videoUrl
      model.comments = []
      arr.push(model)
    })
    return arr
  }
}