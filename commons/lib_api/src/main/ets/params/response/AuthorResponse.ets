/**
 * 用户-云侧接口响应模型
 */
export interface AuthorResponse {
  // 用户id
  authorId: string
  //用户昵称
  authorNickName: string
  // 用户icon
  authorIcon: string
  //用户简介
  authorDesc: string
  // 用户ip
  authorIp: string
  // 用户年龄
  authorAge: string
  // 用户性别
  authorGender: string
  //用户身高
  authorWeight: string
  // 用户体重
  authorHeight: string
  //用户目标
  authorPurpose: string[]
  // 锻炼部位
  authorBody: string[]
  // 手机号
  authorPhone?: string
}