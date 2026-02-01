import 'package:get/get.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/pages/Infoes/info_page.dart';
import 'package:sigma/pages/advertise/advertise_menu.dart';
import 'package:sigma/pages/advertise/stocks/stocks_page.dart';
import 'package:sigma/pages/auth/auth_page.dart';
import 'package:sigma/pages/blog/sigma_news_page.dart';
import 'package:sigma/pages/branches/branches_page.dart';
import 'package:sigma/pages/buy_menu/buy/buy_page.dart';
import 'package:sigma/pages/buy_menu/buy_menu_page.dart';
import 'package:sigma/pages/buy_menu/loan/loan_page.dart';
import 'package:sigma/pages/car/car_page.dart';
import 'package:sigma/pages/car_detail/car_detail_page.dart';
import 'package:sigma/pages/car_detail/compare_car_list/compare_car_page.dart';
import 'package:sigma/pages/compare_cars/binding.dart';
import 'package:sigma/pages/compare_cars/compare_cars_page.dart';
import 'package:sigma/pages/contact_us/contact_us_page.dart';
import 'package:sigma/pages/guide_menu/guide_menu_page.dart';
import 'package:sigma/pages/home/home_page.dart';
import 'package:sigma/pages/my_cars/my_cars_page.dart';
import 'package:sigma/pages/notifs/notifs_page.dart';
import 'package:sigma/pages/price/price_page.dart';
import 'package:sigma/pages/price_chart/price_chart_page.dart';
import 'package:sigma/pages/privacy/privacy_rules_page.dart';
import 'package:sigma/pages/profile/about_us/about_us_page.dart';
import 'package:sigma/pages/profile/favorites/favorite_page.dart';
import 'package:sigma/pages/profile/frequent_questions/questions_page.dart';
import 'package:sigma/pages/profile/profile_page.dart';
import 'package:sigma/pages/refferal/refferal_page.dart';
import 'package:sigma/pages/requests/buy_requests/buy_requests_page.dart';
import 'package:sigma/pages/requests/requests_menu_page.dart';
import 'package:sigma/pages/requests/sell_requests/sales_order_page.dart';
import 'package:sigma/pages/reserve_showroom/reserve_showroom_page.dart';
import 'package:sigma/pages/rules/rules_page.dart';
import 'package:sigma/pages/sell/sell_page.dart';
import 'package:sigma/pages/splash/splash_page.dart';
import 'package:sigma/pages/suggestions/suggestions_page.dart';
import 'package:sigma/pages/technical_compare/technical_compare_page.dart';
import 'package:sigma/pages/technical_menu/technicalInfo_page.dart';
import 'package:sigma/pages/technical_menu/technical_menu.dart';
import 'package:sigma/pages/track_orders/track_page.dart';
import 'package:sigma/pages/transactions/all_transactions_page.dart';

import 'models/my_cars_model.dart';
import 'pages/advertise/advertise_page.dart';
import 'pages/pdf_viewr.dart';
import 'pages/profile/edit/edit_profile_page.dart';
import 'pages/requests/showrooms_requests/showroom_reservations_page.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splash,
          page: () => SplashScreen(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.auth,
          page: () => AuthPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.notifs,
          page: () => NotifsListPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.home,
          page: () => const HomePge(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.technicalInfo,
          page: () => TechnicalInfoPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.technicalMenu,
          page: () => TechnicalMenu(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.priceChart,
          page: () => PriceChartPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.technicalCompare,
          page: () => TechnicalComparePage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.privacy,
          page: () => const PrivacyRulesPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.rules,
          page: () => const RulesPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.pdf,
          page: () => const Pdf(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.editProfile,
          page: () => EditProfileInfo(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RouteName.profile,
          page: () => ProfilePage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.favourites,
          page: () => FavoritesPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.loan,
          page: () => const CalculateLoanPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.car,
          page: () {
            final Cars? order = Get.arguments as Cars?;
            return CarWidget(order: order);
          },
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.myCars,
          page: () => MyCarsPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.advertiseMenu,
          page: () => AdvertiseMenu(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.stocks,
          page: () => StocksPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.track,
          page: () => TrackingSalesOrderPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),

        GetPage(
          name: RouteName.buy_menue,
          page: () => BuyMenuPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.buy,
          page: () => BuyPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.advertise,
          page: () => AdvertisePage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.sell,
          page: () => const SellPageView(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.prices,
          page: () => PricePage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.referral,
          page: () => ReferralPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.questions,
          page: () => QuestionsPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.contactus,
          page: () => ContactUsPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.about,
          page: () => AboutUs(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.info,
          page: () => const InfoPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.allTransactionsSales,
          page: () => AllTransactionsPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.allBlogs,
          page: () => AllBlogsPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.showroomsAddress,
          page: () => BranchesPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.myBuyRequests,
          page: () => const MyBuyOrdersPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.mySalesOrder,
          page: () => const MySalesOrdersPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.requests,
          page: () => RequestsMenuPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.suggestions,
          page: () => SuggestionPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.compare_car,
          page: () => CompareAdvertisePage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.myShowRooms,
          page: () => const MyReservationsPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.carDetails,
          page: () => CarDetailPage(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        // ),

        // GetPage(
        //   name: RouteName.chat,
        //   page: () => ChatPage(),
        //   transitionDuration: const Duration(milliseconds: 10),
        //   transition: Transition.native,
        // ),
        GetPage(
          name: RouteName.reserveShowRoom,
          page: () => ReserveShowRoom(),
          transitionDuration: const Duration(milliseconds: 10),
          transition: Transition.native,
        ),
        GetPage(
          name: RouteName.compare,
          page: () => const CompareCarsPage(),
          binding: CompareCarsBinding(),
        ),
        GetPage(
          name: RouteName.guide,
          page: () => GuideMenuPage(),
          binding: CompareCarsBinding(),
        ),
      ];
}
