import {
  BarChart,
  BarChartModel,
  BarData,
  BarDataSet,
  BarEntry,
  ChartColor,
  CustomUiInfo,
  EntryOhos,
  EventType,
  Highlight,
  IAxisValueFormatter,
  IBarDataSet,
  JArrayList,
  OnChartValueSelectedListener,
  XAxisPosition,
} from '@ohos/mpchart';
import dayjs from 'dayjs';
import { DayBarChartData, BarItem } from '../commons/Types';

@ComponentV2
export struct DayBarChart {
  @Param
  chartData: DayBarChartData = {
    time: '',
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
  displayTime: BarItem[] = [];
  @Local
  model: BarChartModel = new BarChartModel();
  @Local
  customUiInfo: CustomUiInfo = new CustomUiInfo(100, 44);
  @Local
  selectedData: BarItem | undefined = undefined;

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
      const value = h.getY();
      const date = this.displayTime[idx]?.date;
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
            Span((this.chartData.typeLabel ?? '') + ' :  ');
            Span(this.selectedData.value + '分钟');
          }
          Span(' ');
        }
        .width('100%')
        .fontSize($r('sys.float.Body_M'))
        .fontColor(this.markerColor);

        Column() {
          Text('时长（分钟）')
            .fontWeight(FontWeight.Medium)
            .fontSize($r('sys.float.Body_S'))
            .fontColor('rgba(0, 0, 0, 0.6)')
            .textAlign(TextAlign.Start)
        }
        .width('100%')
        .height(16)
        .margin({ top: 10, bottom: -30 })
        .alignItems(HorizontalAlign.Start)

        BarChart({
          model: this.model,
          // 自定义 ui: 传入 builder
          customUiBuilder: this.markerBuilder,
          // 通过什么事件触发
          customUiTriggerEvent: EventType.SingleTap,
          // 自定义ui的位置信息
          customUiInfo: this.customUiInfo,
        })
          .width('100%');
      } else {
        Image($r('app.media.ic_data_empty')).width(80).height(80);
        Text('暂无内容')
          .fontColor('#99000000')
          .fontSize($r('sys.float.Body_M'))
          .fontWeight(FontWeight.Regular);
      }
    }
    .width('100%')
    .height(this.chartHeight)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  markerBuilder() {
    // 是否在图表content内&&是否有数据
    if (this.customUiInfo.isInbounds && this.customUiInfo.data && this.customUiInfo.y) {
      Column() {
        Text() {
          Span(`${this.customUiInfo.data.getY()}分钟 `);
        }
        .fontSize($r('sys.float.Body_M'));
      }
      .justifyContent(FlexAlign.Center)
      .padding(12)
      .borderRadius(99)
      .backgroundColor(Color.White)
      .shadow({
        radius: 20,
        color: '#33000000',
        offsetX: 0,
        offsetY: 0,
      })
      .width(this.customUiInfo.width)
      .height(this.customUiInfo.height)
      .margin({ left: this.customUiInfo.x, top: this.customUiInfo.y })
      .alignItems(HorizontalAlign.Start)
      .onAppear(() => {
        const timer = setTimeout(() => {
          this.customUiInfo.showUi = false;
          clearTimeout(timer);
        }, 2000);
      })
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
    // 显示描述
    this.model.getDescription()?.setEnabled(false);
    // 设置额外偏移量
    this.model.setExtraOffsets(10, 10, 10, 5);
    // 绘制图表背景色
    this.model.setDrawGridBackground(false);
    // 绘制柱状体阴影背景
    this.model.setDrawBarShadow(false);
    // 柱状体上方显示数值
    this.model.setDrawValueAboveBar(false);
    // 为图表添加数据选择的监听器
    this.model.setOnChartValueSelectedListener(this._valueSelectedListener);
    // 设置左轴
    const leftAxis = this.model.getAxisLeft();
    if (leftAxis) {
      leftAxis.setAxisMinimum(0);
      leftAxis.setAxisLineColor(ChartColor.rgb(255, 255, 255));
      leftAxis.setGridColor(ChartColor.argb(60, 0, 0, 0));
      leftAxis.setTextColor(ChartColor.argb(200, 0, 0, 0));
      leftAxis.setLabelXOffset(-10);
    }
    // 设置右轴不显示
    this.model.getAxisRight()?.setEnabled(false);
    // 设置x轴
    const xAxis = this.model.getXAxis();
    if (xAxis) {
      xAxis.setValueFormatter(new MyAxisValueFormatter(this.chartData.time));
      xAxis.setPosition(XAxisPosition.BOTTOM);
      xAxis.setDrawGridLines(false);
      xAxis.setAxisLineColor(ChartColor.argb(60, 0, 0, 0));
      xAxis.setTextColor(ChartColor.argb(200, 0, 0, 0));
    }
    // 初始化图表数据
    this.getChartData();
  }

  async getChartData() {
    this.model.getXAxis()?.setValueFormatter(new MyAxisValueFormatter(this.chartData.time));
    const totalNum = 24;
    this.displayTime = [];
    for (let i = 1; i <= totalNum; i++) {
      const bill = this.chartData.data.find((item) => {
        const hour = item.date.split(':')[0];
        return Number(hour) === i;
      });
      if (bill) {
        this.displayTime.push({
          date: bill.date,
          value: bill.value,
        });
      } else {
        const clock = dayjs().set('hour', i).set('minute', 0);
        this.displayTime.push({
          date: clock.format('hh:mm'),
          value: 0,
        });
      }
    }
    await this.setData();
  }

  async setData() {
    let values: JArrayList<BarEntry> = new JArrayList<BarEntry>();
    for (let i = 0; i < this.displayTime.length; i++) {
      values.add(new BarEntry(i + 1, this.displayTime[i].value));
    }

    let dataSet: BarDataSet = new BarDataSet(values, 'DataSet');
    dataSet.setHighLightColor(this.highlightColor);
    dataSet.setColorByColor(this.initColor);
    dataSet.setDrawValues(false);
    // 显示数据格式化
    let dataSetList: JArrayList<IBarDataSet> = new JArrayList<IBarDataSet>();
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
  time: string;

  hours = ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00',
    '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00'];

  constructor(time: string) {
    this.time = time;
  }

  public getFormattedValue(value: number): string {
    const date = dayjs(this.time ? this.time : new Date()).set('hour', value).hour();
    return this.hours[date];
  }
}