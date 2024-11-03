import 'package:reentry_roadmap/domain/entities/my_service.dart';

class MyServicesState {
  final bool loading;

  final List<MyService> myServices;

  const MyServicesState({required this.loading, required this.myServices});

  factory MyServicesState.initial() =>
      const MyServicesState(loading: false, myServices: []);

  MyServicesState copyWith({bool? loading, List<MyService>? myServices}) =>
      MyServicesState(
          loading: loading ?? this.loading,
          myServices: myServices ?? this.myServices);
}
