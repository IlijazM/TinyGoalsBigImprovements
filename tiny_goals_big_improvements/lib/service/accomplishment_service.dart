import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/core/date_util.dart';
import 'package:tiny_goals_big_improvements/domain/accomplishment.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/repository/accomplishment_repository.dart';
import 'package:tiny_goals_big_improvements/service/notification_service.dart';

class AccomplishmentService {
  static final _log = Logger('AccomplishmentService');

  final AccomplishmentRepository _accomplishmentRepository;

  AccomplishmentService()
      : _accomplishmentRepository = AccomplishmentRepository();

  Future<void> createNewAccomplishment(Accomplishment accomplishment) async {
    _log.info("Request to create or update a Accomplishment.");

    await _accomplishmentRepository.save(accomplishment);

    await NotificationService.instance.scheduleNotification();
  }

  /// Will create an accomplishment that got created just now.
  Future<void> createAccomplishmentNow(Accomplishment accomplishment) async {
    accomplishment.date = timeNow();

    createNewAccomplishment(accomplishment);
  }

  Future<List<Accomplishment>> getAllAccomplishmentsByGoal(Goal goal) async {
    _log.info("Request all Accomplishments by goal $goal.");

    List<Accomplishment> result =
        await _accomplishmentRepository.findAllByGoal(goal);

    _log.info(
        "Successfully got all Accomplishments. Got ${result.length} in total.");

    return result;
  }

  Future<void> deleteAccomplishment(int id) async {
    _log.info("Request to delete Accomplishment with the id $id.");

    await _accomplishmentRepository.delete(id);

    await NotificationService.instance.scheduleNotification();
  }
}
