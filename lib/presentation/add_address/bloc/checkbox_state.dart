import 'package:equatable/equatable.dart';

class CheckboxState extends Equatable {
  final bool isChecked;

  const CheckboxState({required this.isChecked});

  @override
  List<Object> get props => [isChecked];
}
