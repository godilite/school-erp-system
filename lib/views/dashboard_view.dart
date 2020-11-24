import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:fsm/helpers/chart.dart';
import 'package:fsm/theme.dart';
import 'package:fsm/views/bar_chart.dart';
import 'package:intl/intl.dart' show DateFormat;

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DateTime _currentDate = DateTime(2020, 10, 7);
  DateTime _currentDate2 = DateTime(2020, 10, 7);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2020, 10, 7));
  DateTime _targetDateTime = DateTime(2020, 10, 7);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  CalendarCarousel _calendarCarouselNoHeader;

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2019, 2, 25),
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2019, 2, 10),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2019, 2, 11), [
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.08,
            decoration: BoxDecoration(
                color: drawbackgroundColor,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.7,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Search',
                              icon: Icon(Icons.search),
                              border: InputBorder.none),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircleAvatar(),
                  )
                ]),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: constraints.maxHeight * 0.30,
                    margin: EdgeInsets.only(top: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: drawbackgroundColor,
                    ),
                    width: constraints.maxWidth * 0.67,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.2,
                          height: constraints.maxHeight * 0.15,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 6,
                                    color: Colors.grey.shade300),
                                BoxShadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 10,
                                    color: Colors.grey.shade100)
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white54),
                          child: Stack(children: [
                            Positioned(
                                top: 30,
                                bottom: 0,
                                left: 30,
                                child: Text(
                                  '1000+',
                                  style: listTileDefaultTextStyle,
                                )),
                            Positioned(
                              top: 60,
                              bottom: 0,
                              left: 30,
                              child: Text(
                                'Students',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Positioned(
                                top: 30,
                                bottom: 0,
                                right: 20,
                                child: Image.asset('images/003-bar-graph.png')),
                          ]),
                        ),
                        Container(
                          width: constraints.maxWidth * 0.2,
                          height: constraints.maxHeight * 0.15,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 6,
                                    color: Colors.grey.shade300),
                                BoxShadow(
                                    blurRadius: 10, color: Colors.grey.shade100)
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white54),
                          child: Stack(children: [
                            Positioned(
                                top: 30,
                                bottom: 0,
                                left: 30,
                                child: Text(
                                  '294',
                                  style: listTileDefaultTextStyle,
                                )),
                            Positioned(
                              top: 60,
                              bottom: 0,
                              left: 30,
                              child: Text(
                                'Teachers',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Positioned(
                                top: 30,
                                bottom: 0,
                                right: 20,
                                child:
                                    Image.asset('images/002-bar-chart-1.png')),
                          ]),
                        ),
                        Container(
                          width: constraints.maxWidth * 0.2,
                          height: constraints.maxHeight * 0.15,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 6,
                                    color: Colors.grey.shade300),
                                BoxShadow(
                                    blurRadius: 10, color: Colors.grey.shade100)
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white54),
                          child: Stack(children: [
                            Positioned(
                                top: 30,
                                bottom: 0,
                                left: 30,
                                child: Text(
                                  '50+',
                                  style: listTileDefaultTextStyle,
                                )),
                            Positioned(
                              top: 60,
                              bottom: 0,
                              left: 30,
                              child: Text(
                                'Administrators',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Positioned(
                                top: 30,
                                bottom: 0,
                                right: 20,
                                child: Image.asset('images/barchart.png')),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.67,
                    height: constraints.maxHeight * 0.5,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: drawbackgroundColor,
                    ),
                    child: BarChartWithSecondaryAxis(
                      createSampleData(),
                      animate: true,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Chart Showing Students Yearly Distribution'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Male'),
                        Container(color: Colors.blue, width: 10, height: 10),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Female'),
                        Container(
                            color: Colors.lightBlueAccent,
                            width: 10,
                            height: 10)
                      ])
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: drawbackgroundColor,
                      ),
                      width: constraints.maxWidth * 0.30,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  _currentMonth,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                )),
                                FlatButton(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 10,
                                    child: Icon(Icons.arrow_back_ios_outlined,
                                        size: 10, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _targetDateTime = DateTime(
                                          _targetDateTime.year,
                                          _targetDateTime.month - 1);
                                      _currentMonth = DateFormat.yMMM()
                                          .format(_targetDateTime);
                                    });
                                  },
                                ),
                                FlatButton(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 10,
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _targetDateTime = DateTime(
                                          _targetDateTime.year,
                                          _targetDateTime.month + 1);
                                      _currentMonth = DateFormat.yMMM()
                                          .format(_targetDateTime);
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            height: constraints.maxHeight * 0.4,
                            child: _calendarCarouselNoHeader,
                          ), //
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                        width: constraints.maxWidth * 0.3,
                        height: constraints.maxHeight * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: drawbackgroundColor,
                        ),
                        child: Column(
                          children: [
                            Text(
                              '2019/2020',
                              style: listTileDefaultTextStyle,
                            ),
                            Text('Academic Calendar'),
                            Expanded(
                              child: ListView(shrinkWrap: true, children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.circle,
                                    color: listTileSelectedTextStyle.color,
                                    size: 15,
                                  ),
                                  title: Text('Management meeting'),
                                  trailing: Text('20/01/2020',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.circle,
                                    color: listTileSelectedTextStyle.color,
                                    size: 15,
                                  ),
                                  title: Text('Staff Meeting'),
                                  trailing: Text('20/01/2020',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.circle,
                                    size: 15,
                                    color: listTileSelectedTextStyle.color,
                                  ),
                                  title: Text('Resumption Date'),
                                  trailing: Text('20/01/2020',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.circle,
                                    color: listTileSelectedTextStyle.color,
                                    size: 15,
                                  ),
                                  title: Text('Lecture starts'),
                                  trailing: Text('20/01/2020',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                              ]),
                            )
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ],
      );
    });
  }
}
