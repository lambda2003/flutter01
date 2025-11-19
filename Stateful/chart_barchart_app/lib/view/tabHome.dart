// import 'package:chart_TabHomechart_app/model/developer_data.dart';
import 'package:chart_barchart_app/model/developer_data.dart';
import 'package:chart_barchart_app/view/bar.dart';
import 'package:chart_barchart_app/view/multi_lines.dart';
import 'package:chart_barchart_app/view/scatter.dart';
import 'package:chart_barchart_app/view/tab/barChart.dart';
import 'package:chart_barchart_app/view/tab/candleChart.dart';
import 'package:chart_barchart_app/view/tab/lineChart.dart';
import 'package:chart_barchart_app/view/tab/pieChart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with SingleTickerProviderStateMixin {
  // Property
  late List<ChartDataNew> data;
  late TooltipBehavior tooltipBehavior;
  late TabController controller;

  @override
  void dispose() {
    // controller.removeListener(_handleTabSelection);
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    data = [];
    tooltipBehavior = TooltipBehavior(enable: true);
    // controller.addListener(_handleTabSelection);
    addData();
  }



  addData() {
    data.add(
      ChartDataNew(
        year: 2017,
        data: {"open": 19000, "high": 40000, "low": 18500, 'close': 40000},
      ),
    );
    data.add(
      ChartDataNew(
        year: 2018,
        data: {"open": 40000.0, "high": 42000, "low": 35000, 'close': 35000},
      ),
    );
    data.add(
      ChartDataNew(
        year: 2019,
        data: {"open": 35000.0, "high": 45000, "low": 35000, 'close': 37000},
      ),
    );
    data.add(
      ChartDataNew(
        year: 2020,
        data: {"open": 37000.0, "high": 48000, "low": 33000, 'close': 45000},
      ),
    );
    data.add(
      ChartDataNew(
        year: 2021,
        data: {"open": 45000.0, "high": 49000, "low": 37000, 'close': 45000},
      ),
    );
  }

  addMoreData() {
     data.add(
      ChartDataNew(
        year: data[data.length-1].year+1,
        data: {"open": 45000.0, "high": 49000, "low": 37000, 'close': 45000},
      ),
    );
    setState(() {
      
    });
  }
  removeMoreData() {
    data.removeAt(0);
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabHome Chart'),
        actions: [
          IconButton(onPressed: ()=>addMoreData(), icon:Icon(Icons.add)),
          IconButton(onPressed: ()=>removeMoreData(), icon:Icon(Icons.remove)),
        ],
        bottom: TabBar(
          dividerColor: Colors.grey,
          indicatorColor: Colors.red[300],
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          labelColor: Colors.red,
          controller: controller,
          onTap: (index) {
            print('===== Current Index: $index');
            // Get.snackbar(
            //   'Current Index', 
            //   index.toString(),
            //   duration: Duration(milliseconds: 1000),
            //   backgroundColor: Colors.orange,
            //   snackPosition: SnackPosition.BOTTOM
            // );
          },
          tabs: [
            Tab(icon: Icon(Icons.bar_chart), text: 'Bar Chart'),
            Tab(icon: Icon(Icons.line_axis), text: 'Line Chart'),
            Tab(icon: Icon(Icons.candlestick_chart), text: 'Candle Chart'),
            Tab(icon: Icon(Icons.pie_chart), text: 'Pie chart'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          BarChart(data: data),
          LineChart(data: data),
          CandleChart(data: data),
          PieChart(data: data)
          // Scatter()
        ],
      ),
    );
  }
}
