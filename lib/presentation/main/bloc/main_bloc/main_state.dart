import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int currentIndex;

  const MainState( {this.currentIndex = 0});

  @override
  List<Object> get props => [currentIndex];
}
