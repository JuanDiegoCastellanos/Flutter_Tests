import 'package:flutter_test/flutter_test.dart';
import 'package:all_testing/model/article.dart';
import 'package:all_testing/pages/news_change_notifier.dart';
import 'package:all_testing/services/news_service.dart';
import 'package:mocktail/mocktail.dart';

class MockNewService extends Mock implements NewsService {}

void main() {
// Se requiere una instancia de la clase para test, sut se refiere a System Under Test
  late NewsChangeNotifier sut;
  late MockNewService mockNewService;

  //Configurar lo relacionado con los test, este metodo se ejecuta antes que las pruebas
  setUp(() {
    mockNewService = MockNewService();
    sut = NewsChangeNotifier(mockNewService);
  });

  test('initial values are correct ', () {
    expect(sut.articles, []);
    expect(sut.isLoading, false);
  });
  group('getArticles', () {
    final articlesFromService = [
      Article(title: 'Test1', content: 'test1 content'),
      Article(title: 'Test2', content: 'test2 content'),
      Article(title: 'Test3', content: 'test3 content')
    ];
    void arrangeNewsServiceReturns3Articles() {
      when(() => mockNewService.getArticles())
          .thenAnswer((_) async => articlesFromService);
    }

    test('gets articles using the NewsService', () async {
      // when(() => mockNewService.getArticles()).thenAnswer((_) async => []);
      arrangeNewsServiceReturns3Articles();
      await sut.getArticles();
      verify(() => mockNewService.getArticles()).called(1);
    });

    test(
        'inidicates loading of data, sets articles to the ones from the service'
        'indicates that data is not being loaded anymore', () async {
      arrangeNewsServiceReturns3Articles();
      final future = sut.getArticles();
      expect(sut.isLoading, true);
      await future;

      expect(sut.articles, articlesFromService);
      expect(sut.isLoading, false);
    });
  });
}
