part of '../login_page.dart';

/// Mixin của LoginPage xử lý logic UI
mixin LoginPageMixin on State<LoginPage> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _setPasswordTextEditingController;
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _setPasswordTextEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await sl<GetEmailPasswordUseCase>().call();
      result.fold((failure) => context.showSnackbar(context, failure.message),
          (data) {
        _emailTextEditingController.text = data.email;
        _setPasswordTextEditingController.text = data.password;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _setPasswordTextEditingController.dispose();
  }

  Future<void> _login(BuildContext context) async {
    if (!_loginKey.currentState!.validate()) {
      return;
    }
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: sl<LoginUseCase>(),
            params: AuthParams(
              email: _emailTextEditingController.text.trim(),
              password: _setPasswordTextEditingController.text.trim(),
            ),
          ),
        );
  }

  void _listener(BuildContext context, ButtonState state) {
    state.whenOrNull(
      failure: (failure) => context.showSnackbar(context, failure.message),
      success: () {
        // Nếu đăng nhập thành công thì chạy event này để cập nhật lại
        // trạng thái xác thực của app và sử dụng điều hướng của go router
        context.read<AppBloc>().add(const AppEvent.started());
        sl<SaveEmailPasswordUseCase>().call(
          params: AuthParams(
            email: _emailTextEditingController.text.trim(),
            password: _setPasswordTextEditingController.text.trim(),
          ),
        );
      },
    );
  }
}
