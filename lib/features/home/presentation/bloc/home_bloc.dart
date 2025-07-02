import 'package:cbyk_test/features/auth/domain/usecases/get_logged_user_usecase.dart';
import 'package:cbyk_test/features/home/domain/entities/home_state.dart';
import 'package:cbyk_test/features/home/presentation/bloc/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetLoggedUserUseCase getLoggedUser;

  HomeBloc(this.getLoggedUser) : super(HomeInitial()) {
    on<LoadHomeEvent>((event, emit) async {
      emit(HomeLoading());

      try {
        final user = await getLoggedUser();
        emit(HomeLoaded(user: user));
      } catch (e) {
        emit(HomeError('Erro ao carregar usuário'));
      }
    });
  }
}
