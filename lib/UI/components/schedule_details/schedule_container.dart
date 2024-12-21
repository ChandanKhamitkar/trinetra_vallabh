// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ScheduleContainer extends StatefulWidget {
  final String fromTime;
  final String toTime;
  final String duration;
  final String title;
  final String description;

  const ScheduleContainer({
    super.key,
    required this.fromTime,
    required this.toTime,
    required this.duration,
    required this.title,
    this.description = "",
  });

  @override
  State<ScheduleContainer> createState() => _ScheduleContainerState();
}

class _ScheduleContainerState extends State<ScheduleContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.fromTime,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700, color: Color(0xff65558f)),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  widget.toTime,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500, color: Color(0xff65558f)),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  widget.duration,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff65558f).withOpacity(0.5),
                      ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OVERLINE',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff49454F),
                        ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff1D1B20),
                        ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Color(0xff49454F),
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Color(0xffCAC4D0),
          thickness: 1.0,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}
