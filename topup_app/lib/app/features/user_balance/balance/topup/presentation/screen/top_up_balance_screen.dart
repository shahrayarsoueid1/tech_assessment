import 'package:base_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/datasource/remote/top_up_service.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/presentation/widget/available_top_up_chip_widget.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/utils/top_up_utils.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_bloc.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_state.dart';
import 'package:topup_app/core/reusable_widgets.dart';

class TopUpBalanceScreen extends StatefulWidget {
  const TopUpBalanceScreen({
    super.key,
    this.name,
    this.phone,
  });

  final String? name;
  final String? phone;

  @override
  State<TopUpBalanceScreen> createState() => _TopUpBalanceScreenState();
}

class _TopUpBalanceScreenState extends State<TopUpBalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTopUpUserBloc, RemoteUserState>(
      builder: (BuildContext context, RemoteUserState state) {
        final String? currency = state.userEntity?.currency;

        final double? fees = state.userEntity?.fees;

        final bool isMonthlyLimitReached =
            (state.userEntity?.monthlyTransfer ?? 0.0) >= MAX_AMOUNT_PER_MONTH;

        final List<AvailableTopUpsChipModel> availableTopUps =
            state.userEntity?.history.availableTopsPerUser(
                  state.userEntity?.availableTopUp ?? <double>[],
                  state.userEntity?.balance,
                  fees,
                  widget.phone,
                  false,
                  state.userEntity?.monthlyTransfer,
                ) ??
                <AvailableTopUpsChipModel>[];

        final bool isTopUpAvailable = availableTopUps
                .firstWhere(
                  (AvailableTopUpsChipModel value) => value.isActive,
                  orElse: () => AvailableTopUpsChipModel(
                    topUp: -1,
                    isActive: false,
                  ),
                )
                .topUp !=
            -1;

        return Scaffold(
          appBar: getAppBar(
            'Top Up Beneficiary',
            ctx: context,
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 12,
                ),
                if (isTopUpAvailable)
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Top up amount:',
                      textAlign: TextAlign.start,
                    ),
                  ),
                Align(
                  alignment: Alignment.topLeft,
                  child: AvailableTopUpChipWidget(
                    availableTopUps: availableTopUps,
                    currency: currency ?? '',
                    fees: fees ?? 0.0,
                    isMonthlyLimitReached: isMonthlyLimitReached,
                    name: widget.name,
                    phone: widget.phone,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
