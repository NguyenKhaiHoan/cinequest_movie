part of '../login_page.dart';

mixin LoginPageMixin on State<LoginPage> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _setPasswordTextEditingController;
  final GlobalKey<FormState> _LoginKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _setPasswordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _setPasswordTextEditingController.dispose();
  }

  void _login(BuildContext context) async {
    try {
      if (!_LoginKey.currentState!.validate()) {
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
    } catch (e) {
      rethrow;
    }
  }

  void _listener(BuildContext context, ButtonState state) {
    state.whenOrNull(
      failure: (failure) => context.showSnackbar(failure.message),
      success: () {
        // Nếu đăng nhập thành công thì chạy event này để cập nhật lại
        // trạng thái xác thực của app và sử dụng điều hướng của go router
        context.read<AppAuthBloc>().add(const AppAuthEvent.started());
      },
    );
  }
}
