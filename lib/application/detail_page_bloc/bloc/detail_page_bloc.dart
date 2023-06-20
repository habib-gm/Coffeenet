import '../../../domain/detail_page/detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../event/detail_page_event.dart';
import '../state/detail_page_state.dart';

import 'dart:io';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  DetailPageBloc() : super(InitialDetailPageState()) {
    on<LoadDetailPageEvent>((event, emit) async {
      emit(DetailPageLoadingState());
      try {
        // await Future.delayed(Duration(seconds: 20));
        File detectedImage = File(event.leaf.detectedimagelocation);
        File originalImage = File(event.leaf.originalimagelocation);
        DetailPage detailPage = DetailPage(
          detectedLeaf: event.leaf,
          originalImage: originalImage,
          detectedImage: detectedImage,
        );
        emit(DetailPageSuccessState(detailPage));
      } catch (error) {
        emit(DetailPageFailureState());
      }
    });
  }
}
