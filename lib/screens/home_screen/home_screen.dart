import 'package:flutter/material.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/utility/constant.dart';
import 'package:grocery_app/widget/app_drawer.dart';
import 'package:grocery_app/widget/badge.dart';
import 'package:grocery_app/widget/change_theme_button.dart';
import 'package:grocery_app/widget/home_screen_widget/grid_items.dart';
import 'package:grocery_app/widget/snack_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List _allResult = [];
  List _searchResultList = [];
  List? data;
  Future? resultLoaded;
  var _isLoading = true;

  _refreshProducts() async {
    try {
      await Provider.of<ProductProvider>(context, listen: false)
          .fetchAndSetProducts()
          .then((_) {
        data = Provider.of<ProductProvider>(context, listen: false).items;
        setState(() {
          _allResult = data!;
          _isLoading = false;
        });
      });
      searchResulList();
      return 'complete';
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      SnackBarWidget.showSnackBar(
        context,
        'No Product Added yet',
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultLoaded = _refreshProducts();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResulList();
  }

  searchResulList() {
    var showResult = [];
    if (_searchController.text != '') {
      showResult = _allResult.where((prod) {
        var proTitle = prod.title!.toLowerCase();
        var proType = prod.productType!.toLowerCase();
        return proTitle.contains(_searchController.text.toLowerCase()) ||
            proType.contains(_searchController.text.toLowerCase());
      }).toList();
    } else {
      showResult = List.from(_allResult);
    }
    setState(() {
      _searchResultList = showResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kApptitle, style: kAppbarTextStyle),
        actions: const [ChangeThemeButtonWidget()],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Column(
                children: [
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => _refreshProducts(),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: _searchResultList.length,
                        itemBuilder: (context, i) => GridItems(
                          id: _searchResultList[i].id,
                          imageUrl: _searchResultList[i].imageUrl,
                          price: _searchResultList[i].rate.toString(),
                          title: _searchResultList[i].title,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
