import 'package:cinequest/gen/assets.gen.dart';
import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/common/widgets/app_bar_bottom_divider.dart';
import 'package:cinequest/src/common/widgets/custom_circle_button.dart';
import 'package:cinequest/src/common/widgets/padding_app_bar.dart';
import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/repositories/user_repository.dart';
import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '_mixins/profile_page.mixin.dart';

/// Trang Profile
class ProfilePage extends StatefulWidget {
  /// Constructor
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfilePageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBottomDivider(
        leadingWidth: 110,
        leading: PaddingAppBar(
          isLeft: true,
          alignment: Alignment.centerLeft,
          child: CustomCircleButton(
            iconPath: AppAssets.images.gear.path,
            onPressed: _moveToSettingPage,
          ),
        ),
        actions: [
          CustomCircleButton(iconPath: AppAssets.images.magnifyingGlass.path),
          gapW8,
          PaddingAppBar(
            isLeft: false,
            child: CustomCircleButton(iconPath: AppAssets.images.bell.path),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: StreamBuilder(
          stream: sl<UserRepository>().authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: AppColors.white,
              );
            }
            if (snapshot.hasError) {
              return SizedBox(
                child: Center(
                  child: Text('Error load data'.hardcoded),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return SizedBox(
                child: Center(
                  child: Text('No data'.hardcoded),
                ),
              );
            }
            final user = snapshot.data!;
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  gapH48,
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(user.profilePhoto),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  gapH8,
                  Text(
                    '${user.surname} ${user.name} (${user.username})',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
