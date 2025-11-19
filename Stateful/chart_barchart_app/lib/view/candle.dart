// import 'package:chart_Candlechart_app/model/developer_data.dart';
import 'package:chart_barchart_app/model/candle_data.dart';
import 'package:chart_barchart_app/model/developer_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Candle extends StatefulWidget {
  const Candle({super.key});

  @override
  State<Candle> createState() => _CandleState();
}

class _CandleState extends State<Candle> {
  // Property
  late List<CandleData> data;
  late TooltipBehavior tooltipBehavior;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    tooltipBehavior = TooltipBehavior(enable: true);
    addData();
  }

  addData() {
    data.add(CandleData(year: 2017, open: 1, high: 4, low: 0.5, close: 1));
    data.add(CandleData(year: 2018, open: 1, high: 6, low: 0.9, close: 5));
    data.add(CandleData(year: 2019, open: 5, high: 8, low: 3.4, close: 1));
    data.add(CandleData(year: 2020, open: 1, high: 4, low: 0.5, close: 1));


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candle Chart'),
      ),
      body: Center(
        child: SizedBox(
          width: 380,
          height: 600,
          child: SfCartesianChart(
            title: ChartTitle(
              text: "Yearly Growth in the Flutter Community\n"
            ),
            tooltipBehavior: tooltipBehavior,
            legend: Legend(isVisible: true),
            series: [

              // ColumnSeries : 세로축 막대그래프
              // CandleSeries : 가로축 막대그래프

              CandleSeries<CandleData, int>(
                name: '사이트 수',
                dataSource: data,
                xValueMapper:(CandleData candleData, _) => candleData.year, 
                lowValueMapper: (CandleData candleData, _) => candleData.low, 
                highValueMapper: (CandleData candleData, _) => candleData.high, 
                openValueMapper: (CandleData candleData, _) => candleData.open, 
                closeValueMapper: (CandleData candleData, _) => candleData.close, 
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,

                ),
                enableTooltip: true,
              )
            ],
            // X축을 Category로 표현.
            primaryXAxis: CategoryAxis(
              title: AxisTitle(text:'년도'),
            ),
            // Y 축은 숫자로 표현
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: '사이트 수')
            ),

          )
        ),
      ),
    );
  }
}