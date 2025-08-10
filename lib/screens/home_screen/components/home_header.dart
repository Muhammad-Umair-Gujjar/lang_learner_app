import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants.dart';
import '../../../provider/profile_provider.dart';
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        _buildBackground(),
        _buildLogoDecoration(),
        _buildContent(context,screenHeight),
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryDark, primaryRed],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget _buildLogoDecoration() {
    return Positioned(
      right: 20,
      top: 80,
      child: Opacity(
        opacity: 0.2,
        child: Image.asset(
          'assets/images/logo.png',
          height: 140,
          width: 140,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context,double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: screenHeight<670 ? 5 :10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context,screenHeight),
          _buildUserProfile(context,screenHeight),
          const Spacer(),
          _buildWelcomeMessage(context),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context,double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/images/logo.png', width: 50, height: screenHeight<670 ? 45:50,color: white,),
            Image.asset('assets/images/text_logo.png', width: 110, height: screenHeight<670 ? 100 :110),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, size: 28,color: white,),
          onPressed: () => _showStreakNotification(context),
        ),
      ],
    );
  }

  void _showStreakNotification(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Daily Streak Reminder'),
        content: const Text('Complete a lesson today to keep your streak going!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context,double screenHeight) {
    double size=screenHeight>800? 65:50;
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.asset(
          "assets/images/profile_img.jpg",
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.person, size: 50, color: primaryDark);
          },
        ),
      ),
    );
  }


  Widget _buildWelcomeMessage(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profile, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${profile.userName ?? 'Guest'}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Ready to learn ${profile.currentLanguage} today?',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../core/constants.dart';
// import '../../../provider/profile_provider.dart';
//
// class HomeHeader extends StatelessWidget {
//   const HomeHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     // Responsive calculations
//     final headerHeight = screenHeight * 0.25; // 25% of screen height
//     final logoSize = screenWidth * 0.12; // 12% of screen width
//     final textLogoSize = screenWidth * 0.28; // 28% of screen width
//     final decorationLogoSize = screenHeight * 0.15; // 15% of screen height
//     final profileImageSize = screenWidth * 0.12; // 12% of screen width
//     final paddingHorizontal = screenWidth * 0.05; // 5% of screen width
//     final paddingVertical = screenHeight * 0.02; // 2% of screen height
//
//     return SizedBox(
//       height: headerHeight,
//       child: Stack(
//         children: [
//           _buildBackground(),
//           _buildLogoDecoration(decorationLogoSize),
//           _buildContent(
//             context,
//             paddingHorizontal,
//             paddingVertical,
//             logoSize,
//             textLogoSize,
//             profileImageSize,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBackground() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [primaryDark, primaryRed],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLogoDecoration(double size) {
//     return Positioned(
//       right: size * 0.15, // 15% of logo size
//       top: size * 0.5, // 50% of logo size
//       child: Opacity(
//         opacity: 0.2,
//         child: Image.asset(
//           'assets/images/logo.png',
//           height: size,
//           width: size,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContent(
//       BuildContext context,
//       double paddingHorizontal,
//       double paddingVertical,
//       double logoSize,
//       double textLogoSize,
//       double profileImageSize,
//       ) {
//     return Padding(
//       padding: EdgeInsets.only(
//         top: paddingVertical,
//         left: paddingHorizontal,
//         right: paddingHorizontal,
//         bottom: paddingVertical,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildAppBar(context, logoSize, textLogoSize),
//           _buildUserProfile(context, profileImageSize),
//           const Spacer(),
//           _buildWelcomeMessage(context),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAppBar(BuildContext context, double logoSize, double textLogoSize) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Image.asset(
//               'assets/images/logo.png',
//               width: logoSize,
//               height: logoSize,
//               color: white,
//             ),
//             SizedBox(width: logoSize * 0.3), // 30% of logo size
//             Image.asset(
//               'assets/images/text_logo.png',
//               width: textLogoSize,
//               height: textLogoSize,
//             ),
//           ],
//         ),
//         IconButton(
//           icon: Icon(
//             Icons.notifications_outlined,
//             size: logoSize * 0.8, // 80% of logo size
//             color: white,
//           ),
//           onPressed: () => _showStreakNotification(context),
//         ),
//       ],
//     );
//   }
//
//   void _showStreakNotification(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Daily Streak Reminder'),
//         content: const Text('Complete a lesson today to keep your streak going!'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildUserProfile(BuildContext context, double size) {
//     return Container(
//       padding: EdgeInsets.all(size * 0.02), // 2% of profile size
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//       ),
//       child: ClipOval(
//         child: Image.asset(
//           "assets/images/profile_img.jpg",
//           width: size,
//           height: size,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//             return Icon(Icons.person, size: size, color: primaryDark);
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWelcomeMessage(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Consumer<ProfileProvider>(
//       builder: (context, profile, _) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Hello, ${profile.userName ?? 'Guest'}',
//               style: TextStyle(
//                 color: Colors.white.withOpacity(0.9),
//                 fontSize: screenHeight * 0.025, // 2.5% of screen height
//                 fontWeight: FontWeight.w700,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             SizedBox(height: screenHeight * 0.005), // 0.5% of screen height
//             Text(
//               'Ready to learn ${profile.currentLanguage} today?',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: screenHeight * 0.018, // 1.8% of screen height
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }