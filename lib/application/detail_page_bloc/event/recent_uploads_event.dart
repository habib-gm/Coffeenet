import 'package:equatable/equatable.dart';
// import 'package:flutter_auth/domain/detected_leaf/detected_leaf.dart';

import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class RecentUploadsEvent extends Equatable {
  const RecentUploadsEvent();
}

class UpdateRecentUploadsEvent extends RecentUploadsEvent {
  final DetectedLeaf leaf;

  @override
  List<Object> get props => [leaf];

  const UpdateRecentUploadsEvent({required this.leaf});
}

class LoadRecentUploadsEvent extends RecentUploadsEvent {
  @override
  List<Object> get props => [];

  const LoadRecentUploadsEvent();
}
