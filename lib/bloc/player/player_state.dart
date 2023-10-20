part of 'player_bloc.dart';

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState({
    required int? index,
    required bool playing,
    required int position,
    required bool loop,
    required bool shuffle,
    required bool favorite,
    required List<MySongModel> songs,
    required bool? miniOn,
    required bool randomGenerated,
  }) = _PlayerState;
  factory PlayerState.playsong() => PlayerState(
      index: null,
      playing: true,
      position: 0,
      loop: false,
      shuffle: false,
      miniOn: false,
      songs: allSongsList,
      favorite: false,
      randomGenerated: false);
}
