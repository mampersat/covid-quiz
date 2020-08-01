import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  void launchURL() async {
    const url =
        'https://www.texmed.org/TexasMedicineDetail.aspx?Pageid=46106&id=53977';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Simple quiz based on risk list found here:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            RaisedButton(
              child: Text(
                'Texas Medicine Article',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: launchURL,
            ),
          ],
        ),
      ),
    );
  }
}
