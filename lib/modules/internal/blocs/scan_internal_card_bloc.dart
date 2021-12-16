import 'package:rxdart/rxdart.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/internal/repos/scan_internal_card_repo.dart';
import 'package:secman_parking/providers/bloc_provider.dart';

class ScanInternalCardBloc extends BlocBase {
  final _scanCtrl = BehaviorSubject<Card?>();
  Stream<Card?> get scanStream => _scanCtrl.stream;

  Future<void> scan(String id) async {
    try {
      final res = await ScanInternalCardRepo().scan(id);
      if (res != null) {
        _scanCtrl.sink.add(res);
      } else {
        _scanCtrl.sink.add(
          Card('-1', null, null, null, null, null),
        );
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
