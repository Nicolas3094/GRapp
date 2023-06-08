import 'package:g_mcp/data/Models/press_model.dart';
import 'package:g_mcp/data/services/press_service.dart';

import '../Models/repositories/irep.dart';

class PressRepository implements IDocRepository<Press> {
  final PressService _service;

  PressRepository(this._service);

  @override
  Future<void> fetch() async {
    return await _service.fetchFirebase();
  }

  @override
  Future<List<Press>> getAll() async {
    var lst = _service.getProjects();
    return lst;
  }

  @override
  Future<Press> getOne(int id) async {
    var item = _service.getProjects()[id];
    return item;
  }
}
