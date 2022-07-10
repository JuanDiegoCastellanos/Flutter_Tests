import 'package:all_testing/model/article.dart';
import 'package:all_testing/pages/article_page.dart';
import 'package:all_testing/pages/news_change_notifier.dart';
import 'package:all_testing/pages/news_page.dart';
import 'package:all_testing/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockNewService extends Mock implements NewsService {}

void main() {
  late MockNewService mockNewService;

  //Configurar lo relacionado con los test, este metodo se ejecuta antes que las pruebas
  setUp(() {
    mockNewService = MockNewService();
  });
  final articlesFromService = [
    Article(title: 'Test 1', content: 'Test 1 content'),
    Article(title: 'Test 2', content: 'Test 2 content'),
    Article(title: 'Test 3', content: 'Test 3 content')
  ];

  void arrangeNewsServiceReturns3Articles() {
    when(() => mockNewService.getArticles())
        .thenAnswer((_) async => articlesFromService);
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewService),
        child: NewsPage(),
      ),
    );
  }

  testWidgets(
    "Tapping on the first article excerpt opens the article page"
    "where the full article content is displayed",
    (WidgetTester tester) async {
      arrangeNewsServiceReturns3Articles();

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump();

      await tester.tap(find.text('Test 1 content'));

      await tester.pumpAndSettle();

      // verificar que este en la pagina del contenido de la noticia

      expect(find.byType(NewsPage), findsNothing);
      expect(find.byType(ArticlePage), findsOneWidget);

      expect(find.text('Test 1'), findsOneWidget);
      expect(find.text('Test 1 content'), findsOneWidget);
    },
  );
}
