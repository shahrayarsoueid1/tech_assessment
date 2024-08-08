import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/widgets/phone_number/country.dart';

import 'package:topup_app/app/features/beneficiaries/presentation/widgets/phone_number/phone_number_controller.dart';

typedef PhoneNumberFieldPrefixBuilder = Widget? Function(
  BuildContext context,
  Country? country,
);

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({
    Key? key,
    this.decoration = const InputDecoration(),
    this.style,
    this.countryCodeWidth = 135,
    this.controller,
    this.dialogTitle = 'Area code',
    this.prefixBuilder = _buildPrefix,
  }) : super(key: key);

  /// Input decoration to customize input.
  final InputDecoration decoration;

  /// Editing controller that stores current state of the widget.
  final PhoneNumberEditingController? controller;

  /// Text font style
  final TextStyle? style;

  /// Width of the country code section
  final double countryCodeWidth;

  /// Title of area code selection dialog
  final String dialogTitle;

  final PhoneNumberFieldPrefixBuilder prefixBuilder;

  /// Default value for [PhoneNumberField.prefixIconGenerator]
  static PhoneNumberFieldPrefixBuilder? defaultPrefixBuilder;

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();

  static Widget? _buildPrefix(BuildContext context, Country? country) {
    return defaultPrefixBuilder != null
        ? defaultPrefixBuilder!(context, country)
        : null;
  }
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final bool _countryCodeFocused = false;
  PhoneNumberEditingController? _controller;
  final TextStyle _hiddenText = const TextStyle(
    color: Colors.transparent,
    height: 0,
    fontSize: 0,
  );

  PhoneNumberEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  Future<void> onChangeCountry() async {}

  @override
  void initState() {
    if (widget.controller == null) {
      _controller = PhoneNumberEditingController();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle =
        widget.style ?? Theme.of(context).textTheme.bodyLarge;

    return InputDecorator(
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        counterStyle: widget.decoration.counterStyle,
        errorStyle: widget.decoration.errorStyle,
        labelStyle: widget.decoration.labelStyle,
        helperStyle: widget.decoration.helperStyle,
        errorText: widget.decoration.errorText,
        helperText: widget.decoration.helperText,
        labelText: widget.decoration.labelText,
        counterText: widget.decoration.counterText,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: widget.countryCodeWidth,
            margin: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: onChangeCountry,
              child: ValueListenableBuilder<Country?>(
                valueListenable: _effectiveController!.countryNotifier,
                builder:
                    (BuildContext context, Country? value, Widget? child) =>
                        InputDecorator(
                  textAlignVertical: TextAlignVertical.center,
                  isFocused: _countryCodeFocused,
                  decoration: widget.decoration.copyWith(
                    hintText: '',
                    errorStyle: _hiddenText,
                    helperStyle: _hiddenText,
                    counterStyle: _hiddenText,
                    labelStyle: _hiddenText,
                    prefixIcon: widget.prefixBuilder(context, value),
                  ),
                  child: Text(
                    '+${value?.prefix ?? ''}',
                    style: textStyle,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Country?>(
              valueListenable: _effectiveController!.countryNotifier,
              builder: (BuildContext context, Country? value, Widget? child) =>
                  TextField(
                controller: _effectiveController!.nationalNumberController,
                style: textStyle,
                decoration: widget.decoration.copyWith(
                  labelStyle: _hiddenText,
                  errorStyle: _hiddenText,
                  helperStyle: _hiddenText,
                  counterStyle: _hiddenText,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: value?.length.maxLength ?? 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
