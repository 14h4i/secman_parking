import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/internal/blocs/data_card_bloc.dart';
import 'package:secman_parking/providers/bloc_provider.dart';

class InternalBloc extends BlocBase {
  final DataCardBloc _dataCardBloc;

  InternalBloc() : _dataCardBloc = DataCardBloc();

  Stream<Card?> get scanStream => _dataCardBloc.scanStream;

  Future<void> scan(String id) async {
    _dataCardBloc.scan(id);
  }

  @override
  void dispose() {}
}
