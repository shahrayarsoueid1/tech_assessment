import 'package:base_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:topup_app/app/features/user_balance/balance/deposite/presentation/deposite_balance_widget.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_bloc.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_state.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/widget/balance_widget.dart';
import 'package:topup_app/core/app_colors.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTopUpUserBloc, RemoteUserState>(
      builder: (BuildContext context, RemoteUserState state) {
        final double balance = state.userEntity?.balance ?? 0.0;
        final String name = state.userEntity?.name ?? '';
        final String currency = state.userEntity?.currency ?? '';
        final String isVeified = state.userEntity?.isVerified.toString() ?? '';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                BalanceWidget(
                  balance: balance,
                  name: name,
                  currency: currency,
                  isVerified: isVeified,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.color30447D,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {
                          return BlocProvider<GetTopUpUserBloc>.value(
                            value: BlocProvider.of<GetTopUpUserBloc>(context),
                            child: const TopUpBalance(),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      color: AppColors.color30447D,
                      Icons.add,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
