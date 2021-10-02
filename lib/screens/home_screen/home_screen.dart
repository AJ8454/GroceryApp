import 'package:flutter/material.dart';
import 'package:grocery_app/utility/constant.dart';
import 'package:grocery_app/widget/app_drawer.dart';
import 'package:grocery_app/widget/change_theme_button.dart';
import 'package:grocery_app/widget/home_screen_widget/grid_items.dart';
import 'package:grocery_app/widget/snack_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(kApptitle, style: kAppbarTextStyle),
          actions: const [ChangeThemeButtonWidget()]),
      drawer: const AppDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: const EdgeInsets.all(10.0),
        children: [
          GridItems(
            // iconPath: 'assets/icons/purchaseEntry.svg',
            title: 'Purchase Entry',
            onClicked: () =>
                Navigator.of(context).pushNamed('/PurchaseEntryScreen'),
          ),
          GridItems(
            //iconPath: 'assets/icons/salesEntry.svg',
            title: 'Sales Entry',
            onClicked: () =>
                Navigator.of(context).pushNamed('/SalesEntryScreen'),
          ),
          GridItems(
            // iconPath: 'assets/icons/productList.svg',
            title: 'Product List',
            onClicked: () => Navigator.of(context).pushNamed('/ProductScreen'),
          ),
          GridItems(
            //iconPath: 'assets/icons/closingStock.svg',
            title: 'Closing Stock',
            onClicked: () => SnackBarWidget.showSnackBar(
              context,
              'Coming soon',
            ),
          ),
          GridItems(
            //iconPath: 'assets/icons/vendor.svg',
            title: 'Vendor Detail',
            onClicked: () =>
                Navigator.of(context).pushNamed('/VendorDetailScreen'),
          ),
          GridItems(
            //iconPath: 'assets/icons/customers.svg',
            title: 'Customer Detail',
            onClicked: () =>
                Navigator.of(context).pushNamed('/CustomerDetailScreen'),
          ),
          GridItems(
            // iconPath: 'assets/icons/person.svg',
            title: 'Employees',
            onClicked: () => Navigator.of(context).pushNamed('/EmployeeScreen'),
          ),
          GridItems(
            //   iconPath: 'assets/icons/attendance.svg',
            title: 'Attendance',
            onClicked: () => SnackBarWidget.showSnackBar(
              context,
              'Coming soon',
            ),
          ),
        ],
      ),
    );
  }
}
