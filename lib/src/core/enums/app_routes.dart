enum AppRoutes {
  welcome('/welcome'),
  navigation('/'),
  login('/login'),
  signUp('/signUp'),
  accountSetup('/accountSetup'),
  resetPassword('/resetPassword');

  final String path;
  const AppRoutes(this.path);
}
