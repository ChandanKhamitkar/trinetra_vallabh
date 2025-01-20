// ignore_for_file: deprecated_member_use, non_constant_identifier_names, avoid_print
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekCalendar extends StatefulWidget {
  final Function onDayChange;
  const WeekCalendar({
    super.key,
    required this.onDayChange,
  });

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  late String formattedDate;
  late List<int> daysOfWeek;
  final List<String> daysShort = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  int selectedDay = DateTime.now().weekday - 1;

  @override
  void initState() {
    super.initState();
    _updateDateAndDays();
  }

  void _updateDateAndDays() {
    DateTime now = DateTime.now();

    setState(() {
      formattedDate = DateFormat.yMMMM().format(now);

      // 1. Calculate the start of the week (Monday)
      int currentWeekday = now.weekday;
      DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));

      // 2. Generate days from Monday to Saturday
      daysOfWeek = List.generate(
          6, (index) => startOfWeek.add(Duration(days: index)).day);
    });
  }

  void _updateSelectedDay(int newIndex) {
    if(mounted){
      setState(() {
        selectedDay = newIndex;
      });
    }
      widget.onDayChange(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formattedDate,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Color(0xff6B579D), fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 1,
        ),
        SizedBox(
          width: 51,
          child: Divider(
            color: Color(0xff6B579D),
            thickness: 2,
          ),
        ),
        Container(
          width: double.infinity,
          height: 94,
          decoration: BoxDecoration(
            color: Color(0xffE9E7E7).withOpacity(0.66),
            borderRadius: BorderRadius.circular(28),
          ),
          margin: EdgeInsets.only(
            top: 14,
            bottom: 14,
            left: 10,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(6, (index) {
              int dayNumber = daysOfWeek[index];
              String dayShortStr = daysShort[index];
              bool isSelected = index == selectedDay;
              return _dayNumberBox(context, dayNumber.toString(), dayShortStr,
                  isSelected, index);
            }),
          ),
        )
      ],
    );
  }

  Widget _dayNumberBox(BuildContext Context, String dayNum, String dayShort,
      bool isSelected, int index) {
    return InkWell(
      onTap: () {
        _updateSelectedDay(index);
      },
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: isSelected ? Color(0xff6B579D) : Color(0xffF0F0F8),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]),
            alignment: Alignment.center,
            child: Text(
              dayNum,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? Colors.white : Color(0xff909095),
                  ),
            ),
          ),
          Text(
            dayShort,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected ? Color(0xff65558F) : Color(0xff79747E),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500),
          )
        ],
      ),
    );
  }
}
