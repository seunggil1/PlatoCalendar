// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

// Project imports:
import 'package:plato_calendar/etc/calendar_color.dart';
import 'package:plato_calendar/model/model.dart';

Future<int?> selectColor(
    BuildContext context, PlatoAppointment appointment) async {
  final colorScheme = Theme.of(context).colorScheme;

  final pickedColor = await showDialog<int>(
    context: context,
    builder: (context) {
      final borderColor = colorScheme.onSurface.withValues(alpha: 0.5);
      return AlertDialog(
        title: const Text('색상 설정'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: calendarColor.mapIndexed((index, color) {
            return GestureDetector(
              onTap: () => Navigator.pop(context, index),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor),
                ),
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
        ],
      );
    },
  );
  return pickedColor;
}
