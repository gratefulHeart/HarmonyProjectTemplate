import {
  BarChart,
  BarChartModel,
  BarData,
  BarDataSet,
  BarEntry,
  CustomUiInfo,
  ChartColor,
  EntryOhos,
  EventType,
  Highlight,
  IBarDataSet,
  IAxisValueFormatter,
  JArrayList,
  OnChartValueSelectedListener,
  XAxisPosition,
} from '@ohos/mpchart';
import dayjs from 'dayjs';
import { MonthBarChartData, BarItem } from '../commons/Types';

@ComponentV2
export struct MonthBarChart {
  @Param
  chartData: MonthBarChartData = {
    month: '',
    data: [],
  };
  @Param
  initColor: number = 0x8094B982;
  @Param
  highlightColor: number = 0x94B982;
  @Param
  markerColor: ResourceColor = '#e6000000';
  @Param
  chartHeight: Length = 300;
  @Param
  markerFontSize: Length = 12;
  @Local
  displayData: BarItem[] = [];
  @Local
  selectedData: BarItem | undefined = undefined;
  @Local
  model: BarChartModel = new BarChartModel();
  @Local
  customUiInfo: CustomUiInfo = new CustomUiInfo(100, 44);

  @Monitor('chartData')
  refreshChart() {
    this.selectedData = undefined;
    this.getChartData();
  }

  async aboutToAppear() {
    await this.initChartSetting();
  }

  // 构造数据选择监听器
  private _valueSelectedListener: OnChartValueSelectedListener = {
    onNothingSelected: () => {
      this.selectedData = undefined;
    },
    onValueSelected: (e: EntryOhos, h: Highlight) => {
      const idx = h.getX();
      const value = h.getY();
      const date = this.displayData[idx-1]?.date;

      if (typeof date === 'string' && typeof value === 'number') {
        this.selectedData = {
          date,
          value,
        };
      }
    },
  };

