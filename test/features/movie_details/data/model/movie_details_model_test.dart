import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/feature/home/data/model/movie_model.dart';
import 'package:movie_app/feature/movie_details/data/model/movie_details_model.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  test('should parse movieDetails json to MovieDetailsModel', () {
    final jsonMap = jsonDecode(fixture("movie_details.json"));
    final result = MovieDetailsModel.fromJson(jsonMap);

    expect(result, isA<MovieDetailsModel>());
  });


}