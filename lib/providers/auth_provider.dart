import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/material.dart';

enum AuthProviderState { initializing, unauthenticated, authenticated }

class AuthProvider with ChangeNotifier {
  AuthProviderState _state = AuthProviderState.initializing;
  AuthProviderState get state => _state;

  User? _currentUser;
  UserProfile? currentUserProfile;

  set state(AuthProviderState newState) {
    _state = newState;
    notifyListeners();
  }

  AuthProvider() {
    _init();
  }

  _init() async {
    await refresh();
  }

  refresh() async {
    await refreshAccessToken();
  }

  Future<void> refreshAccessToken() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('access_token')) {
      accessToken = pref.getString('access_token');
      supabase.auth.setAuth(accessToken!);
      await getUserProfile();
      notifyListeners();
      return;
    }
    _state = AuthProviderState.unauthenticated;
    notifyListeners();
  }

  Future<void> setAccessToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('access_token')) pref.remove('access_token');
    await pref.setString('access_token', token);
    refreshAccessToken();
  }

  Future<void> signUp(
      {required String email,
      required String password,
      String? username = 'New User'}) async {
    final GotrueSessionResponse res =
        await supabaseRequest(supabase.auth.signUp(email, password));
    final user = res.data?.user;
    // create user profile
    await supabaseRequest(supabase.from('profile').insert(
        {'user_id': user!.id, 'username': username, 'email': email}).execute());
  }

  Future<void> signIn({required String email, required String password}) async {
    final GotrueSessionResponse res = await supabaseRequest(
        supabase.auth.signIn(email: email, password: password));
    final user = res.data?.user;
    if (user != null) {
      _currentUser = user;
      await setAccessToken(res.data!.accessToken);
      await refresh();
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('access_token')) pref.remove('access_token');

    _state = AuthProviderState.unauthenticated;
    notifyListeners();
  }

  Future<void> getUserProfile() async {
    final GotrueUserResponse res =
        await supabaseRequest(supabase.auth.api.getUser(accessToken!));
    _currentUser = res.user;
    if (_currentUser != null) {
      final PostgrestResponse userProfile = await supabaseRequest(supabase
          .from('profile')
          .select('*')
          .eq('user_id', _currentUser?.id)
          .execute());
      currentUserProfile = UserProfile.fromJson(
          (userProfile.data as List).first as Map<String, dynamic>);
      _state = AuthProviderState.authenticated;
      notifyListeners();
      return;
    }
    _state = AuthProviderState.unauthenticated;
    notifyListeners();
  }
}
