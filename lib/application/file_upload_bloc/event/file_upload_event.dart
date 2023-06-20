import 'package:equatable/equatable.dart';
import '../../../domain/undetected_leaf/undetected_leaf.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();
}

class StartUploadEvent extends UploadEvent {
  final UndetectedLeaf leaf;
  final bool scanned;

  @override
  List<Object> get props => [leaf];

  const StartUploadEvent({required this.leaf, required this.scanned});
}
