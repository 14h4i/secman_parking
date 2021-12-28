import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secman_parking/models/card.dart';
import 'package:secman_parking/modules/guest/blocs/camera/camera_bloc.dart';
import 'package:secman_parking/modules/guest/repos/guest_repo.dart';

part 'guest_event.dart';
part 'guest_state.dart';

class GuestBloc extends Bloc<GuestEvent, GuestState> {
  final CameraBloc _cameraBloc;
  late StreamSubscription? cameraSubscription;

  GuestBloc(this._cameraBloc) : super(GuestInitial()) {
    on<ScanGuestCard>(_onScanGuestCard);
    on<InGuest>(_onInGuest);
    on<OutGuest>(_onOutGuest);
    on<SendIn>(_onSendIn);
    on<SendOut>(_onSendOut);
  }

  Future<void> _onScanGuestCard(
      GuestEvent event, Emitter<GuestState> emit) async {
    try {
      if (event is ScanGuestCard) {
        final card = await GuestRepo().getCard(event.id);
        if (card?.currentPhoto == null) {
          _cameraBloc.add(TakePicture());
          cameraSubscription = _cameraBloc.stream.listen((state) async {
            if (state is TakePictureSuccess) {
              final file = state.file;
              if (file != null) {
                add(InGuest(file: file, card: card));
                _cameraBloc.add(ResetCamera());
              }
            }
          });
        } else {
          add(OutGuest(card: card));
        }
      }
    } catch (e) {
      emit(GuestFailure(error: e));
    }
  }

  Future<void> _onInGuest(GuestEvent event, Emitter<GuestState> emit) async {
    if (event is InGuest) {
      try {
        final url = await GuestRepo().upload(event.file!);
        emit(GuestInSuccess(url: url, card: event.card, file: event.file!));
      } catch (e) {
        emit(GuestFailure(error: e));
      }
    }
  }

  Future<void> _onOutGuest(GuestEvent event, Emitter<GuestState> emit) async {
    if (event is OutGuest) {
      try {
        emit(GuestOutSuccess(card: event.card));
      } catch (e) {
        emit(GuestFailure(error: e));
      }
    }
  }

  Future<void> _onSendIn(GuestEvent event, Emitter<GuestState> emit) async {
    if (event is SendIn) {
      try {
        final timeIn = await GuestRepo().sendIn(event.card.docId!, event.url);
        emit(GuestSendedIn(
          timeIn: timeIn,
          card: event.card,
          url: event.url,
          file: event.file,
        ));
        await Future.delayed(const Duration(seconds: 3), () {});
        emit(GuestInitial());
      } catch (e) {
        emit(GuestFailure(error: e));
      }
    }
  }

  Future<void> _onSendOut(GuestEvent event, Emitter<GuestState> emit) async {
    if (event is SendOut) {
      try {
        final timeOut = await GuestRepo()
            .sendOut(event.card.docId!, event.card.currentPhoto!);
        emit(GuestSendedOut(timeOut: timeOut, card: event.card));
        await Future.delayed(const Duration(seconds: 3), () {});
        emit(GuestInitial());
      } catch (e) {
        emit(GuestFailure(error: e));
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
