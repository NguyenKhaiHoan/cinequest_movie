import 'package:cinequest/src/common/bloc/app/app_bloc.dart';
import 'package:cinequest/src/common/constants/app_sizes.dart';
import 'package:cinequest/src/core/extensions/context_extension.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Ảnh hồ sơ
class ProfilePhoto extends StatelessWidget {
  /// Constructor
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: (user) => _buildUserProfile(context, user!),
          orElse: () => _buildMessage('Error when loading data user'.hardcoded),
        );
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
  }
}
