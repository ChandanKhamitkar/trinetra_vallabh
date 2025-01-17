// ignore_for_file: deprecated_member_use, non_constant_identifier_names
import 'package:flutter/material.dart';

class WeekCalendar extends StatefulWidget {
  const WeekCalendar({super.key});

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "March 2025",
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
            children: [
              _dayNumberBox(context, '01', 'Mon', true),
              _dayNumberBox(context, '02', 'Tue', false),
              _dayNumberBox(context, '03', 'Wed', false),
              _dayNumberBox(context, '04', 'Thu', false),
              _dayNumberBox(context, '05', 'Fri', false),
              _dayNumberBox(context, '06', 'Sat', false),
            ],
          ),
        )
      ],
    );
  }

  Widget _dayNumberBox(
      BuildContext Context, String dayNum, String dayShort, bool isSelected) {
    return Column(
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
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
