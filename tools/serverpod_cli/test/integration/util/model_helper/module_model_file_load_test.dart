import 'dart:io';

import 'package:path/path.dart';
import 'package:serverpod_cli/src/config/config.dart';
import 'package:serverpod_cli/src/util/model_helper.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../../../test_util/builders/generator_config_builder.dart';
import '../../../test_util/builders/module_config_builder.dart';

void main() {
  late Directory testDirectory;
  late List<String> testProjectPathParts;
  setUpAll(() {
    testDirectory = Directory(join(Directory.current.path, const Uuid().v4()));
    testDirectory.createSync(recursive: true);
    var testProject = Directory(join(testDirectory.path, const Uuid().v4()));
    testProject.createSync(recursive: true);
    testProjectPathParts = split(testProject.path);
  });

  tearDownAll(() {
    testDirectory.deleteSync(recursive: true);
  });

  group('Given a valid model class with *.yaml file ending', () {
    var modelFileName = 'example.yaml';

    late Directory moduleProject;
    late GeneratorConfig config;
    setUp(() {
      moduleProject = Directory(join(testDirectory.path, const Uuid().v4()));
      moduleProject.createSync(recursive: true);
      config = GeneratorConfigBuilder()
          .withServerPackageDirectoryPathParts(testProjectPathParts)
          .withModules([
        ModuleConfigBuilder('test_module')
            .withServerPackageDirectoryPathParts(split(moduleProject.path))
            .build()
      ]).build();
    });

    tearDown(() {
      moduleProject.deleteSync(recursive: true);
    });

    group('placed in the module "lib/src/models" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in the module "lib/src/protocol" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'protocol',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group(
        'placed in a subdirectory of the module "lib/src/models" directory when loaded',
        () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          'sub',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String

''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, ['sub']);
      });
    });

    group('placed in the module "lib/src" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is not serialized.', () async {
        expect(models, hasLength(0));
      });
    });
  });

  group('Given a valid model class with *.yml file ending', () {
    var modelFileName = 'example.yml';

    late Directory moduleProject;
    late GeneratorConfig config;
    setUp(() {
      moduleProject = Directory(join(testDirectory.path, const Uuid().v4()));
      moduleProject.createSync(recursive: true);
      config = GeneratorConfigBuilder()
          .withServerPackageDirectoryPathParts(testProjectPathParts)
          .withModules([
        ModuleConfigBuilder('test_module')
            .withServerPackageDirectoryPathParts(split(moduleProject.path))
            .build()
      ]).build();
    });

    tearDown(() {
      moduleProject.deleteSync(recursive: true);
    });

    group('placed in the module "lib/src/models" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in the module "lib/src/protocol" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'protocol',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group(
        'placed in a subdirectory of the module "lib/src/models" directory when loaded',
        () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          'sub',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String

''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, ['sub']);
      });
    });

    group(
        'placed in a subdirectory of the module "lib/src/protocol" directory when loaded',
        () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'protocol',
          'sub',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String

''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, ['sub']);
      });
    });

    group('placed in the module "lib/src" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is not serialized.', () async {
        expect(models, hasLength(0));
      });
    });
  });

  group('Given a valid model class with *.spy file ending', () {
    var modelFileName = 'example.spy';

    late Directory moduleProject;
    late GeneratorConfig config;
    setUp(() {
      moduleProject = Directory(join(testDirectory.path, const Uuid().v4()));
      moduleProject.createSync(recursive: true);
      config = GeneratorConfigBuilder()
          .withServerPackageDirectoryPathParts(testProjectPathParts)
          .withModules([
        ModuleConfigBuilder('test_module')
            .withServerPackageDirectoryPathParts(split(moduleProject.path))
            .build()
      ]).build();
    });

    tearDown(() {
      moduleProject.deleteSync(recursive: true);
    });

    group('placed in the module "lib/src/models" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in the module "lib/src/protocol" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'protocol',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group(
        'placed in a subdirectory of the module "lib/src/models" directory when loaded',
        () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          'sub',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String

''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, ['sub']);
      });
    });

    group(
        'placed in a subdirectory of the module "lib/src/protocol" directory when loaded',
        () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'protocol',
          'sub',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String

''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, ['sub']);
      });
    });

    group('placed in the "lib" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in a feature directory inside of "lib" when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'my_feature',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, ['my_feature']);
      });
    });

    group('placed in the "lib/src" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in a feature directory inside of "lib/src" when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'my_feature',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, ['my_feature']);
      });
    });
  });

  group('Given a valid model class with *.spy.yaml file ending', () {
    var modelFileName = 'example.spy.yaml';

    late Directory moduleProject;
    late GeneratorConfig config;
    setUp(() {
      moduleProject = Directory(join(testDirectory.path, const Uuid().v4()));
      moduleProject.createSync(recursive: true);
      config = GeneratorConfigBuilder()
          .withServerPackageDirectoryPathParts(testProjectPathParts)
          .withModules([
        ModuleConfigBuilder('test_module')
            .withServerPackageDirectoryPathParts(split(moduleProject.path))
            .build()
      ]).build();
    });

    tearDown(() {
      moduleProject.deleteSync(recursive: true);
    });

    group('placed in the module "lib/src/models" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in the module "lib/src/protocol" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'protocol',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group(
        'placed in a subdirectory of the module "lib/src/models" directory when loaded',
        () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          'sub',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String

''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, ['sub']);
      });
    });

    group(
        'placed in a subdirectory of the module "lib/src/protocol" directory when loaded',
        () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'protocol',
          'sub',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String

''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, ['sub']);
      });
    });

    group('placed in the "lib" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in a feature directory inside of "lib" when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'my_feature',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, ['my_feature']);
      });
    });

    group('placed in the "lib/src" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in a feature directory inside of "lib/src" when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'my_feature',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, ['my_feature']);
      });
    });
  });

  group('Given a valid model class with *.spy.yml file ending', () {
    var modelFileName = 'example.spy.yml';

    late Directory moduleProject;
    late GeneratorConfig config;
    setUp(() {
      moduleProject = Directory(join(testDirectory.path, const Uuid().v4()));
      moduleProject.createSync(recursive: true);
      config = GeneratorConfigBuilder()
          .withServerPackageDirectoryPathParts(testProjectPathParts)
          .withModules([
        ModuleConfigBuilder('test_module')
            .withServerPackageDirectoryPathParts(split(moduleProject.path))
            .build()
      ]).build();
    });

    tearDown(() {
      moduleProject.deleteSync(recursive: true);
    });

    group('placed in the module "lib/src/models" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in the module "lib/src/protocol" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'protocol',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has no subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group(
        'placed in a subdirectory of the module "lib/src/models" directory when loaded',
        () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'models',
          'sub',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String

''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, ['sub']);
      });
    });

    group(
        'placed in a subdirectory of the module "lib/src/protocol" directory when loaded',
        () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'protocol',
          'sub',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String

''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts.', () async {
        expect(models.firstOrNull?.subDirPathParts, ['sub']);
      });
    });

    group('placed in the "lib" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in a feature directory inside of "lib" when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'my_feature',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, ['my_feature']);
      });
    });

    group('placed in the "lib/src" directory when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, isEmpty);
      });
    });

    group('placed in a feature directory inside of "lib/src" when loaded', () {
      late List<ModelSource> models;

      setUp(() async {
        var modelFile = File(join(
          moduleProject.path,
          'lib',
          'src',
          'my_feature',
          modelFileName,
        ));
        modelFile.createSync(recursive: true);
        modelFile.writeAsStringSync('''
class: Example
fields:
  name: String
''');
        models = await ModelHelper.loadProjectYamlModelsFromDisk(config);
      });

      test('then the class is serialized.', () async {
        expect(models, hasLength(1));
      });

      test('then modelSource has the correct subDirPathParts', () async {
        expect(models.firstOrNull?.subDirPathParts, ['my_feature']);
      });
    });
  });
}
