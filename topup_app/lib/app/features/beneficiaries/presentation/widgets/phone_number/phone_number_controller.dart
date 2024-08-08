import 'package:flutter/widgets.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/widgets/phone_number/country.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/widgets/phone_number/phone_numbers.dart';

/// Controller holds all the persistent state used by the
/// [PhoneNumberField] widget.
class PhoneNumberEditingController extends ChangeNotifier
    implements ValueNotifier<PhoneNumber?> {
  /// Creates a controller with given initial [value].
  PhoneNumberEditingController([PhoneNumber value = PhoneNumber.empty])
      : nationalNumberController =
            TextEditingController(text: value.nationalNumber),
        countryNotifier = ValueNotifier<Country?>(value.country),
        _value = value,
        super() {
    _initialize();
  }

  /// Creates a controller with given default [country] selected.
  PhoneNumberEditingController.fromCountry(Country country)
      : nationalNumberController = TextEditingController(),
        countryNotifier = ValueNotifier<Country?>(country),
        _value = PhoneNumber.empty.copyWith(country: country) {
    _initialize();
  }

  /// Creates a controller with default selected country that matches given
  /// [isoCode] argument.
  factory PhoneNumberEditingController.fromCountryCode(String isoCode) =>
      PhoneNumberEditingController.fromCountry(Country.fromCode(isoCode));

  /// Controller of the national phone number [TextField].
  final TextEditingController nationalNumberController;

  /// Notifier for currently selected country.
  final ValueNotifier<Country?> countryNotifier;

  /// The currently selected country value stored in the controller.
  Country? get country => countryNotifier.value;
  set country(Country? newValue) {
    countryNotifier.value = newValue;
  }

  /// The currently written national number text stored in the controller.
  String get nationalNumber => nationalNumberController.text;
  set nationalNumber(String newValue) {
    nationalNumberController.text = newValue;
  }

  @override
  set value(PhoneNumber? newValue) {
    if (value == newValue) {
      return;
    }
    _value = newValue;
    notifyListeners();
    _detach();
    try {
      countryNotifier.value = newValue?.country;
      nationalNumberController.text = newValue?.nationalNumber ?? '';
    } finally {
      _attach();
    }
  }

  @override
  PhoneNumber? get value => _value;

  @override
  void dispose() {
    _detach();
    countryNotifier.dispose();
    nationalNumberController.dispose();
    super.dispose();
  }

  PhoneNumber? _value;

  void _attach() {
    countryNotifier.addListener(_onChange);
    nationalNumberController.addListener(_onChange);
  }

  void _detach() {
    countryNotifier.removeListener(_onChange);
    nationalNumberController.removeListener(_onChange);
  }

  void _initialize() {
    _attach();
  }

  void _onChange() {
    _value = PhoneNumber(country, nationalNumber);
    notifyListeners();
  }
}
