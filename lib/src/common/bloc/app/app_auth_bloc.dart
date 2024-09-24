import 'package:cinequest/src/core/repositories/user_repository.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/get_profile_user_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/errors/failure.dart';
import '../../../core/routes/route_pages.dart';

part 'app_auth_bloc.freezed.dart';
part 'app_auth_event.dart';
part 'app_auth_state.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  AppAuthBloc(
      {required FirebaseAuth firebaseAuth,
      required GetProfileUserUseCase useCase,
      required UserRepository repository})
      : _firebaseAuth = firebaseAuth,
        _usecase = useCase,
        _repository = repository,
        super(const AppInitialState()) {
    on<AppAuthEvent>((event, emit) async {
      await event.map(
        started: (event) async => await _onStarted(event, emit),
      );
    });
  }

  final FirebaseAuth _firebaseAuth;
  final GetProfileUserUseCase _usecase;
  final UserRepository _repository;

  Future<void> _onStarted(
      EventAppAuthStarted event, Emitter<AppAuthState> emit) async {
    final user = _firebaseAuth.currentUser;

    // Xét nếu user của firebase là null tức app chưa được đăng nhập
    if (user != null) {
      // Nếu user khác null tức đã đăng nhập thì lấy data từ firestore về
      var result =
          await _usecase.call(params: GetProfileUserParams(userId: user.uid));
      result.fold(
        (failure) => emit(AppAuthState.unAuthenticated(failure: failure)),
        (data) {
          // Cập nhật lại dữ liệu user trong stream để theo dõi được
          // dữ liệu user mới trong app
          _repository.setUser(data);
          // Cập nhật trạng thái app đã xác thực
          emit(const AppAuthState.authenticated());
        },
      );
    } else {
      // Cập nhật trạng thái app chưa xác thực
      emit(const AppAuthState.unAuthenticated());
    }
    // Load lại router để chạy lại _guard giúp thay đổi lại path hiện tại
    // thành path của welcome page
    final router = RouterPages.router;
    router.refresh();
  }
}
