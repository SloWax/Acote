import 'package:acote/Home/HomeVM.dart';
import 'package:acote/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HomeScreen Integration Test', () {
    testWidgets('Test loading and scrolling user list',
        (WidgetTester tester) async {
      // 앱 초기화 및 시작
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomeVM()..fetchUsers()),
          ],
          child: MyApp(),
        ),
      );

      // 앱 첫 화면에서 CircularProgressIndicator 표시 확인 (데이터 로딩 중)
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // 첫 번째 데이터 로드 후 ListTile이 표시되는지 확인
      await tester.pumpAndSettle(); // API 호출이 완료되고 UI 업데이트가 완료될 때까지 대기
      expect(find.byType(ListTile), findsWidgets);

      // 스크롤하여 새로운 데이터를 불러오도록 시도
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle(); // 새로운 데이터가 로드되고 UI가 업데이트될 때까지 대기

      // 새로운 데이터를 포함한 ListTile이 있는지 확인
      expect(find.byType(ListTile), findsWidgets);

      // 스크롤을 맨 아래로 이동하여 추가 데이터 로드 시도
      await tester.drag(find.byType(ListView), const Offset(0, -1000));
      await tester.pumpAndSettle(); // API 호출이 완료되고 UI 업데이트가 완료될 때까지 대기

      // 추가 데이터가 로드된 후에도 ListTile이 더 많이 표시되는지 확인
      expect(find.byType(ListTile), findsWidgets);

      // 광고 배너가 10번째 항목에 표시되는지 확인
      expect(find.byType(Image), findsWidgets);

      // 첫 번째 사용자 항목 클릭
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle(); // 화면 전환이 완료될 때까지 대기

      // DetailsScreen이 표시되는지 확인
      expect(find.text("tomtt's Repositories"), findsOneWidget);

      // 저장소 목록이 로드되는지 확인
      expect(find.byType(ListTile), findsWidgets);

      // 스크롤하여 추가 데이터를 로드
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle(); // 새로운 데이터가 로드되고 UI가 업데이트될 때까지 대기

      // 저장소 목록이 로드되었는지 확인
      expect(find.byType(ListTile), findsWidgets);
    });
  });
}
