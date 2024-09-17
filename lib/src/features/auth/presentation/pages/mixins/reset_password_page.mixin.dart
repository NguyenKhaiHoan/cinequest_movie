part of '../reset_password_page.dart';

mixin ResetPasswordPageMixin on State<ResetPasswordPage> {
  late TextEditingController _emailTextEditingController;
  final GlobalKey<FormState> _resetPasswordFormKey = GlobalKey<FormState>();

  final _pageController = PageController(
    initialPage: 0,
  );

  late String email;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
  }

  void _send(BuildContext context) async {
    try {
      // if (!_signUpFormKey.currentState!.validate()) {
      //   return;
      // }
      // var isConnected = ConnectivityUtil.checkConnectivity();
      // if (!isConnected) {
      //   return;
      // }
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      await Future.delayed(const Duration(seconds: 5));
      if (!context.mounted) return;
      context.pop();
    } catch (e) {
      rethrow;
    }
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _resend(BuildContext context) async {
    try {
      // if (!_verificationCodeFormKey.currentState!.validate()) {
      //   return;
      // }
      // var isConnected = ConnectivityUtil.checkConnectivity();
      // if (isConnected) {
      //   return;
      // }
    } catch (e) {
      rethrow;
    }
  }

  void _onChangedEmail(String? value) {
    setState(() {
      email = value ?? '';
    });
  }
}
