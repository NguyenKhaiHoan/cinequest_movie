part of '../sign_up_page.dart';

mixin SignUpPageMixin on State<SignUpPage> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _setPasswordTextEditingController;
  late TextEditingController _confirmPasswordTextEditingController;
  late TextEditingController _verificationCodeTextEditingController;
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _verificationCodeFormKey = GlobalKey<FormState>();

  final _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _setPasswordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
    _verificationCodeTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _setPasswordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    _verificationCodeTextEditingController.dispose();
  }

  void _signUp(BuildContext context) {
    if (!_signUpFormKey.currentState!.validate()) {
      return;
    }
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: SignUpUseCase(sl()),
            params: AuthParams(
              email: _emailTextEditingController.text.trim(),
              password: _setPasswordTextEditingController.text.trim(),
            ),
          ),
        );
  }

  void _listenerSignUp(BuildContext context, ButtonState state) {
    state.whenOrNull(
      success: () {
        _verificationCodeTextEditingController.text = '123456';
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      failure: (failure) => context.showSnackbar(failure.message),
    );
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _verificateCode(BuildContext context) async {
    if (!_verificationCodeFormKey.currentState!.validate()) {
      return;
    }
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: VerificateCodeUseCase(sl()),
            params: VerificationCodeParams(
              verificationCode:
                  _verificationCodeTextEditingController.text.trim(),
            ),
          ),
        );
  }

  void _listenerVerificateCode(BuildContext context, ButtonState state) {
    state.whenOrNull(
      success: () => context.go(AppRoutes.accountSetup.path),
      failure: (failure) => context.showSnackbar(failure.message),
    );
  }
}
