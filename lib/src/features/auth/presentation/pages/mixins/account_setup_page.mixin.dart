part of '../account_setup_page.dart';

mixin AccountSetupPageMixin on State<AccountSetupPage> {
  late TextEditingController _usernameTextEditingController;
  late TextEditingController _nameTextEditingController;
  late TextEditingController _surnameTextEditingController;
  late TextEditingController _bioTextEditingController;
  // final GlobalKey<FormState> _useNameFormKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _fullNameCodeFormKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _bioFormKey = GlobalKey<FormState>();

  final _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _usernameTextEditingController = TextEditingController();
    _nameTextEditingController = TextEditingController();
    _surnameTextEditingController = TextEditingController();
    _bioTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _surnameTextEditingController.dispose();
    _bioTextEditingController.dispose();
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

  void _onPageChanged(int index) {}
}
