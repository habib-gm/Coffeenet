import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../infrustructure/auth/repository/auth_repo.dart';
import '../auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bcrypt/bcrypt.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(LoggingInitialState()) {
    on<LoginEvent>(onLogin);
    on<InitialEvent>((InitialEvent event, Emitter emit) {
      emit(LoggingInitialState());
    });
  }

  onLogin(LoginEvent event, Emitter emit) async {
    emit(LoggingInState());
    try {
      String accessToken = await authRepo.login(event.username, event.password);
      emit(LoggedInState());
    } on Exception {
      emit(LoginFailedState());
    }
  }
}
