import 'package:cinequest/src/core/routes/route_enums.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/core/utils/bottom_sheet_util.dart';
import 'package:cinequest/src/features/navigation/presentation/bloc/bottom_nav_bloc.dart';
import 'package:cinequest/src/features/navigation/presentation/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Trang điều hướng
class NavigationPage extends StatefulWidget {
  /// Constructor
  const NavigationPage({required this.child, super.key});

  ///
  final StatefulNavigationShell child;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet();
    });
  }

  void _showBottomSheet() {
    if (RouterPages.path.contains(AppRoutes.accountSetup.path)) {
      BottomSheetUtil.showSucessSignUp(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: widget.child,
        bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, state) {
            final currentIndex = state.currentIndex;
            return BottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context
                    .read<BottomNavBloc>()
                    .add(BottomNavEvent.selectedIndex(index));
                widget.child.goBranch(
                  index,
                  initialLocation: index == currentIndex,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
