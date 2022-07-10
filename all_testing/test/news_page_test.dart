import 'package:all_testing/model/article.dart';
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
    Article(title: 'Test1', content: 'test1 content'),
    Article(title: 'Test2', content: 'test2 content'),
    Article(title: 'Test3', content: 'test3 content')
  ];

  void arrangeNewsServiceReturns3Articles() {
    when(() => mockNewService.getArticles())
        .thenAnswer((_) async => articlesFromService);
  }

  void arrangeNewsServiceReturns3ArticlesAfter2SecondWait() {
    when(() => mockNewService.getArticles()).thenAnswer(
      (_) async {
        await Future.delayed(const Duration(seconds: 3));
        return articlesFromService;
      },
    );
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
    "title is displayed",
    (WidgetTester tester) async {
      arrangeNewsServiceReturns3Articles();
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('News'), findsOneWidget);
    },
  );

  testWidgets(
    "Loading indicator is displayed while waiting for articles",
    (WidgetTester tester) async {
      arrangeNewsServiceReturns3ArticlesAfter2SecondWait();
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();
    },
  );
  testWidgets(
    "Articles are displayed ",
    (WidgetTester tester) async {
      arrangeNewsServiceReturns3Articles();
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump();

      for (final article in articlesFromService) {
        expect(find.text(article.title), findsOneWidget);
        expect(find.text(article.content), findsOneWidget);
      }
    },
  );
}
