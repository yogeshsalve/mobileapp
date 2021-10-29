import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orderapp/dashboard.dart';

class MonthlyPurchase extends StatefulWidget {
  late final Widget child;
  // MonthlyPurchase({required Key key, required this.child}) : super(key: key);
  @override
  _MonthlyPurchaseState createState() => _MonthlyPurchaseState();
}

class _MonthlyPurchaseState extends State<MonthlyPurchase> {
  late List<charts.Series<Pollution, String>> _seriesData;
  late List<charts.Series<Task, String>> _seriesPieData;
  late List<charts.Series<Sales, int>> _seriesLineData;
  // ignore: non_constant_identifier_names
  DateTime pre_backpress = DateTime.now();

  _generateData() {
    var data1 = [
      new Pollution(1980, 'NUT', 30),
      new Pollution(1980, 'BOLT', 40),
      new Pollution(1980, 'WASHER', 10),
    ];
    var data2 = [
      new Pollution(1985, 'NUT', 100),
      new Pollution(1980, 'BOLT', 150),
      new Pollution(1985, 'WASHER', 80),
    ];
    var data3 = [
      new Pollution(1985, 'NUT', 200),
      new Pollution(1980, 'BOLT', 300),
      new Pollution(1985, 'WASHER', 180),
    ];

    var piedata = [
      new Task('Work', 35.8, Color(0xff3366cc)),
      new Task('Eat', 8.3, Color(0xff990099)),
      new Task('Commute', 10.8, Color(0xff109618)),
      new Task('TV', 15.6, Color(0xfffdbe19)),
      new Task('Sleep', 19.2, Color(0xffff9900)),
      new Task('Other', 10.3, Color(0xffdc3912)),
    ];

    var linesalesdata = [
      new Sales(0, 45),
      new Sales(1, 56),
      new Sales(2, 55),
      new Sales(3, 60),
      new Sales(4, 61),
      new Sales(5, 70),
    ];
    var linesalesdata1 = [
      new Sales(0, 35),
      new Sales(1, 46),
      new Sales(2, 45),
      new Sales(3, 50),
      new Sales(4, 51),
      new Sales(5, 60),
    ];

    var linesalesdata2 = [
      new Sales(0, 20),
      new Sales(1, 24),
      new Sales(2, 25),
      new Sales(3, 40),
      new Sales(4, 45),
      new Sales(5, 60),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Air Pollution',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesData = <charts.Series<Pollution, String>>[];
    _seriesPieData = <charts.Series<Task, String>>[];
    _seriesLineData = <charts.Series<Sales, int>>[];
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            final snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false; // false will do nothing when back press
          } else {
            return true; // true will exit the app
          }
        },
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff1976d2),
              //backgroundColor: Color(0xff308e1c),
              bottom: TabBar(
                indicatorColor: Color(0xff9962D0),
                tabs: [
                  Tab(
                    icon: Icon(FontAwesomeIcons.solidChartBar),
                  ),
                  Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                  Tab(icon: Icon(FontAwesomeIcons.chartLine)),
                ],
              ),
              title: Text('Monthly Purchase'),
              leading: BackButton(
                  color: Colors.white,
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()))),
            ),
            body: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Monthly purchase Graph',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: charts.BarChart(
                              _seriesData,
                              animate: true,
                              barGroupingType: charts.BarGroupingType.grouped,
                              //behaviors: [new charts.SeriesLegend()],
                              animationDuration: Duration(seconds: 5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Time spent on daily tasks',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: charts.PieChart(_seriesPieData,
                                animate: true,
                                animationDuration: Duration(seconds: 5),
                                behaviors: [
                                  new charts.DatumLegend(
                                    outsideJustification:
                                        charts.OutsideJustification.endDrawArea,
                                    horizontalFirst: false,
                                    desiredMaxRows: 2,
                                    cellPadding: new EdgeInsets.only(
                                        right: 4.0, bottom: 4.0),
                                    entryTextStyle: charts.TextStyleSpec(
                                        color: charts.MaterialPalette.purple
                                            .shadeDefault,
                                        fontFamily: 'Georgia',
                                        fontSize: 11),
                                  )
                                ],
                                defaultRenderer: new charts.ArcRendererConfig(
                                    arcWidth: 100,
                                    arcRendererDecorators: [
                                      new charts.ArcLabelDecorator(
                                          labelPosition:
                                              charts.ArcLabelPosition.inside)
                                    ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Purchase for the Last Month',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: charts.LineChart(_seriesLineData,
                                defaultRenderer: new charts.LineRendererConfig(
                                    includeArea: true, stacked: true),
                                animate: true,
                                animationDuration: Duration(seconds: 5),
                                behaviors: [
                                  new charts.ChartTitle('Months',
                                      behaviorPosition:
                                          charts.BehaviorPosition.bottom,
                                      titleOutsideJustification: charts
                                          .OutsideJustification.middleDrawArea),
                                  new charts.ChartTitle('Purchases',
                                      behaviorPosition:
                                          charts.BehaviorPosition.start,
                                      titleOutsideJustification: charts
                                          .OutsideJustification.middleDrawArea),
                                  new charts.ChartTitle(
                                    'Departments',
                                    behaviorPosition:
                                        charts.BehaviorPosition.end,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea,
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<charts.Series<Pollution, String>>(
        '_seriesData', _seriesData));
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
