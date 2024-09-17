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

  late String email;

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

  void _next() {
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
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _signUp(BuildContext context) async {
    try {
      // if (!_verificationCodeFormKey.currentState!.validate()) {
      //   return;
      // }
      // var isConnected = ConnectivityUtil.checkConnectivity();
      // if (isConnected) {
      //   return;
      // }
      context.go(AppRoutes.accountSetup.path);
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
