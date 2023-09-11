import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/feature/home/data/model/movie_model.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  test('should parse movie json to MovieModel', () {
    final jsonMap = jsonDecode(fixture("movie.json"));
    final result = MovieModel.fromJson(jsonMap);

    expect(result, isA<MovieModel>());
  });


}
