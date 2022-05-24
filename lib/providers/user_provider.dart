import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  List<UserProfile> _users = [];

  List<UserProfile> get users => _users;

  UserProvider() {
    _init();
  }

  _init() async {
    await refresh();
  }

  refresh() async {
    await searchUser();
  }

  Future<void> searchUser({String query = ''}) {
    return supabaseRequest(supabase
            .from('profile')
            .select('*')
            .like('email', '%$query%')
            .execute())
        .then((res) {
      _users = (res.data as List).map((e) => UserProfile.fromJson(e)).toList();
      notifyListeners();
    });
  }

  Future<void> deleteUsers(List<UserProfile> users) async {
    final List<String> ids = users.map((e) => e.id.toString()).toList();
    await supabaseRequest(
            supabase.from('profile').delete().in_('id', ids).execute())
        .then((res) {
      notifyListeners();
    });
    await refresh();
  }
}
