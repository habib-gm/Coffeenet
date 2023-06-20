import 'package:equatable/equatable.dart';

import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class DeleteUploadEvent extends Equatable {
  const DeleteUploadEvent();
}

class StartDeleteUploadEvent extends DeleteUploadEvent {
  final DetectedLeaf leaf;

  @override
  List<Object> get props => [leaf];

  const StartDeleteUploadEvent({
    required this.leaf,
  });
}
