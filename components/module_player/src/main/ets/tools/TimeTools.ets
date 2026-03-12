export function fillNum(num: number) {
  if (num < 10) {
    return `0${num}`;
  }
  return num.toString();
}

export function getTimeString(time: number) {
  if (time === -1 || time === undefined) {
    time = 0;
  }
  const TIMESTAMP: number = 1000;
  const TIME_UNIT: number = 60;
  const MAX_HOURS: number = 24;
  let hour = Math.floor(time % (TIMESTAMP * TIME_UNIT * TIME_UNIT * MAX_HOURS) / (TIMESTAMP * TIME_UNIT * TIME_UNIT));
  let minute = Math.floor(time % (TIMESTAMP * TIME_UNIT * TIME_UNIT) / (TIMESTAMP * TIME_UNIT));
  let second = Math.floor(time % (TIMESTAMP * TIME_UNIT) / TIMESTAMP);
  if (hour > 0) {
    return `${fillNum(hour)}:${fillNum(minute)}:${fillNum(second)}`;
  }
  return `${fillNum(minute)}:${fillNum(second)}`;
}