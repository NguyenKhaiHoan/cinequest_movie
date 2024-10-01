part of '../home_page.dart';

/// Mixin của ProfilePage xử lý logic UI
mixin _PageMixin on State<_Page> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<GetMovieLocalUseCase>().call();
    });
  }
}
