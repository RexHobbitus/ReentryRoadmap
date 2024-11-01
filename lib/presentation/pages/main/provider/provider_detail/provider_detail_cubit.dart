import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/alert/app_snack_bar.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/entities/provider_review.dart';
import 'package:reentry_roadmap/domain/repositories/database/app_user_repository.dart';
import 'package:reentry_roadmap/domain/repositories/database/provider_repository.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_contact_form/provider_contact_form.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_suggest_edit/provider_suggest_edit_popup.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/write_review/write_review_popup.dart';
import 'package:reentry_roadmap/presentation/pages/popups/information_popup.dart';
import '../../../popups/upload_photos_popup.dart';
import 'provider_detail_initial_params.dart';
import 'provider_detail_state.dart';
import 'provider_detail_navigator.dart';

class ProviderDetailCubit extends Cubit<ProviderDetailState> {
  ProviderDetailNavigator navigator;
  AppSnackBar snackBar;
  ProviderRepository providerRepository;
  AppUserRepository appUserRepository;
  final UserStore userStore;

  ProviderDetailCubit({
    required this.navigator,
    required this.userStore,
    required this.snackBar,
    required this.providerRepository,
    required this.appUserRepository,
  }) : super(ProviderDetailState.initial());

  BuildContext get context => navigator.context;

  onInit(ProviderDetailInitialParams initialParams) {
    debugPrint("Provider id: ${initialParams.id}");
    _getProviderDetail(initialParams.id);
   _getProviderReviews(initialParams.id);
  }

  onMenuTap(int index) {
    emit(state.copyWith(selectedMenuIndex: index));
  }

  _getProviderDetail(String id) async {
    try {
      emit(state.copyWith(loading: true));
     // Provider provider=Provider.shimmer();
      Provider provider = await providerRepository.getProviderDetail(id: id);
      emit(state.copyWith(provider: provider));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  _getProviderReviews(String id) async {
    try {
      emit(state.copyWith(loadingReviews: true));
      List<ProviderReview> reviews =
          await providerRepository.getProviderReviews(id: id);
      emit(state.copyWith(reviews: reviews));
    } catch (e) {
      snackBar.show(e.toString());
    } finally {
      emit(state.copyWith(loadingReviews: false));
    }
  }

  addReviewAction() {
    navigator.navigator.showDialogBox(context, WriteReviewPopup(
      provider: state.provider,
      onPostReview: (parameter) {
        snackBar.show("Thanks for review, it will be uploaded shortly",
            snackBarType: SnackBarType.SUCCESS);
        appUserRepository
            .giveReviewToProvider(
                providerId: state.provider.userId!,
                review: ProviderReview(
                  rating: parameter.rating,
                  review: parameter.review,
                  images: parameter.images,
                  isAnonymousUser: parameter.postAnonymously,
                ))
            .catchError((error) {
          snackBar.show(error.toString());
        });
      },
    ));
  }

  addPhotosAction() {
    navigator.navigator.showDialogBox(context, UploadPhotosPopup(
      onUpload: (images) {
        snackBar.show("Uploading images, it will be available soon",
            snackBarType: SnackBarType.SUCCESS);
        providerRepository.uploadPhotosOfProvider(
            providerId: state.provider.userId!, images: images);
      },
    ));
  }

  suggestEditAction() {
    navigator.navigator
        .showDialogBox(context, const ProviderSuggestEditPopup());
  }

  contactAction() {
    navigator.navigator.showDialogBox(context, ProviderContactForm(
      onSendMessage: () {
        Navigator.pop(context);
        navigator.navigator.showDialogBox(
            context,
            const InformationPopup(
              title:
                  "Your contact information has been sent! A representative will get back to you shortly",
              subTitle:
                  "In the meanwhile, you can keep track of the services you’ve accessed in the My Services page.",
            ));
      },
    ));
  }
}
