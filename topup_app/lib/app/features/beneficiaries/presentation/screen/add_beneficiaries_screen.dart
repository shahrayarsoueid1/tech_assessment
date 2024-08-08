import 'package:base_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/bloc/remote/get_beneficiaries_bloc.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/bloc/remote/get_beneficiaries_event.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/widgets/phone_number/phone_number.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/widgets/phone_number/phone_number_controller.dart';
import 'package:topup_app/core/app_colors.dart';
import 'package:topup_app/core/reusable_widgets.dart';

class AddBeneficiariesScreen extends StatefulWidget {
  const AddBeneficiariesScreen({super.key});

  @override
  State<AddBeneficiariesScreen> createState() => _AddBeneficiariesScreenState();
}

class _AddBeneficiariesScreenState extends State<AddBeneficiariesScreen> {
  String nickName = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PhoneNumberEditingController phoneNumberController =
      PhoneNumberEditingController.fromCountryCode('AE');

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        'Beneficiary Screen',
        ctx: context,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(20),
                ],
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Nickname',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(224, 224, 224, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onChanged: (String value) {
                  nickName = value;
                },
                onSaved: (String? value) {
                  debugPrint('Value for field saved as "$value"');
                },
              ),
              const SizedBox(
                height: 16,
              ),

              // phone number text field
              PhoneNumberField(
                controller: phoneNumberController,
                countryCodeWidth: 62,
              ),

              // add beneficiary button
              Center(
                child: MaterialButton(
                  color: AppColors.color788CCD,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  textColor: Colors.white,
                  disabledColor: const Color.fromARGB(255, 227, 227, 227),
                  onPressed: () {
                    final String phoneNumber =
                        phoneNumberController.value!.formattedNumber;
                    final RegExp phoneReg = RegExp(
                        r'^(?:00971|\+971|0)?(?:50|51|52|55|56|58|2|3|4|6|7|9)\d{7}');
                    final bool match = phoneReg.hasMatch(phoneNumber);
                    if (!match) {
                      _showAlertDialog(context);
                    }
                    if (_formKey.currentState!.validate() && match) {
                      final PutBeneficiaryEvent event = PutBeneficiaryEvent(
                        BeneficiaryModel(
                          nickName,
                          phoneNumber,
                        ),
                      );
                      BlocProvider.of<GetTopUpBeneficiariesBloc>(context)
                          .add(event);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Save beneficiary',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Please enter valid phone number'),
        );
      },
    );
  }
}
