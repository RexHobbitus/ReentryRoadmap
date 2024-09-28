// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:reentry_roadmap/presentation/pages/main/explore/explore_page.dart';
// import 'package:reentry_roadmap/presentation/pages/main/more/more_page.dart';
// import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_page.dart';
// import 'package:reentry_roadmap/presentation/pages/main/review/review_page.dart';
//
// import '../pages/main/profile/profile_page.dart';
//
// /// Builds the "shell" for the app by building a Scaffold with a
// /// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
// class ScaffoldWithNavBar extends StatelessWidget {
//   /// Constructs an [ScaffoldWithNavBar].
//   const ScaffoldWithNavBar({
//     required this.child,
//     super.key,
//   });
//
//   /// The widget to display in the body of the Scaffold.
//   /// In this sample, it is a Navigator.
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: child,
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Explore',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'My Services',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notification_important_rounded),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notification_important_rounded),
//             label: 'Review',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notification_important_rounded),
//             label: 'More',
//           ),
//         ],
//         currentIndex: _calculateSelectedIndex(context),
//         onTap: (int idx) => _onItemTapped(idx, context),
//       ),
//     );
//   }
//
//   static int _calculateSelectedIndex(BuildContext context) {
//     final String location = GoRouterState.of(context).uri.path;
//     if (location.startsWith(ExplorePage.path)) {
//       return 0;
//     }
//     if (location.startsWith(MyServicesPage.path)) {
//       return 1;
//     }
//     if (location.startsWith(ProfilePage.path)) {
//       return 2;
//     }
//     if (location.startsWith(ReviewPage.path)) {
//       return 3;
//     }
//     if (location.startsWith(MorePage.path)) {
//       return 4;
//     }
//     return 0;
//   }
//
//   void _onItemTapped(int index, BuildContext context) {
//     switch (index) {
//       case 0:
//         GoRouter.of(context).go(ExplorePage.path);
//       case 1:
//         GoRouter.of(context).go(MyServicesPage.path);
//       case 2:
//         GoRouter.of(context).go(ProfilePage.path);
//       case 3:
//         GoRouter.of(context).go(ReviewPage.path);
//       case 4:
//         GoRouter.of(context).go(MorePage.path);
//     }
//   }
// }
