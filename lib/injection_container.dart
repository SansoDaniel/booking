import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:project_architecture/injection_container.config.dart';

final sl = GetIt.instance;

@InjectableInit()
void configureDependencies(String? env) => sl.init(environment: env);
