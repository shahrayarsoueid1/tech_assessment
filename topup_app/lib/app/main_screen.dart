import 'package:base_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/bloc/remote/get_beneficiaries_bloc.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/bloc/remote/get_beneficiaries_event.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/widgets/beneficiaries_list_widget.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_bloc.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_event.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/widget/balance_card_widget.dart';
import 'package:topup_app/core/reusable_widgets.dart';

class MainTopUpScreen extends StatefulWidget {
  const MainTopUpScreen({Key? key}) : super(key: key);

  @override
  State<MainTopUpScreen> createState() => _MainTopUpScreenState();
}

class _MainTopUpScreenState extends State<MainTopUpScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<GetTopUpBeneficiariesBloc>(
          create: (BuildContext context) =>
              Modular.get<GetTopUpBeneficiariesBloc>()
                ..add(GetBeneficiariesEvent()),
        ),
        BlocProvider<GetTopUpUserBloc>(
          create: (BuildContext context) =>
              Modular.get<GetTopUpUserBloc>()..add(GetUserEvent()),
        ),
      ],
      child: Scaffold(
        appBar: getAppBar(
          'Mobile Recharge',
          ctx: context,
          centerTitle: false,
        ),
        body: const Column(
          children: <Widget>[
            BalanceCard(),
            SizedBox(
              height: 12,
            ),
            Expanded(child: BeneficiariesList()),
          ],
        ),
      ),
    );
  }
}
