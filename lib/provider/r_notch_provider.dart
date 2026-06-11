import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notch_r_shop_provider/model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    loginLoad();
    loadCart();
    loadFavourite();
    darkModeLoad();
    emailLoad();
    categoryLoad();
    filterLoad();
    textFieldSearchingLoad();
  }
  TextEditingController searchController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String select = 'All';
  String isFiltersData = 'No Filters';
  bool isPasswordVisible = true;
  bool rememberMe = false;
  bool isLoading = true;
  bool isLogin = false;
  bool isDark = false;
  String emailStore = '';
  String isSearching = '';
  List<Product> products = [];
  List<Product> cartItems = [];
  List<Product> favourites = [];
  List<Product> filteredList = [];
  List<Product> originalProducts = [];
  List<Product> allProductsBackup = [];
  List<Product> searchSource = [];
  List<Product> similarProduct = [];
  List<Product> similarProductStore = [];

  Future<void> getCounter() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        products = data.map((e) => Product.fromMap(e)).toList();
        for (var cartItem in cartItems) {
          for (var product in products) {
            if (product.id == cartItem.id) {
              product.buttonName = cartItem.buttonName;
            }
          }
        }

        for (var favourite in favourites) {
          for (var product in products) {
            if (product.id == favourite.id) {
              product.favourite = true;
            }
          }
        }

        filteredList = products;
        originalProducts = List.from(products);
        allProductsBackup = List.from(products);
        searchSource = List.from(products);
        similarProduct = List.from(products);

        selectCategoryWithApi();
        searching();

        if (isFiltersData == 'PRICE: HIGH TO LOW') {
          priceHighToLow();
        } else if (isFiltersData == 'PRICE: LOW TO HIGH') {
          priceLowToHigh();
        } else if (isFiltersData == 'RATING: BEST RATING') {
          bestRating();
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    cartItems.add(product);
    saveCart();
    notifyListeners();
  }

  void clearCart() {
    for (int i = 0; i < cartItems.length; i++) {
      cartItems[i].buttonName = 'Add to Cart';
      cartItems[i].qtySelect = 1;
      cartItems[i].size = 'XS';
      cartItems[i].selectedSize = 'XS';
      cartItems[i].selectQtyIndex = 0;
    }
    for (var favourite in favourites) {
      favourite.buttonName = 'Add to Cart';
    }
    cartItems.clear();
    saveCart();
    saveFavourite();
    notifyListeners();
  }

  void addToFavourite(Product product) {
    if (product.favourite == true &&
        !favourites.any((e) => e.id == product.id)) {
      favourites.add(product);
    } else {
      favourites.remove(product);
    }
    saveFavourite();
    notifyListeners();
  }

  double totalAmount() {
    double total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      total = total + cartItems[i].price * cartItems[i].qtySelect;
    }
    return total;
  }

  void removeCart(int index) {
    final item = cartItems[index];
    item.qtySelect = 1;
    item.size = 'XS';
    item.selectQtyIndex = 0;
    item.selectedSize = 'XS';
    cartItems.removeAt(index);
    item.buttonName = 'Add to Cart';
    for (var product in products) {
      if (product.id == item.id) {
        product.buttonName = 'Add to Cart';
      }
    }
    for (var favourite in favourites) {
      if (favourite.id == item.id) {
        favourite.buttonName = 'Add to Cart';
      }
    }
    saveCart();
    saveFavourite();
    notifyListeners();
  }

  void removeFavourite(int index) {
    final item = favourites[index];
    item.favourite = false;
    for (var product in products) {
      if (product.id == item.id) {
        product.favourite = false;
      }
    }
    favourites.removeAt(index);
    saveFavourite();
    notifyListeners();
  }

  void isSerachIconShow() {
    searchController.clear();
    notifyListeners();
  }

  void changeButtonName(String newName, Product product) {
    product.buttonName = newName;
    saveCart();
    saveFavourite();
    notifyListeners();
  }

  void selectCategory(String newSelect) {
    select = newSelect;
    categorySave();
    notifyListeners();
  }

  void isFavouriteSelected(Product product) {
    product.favourite = !product.favourite;
    notifyListeners();
  }

  void onSearchChanged() {
    notifyListeners();
  }

  void sizeSelect(int index, String newName) {
    final colors = cartItems[index];
    colors.selectedSize = newName;
    notifyListeners();
  }

  void doneSelectSize(int index) {
    final item = cartItems[index];
    item.size = item.selectedSize;
    saveCart();
    notifyListeners();
  }

  void selectQty(int productIndex, int newQty) {
    final qtyIndex = cartItems[productIndex];
    qtyIndex.selectQtyIndex = newQty;
    notifyListeners();
  }

  void doneSelectQty(int index) {
    final qty = cartItems[index];
    qty.qtySelect = qty.selectQtyIndex + 1;
    saveCart();
    notifyListeners();
  }

  void selectCategoryWithApi() {
    if (select == 'All') {
      filteredList = products;
      searchSource = List.from(products);
      categorySave();
    } else if (select == 'Men\'s') {
      final mens = products
          .where((product) => product.category == 'men\'s clothing')
          .toList();
      filteredList = mens;
      searchSource = List.from(mens);
      categorySave();
    } else if (select == 'Women\'s') {
      final womens = products
          .where((product) => product.category == 'women\'s clothing')
          .toList();
      filteredList = womens;
      searchSource = List.from(womens);
      categorySave();
    } else if (select == 'Jewelery') {
      final jewelery = products
          .where((product) => product.category == 'jewelery')
          .toList();
      filteredList = jewelery;
      searchSource = List.from(jewelery);
      categorySave();
    } else if (select == 'Electronics') {
      final electronics = products
          .where((product) => product.category == 'electronics')
          .toList();
      filteredList = electronics;
      searchSource = List.from(electronics);
      categorySave();
    }

    notifyListeners();
  }

  void priceHighToLow() {
    for (int i = 0; i < filteredList.length; i++) {
      for (int j = 0; j < filteredList.length - i - 1; j++) {
        if (filteredList[j].price < filteredList[j + 1].price) {
          final temp = filteredList[j];
          filteredList[j] = filteredList[j + 1];
          filteredList[j + 1] = temp;
        }
      }
    }
    notifyListeners();
  }

  void priceLowToHigh() {
    for (int i = 0; i < filteredList.length; i++) {
      for (int j = 0; j < filteredList.length - i - 1; j++) {
        if (filteredList[j].price > filteredList[j + 1].price) {
          final temp = filteredList[j];
          filteredList[j] = filteredList[j + 1];
          filteredList[j + 1] = temp;
        }
      }
    }
    notifyListeners();
  }

  void bestRating() {
    for (int i = 0; i < filteredList.length; i++) {
      for (int j = 0; j < filteredList.length - i - 1; j++) {
        if (filteredList[j].rating.rate < filteredList[j + 1].rating.rate) {
          final temp = filteredList[j];
          filteredList[j] = filteredList[j + 1];
          filteredList[j + 1] = temp;
        }
      }
    }
    notifyListeners();
  }

  void resetFilter() {
    if (select == 'All') {
      filteredList = List.from(originalProducts);
      filterSave();
    } else if (select == 'Men\'s') {
      final menCategory = allProductsBackup
          .where((product) => product.category == 'men\'s clothing')
          .toList();
      filteredList = menCategory;
      filterSave();
    } else if (select == 'Women\'s') {
      final womenCategory = allProductsBackup
          .where((product) => product.category == 'women\'s clothing')
          .toList();
      filteredList = womenCategory;
      filterSave();
    } else if (select == 'Jewelery') {
      final jeweleryCategory = allProductsBackup
          .where((product) => product.category == 'jewelery')
          .toList();
      filteredList = jeweleryCategory;
      filterSave();
    } else if (select == 'Electronics') {
      final electronicCategory = allProductsBackup
          .where((product) => product.category == 'electronics')
          .toList();
      filteredList = electronicCategory;
      filterSave();
    }
    notifyListeners();
  }

  void searching() {
    if (searchController.text.isEmpty) {
      filteredList = List.from(searchSource);
    } else {
      filteredList = searchSource
          .where(
            (product) => product.title.toLowerCase().contains(
              searchController.text.toLowerCase(),
            ),
          )
          .toList();
    }
  }

  void similarProductSearching(Product product) {
    final similarPro = similarProduct
        .where(
          (pro) => pro.category == product.category && pro.id != product.id,
        )
        .toList();
    similarProductStore = similarPro;
  }

  void loginSave() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', isLogin);
  }

  void loginLoad() async {
    final prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('isLogin') ?? false;
    notifyListeners();
  }

  void passwordHideShow() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = cartItems.map((e) => jsonEncode(e.toMap())).toList();
    prefs.setStringList('cart', cart);
  }

  void loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];
    cartItems = cart.map((e) => Product.fromMap(jsonDecode(e))).toList();
    notifyListeners();
  }

  void saveFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favourite = favourites
        .map((e) => jsonEncode(e.toMap()))
        .toList();
    prefs.setStringList('fav', favourite);
  }

  void loadFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favourite = prefs.getStringList('fav') ?? [];
    favourites = favourite.map((e) => Product.fromMap(jsonDecode(e))).toList();
    notifyListeners();
  }

  void isDarkMode() {
    isDark = !isDark;
    darkModeSave();
    notifyListeners();
  }

  void darkModeSave() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark', isDark);
  }

  void darkModeLoad() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('dark') ?? false;
    notifyListeners();
  }

  void emailSave() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailStore);
  }

  void emailLoad() async {
    final prefs = await SharedPreferences.getInstance();
    emailStore = prefs.getString('email') ?? '';
    notifyListeners();
  }

  void categorySave() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('category', select);
  }

  void categoryLoad() async {
    final prefs = await SharedPreferences.getInstance();
    select = prefs.getString('category') ?? 'All';
    notifyListeners();
  }

  void filterSave() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('filter', isFiltersData);
  }

  void filterLoad() async {
    final prefs = await SharedPreferences.getInstance();
    isFiltersData = prefs.getString('filter') ?? 'No Filters';
    notifyListeners();
  }

  void textFieldSearchingSave() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('search', isSearching);
  }

  void textFieldSearchingLoad() async {
    final prefs = await SharedPreferences.getInstance();
    isSearching = prefs.getString('search') ?? '';
    searchController.text = isSearching;
    notifyListeners();
  }
}
