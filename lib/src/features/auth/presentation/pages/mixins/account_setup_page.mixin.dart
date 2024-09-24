part of '../account_setup_page.dart';

mixin AccountSetupPageMixin on State<AccountSetupPage> {
  late TextEditingController _usernameTextEditingController;
  late TextEditingController _nameTextEditingController;
  late TextEditingController _surnameTextEditingController;
  late TextEditingController _bioTextEditingController;
  final GlobalKey<FormState> _usernameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _fullNameCodeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _bioFormKey = GlobalKey<FormState>();

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

  void _next(BuildContext context, int currentPage, String? profilePhoto) {
    if (currentPage == 0) {
      if (!_usernameFormKey.currentState!.validate()) {
        return;
      }
    } else if (currentPage == 1) {
      if (!_fullNameCodeFormKey.currentState!.validate()) {
        return;
      }
    } else if (currentPage == 2) {
      FocusScope.of(context).unfocus();
      if (!_bioFormKey.currentState!.validate()) {
        return;
      }
    }

    if (currentPage == 3) {
      print(profilePhoto);
      if (profilePhoto == null) {
        return;
      }
      context.read<ButtonBloc>().add(
            ButtonEvent.execute(
              useCase: SaveProfileUserUseCase(sl()),
              params: SaveProfileUserParams(
                user: AppUser(
                  id: sl<FirebaseAuth>().currentUser?.uid ?? const Uuid().v4(),
                  profilePhoto: profilePhoto,
                  email: sl<FirebaseAuth>().currentUser!.email ?? '',
                  username: _usernameTextEditingController.text.trim(),
                  name: _nameTextEditingController.text.trim(),
                  surname: _surnameTextEditingController.text.trim(),
                  createdAt: DateTime.now(),
                  authBy: 'Email',
                ),
              ),
            ),
          );
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _listener(BuildContext context, ButtonState state) {
    state.whenOrNull(
      success: () => context.go(AppRoutes.home.path),
      failure: (failure) => context.showSnackbar(failure.message),
    );
  }

  void _back() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _changePhoto(BuildContext context) {
    BottomSheetUtil.showTakeImageBottomSheet(context).then((value) {
      if (!context.mounted) return;
      context
          .read<AccountSetupBloc>()
          .add(AccountSetupEvent.profilePhotoChanged(value));
    });
  }
}
