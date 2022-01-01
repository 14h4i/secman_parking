import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_pin_code_fields/reactive_pin_code_fields.dart';
import 'package:secman_parking/route/route_name.dart';

class PinCodePage extends StatelessWidget {
  const PinCodePage({Key? key}) : super(key: key);

  FormGroup _buildForm() => fb.group({
        'pin': FormControl<String>(value: null),
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReactiveFormBuilder(
        form: _buildForm,
        builder: (context, form, child) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AutoSizeText(
                  'Nhập mã OTP',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 20),
                ReactivePinCodeTextField<String>(
                  formControlName: 'pin',
                  length: 6,
                  keyboardType: TextInputType.number,
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w900),
                  onCompleted: (value) {
                    if (form.valid) {
                      // ignore: avoid_print
                      print(form.value);

                      Navigator.pushReplacementNamed(
                          context, RouteName.passwordPage);
                    } else {
                      form.markAllAsTouched();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
