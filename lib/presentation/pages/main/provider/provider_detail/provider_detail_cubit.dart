import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/write_review/write_review_popup.dart';
import 'package:reentry_roadmap/presentation/pages/popups/upload_photos/upload_photos_popup.dart';
import 'provider_detail_initial_params.dart';
import 'provider_detail_state.dart';
import 'provider_detail_navigator.dart';

class ProviderDetailCubit extends Cubit<ProviderDetailState> {
  ProviderDetailNavigator navigator;
  ProviderDetailCubit({required this.navigator,})
      : super(ProviderDetailState.initial());

  BuildContext get context => navigator.context;

  onInit(ProviderDetailInitialParams initialParams) {}

  onMenuTap(int index){
    emit(state.copyWith(selectedMenuIndex: index));
  }

  addReviewAction(){
    navigator.navigator.showDialogBox(context, WriteReviewPopup(
      onPostReview: (parameter){
        // make api call to submit information to database
      },
    ));
  }

  addPhotosAction(){
    navigator.navigator.showDialogBox(context, UploadPhotosPopup(
      onUpload: (images){
        // make api call to submit information to database
      },
    ));
  }
}
