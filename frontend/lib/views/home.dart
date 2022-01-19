import 'package:beachu/components/homepage/registration_button.dart';
import 'package:beachu/components/snackbar.dart';
import 'package:beachu/components/homepage/google_button.dart';
import 'package:beachu/components/homepage/login_button.dart';
import 'package:beachu/components/logout_button.dart';
import 'package:beachu/components/simple_button.dart';
import 'package:beachu/constants.dart' show kH30Padding;
import 'package:beachu/providers/bath_provider.dart';
import 'package:beachu/providers/fire_provider.dart';
import 'package:beachu/providers/http_provider.dart';
import 'package:beachu/views/bath_list.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Column,
        CrossAxisAlignment,
        Image,
        MainAxisAlignment,
        Navigator,
        Padding,
        Row,
        Scaffold,
        ScaffoldMessenger,
        SingleChildScrollView,
        SizedBox,
        StatelessWidget,
        Widget;
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  static const String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    final userId =
        context.select<BathProvider, String>((bathp) => bathp.userId);
    final httpP = context.read<HttpProvider>();
    final fireP = context.read<FireProvider>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: kH30Padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/logo.png', height: 200.0),
                  const SizedBox(height: 50.0),
                  SimpleButton(
                      title: 'search_button'.tr(),
                      onPressed: () async {
                        httpP.loadBaths();
                        Navigator.pushNamed(context, BathListPage.id);
                      }),
                  const SizedBox(height: 10.0),
                  (userId == '')
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RegistrationButton(),
                            LoginButton(),
                            const SizedBox(width: 5.0),
                            GoogleButton(
                              onPressed: () async {
                                bool result = await fireP.signInWithGoogle();
                                if (result) {
                                  httpP.loadManagerBaths();
                                  Navigator.pushNamed(context, BathListPage.id);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarBuilder(title: 'snack_msg'.tr()),
                                  );
                                }
                              },
                            ),
                          ],
                        )
                      : LogoutButton(
                          onPressed: () async {
                            await fireP.signOut();
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
