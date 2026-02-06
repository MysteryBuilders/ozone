part of 'status_bloc.dart';



class StatusState extends Equatable {
  final int currentIndex;
   final List<StatusModel> statusList;

   StatusState( {this.currentIndex = 0,required this.statusList});

  @override
  List<Object> get props => [currentIndex,statusList];
}
