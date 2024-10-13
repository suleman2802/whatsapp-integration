import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:erp_whatsapp/Screens/lead_form_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:path_provider/path_provider.dart';

import '../../Widgets/template_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _pickedFile;
  String _assetpdfPath1 = '';
  String _assetpdfPath2 = '';
  bool hasAssetFile1 = false;
  bool hasAssetFile2 = false;

  TextEditingController phoneNumberController = TextEditingController();
  String message = "Checkout my new Erp Project";
  String url = "https://erpnext.com/";
  bool hasAttachment = false;

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          message,
        ),
      ),
    );
  }

  void trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      sendWhatsapp();
    }
  }

  Future<String> _loadPDFAsset(String path, int fileNumber) async {
    final ByteData data = await rootBundle.load(path);
    final List<int> bytes = data.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/PDF${fileNumber}.pdf';
    final File file = File(tempPath);
    await file.writeAsBytes(bytes);
    return tempPath;
  }

  Future<void> pick_asset_file(int fileNumber) async {
    try {
      String pdfPath = 'assets/PDF${fileNumber}.pdf';
      String fullPath = await _loadPDFAsset(pdfPath, fileNumber);
      setState(() {
        if (fileNumber == 1) {
          _assetpdfPath1 = fullPath;
        } else {
          _assetpdfPath2 = fullPath;
        }
      });
      showSnackBar("Asset file load successfully");
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

  Future pick_file() async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles();

      _pickedFile = File(pickedFile!.files.single.path!);

      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
      debugPrint('${directory?.path} / ${_pickedFile?.path}');

      showSnackBar("You file selected Successfully");
    } catch (er) {
      log(er.toString());
    }
  }

  Future<void> sendWhatsapp() async {
    print(hasAttachment);
    try {
      if (hasAttachment) {
        await WhatsappShare.shareFile(
          phone: phoneNumberController.text,
          filePath: ["${_pickedFile?.path}"],
        );
        setState(() {
          hasAttachment = false;
        });
        return;
      } else if (hasAssetFile1 && hasAssetFile2) {
        await WhatsappShare.shareFile(
            phone: phoneNumberController.text,
            filePath: [_assetpdfPath1, _assetpdfPath2]);
        return;
      } else if (hasAssetFile1) {
        await WhatsappShare.shareFile(
            phone: phoneNumberController.text, filePath: [_assetpdfPath1]);
        return;
      } else if (hasAssetFile2) {
        await WhatsappShare.shareFile(
            phone: phoneNumberController.text, filePath: [_assetpdfPath2]);
        return;
      } else {
        await WhatsappShare.share(
          text: message,
          linkUrl: url,
          phone: phoneNumberController.text,
        );
        return;
      }
    } catch (error) {
      print("Error : " + error.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRM Integration"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: phoneNumberController,
                key: const ValueKey("email"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter customer phone number";
                  } else if (value.contains(".") || value.contains(",")) {
                    return "The phone number must have only numeric digits";
                  } else if (value.length != 12) {
                    return "The phone number length must be equal to 12";
                  } else if (value[0] != "9" || value[1] != "2") {
                    return "Start number from 92";
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (value) {
                  _formKey.currentState!.validate();
                  FocusScope.of(context).unfocus();
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Phone Number", hintText: "eg. 923184482240"),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TemplateCardWidget(message, url),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      "Load Asset Pdf 1",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Checkbox(
                      value: hasAssetFile1,
                      onChanged: (newValue) {
                        if (newValue == true) {
                          pick_asset_file(1);
                        }
                        setState(() {
                          hasAssetFile1 = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Load Asset Pdf 2",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Checkbox(
                      value: hasAssetFile2,
                      onChanged: (newValue) {
                        if (newValue == true) {
                          pick_asset_file(2);
                        }
                        setState(() {
                          hasAssetFile2 = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     await pick_asset_file(true);
                //     setState(() {
                //       hasAssetFile1 = true;
                //     });
                //   },
                //   child: Text("Load Asset File 1"),
                // ),
                // ElevatedButton(
                //   onPressed: () async {
                //     await pick_asset_file(false);
                //     setState(() {
                //       hasAssetFile2 = true;
                //     });
                //   },
                //   child: Text("Load Asset File 2"),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await pick_file();
                    setState(() {
                      hasAttachment = true;
                    });
                  },
                  child: Text("Pick File"),
                ),
                ElevatedButton(
                  onPressed: trySubmit,
                  child: Text("Send WhatsApp"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeadFormScreen(),
                ),
              ),
              child: Text("Lead Table"),
            ),
          ],
        ),
      ),
    );
  }
}
