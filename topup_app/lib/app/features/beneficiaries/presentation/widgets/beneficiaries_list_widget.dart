import 'package:base_dependencies/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/model/beneficiary_model.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/bloc/remote/get_beneficiaries_bloc.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/bloc/remote/get_beneficiaries_state.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/screen/add_beneficiaries_screen.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/widgets/beneficiary_tile_widget.dart';
import 'package:topup_app/core/app_colors.dart';

class BeneficiariesList extends StatelessWidget {
  const BeneficiariesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTopUpBeneficiariesBloc, RemoteBeneficiariesState>(
      builder: (BuildContext context, RemoteBeneficiariesState state) {
        final List<BeneficiaryModel>? list =
            state.beneficiariesEntity?.beneficiaries;
        final bool isBeneficiariesMaxReached =
            state.beneficiariesEntity?.isBeneficiaryMaxReached ?? false;

        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (list == null || list.isEmpty)
                const Text('No Beneficiaries')
              else
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    // shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final String name = list[index].name ?? '';
                      final String phone = list[index].phone ?? '';
                      return BeneficiaryTile(name: name, phone: phone);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 0,
                      );
                    },
                  ),
                ),
              const SizedBox(
                height: 8,
              ),
              MaterialButton(
                color: AppColors.color788CCD,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                textColor: Colors.white,
                disabledColor: const Color.fromARGB(255, 227, 227, 227),
                onPressed: !isBeneficiariesMaxReached
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<AddBeneficiariesScreen>(
                              builder: (BuildContext builder) {
                            return BlocProvider<
                                GetTopUpBeneficiariesBloc>.value(
                              value: BlocProvider.of<GetTopUpBeneficiariesBloc>(
                                  context),
                              child: const AddBeneficiariesScreen(),
                            );
                          }),
                        );
                      }
                    : null,
                child: const Text('Add Beneficiary'),
              ),
            ],
          ),
        );
      },
    );
  }
}
