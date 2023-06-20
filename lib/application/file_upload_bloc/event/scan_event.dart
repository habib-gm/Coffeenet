import 'package:equatable/equatable.dart';
import '../../../domain/undetected_leaf/undetected_leaf.dart';

abstract class ScanEvent extends Equatable {
  const ScanEvent();
}

class StartScanEvent extends ScanEvent {
  final UndetectedLeaf leaf;
  final bool scanned;

  @override
  List<Object> get props => [leaf];

  const StartScanEvent({required this.leaf, required this.scanned});
}
