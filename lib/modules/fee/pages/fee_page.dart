import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/statefull/app_drawer.dart';

class FeePage extends StatefulWidget {
  const FeePage({Key? key}) : super(key: key);

  @override
  _FeePageState createState() => _FeePageState();
}

class _FeePageState extends State<FeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý tiền'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.orange.shade200,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  AutoSizeText(
                    'Tổng cộng',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  AutoSizeText(
                    '2500000',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       width: 3,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.blue.shade200,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              AutoSizeText(
                                'Đã thu',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              AutoSizeText(
                                '2500000',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 90,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(horizontal: 0),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       width: 3,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                          color: Colors.red.shade200,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              AutoSizeText(
                                'Chưa thu',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              AutoSizeText(
                                '2500000',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 90,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.orange.shade200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                          onPressed: () {},
                          child: const Text('Thu phí'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Cập nhật'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
