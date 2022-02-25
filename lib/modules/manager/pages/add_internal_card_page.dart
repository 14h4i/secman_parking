import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:secman_parking/common/widgets/stateless/text_error.dart';
import 'package:secman_parking/modules/manager/blocs/manager_bloc.dart';
import 'package:secman_parking/modules/manager/widgets/scan_nfc_bottom_sheet.dart';

class AddInternalCardPage extends StatefulWidget {
  const AddInternalCardPage({Key? key}) : super(key: key);

  @override
  State<AddInternalCardPage> createState() => _AddInternalCardPageState();
}

class _AddInternalCardPageState extends State<AddInternalCardPage> {
  ManagerBloc? get bloc => BlocProvider.of<ManagerBloc>(context);

  String id = '...';

  final _nfc = NfcManager.instance;

  @override
  void initState() {
    _startNfc();
    super.initState();
  }

  FormGroup buildForm() => FormGroup({
        'id': FormControl<String>(validators: [Validators.required], value: id),
        'vehicle_owner': FormControl<String>(validators: [Validators.required]),
        'phone_number': FormControl<String>(validators: [
          Validators.required,
          Validators.number,
          Validators.minLength(10),
        ]),
        'unit': FormControl<String>(validators: [Validators.required]),
        'vehicle_type': FormControl<String>(validators: [Validators.required]),
        'vehicle_number': FormControl<String>(validators: [
          Validators.required,
          Validators.minLength(6),
        ]),
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerBloc, ManagerState>(
      builder: (context, state) {
        if (state is ManagerFailure) {
          return Scaffold(
            body: TextError(error: state.error),
          );
        }

        if (state is CheckNewCardComplete) {
          if (state.status) {
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
                            readOnly: true,
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
                            formControlName: 'vehicle_number',
                            validationMessages: (control) => {
                              ValidationMessage.required: 'Không được để trống',
                              ValidationMessage.maxLength: 'Không hợp lệ',
                              ValidationMessage.minLength: 'Không hợp lệ',
                            },
                            maxLength: 11,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              labelText: 'Số xe - VD: 63F1-123.45',
                              helperStyle: TextStyle(height: 0.7),
                              errorStyle: TextStyle(height: 0.7),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const Divider(height: 50),
                          ElevatedButton(
                            onPressed: () => _submitForm(form),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
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
          } else {
            return Scaffold(
              body: Center(
                child: ScanNfcBottomSheet(
                  title: 'Quét thẻ cần thêm mới',
                  subTitle: 'Giữ điện thoại lại gần thẻ cần thêm',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          }
        }

        return Scaffold(
          body: Center(
            child: ScanNfcBottomSheet(
              title: 'Quét thẻ cần thêm mới',
              subTitle: 'Giữ điện thoại lại gần thẻ cần thêm',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _submitForm(FormGroup form) {
    if (form.valid) {
      bloc!.add(AddInternalCard(value: form.value));
      Navigator.pop(context);
    } else {
      form.markAllAsTouched();
    }
  }

  void _startNfc() {
    _nfc.startSession(onDiscovered: (NfcTag tag) async {
      id = '${tag.data['nfca']['identifier']}';
      bloc!.add(CheckNewCard(id: id));
    });
  }
}
