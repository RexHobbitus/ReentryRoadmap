import 'package:equatable/equatable.dart';

class ServiceProvider extends Equatable {
  String? name;
  String? address;

  DateTime? accessedDate;
  String? imgUrl;

  ServiceProvider({
    this.name,
    this.address,
    this.accessedDate,
    this.imgUrl,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      name: json['name'],
      address: json['address'],
      accessedDate: json['accessedDate'],
      imgUrl: json['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'accessedDate': accessedDate,
      'imgUrl': imgUrl,
    };
  }

  ServiceProvider copyWith({
    String? name,
    String? address,
    DateTime? accessedDate,
    String? imgUrl,
  }) {
    return ServiceProvider(
      name: name ?? this.name,
      address: address ?? this.address,
      accessedDate: accessedDate ?? this.accessedDate,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        accessedDate,
        imgUrl,
        address,
      ];
}
