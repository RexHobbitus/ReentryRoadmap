import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';

part 'my_services_tile_state.dart';

class MyServicesTileCubit extends Cubit<MyServicesTileState> {
  MyServicesTileCubit(this.myService) : super(MyServicesTileInitial());

  MyService myService;
}
