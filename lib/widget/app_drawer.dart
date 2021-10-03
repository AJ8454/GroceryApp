import 'package:flutter/material.dart';
import 'package:grocery_app/provider/google_sign_in_provider.dart';
import 'package:grocery_app/utility/constant.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.70,
        child: Drawer(
          elevation: 8,
          child: ListView(children: [
            const SizedBox(
              height: 60,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: kCarrotColor,
                ),
                child: Text(
                  'Grocery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const DrawerListTile(
              name: 'Home',
              icon: Icons.home,
              navigate: '/ProductScreen',
            ),
            const DrawerListTile(
              name: 'Add Product',
              icon: Icons.production_quantity_limits,
              navigate: '/EditProductScreen',
            ),
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    color: kGreyColor,
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 13),
              ),
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String? name, navigate;
  final IconData icon;

  const DrawerListTile({
    Key? key,
    required this.name,
    required this.navigate,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        name!,
        style: const TextStyle(fontSize: 13),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(navigate!);
      },
    );
  }
}
