import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailEventStarted extends MovieDetailEvent {
  final int id;
  const MovieDetailEventStarted(this.id);

  @override
  // TODO: implement props
  List<Object> get props => [id];
}
