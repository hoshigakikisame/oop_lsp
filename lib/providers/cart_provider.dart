import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Cart> carts = [];

  CartProvider() {
    _init();
  }

  _init() async {
    await refresh();
  }

  refresh() async {
    await searchCart();
  }

  Future<void> searchCart({String query = ''}) {
    return supabaseRequest(supabase
            .from('cart')
            .select('*')
            .like('customer_name', '%$query%')
            .eq('is_active', true)
            .execute())
        .then((res) {
      // print((res as PostgrestResponse<dynamic>).data);
      carts = (res.data as List).map((e) => Cart.fromJson(e)).toList();
      notifyListeners();
    });
  }

  // Future<void> createCart(Menu menu) async {
  //   final jsonMenu = menu.toJson();
  //   jsonMenu.removeWhere((key, value) => key == "id");
  //   await supabaseRequest(supabase.from('menu').insert(jsonMenu).execute());
  //   await refresh();
  // }

  // Future<void> deleteCart(List<Menu> menus) async {
  //   final List<String> ids = menus.map((e) => e.id.toString()).toList();
  //   await supabaseRequest(
  //           supabase.from('menu').delete().in_('id', ids).execute())
  //       .then((res) {
  //     notifyListeners();
  //   });
  //   await refresh();
  // }

  // Future<void> updateCart(Menu menu) async {
  //   await supabaseRequest(supabase
  //       .from('menu')
  //       .update(menu.toJson())
  //       .eq('id', menu.id)
  //       .execute());
  //   await refresh();
  // }
}
