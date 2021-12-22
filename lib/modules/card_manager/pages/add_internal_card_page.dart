import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:secman_parking/modules/card_manager/blocs/add/add_internal_card_bloc.dart';

class AddInternalCardPage extends StatefulWidget {
  const AddInternalCardPage({Key? key}) : super(key: key);

  @override
  State<AddInternalCardPage> createState() => _AddInternalCardPageState();
}

class _AddInternalCardPageState extends State<AddInternalCardPage> {
  AddInternalCardBloc? get bloc =>
      BlocProvider.of<AddInternalCardBloc>(context);

  FormGroup buildForm() => FormGroup({
        'id': FormControl<String>(validators: [Validators.required]),
        'vehicle_owner': FormControl<String>(validators: [Validators.required]),
        'phone_number': FormControl<String>(validators: [
          Validators.required,
          Validators.number,
          Validators.minLength(10),
        ]),
        'unit': FormControl<String>(validators: [Validators.required]),
        'vehicle_type': FormControl<String>(validators: [Validators.required]),
        'sub_vehicle': FormControl<String>(validators: [
          Validators.required,
          Validators.minLength(2),
        ]),
        'vehicle_number': FormControl<String>(validators: [
          Validators.required,
          Validators.minLength(4),
        ]),
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm thẻ nội bộ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ReactiveFormBuilder(
          form: buildForm,
          builder: (context, form, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ReactiveTextField<String>(
                    formControlName: 'id',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Không được để trống',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'id',
                      helperStyle: TextStyle(height: 0.7),
                      errorStyle: TextStyle(height: 0.7),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReactiveTextField<String>(
                    formControlName: 'vehicle_owner',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Không được để trống',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Tên chủ xe',
                      helperStyle: TextStyle(height: 0.7),
                      errorStyle: TextStyle(height: 0.7),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReactiveTextField<String>(
                    formControlName: 'phone_number',
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Không được để trống',
                      ValidationMessage.number: 'Không hợp lệ',
                      ValidationMessage.maxLength: 'Không hợp lệ',
                      ValidationMessage.minLength: 'Không hợp lệ',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Số điện thoại',
                      helperStyle: TextStyle(height: 0.7),
                      errorStyle: TextStyle(height: 0.7),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReactiveTextField<String>(
                    formControlName: 'unit',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Không được để trống',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Đơn vị',
                      helperStyle: TextStyle(height: 0.7),
                      errorStyle: TextStyle(height: 0.7),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReactiveDropdownField<String>(
                    formControlName: 'vehicle_type',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Không được để trống',
                    },
                    decoration: const InputDecoration(
                      labelText: 'Loại xe',
                      helperStyle: TextStyle(height: 0.7),
                      errorStyle: TextStyle(height: 0.7),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Xe số',
                        child: Text('Xe số'),
                      ),
                      DropdownMenuItem(
                        value: 'Xe ga',
                        child: Text('Xe ga'),
                      ),
                      DropdownMenuItem(
                        value: 'Xe ôtô',
                        child: Text('Xe ôtô'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ReactiveTextField<String>(
                    formControlName: 'sub_vehicle',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Không được để trống',
                      ValidationMessage.maxLength: 'Không hợp lệ',
                      ValidationMessage.minLength: 'Không hợp lệ',
                    },
                    textInputAction: TextInputAction.next,
                    maxLength: 8,
                    decoration: const InputDecoration(
                      labelText: 'Mã vùng/Seri',
                      helperStyle: TextStyle(height: 0.7),
                      errorStyle: TextStyle(height: 0.7),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReactiveTextField<String>(
                    formControlName: 'vehicle_number',
                    keyboardType: TextInputType.number,
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Không được để trống',
                      ValidationMessage.maxLength: 'Không hợp lệ',
                      ValidationMessage.minLength: 'Không hợp lệ',
                    },
                    maxLength: 6,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Số xe',
                      helperStyle: TextStyle(height: 0.7),
                      errorStyle: TextStyle(height: 0.7),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Divider(height: 50),
                  ElevatedButton(
                    onPressed: () => _submitForm(form),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        'Thêm',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(FormGroup form) {
    if (form.valid) {
      bloc!.add(AddInternalCard(mapValue: form.value));
      Navigator.pop(context);
    } else {
      form.markAllAsTouched();
    }
  }
}
