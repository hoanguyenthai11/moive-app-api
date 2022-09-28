import 'package:equatable/equatable.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();

  @override
  List<Object?> get props => [];
}

class GenreStartedEvent extends GenreEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
