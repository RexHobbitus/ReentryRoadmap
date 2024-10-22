import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_contact_form/provider_contact_form.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_suggest_edit/provider_suggest_edit_popup.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/write_review/write_review_popup.dart';
import 'package:reentry_roadmap/presentation/pages/popups/information_popup.dart';
import 'package:reentry_roadmap/presentation/pages/popups/upload_photos/upload_photos_popup.dart';
import 'provider_detail_initial_params.dart';
import 'provider_detail_state.dart';
import 'provider_detail_navigator.dart';

class ProviderDetailCubit extends Cubit<ProviderDetailState> {
  ProviderDetailNavigator navigator;

  ProviderDetailCubit({
    required this.navigator,
  }) : super(ProviderDetailState.initial());

  BuildContext get context => navigator.context;

  onInit(ProviderDetailInitialParams initialParams) {}

  onMenuTap(int index) {
    emit(state.copyWith(selectedMenuIndex: index));
  }

  addReviewAction() {
    navigator.navigator.showDialogBox(context, WriteReviewPopup(
      onPostReview: (parameter) {
        // make api call to submit information to database
      },
    ));
  }

  addPhotosAction() {
    navigator.navigator.showDialogBox(context, UploadPhotosPopup(
      onUpload: (images) {
        // make api call to submit information to database
      },
    ));
  }

  suggestEditAction() {
    navigator.navigator
        .showDialogBox(context, const ProviderSuggestEditPopup());
  }

  contactAction() {
    navigator.navigator.showDialogBox(
        context,
        ProviderContactForm(
          onSendMessage: () {
            Navigator.pop(context);
            navigator.navigator.showDialogBox(context,  InformationPopup(
              title: "Your contact information has been sent! A representative will get back to you shortly",
              subTitle: "In the meanwhile, you can keep track of the services you’ve accessed in the My Services page.",
            ));
          },
        ));
  }
}
