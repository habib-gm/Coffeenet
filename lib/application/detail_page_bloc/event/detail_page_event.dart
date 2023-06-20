import 'package:equatable/equatable.dart';
import '../../../domain/detected_leaf/detected_leaf.dart';

abstract class DetailPageEvent extends Equatable {
  const DetailPageEvent();
}

class LoadDetailPageEvent extends DetailPageEvent {
  final DetectedLeaf leaf;

  @override
  List<Object> get props => [leaf];

  const LoadDetailPageEvent({required this.leaf});
}
