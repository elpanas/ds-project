import 'package:beachu/components/action_button.dart';
import 'package:beachu/components/bathpage/bath_container.dart';
import 'package:beachu/components/bathpage/bath_subtitle.dart';
import 'package:beachu/components/bathpage/bath_title.dart';
import 'package:beachu/components/bathpage/umbrella_button.dart';
import 'package:beachu/components/snackbar.dart';
import 'package:beachu/components/simple_button.dart';
import 'package:beachu/constants.dart';
import 'package:beachu/models/bath_index.dart';
import 'package:beachu/models/bath_model.dart';
import 'package:beachu/providers/bath_provider.dart';
import 'package:beachu/providers/fav_provider.dart';
import 'package:beachu/providers/http_provider.dart';
import 'package:beachu/views/edit_bath.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: use_key_in_widget_constructors
class BathPage extends StatelessWidget {
  static const String id = 'bath_screen';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BathIndex;
    final bathP = context.read<BathProvider>();
    final httpP = context.read<HttpProvider>();
    final favP = context.watch<FavProvider>();
    final userId =
        context.select<BathProvider, String>((bathp) => bathp.userId);
    final bath =
        context.select<BathProvider, Bath>((bathp) => bathp.bath[args.index]);
    final loading = context.select<HttpProvider, bool>((http) => http.loading);
    return WillPopScope(
      onWillPop: () async {
        context.read<FavProvider>().loadFavList();
        return true;
      },
      child: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator: circleProgressColor,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              (userId != bath.uid)
                  ? ActionIconButton(
                      key: UniqueKey(),
                      icon:
                          (bath.fav) ? Icons.favorite : Icons.favorite_outline,
                      onPressed: () {
                        (bath.fav)
                            ? favP.delFav(bath.bid)
                            : favP.addFav(args.index);
                      },
                    )
                  : ActionIconButton(
                      key: UniqueKey(),
                      icon: Icons.edit,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          EditBath.id,
                          arguments: BathIndex(index: args.index),
                        );
                      },
                    ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BathTitle(title: bath.name),
                const SizedBox(height: 5.0),
                BathSubTitle(),
                Row(
                  children: [
                    BathContainer(
                      title: 'bath_available'.tr(),
                      icon: Icons.beach_access,
                      colour: const Color(0xFF4CAF50),
                      info: bath.avUmbrellas.toString(),
                    ),
                    BathContainer(
                      onPressed: () => bathP.openMap(args.index),
                      title: 'bath_position'.tr(),
                      icon: Icons.location_on,
                      colour: const Color(0xFF2196F3),
                      info: 'bath_openmap'.tr(),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                (userId != bath.uid)
                    ? SimpleButton(
                        title: 'bath_call'.tr(),
                        onPressed: () async =>
                            await bathP.callNumber(args.index),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UmbrellasIconButton(
                            key: UniqueKey(),
                            icon: Icons.remove,
                            onPressed: () async {
                              bool _result =
                                  await httpP.decreaseUmbrellas(args.index);
                              if (!_result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarBuilder(title: 'bath_min'.tr()),
                                );
                              }
                            },
                          ),
                          const SizedBox(width: 20.0),
                          UmbrellasIconButton(
                            key: UniqueKey(),
                            icon: Icons.add,
                            onPressed: () async {
                              bool _result =
                                  await httpP.increaseUmbrellas(args.index);
                              if (!_result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarBuilder(title: 'bath_max'.tr()),
                                );
                              }
                            },
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
