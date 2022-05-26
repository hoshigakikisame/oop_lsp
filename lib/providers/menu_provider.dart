import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  List<Menu> menus = [];

  MenuProvider() {
    _init();
  }

  _init() async {
    await refresh();
  }

  refresh() async {
    await searchMenu();
  }

  Future<void> searchMenu({String query = ''}) {
    return supabaseRequest(supabase
            .from('menu')
            .select('*')
            .like('name', '%$query%')
            .execute())
        .then((res) {
      // print((res as PostgrestResponse<dynamic>).data);
      menus = (res.data as List).map((e) => Menu.fromJson(e)).toList();
      notifyListeners();
    });
  }

  Future<void> createMenu(Menu menu) async {
    final jsonMenu = menu.toJson();
    jsonMenu.removeWhere((key, value) => key == "id");
    await supabaseRequest(supabase.from('menu').insert(jsonMenu).execute());
    await refresh();
  }

  Future<void> deleteMenu(List<Menu> menus) async {
    final List<String> ids = menus.map((e) => e.id.toString()).toList();
    await supabaseRequest(
            supabase.from('menu').delete().in_('id', ids).execute())
        .then((res) {
      notifyListeners();
    });
    await refresh();
  }

  Future<void> updateMenu(Menu menu) async {
    await supabaseRequest(supabase
        .from('menu')
        .update(menu.toJson())
        .eq('id', menu.id)
        .execute());
    await refresh();
  }
}
