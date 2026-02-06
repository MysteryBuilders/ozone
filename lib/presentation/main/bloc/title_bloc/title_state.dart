part of 'title_bloc.dart';

sealed class TitleState extends Equatable {
  const TitleState();
}

final class TitleInitial extends TitleState {
  @override
  List<Object> get props => [];
}
