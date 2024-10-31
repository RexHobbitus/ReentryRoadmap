import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'my_service.g.dart';
part 'my_service.freezed.dart';

@Freezed()
class MyService with _$MyService {
  factory MyService({
     String? name,
     String? address,
     String? imgUrl,
  }) = _MyService;


  factory MyService.fromJson(Map<String, dynamic> json) => _$MyServiceFromJson(json);

}
