import 'package:flutter/material.dart';
import 'package:flutter_application/viewmodels/auth_view_model.dart';
import 'package:flutter_application/views/account_view.dart';
import 'package:flutter_application/views/auth/login_view.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class AuthCheck extends StatefulWidget {
  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final AuthViewModel authViewModel = AuthViewModel();
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    try {
      String? token = await authViewModel.getToken();
      setState(() {
        _isLoading = false;
        _isAuthenticated = token != null && !JwtDecoder.isExpired(token);
      });
    } catch (e) {
      // En cas d'erreur, on considère l'utilisateur comme non authentifié
      setState(() {
        _isLoading = false;
        _isAuthenticated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoading();
    } else if (_isAuthenticated) {
      return AccountView();
    } else {
      return LoginView();
    }
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
