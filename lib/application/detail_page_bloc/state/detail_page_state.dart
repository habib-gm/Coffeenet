import 'package:equatable/equatable.dart';

import '../../../domain/detail_page/detail_page.dart';

abstract class DetailPageState extends Equatable {
  const DetailPageState();
}

class InitialDetailPageState extends DetailPageState {
  @override
  List<Object?> get props => [];
}

class DetailPageLoadingState extends DetailPageState {
  @override
  List<Object?> get props => [];
}

class DetailPageSuccessState extends DetailPageState {
  final DetailPage leafDetail;

  const DetailPageSuccessState(this.leafDetail);

  @override
  List<Object?> get props => [leafDetail];
}

class DetailPageFailureState extends DetailPageState {
  @override
  List<Object?> get props => [];
}
