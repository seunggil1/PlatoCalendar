import 'package:flutter/material.dart';

Widget durationHeaderWidget(String str, int index) {
  return Container(
      margin: const EdgeInsets.all(5),
      // child 없는 빈 Container도 터치 감지할 수 있게 하기 위해 설정
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          // TODO : 누르면 해당하는 기간 fold / unfold 되게 하기
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(str, style: TextStyle(fontSize: 15)),
              Expanded(child: Container()),
              Icon(Icons.keyboard_arrow_up_sharp,
                  // : Icons.keyboard_arrow_down_sharp,
                  color: Colors.blueAccent[100],
                  size: 27),
            ],
          )));
}
