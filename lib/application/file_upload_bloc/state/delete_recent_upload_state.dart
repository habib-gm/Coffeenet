import 'package:equatable/equatable.dart';

import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class DeleteRecentUploadsState extends Equatable {
  const DeleteRecentUploadsState();
}

class InitialDeleteRecentUploadsState extends DeleteRecentUploadsState {
  // DetectedLeaf detectedLeaf;
  @override
  List<Object?> get props => [];
}

class DeleteRecentUploadsLoadingState extends DeleteRecentUploadsState {
  @override
  List<Object?> get props => [];
}

class DeleteRecentUploadsSuccessState extends DeleteRecentUploadsState {
  final List<DetectedLeaf> detectedLeafs;

  const DeleteRecentUploadsSuccessState(this.detectedLeafs);

  @override
  List<Object?> get props => [detectedLeafs];
}

class DeleteRecentUploadsFailureState extends DeleteRecentUploadsState {
  @override
  List<Object?> get props => [];
}
