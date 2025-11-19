// import 'package:chart_Linechart_app/model/developer_data.dart';
import 'package:chart_barchart_app/model/developer_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MultiLine extends StatefulWidget {
  const MultiLine({super.key});

  @override
  State<MultiLine> createState() => _MultiLineState();
}

class _MultiLineState extends State<MultiLine> {
  // Property
  late List<DeveloperData> data;
  late List<DeveloperData> data2;
  late TooltipBehavior tooltipBehavior;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    data2 = [];
    tooltipBehavior = TooltipBehavior(enable: true);
    addData();
  }

  addData() {
    data.add(DeveloperData(year: 2017, developers: 19000));
    data.add(DeveloperData(year: 2018, developers: 40000));
    data.add(DeveloperData(year: 2019, developers: 35000));
    data.add(DeveloperData(year: 2020, developers: 37000));
    data.add(DeveloperData(year: 2021, developers: 45000));

    data2.add(DeveloperData(year: 2017, developers: 9000));
    data2.add(DeveloperData(year: 2018, developers: 20000));
    data2.add(DeveloperData(year: 2019, developers: 17000));
    data2.add(DeveloperData(year: 2020, developers: 18000));
    data2.add(DeveloperData(year: 2021, developers: 23000));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiLine Chart'),
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
              // LineSeries : 가로축 막대그래프

              LineSeries<DeveloperData, int>(
                name: '사이트 수',
                dataSource: data,
                xValueMapper:(DeveloperData developers, _) => developers.year, 
                yValueMapper: (DeveloperData developers, _) => developers.developers,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,

                ),
                enableTooltip: true,
              ),
              LineSeries<DeveloperData, int>(
                name: '사이트 수',
                dataSource: data2,
                xValueMapper:(DeveloperData developers, _) => developers.year, 
                yValueMapper: (DeveloperData developers, _) => developers.developers,
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