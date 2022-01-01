import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_pin_code_fields/reactive_pin_code_fields.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'pass': FormControl<String>(value: null),
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AutoSizeText(
                  'Nhập mật khẩu',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 20),
                ReactivePinCodeTextField<String>(
                  formControlName: 'pass',
                  length: 6,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w900),
                  onCompleted: (value) {
                    if (form.valid) {
                      // ignore: avoid_print
                      print(form.value);
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
