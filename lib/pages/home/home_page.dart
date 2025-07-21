import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/drawer_icon.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/menu/menu_controller.dart';

class HomePge extends StatefulWidget {
  const HomePge({super.key});

  @override
  State<HomePge> createState() => _HomePgeState();
}

class _HomePgeState extends State<HomePge> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _logoOffsetX = 0.0;

  bool _isLeftDrawerOpen = false;
  bool _isRightDrawerOpen = false;
  double _leftIconOffset = 0.0;
  double _rightIconOffset = 0.0;
  String version = '';

  @override
  void initState() {
    super.initState();
    // Auto-open left drawer after 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      final _packageInfo = await PackageInfo.fromPlatform();
      version = await _packageInfo.version;
      if (mounted) {
        _openLeftDrawer();
      }
    });
  }

  void _openLeftDrawer() {
    setState(() {
      _isLeftDrawerOpen = true;
      _isRightDrawerOpen = false;
      _leftIconOffset = 90.0;
      _rightIconOffset = 0.0;
      _logoOffsetX = 0.1; // reset right icon
    });
  }

  void _openRightDrawer() {
    setState(() {
      _isRightDrawerOpen = true;
      _isLeftDrawerOpen = false;
      _rightIconOffset = -90.0;
      _leftIconOffset = 0.0;
      _logoOffsetX = -0.1; //   // reset left icon
    });
  }

  void _closeDrawers() {
    if (_isLeftDrawerOpen) {
      _openRightDrawer();
      return;
    } else {
      _openLeftDrawer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MenuControllerDefault()); // ثبت اولیه

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          transform: Matrix4.translationValues(_leftIconOffset, 0, 0),
          child: InkWell(
            onTap: () {
              if (_isLeftDrawerOpen) {
                _closeDrawers();
              } else {
                _openLeftDrawer();
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8),
                const Icon(Icons.menu_outlined, color: Colors.black),
                const SizedBox(width: 4),
                Expanded(
                  child: CustomText(
                    Strings.services,
                    color: Colors.black,
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: 120,
        actions: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            transform: Matrix4.translationValues(_rightIconOffset, 0, 0),
            child: InkWell(
              onTap: () {
                if (_isRightDrawerOpen) {
                  _closeDrawers();
                } else {
                  _openRightDrawer();
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(Strings.mySigma,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      size: 16),
                  const SizedBox(width: 8),
                  const Icon(Icons.menu_rounded, color: Colors.black),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
      body: InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: _closeDrawers,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Main content
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            AnimatedSlide(
              offset: Offset(_logoOffsetX, 0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 65),
                  child: SvgPicture.asset(
                    'assets/sigma_home.svg',
                    height: 140,
                    width: 140,
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(version.usePersianNumbers(),
                          fontWeight: FontWeight.bold, size: 12,color: AppColors.grey),
                      CustomText('       نسخه    ',
                          isRtl: true, fontWeight: FontWeight.bold, size: 12,color: AppColors.grey),
                    ],
                  ),
                )),
            // Left drawer
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
              left: _isLeftDrawerOpen ? 0 : -100,
              top: 0,
              bottom: 0,
              width: 100,
              child: Material(
                color: AppColors.grey,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    drawerIcon(
                        path: 'assets/advretise.svg',
                        route: RouteName.advertise),
                    drawerIcon(
                        path: 'assets/buy_car.svg', route: RouteName.buy_menue),
                    drawerIcon(
                        path: 'assets/sell_car.svg', route: RouteName.sell),
                    drawerIcon(
                        path: 'assets/price_car.svg', route: RouteName.prices),
                    drawerIcon(
                        path: 'assets/etelaie.svg', route: RouteName.info),
                    drawerIcon(
                        path: 'assets/branches.svg',
                        route: RouteName.showroomsAddress),
                    drawerIcon(
                        path: 'assets/sigma_transactions.svg',
                        route: RouteName.allTransactionsSales),
                    // drawerIcon(path: 'assets/news_car.svg', route: RouteName.allBlogs),
                  ],
                ),
              ),
            ),

            // Right drawer
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
              right: _isRightDrawerOpen ? 0 : -100,
              top: 0,
              bottom: 0,
              width: 100,
              child: Material(
                color: AppColors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        drawerIcon(
                            path: 'assets/profile.svg',
                            route: RouteName.profile),
                        drawerIcon(
                            path: 'assets/requests.svg',
                            route: RouteName.requests),
                        drawerIcon(
                            path: 'assets/refferal.svg',
                            route: RouteName.referral),
                        drawerIcon(
                            path: 'assets/about_us.svg',
                            route: RouteName.about),
                        // drawerIcon(
                        //     path: 'assets/questions.svg',
                        //     route: RouteName.),
                        drawerIcon(
                            path: 'assets/frequent.svg',
                            route: RouteName.questions),
                        drawerIcon(
                            path: 'assets/ghavanin.svg',
                            route: RouteName.rules),
                        // drawerIcon(
                        //     path: 'assets/ghavanin.svg',
                        //     route: RouteName.chat),
                        drawerIcon(
                            path: 'assets/social.svg', route: RouteName.social),
                        drawerIcon(
                            path: 'assets/chat.svg', route: RouteName.chat),
                      ],
                    ),
                    drawerIcon(path: 'assets/exit.svg', route: 'exit')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
