import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core.dart';
import '../../../domain/detected_leaf/detected_leaf.dart';
import '../event/delete_recent_upload_event.dart';
import '../state/delete_recent_upload_state.dart';

class DeleteRecentUploadsBloc
    extends Bloc<DeleteUploadEvent, DeleteRecentUploadsState> {
  DeleteRecentUploadsBloc() : super(InitialDeleteRecentUploadsState()) {
    on<StartDeleteUploadEvent>((event, emit) async {
      emit(DeleteRecentUploadsLoadingState());
      try {
        final Box<DetectedLeaf> detectedLeafBox = Boxes.getDetectedLeaf();
        List<DetectedLeaf> detectedLeafs = detectedLeafBox.values.toList();
        await detectedLeafBox.delete(int.parse(event.leaf.coffeeLeafId));
        detectedLeafs = detectedLeafBox.values.toList().reversed.toList();

        emit(DeleteRecentUploadsSuccessState(detectedLeafs));
      } catch (error) {
        emit(DeleteRecentUploadsFailureState());
      }
    });
  }
}
