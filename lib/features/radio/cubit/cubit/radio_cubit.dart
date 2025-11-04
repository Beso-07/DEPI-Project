import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';

import 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<PlayerState>? _playerStateSub;
  String? _currentStationName;
  String? _currentUrl;

  RadioCubit() : super(RadioInitial()) {
    _playerStateSub = _player.playerStateStream.listen(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged(PlayerState state) {
    final processing = state.processingState;
    final playing = state.playing;

    if (processing == ProcessingState.loading ||
        processing == ProcessingState.buffering) {
      emit(RadioLoading());
    } else if (playing) {
      emit(RadioPlaying(_currentStationName ?? "محطة غير معروفة"));
    } else {
      emit(RadioStopped());
    }
  }

  Future<void> playStation(String name, String url) async {
    _currentStationName = name;
    _currentUrl = url;

    try {
      emit(RadioLoading());
      await _player.setUrl(url);
      await _player.play();
    } catch (e) {
      emit(RadioError("حدث خطأ أثناء تشغيل الإذاعة"));
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e) {
      emit(RadioError("حدث خطأ أثناء الإيقاف"));
    }
  }

  Future<void> togglePlay() async {
    if (state is RadioPlaying) {
      await stop();
    } else if (_currentUrl != null && _currentStationName != null) {
      await playStation(_currentStationName!, _currentUrl!);
    }
  }

  @override
  Future<void> close() async {
    await _playerStateSub?.cancel();
    await _player.dispose();
    return super.close();
  }
}
