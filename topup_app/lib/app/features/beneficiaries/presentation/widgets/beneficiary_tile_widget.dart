import 'package:base_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/presentation/screen/top_up_balance_screen.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_bloc.dart';
import 'package:topup_app/core/app_colors.dart';

class BeneficiaryTile extends StatelessWidget {
  const BeneficiaryTile({
    super.key,
    required this.name,
    required this.phone,
  });

  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
        ),
        child: SizedBox(
          width: 128,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.color30447D,
                ),
              ),
              Text(
                phone,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorADB1B1,
                ),
              ),
              MaterialButton(
                height: 24,
                color: AppColors.color788CCD,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<TopUpBalanceScreen>(
                        builder: (BuildContext builder) {
                      return BlocProvider<GetTopUpUserBloc>.value(
                        value: BlocProvider.of<GetTopUpUserBloc>(context),
                        child: TopUpBalanceScreen(
                          name: name,
                          phone: phone,
                        ),
                      );
                    }),
                  );
                },
                child: const Text(
                  'Recharge now',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
