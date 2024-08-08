import 'package:base_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_bloc.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_event.dart';
import 'package:topup_app/core/app_colors.dart';

class TopUpBalance extends StatefulWidget {
  const TopUpBalance({super.key});

  @override
  State<TopUpBalance> createState() => _TopUpBalanceState();
}

class _TopUpBalanceState extends State<TopUpBalance> {
  final TextEditingController myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        16.0,
      ),
      child: Column(
        children: <Widget>[
          Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Deposite amount',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color.fromRGBO(46, 46, 46, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                TextFormField(
                  controller: myController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Deposite',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(192, 192, 192, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onSaved: (String? value) {
                    debugPrint('Value for field saved as "$value"');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          MaterialButton(
            color: AppColors.color788CCD,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            textColor: Colors.white,
            disabledColor: const Color.fromARGB(255, 227, 227, 227),
            onPressed: () {
              if (myController.text.isNotEmpty) {
                BlocProvider.of<GetTopUpUserBloc>(context).add(
                  PutDipositeEvent(
                    double.parse(
                      myController.text,
                    ),
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Diposite'),
          ),
        ],
      ),
    );
  }
}
