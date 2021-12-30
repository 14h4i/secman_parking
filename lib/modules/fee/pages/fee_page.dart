import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secman_parking/common/widgets/statefull/app_drawer.dart';
import 'package:secman_parking/common/widgets/stateless/animated_couter.dart';
import 'package:secman_parking/common/widgets/stateless/circular_progress_center.dart';
import 'package:secman_parking/common/widgets/stateless/text_error.dart';
import 'package:secman_parking/modules/fee/blocs/fee_bloc.dart';
import 'package:secman_parking/themes/app_text_style.dart';

class FeePage extends StatefulWidget {
  const FeePage({Key? key}) : super(key: key);

  @override
  _FeePageState createState() => _FeePageState();
}

class _FeePageState extends State<FeePage> {
  FeeBloc? get feeBloc => BlocProvider.of<FeeBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý tiền'),
      ),
      body: BlocBuilder<FeeBloc, FeeState>(
        bloc: feeBloc,
        builder: (context, state) {
          if (state is FeeFailure) {
            return TextError(error: state.error);
          }

          if (state is GetListFeeSuccess) {
            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.orange.shade200,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AutoSizeText(
                          'Tổng cộng',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        AnimatedCouter(
                          value: state.total,
                          textStyle: AppTextStyle.h2,
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  children: [
                                    const AutoSizeText(
                                      'Đã thu',
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    AnimatedCouter(
                                      value: state.collected,
                                      textStyle: AppTextStyle.h2
                                          .copyWith(fontSize: 60),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.red.shade200,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const AutoSizeText(
                                      'Chưa thu',
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    AnimatedCouter(
                                      value: state.notCollected,
                                      textStyle: AppTextStyle.h2
                                          .copyWith(fontSize: 60),
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
            );
          }

          return const CircularProgressCenter(
            color: Colors.blue,
          );
        },
      ),
    );
  }
}
