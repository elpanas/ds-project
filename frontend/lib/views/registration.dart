import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:beachu/components/simple_button.dart';
import 'package:beachu/components/snackbar.dart';
import 'package:beachu/constants.dart';
import 'package:beachu/providers/fire_provider.dart';
import 'package:beachu/providers/http_provider.dart';
import 'package:beachu/views/bath_list.dart';

// ignore: use_key_in_widget_constructors
class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _mailController = TextEditingController(),
      _pswController = TextEditingController();

  @override
  void dispose() {
    _mailController.dispose();
    _pswController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final httpP = context.read<HttpProvider>();
    final fireP = context.read<FireProvider>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: paddingEdgeValues,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _mailController,
                  decoration: InputDecoration(
                    labelText: 'decoration_mail'.tr(),
                    labelStyle: kBathOpacTextStyle,
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _pswController,
                  decoration: InputDecoration(
                    labelText: 'decoration_psw'.tr(),
                    labelStyle: kBathOpacTextStyle,
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20.0),
                SimpleButton(
                  title: 'register_button'.tr(),
                  onPressed: () async {
                    bool result = await fireP.registerWithEmail(
                      _mailController.text,
                      _pswController.text,
                    );
                    if (result) {
                      httpP.loadManagerBaths();
                      Navigator.pushReplacementNamed(context, BathListPage.id);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          snackBarBuilder(title: 'snack_msg'.tr()));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
