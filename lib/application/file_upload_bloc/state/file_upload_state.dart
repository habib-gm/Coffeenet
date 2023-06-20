import 'package:equatable/equatable.dart';

import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class UploadState extends Equatable {
  const UploadState();
}

class InitialUploadState extends UploadState {
  @override
  List<Object?> get props => [];
}

class UploadLoadingState extends UploadState {
  @override
  List<Object?> get props => [];
}

class UploadSuccessState extends UploadState {
  final List<DetectedLeaf> detectedLeafs;

  const UploadSuccessState(this.detectedLeafs);

  @override
  List<Object?> get props => [detectedLeafs];
}

class UploadImageNotLeafState extends UploadState {
  @override
  List<Object?> get props => [];
}

class NoInternetState extends UploadState {
  @override
  List<Object?> get props => [];
}

class UploadFailureState extends UploadState {
  @override
  List<Object?> get props => [];
}
