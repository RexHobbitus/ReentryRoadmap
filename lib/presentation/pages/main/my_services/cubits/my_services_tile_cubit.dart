import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reentry_roadmap/core/enums/my_services_status.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';

part 'my_services_tile_state.dart';

class MyServicesTileCubit extends Cubit<MyServicesTileState> {
  MyServicesTileCubit(this.myService) : super(MyServicesTileInitial());

  MyService myService;

  String getBtnText(MyServicesStatus status) {
    switch (status) {
      case MyServicesStatus.savedServices:
        return "Contact Provider";

      case MyServicesStatus.contactedServices:
        return "Applied 3 days ago";

      case MyServicesStatus.activeServices:
        return "Mark as Complete";

      case MyServicesStatus.completedServices:
        return "Add Review";

      case MyServicesStatus.ineligibleServices:
        return "Reapply";
    }
  }
}
