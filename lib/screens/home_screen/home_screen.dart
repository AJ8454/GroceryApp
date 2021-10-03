import 'package:flutter/material.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/utility/constant.dart';
import 'package:grocery_app/widget/app_drawer.dart';
import 'package:grocery_app/widget/badge.dart';
import 'package:grocery_app/widget/change_theme_button.dart';
import 'package:grocery_app/widget/home_screen_widget/product_grid.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    fetchAllProducts();
    super.didChangeDependencies();
  }

  Future<void> fetchAllProducts() async {
    try {
      if (_isInit) {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<ProductProvider>(context)
            .fetchAndSetProducts()
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        }); // It work
      }
      _isInit = false;
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(kApptitle, style: kAppbarTextStyle),
          actions: const [ChangeThemeButtonWidget()]),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const ProductGrid(),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () => Navigator.of(context).pushNamed('/CartScreen'),
        child: Consumer<CartProvider>(
          builder: (_, cart, ch) => Badge(
            child: ch!,
            value: cart.itemCount.toString(),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/CartScreen');
            },
          ),
        ),
      ),
    );
  }
}
