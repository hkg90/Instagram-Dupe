// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:counter_app/counter.dart';
import 'package:wasteagram/models/get_location.dart';
import 'dart:async';
import '../lib/models/get_location.dart';

void main() {
  test('Counter value should be incremented', () async {
    var counter = await retrieveLocation();

    counter.increment();

    expect(counter.value, 1);
  });
}
