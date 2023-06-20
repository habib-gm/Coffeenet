import 'package:equatable/equatable.dart';

import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class ScannedUploadsState extends Equatable {
  const ScannedUploadsState();
}

class InitialScannedUploadsState extends ScannedUploadsState {

  @override
  List<Object?> get props => [];
}

class ScannedUploadsLoadingState extends ScannedUploadsState {
  @override
  List<Object?> get props => [];
}

class ScannedUploadsSuccessState extends ScannedUploadsState {
  final List<DetectedLeaf> detectedLeafs;

  const ScannedUploadsSuccessState(this.detectedLeafs);

  @override
  List<Object?> get props => [detectedLeafs];
}

class ScannedUploadsFailureState extends ScannedUploadsState {
  @override
  List<Object?> get props => [];
}
