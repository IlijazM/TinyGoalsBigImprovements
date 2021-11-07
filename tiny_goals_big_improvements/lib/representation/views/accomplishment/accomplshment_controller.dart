import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/domain/accomplishment.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/representation/views/accomplishment/update/accomplishment_update_dialog.dart';
import 'package:tiny_goals_big_improvements/service/accomplishment_service.dart';

class AccomplishmentController {
  final Goal goal;

  final AccomplishmentService _accomplishmentService;

  AccomplishmentController(this.goal)
      : _accomplishmentService = AccomplishmentService();

  create(Accomplishment accomplishment) {
    _accomplishmentService.createNewAccomplishment(accomplishment);
  }
}
