enum AppRoutes {
  welcome('/welcome'),
  splash('/'),
  login('/login'),
  signUp('/signUp'),
  accountSetup('/accountSetup'),
  resetPassword('/resetPassword'),
  ticket('/ticket'),
  home('/home'),
  profile('/profile'),
  setting('/setting');

  final String path;
  const AppRoutes(this.path);
}

enum PageTransitionDirection {
  left,
  up,
  right,
  down,
}
