import 'package:flutter/material.dart';

import '../../utility.dart';
import '../../pnu/pnu.dart';

// Loading Icon
class Loading extends AnimatedWidget{
  AnimationController controller;
  static DateTime _manualUpdateTime = DateTime.utc(0);
  Loading({Key key, Animation<double> animation, AnimationController control}) : super(key: key, listenable: animation){
    controller = control;
  }

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.rotate(
        angle: animation.value,
        child: Container(
          padding: EdgeInsets.zero,
            child: IconButton(
              iconSize: 28,
              padding: EdgeInsets.zero,
              onPressed: () async{
                if(!controller.isAnimating)
                  if(DateTime.now().difference(_manualUpdateTime).inMinutes > 4){
                    controller.repeat();
                    await update(force : true).then((value) {
                        if(value) _manualUpdateTime = DateTime.now();
                    });
                    controller.stop();
                  }else{
                    showToastMessageTop("동기화는 5분에 한 번씩만 가능합니다.");
                  }
              }, 
              icon: Icon(Icons.refresh_rounded, color: Colors.blueAccent[100])
            )
        )
    );
  }
}
