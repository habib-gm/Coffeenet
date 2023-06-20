import '../../../domain/detected_leaf/detected_leaf.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core.dart';
import '../event/scanned_recent_uploads_event.dart';
import '../state/scanned_recent_uploads_state.dart';

class ScannedRecentBloc extends Bloc<ScannedUploadsEvent, ScannedUploadsState> {
  ScannedRecentBloc() : super(InitialScannedUploadsState()) {
    on<LoadScannedUploadsEvent>((event, emit) async {
      emit(ScannedUploadsLoadingState());
      try {
        final Box<DetectedLeaf> detectedLeafBox = Boxes.getDetectedLeaf();
        List<DetectedLeaf> detectedLeafs = detectedLeafBox.values
            .toList()
            .reversed
            .where((element) => element.scanned == true)
            .toList();
        emit(ScannedUploadsSuccessState(detectedLeafs));
      } catch (error) {
        emit(ScannedUploadsFailureState());
      }
    });
  }
}
