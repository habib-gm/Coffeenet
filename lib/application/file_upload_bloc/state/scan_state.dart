import 'package:equatable/equatable.dart';

import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class ScanState extends Equatable {
  const ScanState();
}

class InitialScanState extends ScanState {
  @override
  List<Object?> get props => [];
}

class ScanLoadingState extends ScanState {
  @override
  List<Object?> get props => [];
}

class ScanSuccessState extends ScanState {
  final List<DetectedLeaf> detectedLeafs;

  const ScanSuccessState(this.detectedLeafs);

  @override
  List<Object?> get props => [detectedLeafs];
}

class ScanImageNotLeafState extends ScanState {
  @override
  List<Object?> get props => [];
}

class NoInternetScanState extends ScanState {
  @override
  List<Object?> get props => [];
}

class ScanFailureState extends ScanState {
  @override
  List<Object?> get props => [];
}
