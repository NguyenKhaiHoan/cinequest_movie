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

  void _send() async {
    try {
      if (!_resetPasswordFormKey.currentState!.validate()) {
        return;
      }
      // var isConnected = ConnectivityUtil.checkConnectivity();
      // if (!isConnected) {
      //   return;
      // }
      FocusScope.of(context).unfocus();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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

  void _resend() async {
    try {
      // var isConnected = ConnectivityUtil.checkConnectivity();
      // if (isConnected) {
      //   return;
      // }
    } catch (e) {
      rethrow;
    }
  }
}
