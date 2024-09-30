import 'package:cinequest/gen/colors.gen.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/repositories/user_repository.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';

/// Ảnh hồ sơ
class ProfilePhoto extends StatelessWidget {
  /// Constructor
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sl<UserRepository>().authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: AppColors.white,
          );
        }
        if (snapshot.hasError) {
          return _buildMessage('Error load data');
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return _buildMessage('No data');
        }

        final user = snapshot.data!;
        return _buildUserProfile(context, user);
      },
    );
  }

  Widget _buildMessage(String message) {
    return SizedBox(
      child: Center(
        child: Text(message.hardcoded),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, AppUser user) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          UserAvatar(imageUrl: user.profilePhoto),
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
  }
}

/// Ảnh người dùng
class UserAvatar extends StatelessWidget {
  /// Constructor
  const UserAvatar({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
