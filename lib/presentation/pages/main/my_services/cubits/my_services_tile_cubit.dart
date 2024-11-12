import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/core/enums/my_services_status.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';
import 'package:reentry_roadmap/domain/repositories/database/my_services_repository.dart';

part 'my_services_tile_state.dart';

class MyServicesTileCubit extends Cubit<MyServicesTileState> {
  MyServicesTileCubit(this.myService) : super(MyServicesTileState.initial());

  final MyServicesRepository myServicesRepository = GetIt.I.get();
  final AppSnackBar snackBar = GetIt.I.get();
  MyService myService;

  updateActiveServiceStatus(
      String userId, String serviceId, bool completed) async {
    try {
      emit(state.copyWith(loading: true));
      await myServicesRepository.updateActiveServiceStatus(
          userId: userId,
          serviceId: serviceId,
          data: {"serviceStatus": MyServicesStatus.completedServices.name});

      emit(state.copyWith(serviceStatusUpdated: true));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      if (isClosed) return;
      emit(state.copyWith(loading: false));
    }
  }

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
