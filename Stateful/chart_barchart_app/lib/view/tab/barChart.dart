// import 'package:chart_Linechart_app/model/developer_data.dart';
import 'package:chart_barchart_app/model/developer_data.dart';
import 'package:chart_barchart_app/util/logInController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {
  final List<ChartDataNew> data;
  BarChart({super.key, required this.data});
  
  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  // Property
 
  late TooltipBehavior tooltipBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tooltipBehavior = TooltipBehavior(enable: true);

  }

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line Chart'),
      ),
      body: Center(
        child: Column(
          children: [
             Obx(() => Text(LoginController.to.isLogin.toString())),
            ElevatedButton(onPressed: (){
              if(LoginController.to.isLogin == RxBool(true)){
                LoginController.to.logout();
                print(LoginController.to.isLogin.toString());
              }else{
                LoginController.to.login();
              
                print(LoginController.to.isLogin.toString());
              }
                setState(() {
                  
                });
            }, child: Text('login/out')),
            SizedBox(
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
            
                  ColumnSeries<ChartDataNew, int>(
                    name: '사이트 수',
                    dataSource: widget.data,
                    xValueMapper:(ChartDataNew data, _) => data.year, 
                    yValueMapper: (ChartDataNew data, _) => data.data['open'],
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
          ],
        ),
      ),
    );
  }
}