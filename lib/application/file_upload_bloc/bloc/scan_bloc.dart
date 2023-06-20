import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../Exceptions/upload/upload_exceptions.dart';
import '../../../core.dart';
import '../../../domain/detected_leaf/detected_leaf.dart';
import '../../../infrustructure/upload/repository/upload_repo.dart';
import '../event/scan_event.dart';
import '../state/scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  UploadRepository ScanRepo;

  ScanBloc({required this.ScanRepo}) : super(InitialScanState()) {
    on<StartScanEvent>((event, emit) async {
      emit(ScanLoadingState());
      try {
        await Future.delayed(const Duration(milliseconds: 200));
        final Box<DetectedLeaf> detectedLeafBox = Boxes.getDetectedLeaf();
        final detectedLeaf =
            await ScanRepo.uploadLeaf(event.leaf, event.scanned);
        print("hi----");
        int key = await detectedLeafBox.add(detectedLeaf);
        detectedLeaf.coffeeLeafId = key.toString();
        detectedLeafBox.put(key, detectedLeaf);
        List<DetectedLeaf> detectedLeafs = detectedLeafBox.values.toList();
        emit(ScanSuccessState(detectedLeafs));
      } on ImageNotLeaf {
        emit(ScanImageNotLeafState());
      } on NoInternet{
        emit(NoInternetScanState());
      }catch (error) {
        // rethrow;
        emit(ScanFailureState());
      }
    });
  }
}
