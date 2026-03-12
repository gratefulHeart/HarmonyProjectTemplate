export class NumberUtil {
  /**
   * 获取时分格式化。
   * 格式为xx小时xx分钟
   * @param seconds 秒
   * @returns
   */
  public static getHourAndMinuteFormat(seconds: number | undefined): string {
    if (seconds) {
      let hours: number = Math.floor(seconds / 3600); // 每小时3600秒
      let minutes: number = Math.floor((seconds % 3600) / 60); // 剩余秒数转换为分钟
      let format: string = `${minutes}分钟`;
      if (hours > 0) {
        format = `${hours}小时${minutes}分钟`
      }
      return format;
    }
    return '0分钟'
  }

  /**
   *  获取时分秒格式化。
   * 格式化为xx:xx:xx
   * @param seconds 秒
   * @returns
   */
  public static getTimeFromSecondsFormat(seconds: number): string {
    const hours = Math.floor(seconds / 3600); // 每小时3600秒
    const minutes = Math.floor((seconds % 3600) / 60); // 剩余秒数转换为分钟
    const remainingSeconds = Math.round(seconds % 60); // 剩余的秒数

    // 使用字符串模板和padStart来确保小时、分钟和秒都是两位数
    return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${remainingSeconds.toString()
      .padStart(2, '0')}`;
  }

  /**
   * 获取数量格式化
   * @param count
   * @returns
   */
  public static getCountFormat(num: number | undefined): string {
    let count: string = '0'
    if (num) {
      count = num.toString()
      if (num >= 10000) {
        count = (num / 10000).toFixed(1) + 'w'
      } else if (num >= 1000) {
        count = (num / 1000).toFixed(1) + 'k'
      }
    }
    return count;
  }

  /**
   * 获取时分格式化。
   * 格式为 年-月-日 时：分：秒
   * @param seconds 秒
   * @returns
   */
  public static getCurrentDateString(): string {
    let timestamp = Date.now();
    let date = new Date(timestamp);
    const hour = ('0' + date.getHours()).slice(-2);
    const min = ('0' + date.getMinutes()).slice(-2);
    const sec = ('0' + date.getSeconds()).slice(-2);
    const year = date.getFullYear();
    const month = ('0' + (date.getMonth() + 1)).slice(-2);
    const day = ('0' + date.getDate()).slice(-2);
    return `${year}-${month}-${day}  ${hour}:${min}:${sec}`;
  }
}
 