import { AuthorService } from './AuthorService';
import { MyAuthor } from '../database/AuthorType';
import { ModifyPersonalInfoRequest } from '../params/request/CommonRequest';

/**
 * 我的管理类
 */
export class MineService extends AuthorService {
  /**
   * 收藏
   * @param label
   */
  public addMark(label: string) {
    const mineUserInfo = this.queryAuthorRaw() as MyAuthor;
    mineUserInfo?.myMarks.splice(0, 0, label);
  }

  /**
   * 取消收藏
   * @param label
   */
  public cancelMark(label: string) {
    const mineUserInfo = this.queryAuthorRaw() as MyAuthor;
    const index = mineUserInfo?.myMarks.findIndex(id => id === label);
    if (index !== -1) {
      mineUserInfo?.myMarks.splice(index, 1);
    }
  }

  /**
   * 查询我的收藏
   * @returns
   */
  public queryMyMarks(): string[] {
    const mineUserInfo = this.queryAuthorRaw() as MyAuthor;
    return mineUserInfo.myMarks
  }

  /**
   * 清空我的收藏
   * @returns
   */
  public clearMyMarks(): string[] {
    const mineUserInfo = this.queryAuthorRaw() as MyAuthor;
    mineUserInfo.myMarks = []
    return mineUserInfo.myMarks
  }

  /**
   * 添加到浏览历史
   * @param label
   */
  public addToHistory(label: string) {
    this.deleteFromHistory(label);
    const mineUserInfo = this.queryAuthorRaw() as MyAuthor;
    mineUserInfo?.myHistory.splice(0, 0, label);
  }

  /**
   * 从浏览历史中删除
   * @param label
   */
  public deleteFromHistory(label: string) {
    const mineUserInfo = this.queryAuthorRaw() as MyAuthor;
    const index = mineUserInfo?.myHistory.findIndex(id => id === label);
    if (index !== -1) {
      mineUserInfo?.myHistory.splice(index, 1);
    }
  }

  /**
   * 查询我的浏览记录
   * @returns
   */
  public queryMyHistory(): string[] {
    const mineUserInfo = this.queryAuthorRaw() as MyAuthor;
    return mineUserInfo.myHistory
  }

  /**
   * 清空我的足迹
   * @returns
   */
  public clearMyHistory(): string[] {
    const mineUserInfo = this.queryAuthorRaw() as MyAuthor;
    mineUserInfo.myHistory = []
    return mineUserInfo.myHistory
  }

  /**
   * 修改个人信息
   * @param nickName
   */
  public modifyPersonalInfo(params: ModifyPersonalInfoRequest) {
    const mineUserInfo = this.queryAuthorRaw() as MyAuthor;
    if (params.authorIcon) {
      mineUserInfo.authorIcon = params.authorIcon;
    }
    if (params.authorNickName) {
      mineUserInfo.authorNickName = params.authorNickName;
    }
    if (params.authorPhone) {
      mineUserInfo.authorPhone = params.authorPhone;
    }
    if (params.authorDesc) {
      mineUserInfo.authorDesc = params.authorDesc;
    }
    if (params.authorAge) {
      mineUserInfo.authorAge = params.authorAge;
    }
    if (params.authorGender) {
      mineUserInfo.authorGender = params.authorGender;
    }
    if (params.authorHeight) {
      mineUserInfo.authorHeight = params.authorHeight;
    }
    if (params.authorWeight) {
      mineUserInfo.authorWeight = params.authorWeight;
    }
    if (params.authorPurpose) {
      mineUserInfo.authorPurpose = params.authorPurpose;
    }
    if (params.authorBody) {
      mineUserInfo.authorBody = params.authorBody;
    }
  }
}

const instance = new MineService();

export { instance as MineServiceApi };