  build() {
    Column() {
      if (this.chartData.data.length) {
        Text() {
          if (this.selectedData) {
            Span(dayjs(this.selectedData.date as string).format('M月D日'));
            Span((this.chartData.typeLabel ?? '') + ': ');
            Span(this.selectedData.value + '分钟');
          }
          Span(' ');
        }
        .fontSize($r('sys.float.Body_M'))
        .fontColor(this.markerColor)
        .width('100%')

        Column() {
          Text('时长（分钟）')
            .fontSize($r('sys.float.Body_S'))
            .fontColor('rgba(0, 0, 0, 0.6)')
            .textAlign(TextAlign.Start)
            .fontWeight(FontWeight.Medium)
        }
        .margin({ top: 10, bottom: -30 })
        .width('100%')
        .height(16)
        .alignItems(HorizontalAlign.Start)

        BarChart({
          model: this.model,
          // 自定义ui的位置信息
          customUiInfo: this.customUiInfo,
          // 自定义 ui: 传入 builder
          customUiBuilder: this.markerBuilder,
          // 通过什么事件触发
          customUiTriggerEvent: EventType.SingleTap,
        })
          .width('100%');
      } else {
        Image($r('app.media.ic_data_empty')).width(80).height(80);
        Text('暂无内容')
          .fontColor('#99000000')
          .fontWeight(FontWeight.Regular)
          .fontSize($r('sys.float.Body_M'))
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .height(this.chartHeight)
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  markerBuilder() {
    // 是否在图表content内&&是否有数据
    if (this.customUiInfo.isInbounds && this.customUiInfo.data && this.customUiInfo.y) {
      Column() {
        Text() {
          Span(`${this.customUiInfo.data.getY()}分钟`);
        }
        .fontSize($r('sys.float.Body_M'));
      }
      .borderRadius(99)
      .justifyContent(FlexAlign.Center)
      .padding(12)
      .backgroundColor(Color.White)
      .shadow({
        radius: 20,
        offsetX: 0,
        offsetY: 0,
        color: '#33000000',
      })
      .width(this.customUiInfo.width)
      .height(this.customUiInfo.height)
      .margin({ left: this.customUiInfo.x, top: this.customUiInfo.y })
      .onAppear(() => {
        const timer = setTimeout(() => {
          this.customUiInfo.showUi = false;
          clearTimeout(timer);
        }, 2000);
      })
      .alignItems(HorizontalAlign.Start)
      .onClick(() => {
        this.customUiInfo.showUi = false;
      });
    }
  }

  async initChartSetting() {
    // 显示描述
    this.model.getDescription()?.setEnabled(false);
    // 初始化动画时长
    this.model.animateY(1000);
    // 显示图例
    this.model.getLegend()?.setEnabled(false);
    // 设置额外偏移量
    this.model.setExtraOffsets(10, 10, 10, 5);
    // 绘制柱状体阴影背景
    this.model.setDrawBarShadow(false);
    // 柱状体上方显示数值
    this.model.setDrawValueAboveBar(false);
    // 为图表添加数据选择的监听器
    this.model.setOnChartValueSelectedListener(this._valueSelectedListener);
    // 绘制图表背景色
    this.model.setDrawGridBackground(false);
    // 设置左轴
    const leftAxis = this.model.getAxisLeft();
    if (leftAxis) {
      leftAxis.setAxisMinimum(0);
      leftAxis.setGridColor(ChartColor.argb(60, 0, 0, 0));
      leftAxis.setTextColor(ChartColor.argb(200, 0, 0, 0));
      leftAxis.setAxisLineColor(ChartColor.rgb(255, 255, 255));
      leftAxis.setLabelXOffset(-10);
    }
    // 设置右轴不显示
    this.model.getAxisRight()?.setEnabled(false);
    const xAxis = this.model.getXAxis();
    if (xAxis) {
      xAxis.setValueFormatter(new MyAxisValueFormatter(this.chartData.month));
      xAxis.setPosition(XAxisPosition.BOTTOM);
      xAxis.setDrawGridLines(false);
      xAxis.setAxisLineColor(ChartColor.argb(60, 0, 0, 0));
      xAxis.setTextColor(ChartColor.argb(200, 0, 0, 0));
    }
    // 初始化图表数据
    this.getChartData();
  }

  async getChartData() {
    const month = new Date(this.chartData.month);
    this.model.getXAxis()?.setValueFormatter(new MyAxisValueFormatter(this.chartData.month));
    const totalDayNum = new Date(month.getFullYear(), month.getMonth() + 1, 0).getDate();
    this.displayData = [];
    for (let i = 1; i <= totalDayNum; i++) {
      const bill = this.chartData.data.find((item) => {
        const day = item.date.split('-')[2];
        return Number(day) === i;
      });
      if (bill) {
        this.displayData.push({
          date: bill.date,
          value: bill.value,
        });
      } else {
        const date = dayjs().set('month', month.getMonth()).set('date', i);
        this.displayData.push({
          date: date.format('YYYY-MM-DD'),
          value: 0,
        });
      }
    }
    await this.setData();
  }

  async setData() {
    let dataSetList: JArrayList<IBarDataSet> = new JArrayList<IBarDataSet>();
    let values: JArrayList<BarEntry> = new JArrayList<BarEntry>();
    for (let i = 0; i < this.displayData.length; i++) {
      values.add(new BarEntry(i + 1, this.displayData[i].value));
    }

    let dataSet: BarDataSet = new BarDataSet(values, 'DataSet');
    dataSet.setColorByColor(this.initColor);
    dataSet.setDrawValues(false);
    dataSet.setHighLightColor(this.highlightColor);
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
  month: string;

  constructor(month: string) {
    this.month = month;
  }

  public getFormattedValue(value: number): string {
    const date = dayjs(this.month ? this.month : new Date()).set('date', value);
    return date.format('M-D');
  }
}