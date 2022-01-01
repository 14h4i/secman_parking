import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:secman_parking/route/route_name.dart';
import 'package:secman_parking/themes/app_text_style.dart';
import 'package:secman_parking/utils/ui_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FormGroup buildForm() => fb.group({
        'phone':
            FormControl<String>(value: null, validators: [Validators.required]),
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: Image.asset(
              UIData.logoSecman,
            ),
          ),
          ReactiveFormBuilder(
            form: buildForm,
            builder: (context, form, child) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'phone',
                      validationMessages: (control) => {
                        ValidationMessage.required: 'Không được để trống',
                      },
                      style: AppTextStyle.h3,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.phone_android,
                          size: 30,
                        ),
                        labelText: 'Nhập số điện thoại',
                        labelStyle: AppTextStyle.h3,
                        helperStyle: TextStyle(height: 0.7),
                        errorStyle: TextStyle(height: 0.7),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          'Đăng nhập',
                          maxLines: 1,
                          style: AppTextStyle.h3,
                        ),
                      ),
                      onPressed: () {
                        if (form.valid) {
                          // ignore: avoid_print
                          print(form.value);
                          Navigator.pushNamed(context, RouteName.pinCodePage);
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
        ],
      ),
    );
  }

  void _onPress() {
    Navigator.pushNamed(context, RouteName.pinCodePage);
  }
}
