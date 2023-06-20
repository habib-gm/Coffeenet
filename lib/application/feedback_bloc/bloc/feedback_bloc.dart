import 'package:bloc/bloc.dart';
import 'package:coffee_net/infrustructure/feedback/repository/feedback_repo.dart';

import '../event/feedback_event.dart';
import '../state/feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackRepository feedbackRepository;
  FeedbackBloc({required this.feedbackRepository})
      : super(FeedbackInitialState()) {
    on<SubmitFeedbackEvent>(onSubmitFeedback);
    on<DisposeFeedbackEvent>((DisposeFeedbackEvent event, Emitter emit) {
      emit(FeedbackInitialState());
    });
  }

  onSubmitFeedback(SubmitFeedbackEvent event, Emitter emit) async {
    emit(FeedbackSubmittingState());
    try {
      bool feedbackSent = await feedbackRepository.senFeedback(event.feedback);
      emit(FeedbackSubmittedState());
    } catch (e) {
      emit(FeedbackFailedState());
    }
  }
}
