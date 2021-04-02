import 'package:get_it/get_it.dart';
import 'AppSCoedModel.dart';
GetIt locatorGetIt = GetIt();
void setupLocator()
{
  //scoped model


  //api servicesAppModel

  locatorGetIt.registerLazySingleton<AppModel>(()=>AppModel());

}