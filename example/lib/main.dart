import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_openim_sdk_ffi/flutter_openim_sdk_ffi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int sumResult;
  late Future<int> sumAsyncResult;

  @override
  void initState() {
    super.initState();
    sumResult = 1;
    sumAsyncResult = Future.value(2);
    init();
  }

  Future<void> init() async {
    print(await OpenIMManager.init(
      apiAddr: 'https://web.muka.site/api',
      wsAddr: 'wss://web.muka.site/msg_gateway',
    ));
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as source in the package. '
                  'The native code is built as part of the Flutter Runner build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                Text(
                  'sum(1, 2) = $sumResult',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                FutureBuilder<int>(
                  future: sumAsyncResult,
                  builder: (BuildContext context, AsyncSnapshot<int> value) {
                    final displayValue = (value.hasData) ? value.data : 'loading';
                    return Text(
                      'await sumAsync(3, 4) = $displayValue',
                      style: textStyle,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    print(await OpenIM.version);
                    // OpenIM.iMManager.login(uid: '2131', token: '1231');
                  },
                  child: Text('version'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
