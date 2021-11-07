import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/domain/accomplishment.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/repository/accomplishment_repository.dart';

class AccomplishmentService {
  static final _log = Logger('AccomplishmentService');

  final AccomplishmentRepository _accomplishmentRepository;

  AccomplishmentService()
      : _accomplishmentRepository = AccomplishmentRepository();

  void createNewAccomplishment(Accomplishment accomplishment) {
    _log.info("Request to create or update a Accomplishment.");

    _accomplishmentRepository.save(accomplishment);
  }

  Future<List<Accomplishment>> getAllAccomplishmentsByGoal(Goal goal) async {
    _log.info("Request all Accomplishments by goal $goal.");

    List<Accomplishment> result =
        await _accomplishmentRepository.findAllByGoal(goal);

    _log.info(
        "Successfully got all Accomplishments. Got ${result.length} in total.");

    return result;
  }

  void deleteAccomplishment(int id) {
    _log.info("Request to delete Accomplishment with the id $id.");

    _accomplishmentRepository.delete(id);
  }
}
