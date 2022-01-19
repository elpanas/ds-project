import 'package:beachu/components/new_edit_bathpage/bath_field.dart';
import 'package:beachu/components/simple_button.dart';
import 'package:beachu/components/snackbar.dart';
import 'package:beachu/constants.dart'
    show circleProgressColor, kAppBarTextStyle, kH20Padding;
import 'package:beachu/models/bath_model.dart';
import 'package:beachu/providers/http_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Center,
        Column,
        Form,
        FormState,
        GlobalKey,
        MainAxisAlignment,
        MainAxisSize,
        Navigator,
        Padding,
        Row,
        Scaffold,
        ScaffoldMessenger,
        SingleChildScrollView,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextEditingController,
        TextInputType,
        Widget;
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class NewBath extends StatefulWidget {
  static const String id = 'new_bath_screen';
  @override
  _NewBathState createState() => _NewBathState();
}

class _NewBathState extends State<NewBath> {
  final _nameController = TextEditingController(),
      _totUmbrellasController = TextEditingController(),
      _phoneController = TextEditingController(),
      _cityController = TextEditingController(),
      _provinceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _totUmbrellasController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final httpP = context.read<HttpProvider>();
    final loading = context.select<HttpProvider, bool>((http) => http.loading);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'new_title',
          style: kAppBarTextStyle,
        ).tr(),
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator: circleProgressColor,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: kH20Padding,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BathField(
                      controller: _nameController,
                      labelText: 'bath_name'.tr(),
                    ),
                    const SizedBox(width: 10.0),
                    BathField(
                      controller: _totUmbrellasController,
                      labelText: 'bath_tot'.tr(),
                      inputType: TextInputType.number,
                    ),
                    BathField(
                      controller: _phoneController,
                      labelText: 'bath_phone'.tr(),
                      inputType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        BathField(
                          controller: _cityController,
                          labelText: 'bath_city'.tr(),
                        ),
                        const SizedBox(width: 20.0),
                        BathField(
                          controller: _provinceController,
                          labelText: 'bath_province'.tr(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    SimpleButton(
                      title: 'new_button'.tr(),
                      onPressed: () async {
                        bool validate = _formKey.currentState!.validate(),
                            result = false;
                        if (validate) {
                          Bath bath = await httpP.makeRequest(
                            _nameController.text,
                            int.parse(_totUmbrellasController.text),
                            int.parse(_totUmbrellasController.text),
                            _phoneController.text,
                            _cityController.text,
                            _provinceController.text,
                          );
                          result = await httpP.postBath(http.Client(), bath);
                          if (result) Navigator.pop(context);
                        }

                        if (!validate || !result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBarBuilder(title: 'snack_msg'.tr()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
