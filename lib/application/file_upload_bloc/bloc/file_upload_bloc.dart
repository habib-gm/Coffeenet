// import 'package:flutter/material.dart';
import '../../../Exceptions/upload/upload_exceptions.dart';

import '../../../infrustructure/upload/repository/upload_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core.dart';
import '../../../domain/detected_leaf/detected_leaf.dart';
import '../event/file_upload_event.dart';
import '../state/file_upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadRepository uploadRepo;

  UploadBloc({required this.uploadRepo}) : super(InitialUploadState()) {
    on<StartUploadEvent>((event, emit) async {
      emit(UploadLoadingState());
      try {
        print("heeeeee");
        await Future.delayed(const Duration(milliseconds: 200));
        final Box<DetectedLeaf> detectedLeafBox = Boxes.getDetectedLeaf();
        print("heeeeee");

        final detectedLeaf =
            await uploadRepo.uploadLeaf(event.leaf, event.scanned);
        print("hi----");
        int key = await detectedLeafBox.add(detectedLeaf);
        detectedLeaf.coffeeLeafId = key.toString();
        detectedLeafBox.put(key, detectedLeaf);
        List<DetectedLeaf> detectedLeafs = detectedLeafBox.values.toList();
        emit(UploadSuccessState(detectedLeafs));
      } on ImageNotLeaf {
        emit(UploadImageNotLeafState());
      } on NoInternet {
        print("nooooooo internet");
        emit(NoInternetState());
      } catch (error) {
        // rethrow;
        emit(UploadFailureState());
      }
    });
  }
}
