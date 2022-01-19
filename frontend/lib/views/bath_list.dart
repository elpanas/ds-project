import 'package:beachu/components/action_button.dart';
import 'package:beachu/components/add_button.dart';
import 'package:beachu/components/bathlistpage/bath_alert.dart';
import 'package:beachu/components/bathlistpage/bath_card.dart';
import 'package:beachu/components/message.dart';
import 'package:beachu/components/snackbar.dart';
import 'package:beachu/constants.dart'
    show circleProgressColor, kAppBarTextStyle, kTitleListStyle;
import 'package:beachu/models/bath_index.dart';
import 'package:beachu/models/bath_model.dart';
import 'package:beachu/providers/bath_provider.dart';
import 'package:beachu/providers/fav_provider.dart';
import 'package:beachu/providers/http_provider.dart';
import 'package:beachu/views/bath_page.dart';
import 'package:beachu/views/fav_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Column,
        Expanded,
        Icons,
        ListView,
        Navigator,
        Scaffold,
        ScaffoldMessenger,
        SizedBox,
        StatelessWidget,
        Text,
        UniqueKey,
        Widget,
        showDialog;
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class BathListPage extends StatelessWidget {
  static const String id = 'bath_list_screen';
  @override
  Widget build(BuildContext context) {
    final message =
        context.select<BathProvider, String>((bathp) => bathp.message);
    final bathCount =
        context.select<BathProvider, int>((bathp) => bathp.bathCount);
    final bathList =
        context.select<BathProvider, List<Bath>>((bathp) => bathp.bath);
    final userId =
        context.select<BathProvider, String>((bathp) => bathp.userId);
    final httpP = context.read<HttpProvider>();
    final favP = context.read<FavProvider>();
    final loading = context.select<HttpProvider, bool>((http) => http.loading);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'bath_list_title',
          style: kAppBarTextStyle,
        ).tr(),
        actions: [
          if (userId != '')
            ActionIconButton(
              key: UniqueKey(),
              icon: Icons.admin_panel_settings,
              onPressed: () => httpP.loadManagerBaths(),
            ),
          ActionIconButton(
            key: UniqueKey(),
            icon: Icons.list,
            onPressed: () {
              favP.loadFavList();
              Navigator.pushNamed(context, FavListPage.id);
            },
          ),
        ],
      ),
      floatingActionButton: (userId != '') ? FloatingAdd() : null,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator: circleProgressColor,
        child: SizedBox(
          width: double.infinity,
          child: (bathList.isNotEmpty)
              ? Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      bathList[0].city,
                      style: kTitleListStyle,
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: bathCount,
                        itemBuilder: (context, index) {
                          return BathCard(
                            key: UniqueKey(),
                            title: bathList[index].name,
                            availableUmbrella: bathList[index].avUmbrellas,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                BathPage.id,
                                arguments: BathIndex(index: index),
                              );
                            },
                            onLongPress: () {
                              if (userId != '') {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return DeleteAlert(
                                      onPressed: () async {
                                        bool result = await httpP.deleteBath(
                                            http.Client(), index);
                                        if (result) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            snackBarBuilder(
                                              title: 'bath_deleted'.tr(),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Message(message: message),
        ),
      ),
    );
  }
}
