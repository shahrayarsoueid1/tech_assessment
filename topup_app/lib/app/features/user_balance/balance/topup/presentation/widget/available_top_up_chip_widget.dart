import 'package:base_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/entity/top_up_entity.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/utils/top_up_utils.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_bloc.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_event.dart';
import 'package:topup_app/core/app_colors.dart';

class AvailableTopUpChipWidget extends StatefulWidget {
  const AvailableTopUpChipWidget({
    super.key,
    required this.availableTopUps,
    required this.currency,
    required this.fees,
    required this.isMonthlyLimitReached,
    required this.name,
    required this.phone,
  });

  final List<AvailableTopUpsChipModel> availableTopUps;
  final String currency;
  final double fees;
  final bool isMonthlyLimitReached;
  final String? name;
  final String? phone;

  @override
  State<AvailableTopUpChipWidget> createState() =>
      _AvailableTopUpChipWidgetState();
}

class _AvailableTopUpChipWidgetState extends State<AvailableTopUpChipWidget> {
  int? _index;
  double? _topUpValue = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 4,
          children: List<ChoiceChip>.generate(
            widget.availableTopUps.length,
            (int index) {
              return ChoiceChip(
                showCheckmark: false,
                padding: const EdgeInsets.all(8),
                label: Text(
                    '${widget.currency} ${widget.availableTopUps[index].topUp}'),
                selectedColor: AppColors.color054C61A5,
                selected: _index == index,
                disabledColor: const Color.fromARGB(255, 197, 196, 196),
                onSelected: widget.isMonthlyLimitReached == true ||
                        !widget.availableTopUps[index].isActive
                    ? null
                    : (bool selected) {
                        setState(() {
                          _index = selected ? index : null;
                          _topUpValue = widget.availableTopUps[index].topUp;
                        });
                      },
              );
            },
          ).toList(),
        ),
        if (widget.availableTopUps.isNotEmpty && _index != null)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.w500),
              'Total Amount: ${getFullAmount(
                _topUpValue,
                widget.fees,
              )}',
            ),
          ),
        if (widget.availableTopUps.isNotEmpty)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              style: const TextStyle(fontWeight: FontWeight.w200),
              'A charge of ${widget.currency} ${widget.fees} will be applied for top-up transaction',
            ),
          ),
        if (widget.availableTopUps.isNotEmpty)
          Align(
            child: MaterialButton(
              color: AppColors.color788CCD,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              textColor: Colors.white,
              disabledColor: const Color.fromARGB(255, 227, 227, 227),
              onPressed: _index != null
                  ? () {
                      BlocProvider.of<GetTopUpUserBloc>(context).add(
                        TopUpEvent(
                          TopUpEntity(
                            widget.name,
                            widget.phone,
                            _topUpValue,
                            widget.currency,
                            widget.fees,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('Top up'),
            ),
          )
      ],
    );
  }
}
