import {
  BarChart,
  BarChartModel,
  BarDataSet,
  BarData,
  BarEntry,
  ChartColor,
  CustomUiInfo,
  EntryOhos,
  EventType,
  Highlight,
  IBarDataSet,
  JArrayList,
  IAxisValueFormatter,
  OnChartValueSelectedListener,
  XAxisPosition,
} from '@ohos/mpchart';
import dayjs from 'dayjs';
import { YearBarChartData, BarItem } from '../commons/Types';

@ComponentV2
export struct YearBarChart {
  @Param
  chartData: YearBarChartData = {
    year: '',
    data: [],
  };
  @Param
  chartHeight: Length = 300;
  @Param
  initColor: number = 0x8094B982;
  @Param
  highlightColor: number = 0x94B982;
  @Param
  markerColor: ResourceColor = '#e6000000';
  @Param
  markerFontSize: Length = 12;
  @Local
  displayData: BarItem[] = [];
  @Local
  model: BarChartModel = new BarChartModel();
  @Local
  selectedData: BarItem | undefined = undefined;
  @Local
  customUiInfo: CustomUiInfo = new CustomUiInfo(100, 44);

  async aboutToAppear() {
    await this.initChartSetting();
  }

  @Monitor('chartData')
  refreshChart() {
    this.getChartData();
    this.selectedData = undefined;
  }

  // 构造数据选择监听器
  private _valueSelectedListener: OnChartValueSelectedListener = {
    onValueSelected: (e: EntryOhos, h: Highlight) => {
      const value = h.getY();
      const idx = h.getX();
      const date = this.displayData[idx-1]?.date;
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
            Span((this.chartData.typeLabel ?? '') + ': ');
            Span(this.selectedData.value + '分钟');
          }
          Span(' ');
        }
        .fontSize($r('sys.float.Body_M'))
        .width('100%')
        .fontColor(this.markerColor);

        Column() {
          Text('时长（分钟）')
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(0, 0, 0, 0.6)')
            .fontSize($r('sys.float.Body_S'))
            .textAlign(TextAlign.Start)
        }
        .height(16)
        .width('100%')
        .margin({ top: 10, bottom: -30 })
        .alignItems(HorizontalAlign.Start)

        BarChart({
          // 自定义 ui: 传入 builder
          customUiBuilder: this.markerBuilder,
          model: this.model,
          // 通过什么事件触发
          customUiTriggerEvent: EventType.SingleTap,
          // 自定义ui的位置信息
          customUiInfo: this.customUiInfo,
        })
          .width('100%');
      } else {
        Image($r('app.media.ic_data_empty')).width(80).height(80);
        Text('暂无内容')
          .fontSize($r('sys.float.Body_M'))
          .fontColor('#99000000')
          .fontWeight(FontWeight.Regular);
      }
    }
    .height(this.chartHeight)
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  markerBuilder() {
    // 是否在图表content内&&是否有数据
    if (this.customUiInfo.isInbounds && this.customUiInfo.data && this.customUiInfo.y) {
      Column() {
        Text() {
          Span(` ${this.customUiInfo.data.getY()}分钟`);
        }
        .fontSize($r('sys.float.Body_M'));
      }
      .padding(12)
      .borderRadius(99)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)
      .shadow({
        radius: 20,
        color: '#33000000',
        offsetX: 0,
        offsetY: 0,
      })
      .width(this.customUiInfo.width)
      .height(this.customUiInfo.height)
      .alignItems(HorizontalAlign.Start)
      .onAppear(() => {
        const timer = setTimeout(() => {
          this.customUiInfo.showUi = false;
          clearTimeout(timer);
        }, 2000);
      })
      .margin({ left: this.customUiInfo.x, top: this.customUiInfo.y })
      .onClick(() => {
        this.customUiInfo.showUi = false;
      });
    }
  }

  async initChartSetting() {
    // 初始化动画时长
    this.model.animateY(1000);
    // 显示图例
    this.model.getLegend()?.setEnabled(false);
    // 设置额外偏移量
    this.model.setExtraOffsets(10, 10, 10, 5);
    // 显示描述
    this.model.getDescription()?.setEnabled(false);
    // 绘制图表背景色
    this.model.setDrawGridBackground(false);
    // 绘制柱状体阴影背景
    this.model.setDrawBarShadow(false);
    // 为图表添加数据选择的监听器
    this.model.setOnChartValueSelectedListener(this._valueSelectedListener);
    // 柱状体上方显示数值
    this.model.setDrawValueAboveBar(false);
    // 设置左轴
    const leftAxis = this.model.getAxisLeft();
    if (leftAxis) {
      leftAxis.setAxisLineColor(ChartColor.rgb(255, 255, 255));
      leftAxis.setGridColor(ChartColor.argb(60, 0, 0, 0));
      leftAxis.setTextColor(ChartColor.argb(200, 0, 0, 0));
      leftAxis.setLabelXOffset(-10);
      leftAxis.setAxisMinimum(0);
    }
    // 设置右轴不显示
    this.model.getAxisRight()?.setEnabled(false);
    // 设置x轴
    const xAxis = this.model.getXAxis();
    if (xAxis) {
      xAxis.setValueFormatter(new MyAxisValueFormatter(this.chartData.year));
      xAxis.setPosition(XAxisPosition.BOTTOM);
      xAxis.setDrawGridLines(false);
      xAxis.setAxisLineColor(ChartColor.argb(60, 0, 0, 0));
      xAxis.setTextColor(ChartColor.argb(200, 0, 0, 0));
    }
    // 初始化图表数据
    this.getChartData();
  }

  async getChartData() {
    this.model.getXAxis()?.setValueFormatter(new MyAxisValueFormatter(this.chartData.year));
    const totalMonthNum = 12;
    this.displayData = [];
    for (let i = 1; i <= totalMonthNum; i++) {
      const bill = this.chartData.data.find((item) => {
        const month = item.date.substring(0, item.date.length-1);
        return Number(month) === i;
      });
      if (bill) {
        this.displayData.push({
          date: bill.date,
          value: bill.value,
        });
      } else {
        let monthDate = '';
        switch (i) {
          case 1:
            monthDate = '一月';
            break;

          case 2:
            monthDate = '二月';
            break;

          case 3:
            monthDate = '三月';
            break;

          case 4:
            monthDate = '四月';
            break;

          case 5:
            monthDate = '五月';
            break;

          case 6:
            monthDate = '六月';
            break;

          case 7:
            monthDate = '七月';
            break;

          case 8:
            monthDate = '八月';
            break;

          case 9:
            monthDate = '九月';
            break;

          case 10:
            monthDate = '十月';
            break;

          case 11:
            monthDate = '十一月';
            break;

          case 12:
            monthDate = '十二月';
            break;

          default:
            break;
        }
        const date = monthDate;
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
    let dataSetList: JArrayList<IBarDataSet> = new JArrayList<IBarDataSet>();
    for (let i = 0; i < this.displayData.length; i++) {
      values.add(new BarEntry(i + 1, this.displayData[i].value));
    }

    let dataSet: BarDataSet = new BarDataSet(values, 'DataSet');
    dataSet.setHighLightColor(this.highlightColor);
    dataSet.setDrawValues(false);
    dataSet.setColorByColor(this.initColor);
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
  year: string;

  month = ['十二月', '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月'];

  constructor(year: string) {
    this.year = year;
  }

  public getFormattedValue(value: number): string {
    const date = dayjs(this.year ? this.year : new Date()).set('month', value).month();
    return this.month[date];
  }
}