import 'package:equatable/equatable.dart';
import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class ScannedUploadsEvent extends Equatable {
  const ScannedUploadsEvent();
}

class UpdateScannedUploadsEvent extends ScannedUploadsEvent {
  final DetectedLeaf leaf;

  @override
  List<Object> get props => [leaf];

  const UpdateScannedUploadsEvent({required this.leaf});
}

class LoadScannedUploadsEvent extends ScannedUploadsEvent {
  @override
  List<Object> get props => [];

  const LoadScannedUploadsEvent();
}
