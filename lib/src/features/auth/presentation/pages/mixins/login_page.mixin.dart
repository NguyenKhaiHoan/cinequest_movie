part of '../login_page.dart';

mixin LoginPageMixin on State<LoginPage> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _setPasswordTextEditingController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

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
      // if (!_verificationCodeFormKey.currentState!.validate()) {
      //   return;
      // }
      // var isConnected = ConnectivityUtil.checkConnectivity();
      // if (isConnected) {
      //   return;
      // }
      context.go(AppRoutes.navigation.path);
    } catch (e) {
      rethrow;
    }
  }
}
