import 'package:flutter/material.dart';

class SelectableContainer extends StatefulWidget {
  final String title;
  final String imagePath;
  final int index;
  final int isSelectedIndex;

  const SelectableContainer({
    super.key,
    required this.title,
    required this.imagePath,
    required this.index,
    required this.isSelectedIndex,
  });

  @override
  State<SelectableContainer> createState() => _SelectableContainerState();
}

class _SelectableContainerState extends State<SelectableContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isSelectedIndex == widget.index
            ? Color(0xff65558F)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: widget.isSelectedIndex != widget.index
                          ? Color(0xff65558F)
                          : Colors.white,
                    ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                widget.imagePath,
                width: 125,
                height: 95,
              ),
            )
          ],
        ),
      ),
    );
  }
}
