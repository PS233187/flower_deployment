import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRCodeScannerPage extends StatefulWidget {
  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  Barcode? result; // Variabele om de gescande QR-code op te slaan
  late QRViewController controller; // Controller voor de QR-code scanner

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4, // Verkleind de hoogte van de QRView
            child: Container(

              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (result != null && result!.code != null && result!.code!.isNotEmpty) {
                    _launchURL(result!.code!);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  padding: EdgeInsets.all(10),
                  width: 400, // Beperkt de breedte van het witte schermpje
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Scan QR-code: ${result?.code ?? "Geen Qr-code gedetecteerd"}',
                      style: TextStyle(
                        decoration: TextDecoration.combine(
                          [TextDecoration.underline],
                        ),
                        decorationColor: Colors.white, // Kleur van de underline
                        decorationThickness: 2.0, // Dikte van de underline
                        color: Colors.white, // Tekstkleur
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        height: 2.0,
                      ),
                    ),
                  ),

                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Methode om de QR-view controller te initialiseren wanneer deze is gemaakt
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    try {
      await launchUrl(Uri.parse (url));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Could not launch URL: $url'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
