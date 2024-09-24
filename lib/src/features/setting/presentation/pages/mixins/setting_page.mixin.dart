part of '../setting_page.dart';

mixin SettingPageMixin on State<SettingPage> {
  void _signOut(BuildContext context) {
    context.read<ButtonBloc>().add(
        ButtonEvent.execute(useCase: SignOutUseCase(sl()), params: NoParams()));
  }

  void _listener(BuildContext context, ButtonState state) {
    state.whenOrNull(
      failure: (failure) => context.showSnackbar(failure.message),
      success: () =>
          context.read<AppAuthBloc>().add(const AppAuthEvent.started()),
    );
  }
}
