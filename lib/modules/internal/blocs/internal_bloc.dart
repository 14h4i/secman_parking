import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/internal/blocs/scan_internal_card_bloc.dart';
import 'package:secman_parking/providers/bloc_provider.dart';

class InternalBloc extends BlocBase {
  final ScanInternalCardBloc _scanInternalCardBloc;

  InternalBloc() : _scanInternalCardBloc = ScanInternalCardBloc();

  Stream<Card?> get scanStream => _scanInternalCardBloc.scanStream;

  Future<void> scan(String id) async {
    _scanInternalCardBloc.scan(id);
  }

  @override
  void dispose() {}
}
