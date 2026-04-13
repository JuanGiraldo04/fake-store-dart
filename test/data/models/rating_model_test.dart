import 'package:fake_store/data/models/rating_model.dart';
import 'package:test/test.dart';

void main() {
  group('RatingModel', () {
    test('Given a valid JSON, should return a RatingModel', () {
      final json = {"rate": 3.9, "count": 120};
      expect(RatingModel.fromJson(json), isA<RatingModel>());
    });
  });
}
