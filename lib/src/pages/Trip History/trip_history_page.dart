
import 'package:get/get.dart';
import 'package:pickup_load_update/src/controllers/trip%20history%20controller/return_trip_history_controller.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../controllers/trip history controller/rental_trip_history_controller.dart';

class AllTripHistoryController extends GetxController {
  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  void refresh() {
    final RentalTripHistoryController _controller =
        Get.put(RentalTripHistoryController());
    _controller.getRentalTrip();
    final ReturnHistoryController _returnC = Get.put(ReturnHistoryController());
    _returnC.getReturnHistory();
  }
}

// class AllTripHistoryPage extends StatefulWidget {
//   @override
//   State<AllTripHistoryPage> createState() => _AllTripHistoryPageState();
// }
//
// class _AllTripHistoryPageState extends State<AllTripHistoryPage>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final AllTripHistoryController controller =
//       Get.put(AllTripHistoryController());
//
//   @override
//   void initState() {
//     tabController = TabController(length: 5, vsync: this);
//     controller.refresh();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: bgColor,
//       drawer: Drawer(
//         child: ExampleSidebarX(
//           controller: controller.sidebarController,
//         ),
//       ),
//       appBar: CustomCommonAppBar(
//         title: 'tripHistory',
//         scaffoldKey: _scaffoldKey,
//       ),
//       body: GetBuilder<AllTripHistoryController>(
//         builder: (_) => Column(
//           children: [
//             TabBar(
//               controller: tabController,
//               tabs: [
//                 Tab(text: 'truck'.tr),
//                 Tab(text: 'return truck'.tr),
//                 Tab(text: 'rideShare'.tr),
//                 Tab(text: 'rental'.tr),
//                 Tab(text: 'airport'.tr),
//               ],
//               labelColor: Colors.black,
//               unselectedLabelColor: Colors.grey,
//               indicatorSize: TabBarIndicatorSize.label,
//               indicatorColor: primaryColor,
//             ),
//             Expanded(
//               child: TabBarView(
//                 controller: tabController,
//                 children: [
//                   TruckTripTripHistory(),
//                   ReturnTripHistory(),
//                   BikeTripTripHistory(),
//                   RentalTripHistory(),
//                   AirportTripTripHistory(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
