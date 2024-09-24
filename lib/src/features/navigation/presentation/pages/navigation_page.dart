import 'package:cinequest/src/features/navigation/presentation/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bottom_nav_bloc.dart';

class NavigationPage extends StatefulWidget {
  final StatefulNavigationShell child;

  const NavigationPage({super.key, required this.child});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: widget.child,
        bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, state) {
            var currentIndex = state.currentIndex;
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
