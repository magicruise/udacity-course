// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// Dart Auto Formatter
// menu > Code > Reformat Code with dartfmt

// container widget 함수화
/* fixed
Widget helloRectangle() {
  return Container(
      color: Colors.greenAccent,
  );
}
*/

// stateless widget
class HelloRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(//Container( // alt+enter while cursors inside that container you want to wrap
      child: Container(
        color: Colors.greenAccent,
        height: 400.0,
        width: 300.0,
        child: Center( // The center widget above the container only applies to its immediate child
          child: Text(
            'Hello!',
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
    );
  }
}

void main() {
  //print('Hello!'); // 디버깅 콘솔에서 확인용

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Rectangle'),
        ),
        /*
        body: Container(
        color: Colors.greenAccent,
        */
        // body: helloRectangle(),
        body: HelloRectangle(),
      ), // 위젯의 속성 다음에 반드시 쉼표; 서식 지정에 도움
    ),
  );
}

/* 처음
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello Rectangle',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Rectangle'),
        ),
        body: HelloRectangle(),
      ),
    ),
  );
}

class HelloRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.greenAccent,
        height: 400.0,
        width: 300.0,
        child: Center(
          child: Text(
            'Hello!',
            style: TextStyle(fontSize: 40.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
*/
