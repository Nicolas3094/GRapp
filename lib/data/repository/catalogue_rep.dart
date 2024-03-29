import 'package:g_mcp/data/Models/catalogue.dart';
import 'package:g_mcp/data/services/catalogue_service.dart';
import '../Models/repositories/irep.dart';

class CatalogueRepository implements IDocRepository<Catalogue> {
  final CatalogueService _service;

  CatalogueRepository(this._service);

  @override
  Future<void> fetch() async {
    return await _service.fetchFirebase();
  }

  @override
  Future<List<Catalogue>> getAll() async {
    var lst = _service.getCatalogues();
    return lst;
  }

  @override
  Future<Catalogue> getOne(int id) async {
    var item = _service.getCatalogues()[id];
    return item;
  }
}
