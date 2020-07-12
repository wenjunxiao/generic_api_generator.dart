import 'dart:async';
import 'package:generic_api_generator/generic_api_generator.dart';
import 'package:source_gen_test/src/build_log_tracking.dart';
import 'package:source_gen_test/src/init_library_reader.dart';
import 'package:source_gen_test/src/test_annotated_classes.dart';

import 'package:retrofit/http.dart' as http;

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
      'test/generator/src', 'generator_test_src.dart');
  initializeBuildLogTracking();
  testAnnotatedElements<http.RestApi>(
      reader, GenericApiGenerator(autoCastResponse: true));
}
