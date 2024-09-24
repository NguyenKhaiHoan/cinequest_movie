part of '../profile_page.dart';

mixin ProfilePageMixin on State<ProfilePage> {
  void _moveToSettingPage() {
    context.push(AppRoutes.setting.path);
  }
}
