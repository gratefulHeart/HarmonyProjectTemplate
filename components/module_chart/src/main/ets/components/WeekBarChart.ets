import {
  BarChartModel,
  BarChart,
  BarData,
  BarDataSet,
  BarEntry,
  ChartColor,
  CustomUiInfo,
  EntryOhos,
  EventType,
  Highlight,
  IAxisValueFormatter,
  JArrayList,
  IBarDataSet,
  OnChartValueSelectedListener,
  XAxisPosition,
} from '@ohos/mpchart';
import { WeekBarChartData, BarItem } from '../commons/Types';
import dayjs from 'dayjs';

@ComponentV2
export struct WeekBarChart {
  @Param
  chartData: WeekBarChartData = {
    data: [],
    weekday: '',
  };
  @Param
  initColor: number = 0x8094B982;
  @Param
  chartHeight: Length = 300;
  @Param
  highlightColor: number = 0x94B982;
  @Param
  markerColor: ResourceColor = '#e6000000';
  @Param
  markerFontSize: Length = 12;
  @Local
  selectedData: BarItem | undefined = undefined;
  @Local
  model: BarChartModel = new BarChartModel();
  @Local
  displayData: BarItem[] = [];
  @Local
  customUiInfo: CustomUiInfo = new CustomUiInfo(100, 44);
  @Local
  weekDays: string[] = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];

  @Monitor('chartData')
  refreshChart() {
    this.getChartData();
    this.selectedData = undefined;
  }

  async aboutToAppear() {
    await this.initChartSetting();
  }

  // 构造数据选择监听器
  private _valueSelectedListener: OnChartValueSelectedListener = {
    onValueSelected: (e: EntryOhos, h: Highlight) => {
      const idx = h.getX();
      const date = this.displayData[idx - 1]?.date;
      const value = h.getY();
      if (typeof date === 'string' && typeof value === 'number') {
        this.selectedData = {
          date,
          value,
        };
      }
    },
    onNothingSelected: () => {
      this.selectedData = undefined;
    },
  };

  build() {
    Column() {
      if (this.chartData.data.length) {
        Text() {
          if (this.selectedData) {
            Span(this.selectedData.date as string);
            Span((this.chartData.typeLabel ?? '') + ' : ');
            Span(this.selectedData.value + '分钟');
          }
          Span(' ');
        }
        .width('100%')
        .fontColor(this.markerColor)
        .fontSize($r('sys.float.Body_M'))

        Column() {
          Text('时长（分钟）')
            .fontSize($r('sys.float.Body_S'))
            .fontColor('rgba(0, 0, 0, 0.6)')
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Start)
        }
        .width('100%')
        .height(16)
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 10, bottom: -30 })

        BarChart({
          model: this.model,
          // 通过什么事件触发
          customUiTriggerEvent: EventType.SingleTap,
          // 自定义 ui: 传入 builder
          customUiBuilder: this.markerBuilder,
          // 自定义ui的位置信息
          customUiInfo: this.customUiInfo,
        })
          .width('100%');
      } else {
        Image($r('app.media.ic_data_empty')).width(80).height(80);
        Text('暂无内容')
          .fontSize($r('sys.float.Body_M'))
          .fontWeight(FontWeight.Regular)
          .fontColor('#99000000')
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .height(this.chartHeight)
  }

  @Builder
  markerBuilder() {
    // 是否在图表content内&&是否有数据
    if (this.customUiInfo.isInbounds && this.customUiInfo.data && this.customUiInfo.y) {
      Column() {
        Text() {
          Span(`${this.customUiInfo.data.getY()} 分钟`);
        }
        .fontSize($r('sys.float.Body_M'));
      }
      .padding(12)
      .borderRadius(99)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.White)
      .shadow({
        radius: 20,
        color: '#33000000',
        offsetX: 0,
        offsetY: 0,
      })
      .width(this.customUiInfo.width)
      .height(this.customUiInfo.height)
      .onAppear(() => {
        const timer = setTimeout(() => {
          this.customUiInfo.showUi = false;
          clearTimeout(timer);
        }, 2000);
      })
      .margin({ left: this.customUiInfo.x, top: this.customUiInfo.y })
      .alignItems(HorizontalAlign.Start)
      .onClick(() => {
        this.customUiInfo.showUi = false;
      });
    }
  }

  async initChartSetting() {
    // 初始化动画时长
    this.model.animateY(1000);
    // 显示描述
    this.model.getDescription()?.setEnabled(false);
    // 显示图例
    this.model.getLegend()?.setEnabled(false);
    // 设置额外偏移量
    this.model.setExtraOffsets(10, 10, 10, 5);
    // 绘制图表背景色
    this.model.setDrawGridBackground(false);
    // 柱状体上方显示数值
    this.model.setDrawValueAboveBar(false);
    // 绘制柱状体阴影背景
    this.model.setDrawBarShadow(false);
    // 为图表添加数据选择的监听器
    this.model.setOnChartValueSelectedListener(this._valueSelectedListener);
    // 设置左轴
    const leftAxis = this.model.getAxisLeft();
    if (leftAxis) {
      leftAxis.setAxisMinimum(0);
      leftAxis.setLabelXOffset(-10);
      leftAxis.setAxisLineColor(ChartColor.rgb(255, 255, 255));
      leftAxis.setGridColor(ChartColor.argb(60, 0, 0, 0));
      leftAxis.setTextColor(ChartColor.argb(200, 0, 0, 0));
    }
    this.model.getAxisRight()?.setEnabled(false);
    // 设置x轴
    const xAxis = this.model.getXAxis();
    if (xAxis) {
      xAxis.setValueFormatter(new MyAxisValueFormatter(this.weekDays));
      xAxis.setPosition(XAxisPosition.BOTTOM);
      xAxis.setDrawGridLines(false);
      xAxis.setAxisLineColor(ChartColor.argb(60, 0, 0, 0));
      xAxis.setTextColor(ChartColor.argb(200, 0, 0, 0));
    }
    // 初始化图表数据
    this.getChartData();
  }

  async getChartData() {
    this.model.getXAxis()?.setValueFormatter(new MyAxisValueFormatter(this.weekDays));
    const totalDayNum = 7;
    this.displayData = [];
    for (let i = 0; i < totalDayNum; i++) {
      const bill = this.chartData.data.find((item) => {
        const day = item.date[1];
        let dayIndex = 0;
        switch (day) {
          case '一':
            dayIndex = 0;
            break;

          case '二':
            dayIndex = 1;
            break;

          case '三':
            dayIndex = 2;
            break;

          case '四':
            dayIndex = 3;
            break;

          case '五':
            dayIndex = 4;
            break;

          case '六':
            dayIndex = 5;
            break;

          case '日':
            dayIndex = 6;
            break;

          default:
            break;
        }
        return dayIndex === i;
      });
      if (bill) {
        this.displayData.push({
          date: bill.date,
          value: bill.value,
        });
      } else {
        let weekdayDate = '';
        switch (i) {
          case 1:
            weekdayDate = '周一';
            break;

          case 2:
            weekdayDate = '周二';
            break;

          case 3:
            weekdayDate = '周三';
            break;

          case 4:
            weekdayDate = '周四';
            break;

          case 5:
            weekdayDate = '周五';
            break;

          case 6:
            weekdayDate = '周六';
            break;

          case 7:
            weekdayDate = '周日';
            break;

          default:
            break;
        }
        const date = weekdayDate;
        this.displayData.push({
          date: date,
          value: 0,
        });
      }
    }
    await this.setData();
  }

  async setData() {
    let values: JArrayList<BarEntry> = new JArrayList<BarEntry>();
    for (let i = 0; i < this.displayData.length; i++) {
      values.add(new BarEntry(i + 1, this.displayData[i].value));
    }

    let dataSet: BarDataSet = new BarDataSet(values, 'DataSet');
    let dataSetList: JArrayList<IBarDataSet> = new JArrayList<IBarDataSet>();
    dataSet.setColorByColor(this.initColor);
    dataSet.setHighLightColor(this.highlightColor);
    dataSet.setDrawValues(false);
    // 显示数据格式化
    dataSetList.add(dataSet);

    let barData: BarData = new BarData(dataSetList);
    barData.setBarWidth(0.85);
    if (this.model) {
      this.model.setData(barData);
    }
    return barData;
  }
}

class MyAxisValueFormatter implements IAxisValueFormatter {
  weekday: string[];

  constructor(weekday: string[]) {
    this.weekday = weekday;
  }

  public getFormattedValue(value: number): string {
    return this.weekday[value - 1];
  }
}