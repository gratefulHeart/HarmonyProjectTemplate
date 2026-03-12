export interface BarItem {
  date: string;
  value: number;
}

export interface DayBarChartData {
  data: BarItem[];
  time: string;
  typeLabel?: string;
}

export interface WeekBarChartData {
  data: BarItem[];
  weekday: string;
  typeLabel?: string;
}

export interface MonthBarChartData {
  data: BarItem[];
  month: string;
  typeLabel?: string;
}

export interface YearBarChartData {
  data: BarItem[];
  year: string;
  typeLabel?: string;
}
