import 'package:equatable/equatable.dart';

class Career extends Equatable {
  String? title;
  String? subTitle;

  Career({this.subTitle, this.title});

  @override
  // TODO: implement props
  List<Object?> get props => [title, subTitle];
}
