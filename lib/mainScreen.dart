import 'package:flutter/material.dart';
import 'package:new_looks/screens/DashBoard/dashborad.dart';
import 'package:new_looks/screens/search/search.dart';
import 'constants/colors.dart';
import 'profile/profile_screen.dart';
import 'screens/cart/user_cart.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  static const int homeTabIndex = 0;
  static const int searchTabIndex = 1;
  static const int cartTabIndex = 2;
  static const int profileTabIndex = 3;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex; // Set initial index
  }


  Widget getTabWidgets() {
    if (selectedIndex == homeTabIndex) {
      return DashBoard();
    } else if (selectedIndex == searchTabIndex) {
      return SearchScreen();
    } else if (selectedIndex == cartTabIndex) {
      return CartProducts();
    } else {
      return ProfileScreen();
      // Add your ProfileScreen here
    }
    return Container(); // Default empty container
  }

  Future<bool> _onWillPop() async {
    if (selectedIndex != homeTabIndex) {
      setState(() {
        selectedIndex = homeTabIndex;
      });
      return false; // Prevent closing the app
    }
    return true; // Close the app if already on the home tab
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: getTabWidgets(),
        bottomNavigationBar: BottomNavigationBar(
          useLegacyColorScheme: false,
          unselectedItemColor: const Color(0xffBEBFC4),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: CustomColor.black,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: ""),
          ],
        ),
      ),
    );
  }
}
