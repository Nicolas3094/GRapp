import 'package:g_mcp/data/Models/project.dart';
import 'package:g_mcp/data/services/project_service.dart';

import '../Models/repositories/irep.dart';

class ProjectRepository implements IDocRepository<Project> {
  final ProjectService _service = ProjectService();
  static final ProjectRepository _instance = ProjectRepository._();
  ProjectRepository._();

  factory ProjectRepository() {
    return _instance;
  }
  @override
  Future<void> fetch() async {
    return await _service.fetchFirebase();
  }

  @override
  Future<List<Project>> getAll() async {
    var lst = _service.getProjects();
    return lst;
  }

  @override
  Future<Project> getOne(int id) async {
    var item = _service.getProjects()[id];
    return item;
  }

  Future<bool> isLoading() async {
    return await _service.subject.first;
  }
}
