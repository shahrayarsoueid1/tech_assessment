// ignore_for_file: avoid_classes_with_only_static_members

import 'package:base_common/main.dart';
import 'package:base_dependencies/main.dart';
import 'package:modular_interfaces/src/di/injector.dart';
import 'package:modular_interfaces/src/route/modular_arguments.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/remote/get_beneficiaries_service.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/repository/get_beneficiaries_repository_impl.dart';
import 'package:topup_app/app/features/beneficiaries/datasource/repository/put_beneficiaries_repository_impl.dart';
import 'package:topup_app/app/features/beneficiaries/domain/repository/get_beneficiaries_repository.dart';
import 'package:topup_app/app/features/beneficiaries/domain/repository/put_beneficiary_repository.dart';
import 'package:topup_app/app/features/beneficiaries/domain/usecase/get_beneficiaries_usecase.dart';
import 'package:topup_app/app/features/beneficiaries/domain/usecase/put_beneficiaries_usecase.dart';
import 'package:topup_app/app/features/beneficiaries/presentation/bloc/remote/get_beneficiaries_bloc.dart';
import 'package:topup_app/app/features/user_balance/balance/deposite/datasource/remote/put_deposite_service.dart';
import 'package:topup_app/app/features/user_balance/balance/deposite/datasource/repository/put_deposite_repository_impl.dart';
import 'package:topup_app/app/features/user_balance/balance/deposite/domain/repository/put_deposite_repository.dart';
import 'package:topup_app/app/features/user_balance/balance/deposite/domain/use_case/put_diposite_usecase.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/datasource/remote/top_up_service.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/datasource/repository/top_up_repository_impl.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/repository/top_up_repository.dart';
import 'package:topup_app/app/features/user_balance/balance/topup/domain/use_case/top_up_usecase.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/remote/get_user_service.dart';
import 'package:topup_app/app/features/user_balance/user/datasource/repository/user_repository_impl.dart';
import 'package:topup_app/app/features/user_balance/user/domain/repository/user_repository.dart';
import 'package:topup_app/app/features/user_balance/user/domain/use_case/get_user_usecase.dart';
import 'package:topup_app/app/features/user_balance/user/presentation/bloc/get_user_bloc.dart';
import 'package:topup_app/app/main_screen.dart';

class TopUpModule {
  static List<Bind<Object>> getBinds() => <Bind<Object>>[
        ..._getDatabase(),
        ..._getService(),
        ..._getRepositories(),
        ..._getUsecases(),
        ..._getBloc(),
      ];

  static List<Bind<Object>> _getDatabase() => <Bind<Object>>[];

  static List<Bind<Object>> _getService() => <Bind<Object>>[
        Bind.factory<BeneficiariesService>(
            (Injector<dynamic> i) => BeneficiariesService()),
        Bind.factory<GetUserService>(
          (Injector<dynamic> i) => GetUserService(),
        ),
        Bind.factory<PutDepositeService>(
          (Injector<dynamic> i) => PutDepositeService(),
        ),
        Bind.factory<TopUpService>(
          (Injector<dynamic> i) => TopUpService(),
        ),
      ];

  static List<Bind<Object>> _getRepositories() => <Bind<Object>>[
        Bind.factory<GetBeneficiariesRepository>(
          (Injector<dynamic> i) => BeneficiariesRepositoryImpl(
            i.get(),
          ),
        ),
        Bind.factory<PutBeneficiaryRepository>(
          (Injector<dynamic> i) => PutBeneficiaryRepositoryImpl(
            i.get(),
          ),
        ),
        Bind.factory<UserRepository>(
          (Injector<dynamic> i) => UserRepositoryImpl(
            i.get(),
          ),
        ),
        Bind.factory<PutDepositeRepository>(
          (Injector<dynamic> i) => PutDepositeRepositoryImpl(
            i.get(),
          ),
        ),
        Bind.factory<TopUpRepository>(
          (Injector<dynamic> i) => TopUpRepositoryImpl(
            i.get(),
          ),
        ),
      ];

  static List<Bind<Object>> _getUsecases() => <Bind<Object>>[
        Bind.factory<GetBeneficiariesUsecase>(
          (Injector<dynamic> i) => GetBeneficiariesUsecaseImpl(
            i.get(),
          ),
        ),
        Bind.factory<PutBeneficiariesUsecase>(
          (Injector<dynamic> i) => PutBeneficiariesUsecaseImpl(
            i.get(),
          ),
        ),
        Bind.factory<GetUserUsecase>(
          (Injector<dynamic> i) => GetUserUsecaseImpl(
            i.get(),
          ),
        ),
        Bind.factory<PutDipositeUsecase>(
          (Injector<dynamic> i) => PutDipositeUsecaseImpl(
            i.get(),
          ),
        ),
        Bind.factory<TopUpUsecase>(
          (Injector<dynamic> i) => TopUpUsecaseImpl(
            i.get(),
          ),
        ),
      ];

  static List<Bind<Object>> _getBloc() => <Bind<Object>>[
        Bind.factory<GetTopUpBeneficiariesBloc>(
            (Injector<dynamic> i) => GetTopUpBeneficiariesBloc(
                  i.get(),
                  i.get(),
                )),
        Bind.factory<GetTopUpUserBloc>(
            (Injector<dynamic> i) => GetTopUpUserBloc(
                  i.get(),
                  i.get(),
                  i.get(),
                )),
      ];

  static List<ModularRoute> getRoutes() => <ModularRoute>[
        ChildRoute<dynamic>(defaultScreen,
            child: (_, ModularArguments args) => const MainTopUpScreen()),
      ];
}
