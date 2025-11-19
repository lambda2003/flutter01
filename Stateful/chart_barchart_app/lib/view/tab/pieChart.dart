// import 'package:chart_PieChart_app/model/developer_data.dart';
import 'package:chart_barchart_app/model/developer_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  final List<ChartDataNew> data;
  PieChart({super.key, required this.data});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
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
      appBar: AppBar(title: Text('Pie Chart')),
      body: Center(
        child: SizedBox(
          width: 380,
          height: 600,
          child: SfCircularChart(
            title: ChartTitle(text: "Yearly Growth in the Flutter Community\n"),
            tooltipBehavior: tooltipBehavior,
            legend: Legend(isVisible: true),
            series: <CircularSeries<ChartDataNew, int>>[
              PieSeries(
                name: 'Pie Chart',
                dataSource: widget.data,
                explode: true,
                selectionBehavior: SelectionBehavior(enable: true),
                xValueMapper: (ChartDataNew data, _) => data.year,
                yValueMapper: (ChartDataNew data, _) => data.data['open'],
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
