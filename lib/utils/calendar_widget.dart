import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart' as cc;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:realtime_innovations_assignment2/constants/colors.dart';

import 'device.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget(
      {required this.onDaySelected,
      this.maxSelectedDate,
      required this.noDateDaySelected,
      this.noDaySelectedView = false});

  final Function(DateTime) onDaySelected;
  final Function(bool) noDateDaySelected;
  final bool noDaySelectedView;
  final DateTime? maxSelectedDate;

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _calenderSelectedDate = DateTime.now();
  bool todayButtonView = true;
  bool nextMondayButtonView = false;
  bool nextTuesdayButtonView = false;
  bool afterOneWeekButtonView = false;
  bool noDateButtonView = true;
  bool noDateTodayButtonView = false;

  @override
  void initState() {
    widget.onDaySelected(_calenderSelectedDate);
    widget.noDateDaySelected(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            if (widget.noDaySelectedView == false) ...<Widget>[
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: elevatedButtonView(
                          text: 'Today',
                          bgColor: todayButtonView
                              ? AppColors.themeColor
                              : AppColors.themeColorTransparent,
                          textColor: todayButtonView
                              ? Colors.white
                              : AppColors.themeColor,
                          onButtonTap: () {
                            setState(() {
                              todayButtonView = true;
                              nextTuesdayButtonView =false;
                              nextMondayButtonView=false;
                              afterOneWeekButtonView =false;
                              _calenderSelectedDate = DateTime.now();
                            });
                          }),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: elevatedButtonView(
                        text: 'Next Monday',
                        bgColor: nextMondayButtonView
                            ? AppColors.themeColor
                            : AppColors.themeColorTransparent,
                        textColor: nextMondayButtonView
                            ? Colors.white
                            : AppColors.themeColor,
                        onButtonTap: () {
                          setState(() {
                            todayButtonView = false;
                            nextTuesdayButtonView =false;
                            nextMondayButtonView=true;
                            afterOneWeekButtonView =false;

                            var monday = 1;
                            var now = DateTime.now();

                            while (now.weekday != monday) {
                              now = now.add(const Duration(days: 1));
                              _calenderSelectedDate = now;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: elevatedButtonView(
                        text: 'Next Tuesday',
                        bgColor: nextTuesdayButtonView
                            ? AppColors.themeColor
                            : AppColors.themeColorTransparent,
                        textColor: nextTuesdayButtonView
                            ? Colors.white
                            : AppColors.themeColor,
                        onButtonTap: () {
                          setState(() {
                            todayButtonView = false;
                            nextTuesdayButtonView =true;
                            nextMondayButtonView=false;
                            afterOneWeekButtonView =false;
                            nextTuesdayView();

                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: elevatedButtonView(
                        text: 'After 1 week',
                        bgColor: afterOneWeekButtonView
                            ? AppColors.themeColor
                            : AppColors.themeColorTransparent,
                        textColor: afterOneWeekButtonView
                            ? Colors.white
                            : AppColors.themeColor,
                        onButtonTap: () {
                          setState(() {
                            todayButtonView = false;
                            nextTuesdayButtonView =false;
                            nextMondayButtonView=false;
                            afterOneWeekButtonView =true;
                            afterOneWeekView();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...<Widget>[
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: DeviceUtils.getDeviceWidth(context) / 2.5,
                      child: elevatedButtonView(
                        text: 'No Date',
                        bgColor: noDateButtonView
                            ? AppColors.themeColor
                            : AppColors.themeColorTransparent,
                        textColor: noDateButtonView
                            ? Colors.white
                            : AppColors.themeColor,
                        onButtonTap: () {
                          setState(() {
                            noDateButtonView =true;
                            noDateTodayButtonView =false;
                            widget.noDateDaySelected(noDateButtonView);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: DeviceUtils.getDeviceWidth(context) / 2.5,
                      child: elevatedButtonView(
                        text: 'Today',
                        bgColor: noDateTodayButtonView
                            ? AppColors.themeColor
                            : AppColors.themeColorTransparent,
                        textColor: noDateTodayButtonView
                            ? Colors.white
                            : AppColors.themeColor,
                        onButtonTap: () {
                          setState(() {
                            noDateButtonView =false;
                            noDateTodayButtonView =true;
                            _calenderSelectedDate = DateTime.now();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
            buildShowCalender(context),
            divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              //  mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 4),
                  child: Image.asset(
                    "assets/image/calender_today_icon.png",
                    color: AppColors.themeColor,
                    height: 20,
                  ),
                ),
                Text(noDateButtonView == true
                    ? 'No Date'
                    : '${DateFormat('dd MMM yy').format(_calenderSelectedDate)} '),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColorTransparent,
                    elevation: 0,
                    shadowColor: Colors.transparent.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // <-- Radius
                    ),
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(color: AppColors.themeColor)),
                ),
                const SizedBox(
                  width: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onDaySelected(_calenderSelectedDate);
                      Navigator.pop(
                          context, widget.onDaySelected(_calenderSelectedDate));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      elevation: 0,
                      shadowColor: Colors.transparent.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // <-- Radius
                      ),
                    ),
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void afterOneWeekView() {
    var now = DateTime.now();
    _calenderSelectedDate = DateTime(now.year, now.month, now.day + 7);
  }

  void nextTuesdayView() {
    var tuesday = 2;
    var now = DateTime.now();

    while (now.weekday != tuesday) {
      now = now.add(const Duration(days: 1));
      _calenderSelectedDate = now;
    }
  }

  Container buildShowCalender(BuildContext context) {
    return Container(
      color: Colors.white,
      height: widget.noDaySelectedView ? 315 : 275,
      width: DeviceUtils.getDeviceWidth(context),
      child: CalendarCarousel<cc.Event>(
        onDayPressed: (DateTime date, List<cc.Event> events) {
          setState(() => refresh(date));
        },
        selectedDateTime: _calenderSelectedDate,
        weekdayTextStyle: const TextStyle(color: AppColors.black),
        headerTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        headerMargin: EdgeInsets.zero,
        iconColor: Colors.grey,
        showOnlyCurrentMonthDate: true,
        dayPadding: 2,
        weekDayMargin: EdgeInsets.zero,
        customDayBuilder: (bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day) {
          if (day.day == 15) {
            textStyle = const TextStyle(color: Colors.black);
          }
          return null;
        },
        maxSelectedDate: widget.maxSelectedDate,
        todayBorderColor: Colors.blue,
        todayButtonColor: Colors.transparent,
        todayTextStyle: const TextStyle(color: Colors.black),
        height: DeviceUtils.getDeviceHeight(context) / 2,
        selectedDayTextStyle: const TextStyle(color: Colors.white),
        selectedDayButtonColor: AppColors.themeColor,
        selectedDayBorderColor: widget.noDaySelectedView
            ? Colors.transparent
            : AppColors.themeColor,
        daysHaveCircularBorder: true,
        weekendTextStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  void refresh(DateTime date) {
    setState(() {
      _calenderSelectedDate = date;
      widget.onDaySelected(date);
    });
  }

  ElevatedButton elevatedButtonView(
      {required String text,
      required VoidCallback onButtonTap,
      Color? bgColor,
      Color? textColor}) {
    return ElevatedButton(
      onPressed: onButtonTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? AppColors.themeColorTransparent,
        elevation: 0,
        shadowColor: Colors.transparent.withOpacity(0.1),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // <-- Radius
        ),
      ),
      child: Text(text,
          style: TextStyle(color: textColor ?? AppColors.themeColor)),
    );
  }

  Divider divider() =>
      Divider(thickness: 0.5, color: AppColors.lightGrayColor.withOpacity(0.5));
}
