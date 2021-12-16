import 'package:rxdart/rxdart.dart';
import 'package:secman_parking/common/widgets/stateless/app_toast.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/internal/repos/data_card_repo.dart';
import 'package:secman_parking/providers/bloc_provider.dart';

class DataCardBloc extends BlocBase {
  final _scanCtrl = BehaviorSubject<Card?>();
  Stream<Card?> get scanStream => _scanCtrl.stream;

  Future<void> scan(String id) async {
    try {
      final res = await DataCardRepo().scan(id);
      if (res != null) {
        _scanCtrl.sink.add(res);
      } else {
        _scanCtrl.sink.add(null);
        AppToast.showShortToast('Thẻ không có dữ liệu');
      }
    } catch (e) {
      _scanCtrl.sink.addError(e);
    }
  }

  @override
  void dispose() {
    _scanCtrl.close();
  }
}
