import 'package:logging/logging.dart';

initLogger() {
  // Init logger.
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time}: [${record.loggerName}] ${record.level.name}: ${record.message}');
  });
}
