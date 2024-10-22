import 'package:equatable/equatable.dart';

class ServiceCategory extends Equatable {
  String title;
  String icon;
  List<String> subCategories;

  ServiceCategory(
      {required this.icon, required this.title, required this.subCategories});

  @override
  // TODO: implement props
  List<Object?> get props => [title, icon, subCategories];
}
