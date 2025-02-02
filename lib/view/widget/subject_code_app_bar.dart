import 'package:flutter/material.dart';

AppBar getSubjectCodeAppBarWidget(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return AppBar(
    elevation: 0,
    title: Row(
      children: [
        const SizedBox(width: 5),
        Expanded(
            child: DropdownButton<String>(
          value: '전체',
          icon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
          isExpanded: true,
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: colorScheme.primary,
          ),
          onChanged: (String? newValue) {},
          items: <String>['전체', '전공', '교양', '기타']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: TextStyle(
                      color: colorScheme.primary, fontWeight: FontWeight.bold)),
            );
          }).toList(),
        ))
      ],
    ),
  );
}
