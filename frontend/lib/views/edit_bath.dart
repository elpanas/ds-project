import 'package:beachu/components/new_edit_bathpage/bath_field.dart';
import 'package:beachu/components/simple_button.dart';
import 'package:beachu/components/snackbar.dart' show snackBarBuilder;
import 'package:beachu/constants.dart';
import 'package:beachu/models/bath_index.dart';
import 'package:beachu/models/bath_model.dart';
import 'package:beachu/providers/bath_provider.dart';
import 'package:beachu/providers/http_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class EditBath extends StatefulWidget {
  static const String id = 'edit_bath_screen';
  @override
  _EditBathState createState() => _EditBathState();
}

class _EditBathState extends State<EditBath> {
  final _nameController = TextEditingController(),
      _avUmbrellasController = TextEditingController(),
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as BathIndex;
      final bath =
          context.read<BathProvider>().bath[args.index];

      _nameController.text = bath.name;
      _avUmbrellasController.text = bath.avUmbrellas.toString();
      _totUmbrellasController.text = bath.totUmbrellas.toString();
      _phoneController.text = bath.phone;
      _cityController.text = bath.city;
      _provinceController.text = bath.province;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BathIndex;
    final bathP = context.read<BathProvider>();
    final httpP = context.read<HttpProvider>();
    final loading = context.select<HttpProvider, bool>((http) => http.loading);
    Bath bath = bathP.bath[args.index];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bath.name,
          style: kAppBarTextStyle,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator: circleProgressColor,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: kH20Padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20.0),
                    BathField(
                      controller: _nameController,
                      labelText: 'bath_name'.tr(),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        BathField(
                          controller: _avUmbrellasController,
                          inputType: TextInputType.number,
                          labelText: 'bath_av_input'.tr(),
                        ),
                        const SizedBox(width: 20.0),
                        BathField(
                          controller: _totUmbrellasController,
                          inputType: TextInputType.number,
                          labelText: 'bath_tot'.tr(),
                        ),
                      ],
                    ),
                    BathField(
                      controller: _phoneController,
                      inputType: TextInputType.phone,
                      labelText: 'bath_phone'.tr(),
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
                      title: 'edit_button'.tr(),
                      onPressed: () async {
                        bool _validate = _formKey.currentState!.validate(),
                            _result = false;
                        if (_formKey.currentState!.validate()) {
                          Bath bath = await httpP.makeRequest(
                            _nameController.text,
                            int.parse(_avUmbrellasController.text),
                            int.parse(_totUmbrellasController.text),
                            _phoneController.text,
                            _cityController.text,
                            _provinceController.text,
                          );
                          _result = await httpP.putBath(
                              http.Client(), bath, args.index);
                          if (_result) Navigator.pop(context);
                        }

                        if (!_validate || !_result) {
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
