import 'package:flutter_test/flutter_test.dart';
import 'package:fundamental2/data/api/api_service.dart';
import 'package:fundamental2/widget/config.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('testing restaurant list', ()
  {
    test('mengebalikan restoran jika http call berhasil diselesaikan',
            () async {
          final apiService = ApiService();
          final client = MockClient();
          var response =
              '{"error": false, "message": "success", "count": 20, "restaurants": []}';

          when(
            client.get(Uri.parse(baseUrl + "list")),
          ).thenAnswer((_) async => http.Response(response, 200));

          var restaurantActual = await apiService.getList(client);
          expect(restaurantActual.message, 'success');
        });
    test('mengembalikan exception jika http call tidak berhasil diselesaikan',
            () async {
          final client = MockClient();
          final apiService = ApiService();

          when(client.get(Uri.parse(baseUrl + "list")))
              .thenAnswer((_) async => http.Response('Not Found', 404));

          var actual = apiService.getList(client);
          expect(actual, throwsException);
        });
  });
}