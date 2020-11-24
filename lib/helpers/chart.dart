import 'package:fsm/views/bar_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

/// Create series list with multiple series
List<charts.Series<OrdinalSales, String>> createSampleData() {
  final globalSalesData = [
    new OrdinalSales('2014', 5000),
    new OrdinalSales('2015', 25000),
    new OrdinalSales('2016', 100000),
    new OrdinalSales('2017', 750000),
  ];

  final losAngelesSalesData = [
    new OrdinalSales('2014', 25),
    new OrdinalSales('2015', 50),
    new OrdinalSales('2016', 10),
    new OrdinalSales('2017', 20),
  ];

  return [
    new charts.Series<OrdinalSales, String>(
      id: 'Global Revenue',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: globalSalesData,
    ),
    new charts.Series<OrdinalSales, String>(
      id: 'Los Angeles Revenue',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: losAngelesSalesData,
    )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId)
    // Set the 'Los Angeles Revenue' series to use the secondary measure axis.
    // All series that have this set will use the secondary measure axis.
    // All other series will use the primary measure axis.
  ];
}
