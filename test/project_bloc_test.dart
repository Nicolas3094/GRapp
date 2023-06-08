import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:g_mcp/data/Models/project.dart';
import 'package:g_mcp/data/Models/repositories/irep.dart';
import 'package:g_mcp/main.dart';
import 'package:mockito/mockito.dart';

const ProjectCollection = "projects";

class MockProjectsRepository extends Mock implements IDocRepository<Project> {}

void main() {
  testWidgets("Testing init", (tester) async {
    final FakeFirebaseFirestore firestore = FakeFirebaseFirestore();
    final MockFirebaseStorage storage = MockFirebaseStorage();
    const filename1 = "Frame.png";
    const filename2 = "Iphone.png";
    const filename3 = "13.png";

    final storageRef1 = storage.ref("root1").child("$filename1");
    final localImage1 = await rootBundle.load("assets/images/$filename1");
    await storageRef1.putData(localImage1.buffer.asUint8List());

    final storageRef2 = storage.ref("root2").child("$filename2");
    final localImage2 = await rootBundle.load("assets/images/$filename2");
    await storageRef2.putData(localImage2.buffer.asUint8List());

    final storageRef3 = storage.ref("root3").child("$filename3");
    final localImage3 = await rootBundle.load("assets/images/$filename3");
    await storageRef3.putData(localImage3.buffer.asUint8List());

    await firestore.collection(ProjectCollection).add({
      'title': 't1',
      'year': 2,
      'dataENG': 'ss',
      'dataESP': 'esp',
      'descriptionENG': 'eng',
      'descriptionESP': 'esp',
      'dir': 'root1',
      'year_place': 'sss',
      'order': 1
    });
    await firestore.collection(ProjectCollection).add({
      'title': 't2',
      'year': 2,
      'dataENG': 'ss',
      'dataESP': 'esp',
      'descriptionENG': 'eng',
      'descriptionESP': 'esp',
      'dir': 'root2',
      'year_place': 'sss',
      'order': 2
    });
    await firestore.collection(ProjectCollection).add({
      'title': 't3',
      'year': 2,
      'dataENG': 'ss',
      'dataESP': 'esp',
      'descriptionENG': 'eng',
      'descriptionESP': 'esp',
      'dir': 'root3',
      'year_place': 'sss',
      'order': 3
    });

    await tester.pumpWidget(MyApp(
      firestore: firestore,
      storage: storage,
    ));

    /*await tester.idle();

    await tester.pump();

    await tester.pumpWidget(ProyectsListWidget(
      isProject: true,
    ));
    await tester.idle();

    await tester.pump();

    expect(find.text('t1'), findsOneWidget);
    expect(find.text('t3'), findsOneWidget);
    expect(find.text('t2'), findsOneWidget);*/
  });
}
