import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>['email'],
);

class SignInRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SignInDemo()),
    );
  }
}

class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount _currentUser;
  String _contactText;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn(Function successCallback) async {
    _googleSignIn.signIn().then((account) {
      account.authentication.then((auth) {
        if (auth.idToken != null) {
          successCallback(auth.idToken);
        }
        print("acceToken : ${auth.accessToken}");
        print("idToken : ${auth.idToken}");
      }).catchError((err) {
        print(err);
      });
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  void showSnackBar(BuildContext context, String msg) {
    var snackBar = SnackBar(content: Text(msg), duration: Duration(seconds: 2));
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          const Text("Signed in successfully."),
          Text(_contactText ?? ''),
          RaisedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          RaisedButton(
            child: const Text('SIGN IN'),
            onPressed: (() =>
                _handleSignIn((token) => showSnackBar(context, token))),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
