import 'package:go_router/go_router.dart';

import '../../features/all_complete/all_complete_screen.dart';
import '../../features/level_select/level_select_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/puzzle_play/level_complete_screen.dart';
import '../../features/puzzle_play/puzzle_play_screen.dart';
import '../../features/settings/donate_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../app_controller.dart';

GoRouter createAppRouter(AppController controller) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: controller,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/levels',
        builder: (context, state) => const LevelSelectScreen(),
      ),
      GoRoute(
        path: '/play/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final tutorial = state.uri.queryParameters['tutorial'] == '1';
          return PuzzlePlayScreen(levelId: id, showTutorial: tutorial);
        },
      ),
      GoRoute(
        path: '/play/:id/complete',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final perfect = state.uri.queryParameters['perfect'] == '1';
          return LevelCompleteScreen(levelId: id, perfect: perfect);
        },
      ),
      GoRoute(
        path: '/complete',
        builder: (context, state) => const AllCompleteScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'donate',
            builder: (context, state) => const DonateScreen(),
          ),
        ],
      ),
    ],
  );
}
