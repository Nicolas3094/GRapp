import 'package:g_mcp/data/Models/DescriptionAR.dart';
import 'package:g_mcp/data/services/arProjects_service.dart';

import '../Models/repositories/irep.dart';

class ARProjectRepository implements IDocRepository<DescriptionAR> {
  final ARProjectService _service = ARProjectService();

  static final ARProjectRepository _instance = ARProjectRepository._();
  ARProjectRepository._();

  factory ARProjectRepository() {
    return _instance;
  }

  @override
  Future<void> fetch() async {
    return await _service.fetchFirebase();
  }

  @override
  Future<List<DescriptionAR>> getAll() async {
    var lst = _service.getProjects();
    return lst;
  }

  @override
  Future<DescriptionAR> getOne(int id) async {
    var item = _service.getProjects()[id];
    return item;
  }
}
