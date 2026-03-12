// 日历项数据类型定义
export class CalendarItem {
  year: number;      // 年份
  month: number;     // 月份 (1-12)
  day: number;       // 日期
  isCurrentMonth: boolean; // 是否是当前月
  isToday: boolean;  // 是否是今天
  isPastDate: boolean; // 是否是过去的日期（相对于今天）

  constructor(year: number, month: number, day: number,
    isCurrentMonth: boolean, isToday: boolean, isPastDate: boolean) {
    this.year = year;
    this.month = month;
    this.day = day;
    this.isCurrentMonth = isCurrentMonth;
    this.isToday = isToday;
    this.isPastDate = isPastDate;
  }
}

// 日历工具类
export class CalendarUtils {

  /**
   * 获取指定年月的日历数据
   * @param year 年份
   * @param month 月份 (1-12)
   * @returns 日历数据数组，包含前一个月和后一个月的补全日期
   */
  static getCalendar(year: number, month: number): CalendarItem[] {
    const calendar: CalendarItem[] = [];

    // 获取当前日期用于标记今天
    const today = new Date();
    const currentYear = today.getFullYear();
    const currentMonth = today.getMonth() + 1;
    const currentDay = today.getDate();

    // 获取当前月的第一天
    const firstDayOfMonth = new Date(year, month - 1, 1);
    // 获取当前月的最后一天
    const lastDayOfMonth = new Date(year, month, 0);

    // 获取当前月第一天是星期几 (0-6, 0代表周日)
    const firstDayWeek = firstDayOfMonth.getDay();

    // 获取当前月的天数
    const daysInMonth = lastDayOfMonth.getDate();

    // 添加上个月的补全日期（从最后一个周日开始）
    if (firstDayWeek > 0) {
      // 获取上个月的最后一天
      const lastDayOfPrevMonth = new Date(year, month - 1, 0);
      const daysInPrevMonth = lastDayOfPrevMonth.getDate();
      const prevMonth = month - 1 === 0 ? 12 : month - 1;
      const prevYear = month - 1 === 0 ? year - 1 : year;

      // 添加上个月的日期，从最后一个周日开始
      for (let i = daysInPrevMonth - firstDayWeek + 1; i <= daysInPrevMonth; i++) {
        const isToday = (prevYear === currentYear && prevMonth === currentMonth && i === currentDay);
        const isPastDate = CalendarUtils.isPastDate(prevYear, prevMonth, i, currentYear, currentMonth, currentDay);
        calendar.push(new CalendarItem(prevYear, prevMonth, i, false, isToday, isPastDate));
      }
    }

    // 添加当前月的日期
    for (let i = 1; i <= daysInMonth; i++) {
      const isToday = (year === currentYear && month === currentMonth && i === currentDay);
      const isPastDate = CalendarUtils.isPastDate(year, month, i, currentYear, currentMonth, currentDay);
      calendar.push(new CalendarItem(year, month, i, true, isToday, isPastDate));
    }

    // 计算需要添加的下个月日期数量（补齐到周六）
    const totalCells = 42; // 通常显示6行7列
    const remainingCells = totalCells - calendar.length;

    if (remainingCells > 0) {
      const nextMonth = month + 1 === 13 ? 1 : month + 1;
      const nextYear = month + 1 === 13 ? year + 1 : year;

      // 添加下个月的日期
      for (let i = 1; i <= remainingCells; i++) {
        const isToday = (nextYear === currentYear && nextMonth === currentMonth && i === currentDay);
        const isPastDate = CalendarUtils.isPastDate(nextYear, nextMonth, i, currentYear, currentMonth, currentDay);
        calendar.push(new CalendarItem(nextYear, nextMonth, i, false, isToday, isPastDate));
      }
    }

    return calendar;
  }

  /**
   * 判断指定日期是否是过去日期（相对于今天）
   * @param year 要判断的年份
   * @param month 要判断的月份
   * @param day 要判断的日期
   * @param currentYear 当前年份
   * @param currentMonth 当前月份
   * @param currentDay 当前日期
   * @returns 如果是过去日期返回true，否则返回false
   */
  private static isPastDate(year: number, month: number, day: number,
    currentYear: number, currentMonth: number, currentDay: number): boolean {
    // 如果年份小于当前年份，则是过去日期
    if (year < currentYear) {
      return true;
    }

    // 如果年份等于当前年份但月份小于当前月份，则是过去日期
    if (year === currentYear && month < currentMonth) {
      return true;
    }

    // 如果年份和月份都等于当前年份和月份，但日期小于当前日期，则是过去日期
    if (year === currentYear && month === currentMonth && day < currentDay) {
      return true;
    }

    // 其他情况都不是过去日期
    return false;
  }

  /**
   * 获取当前月份的日历数据
   * @returns 当前月的日历数据
   */
  static getCurrentMonthCalendar(): CalendarItem[] {
    const today = new Date();
    const year = today.getFullYear();
    const month = today.getMonth() + 1;

    return CalendarUtils.getCalendar(year, month);
  }

  /**
   * 将日历数据按周分组
   * @param calendar 日历数据
   * @returns 按周分组的二维数组
   */
  static groupByWeek(calendar: CalendarItem[]): CalendarItem[][] {
    const weeks: CalendarItem[][] = [];

    for (let i = 0; i < calendar.length; i += 7) {
      weeks.push(calendar.slice(i, i + 7));
    }

    return weeks;
  }

  /**
   * 获取星期标题（周日到周六）
   * @returns 星期标题数组
   */
  static getWeekHeaders(): string[] {
    return ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
  }

  /**
   * 获取当前月的未来日期数量（用于统计等用途）
   * @param calendar 日历数据
   * @returns 当前月中未来日期的数量
   */
  static getFutureDatesCountInCurrentMonth(calendar: CalendarItem[]): number {
    return calendar.filter(item => item.isCurrentMonth && !item.isPastDate && !item.isToday).length;
  }
}
