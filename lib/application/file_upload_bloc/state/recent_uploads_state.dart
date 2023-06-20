import 'package:equatable/equatable.dart';

import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class RecentUploadsState extends Equatable {
  const RecentUploadsState();
}

class InitialRecentUploadsState extends RecentUploadsState {
  // DetectedLeaf detectedLeaf;
  @override
  List<Object?> get props => [];
}

class RecentUploadsLoadingState extends RecentUploadsState {
  @override
  List<Object?> get props => [];
}

class RecentUploadsSuccessState extends RecentUploadsState {
  List<DetectedLeaf> detectedLeafs;

  RecentUploadsSuccessState(this.detectedLeafs);

  @override
  List<Object?> get props => [detectedLeafs];
}

class RecentUploadsFailureState extends RecentUploadsState {
  @override
  List<Object?> get props => [];
}
