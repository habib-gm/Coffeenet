import '../../../domain/detected_leaf/detected_leaf.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core.dart';
import '../event/recent_uploads_event.dart';
import '../state/recent_uploads_state.dart';

class RecentUploadsBloc extends Bloc<RecentUploadsEvent, RecentUploadsState> {
  RecentUploadsBloc() : super(InitialRecentUploadsState()) {
    on<LoadRecentUploadsEvent>((event, emit) async {
      emit(RecentUploadsLoadingState());
      try {
        final Box<DetectedLeaf> detectedLeafBox = Boxes.getDetectedLeaf();
        List<DetectedLeaf> detectedLeafs = detectedLeafBox.values
            .toList()
            .reversed
            .where((element) => element.scanned == false)
            .toList();
        // print(detectedLeafs.length);
        // if (detectedLeafs.length > 100) {
        //   var newLeafs = detectedLeafs.asMap().keys.toList();
        //   newLeafs.setRange(100, newLeafs.length, []);
        //   print('hiiiiiiiiiiii');
        //   detectedLeafBox.deleteAll(newLeafs);
        // }
        emit(RecentUploadsSuccessState(detectedLeafs));
      } catch (error) {
        emit(RecentUploadsFailureState());
      }
    });
  }
}
