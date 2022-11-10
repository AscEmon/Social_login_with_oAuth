import 'package:flutter/material.dart';
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/linkedin_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? accessToken;

  final clientIdController = TextEditingController();
  final clientSecretController = TextEditingController();
  final scopesController = TextEditingController();

  final redirectUri = 'mytestapp:/oauth2redirect';
  final customUriScheme = 'mytestapp';

  List _clientNames = ["GitHub", "Google", "LinkedIn", "Spotify", "Discord"];

  List<DropdownMenuItem<String>>? _dropDownMenuItems;
  String? _currentClient;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentClient = _dropDownMenuItems![1].value;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String clientName in _clientNames) {
      items.add(
          new DropdownMenuItem(value: clientName, child: new Text(clientName)));
    }
    return items;
  }

  void changedDropDownItem(String selectedClient) {
    setState(() {
      _currentClient = selectedClient;
    });
  }

  authorize() async {
    var client = getClient();

    if (client != null) {
      List scopes =
          scopesController.text.split(',').map((s) => s.trim()).toList();

      String clientId =
          "213041559497-gdgtu94om8inff44d39gcg1tti5g9524.apps.googleusercontent.com";
      String clientSecret = clientSecretController.text;

      var hlp = OAuth2Helper(
        client,
        clientId: clientId,
        clientSecret: clientSecret,
        scopes: [
          "https://www.googleapis.com/auth/plus.me",
          "https://www.googleapis.com/auth/userinfo.email",
          "https://www.googleapis.com/auth/userinfo.profile",
        ],
      );

      var tokenResp = await hlp.getToken();

      setState(() {
        accessToken = tokenResp?.accessToken;
      });
    }
  }

  OAuth2Client getClient() {
    var client;

    switch (_currentClient) {
      case 'GitHub':
        client = GitHubOAuth2Client(
            redirectUri: redirectUri, customUriScheme: customUriScheme);
        break;

      case 'Google':
        client = GoogleOAuth2Client(
          redirectUri: 'mytestapp://oauth2redirect',
          customUriScheme: 'mytestapp',
        );
        break;

      case 'LinkedIn':
        client = LinkedInOAuth2Client(
            redirectUri: redirectUri, customUriScheme: customUriScheme);
        break;

      case 'Spotify':
        client = SpotifyOAuth2Client(
            redirectUri: redirectUri, customUriScheme: customUriScheme);
        break;
    }

    return client;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text('Client Type', style: TextStyle(fontSize: 14)),
          ),
          DropdownButton(
            value: _currentClient,
            items: _dropDownMenuItems,
            onChanged: (String? value) {
              changedDropDownItem(value!);
            },
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text('Client Id', style: TextStyle(fontSize: 14))),
          TextField(
            controller: clientIdController,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text('Client Secret', style: TextStyle(fontSize: 14))),
          TextField(
            controller: clientSecretController,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text('Scopes', style: TextStyle(fontSize: 14))),
          TextField(
            controller: scopesController,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text('Access Token', style: TextStyle(fontSize: 14)),
          ),
          Text('$accessToken', style: TextStyle(fontSize: 14))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // onPressed: testAuthorize,
        onPressed: authorize,
        label: Text('Authorize'),
        icon: Icon(Icons.lock_open),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    clientIdController.dispose();
    clientSecretController.dispose();
    scopesController.dispose();

    super.dispose();
  }
}
