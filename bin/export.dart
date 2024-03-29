import 'dart:io';

final libDir = Directory('lib');

Future<void> main(List<String> args) async {
  generateExport(
    libDir,
    fileName: 'oop_lsp',
    ext: '',
  );
}

const _templateHeader = """
// This file is automatically generated by tools.
// To update all exports inside project
// run :
// flutter pub run bin/export
""";

bool generateExport(
  Directory directory, {
  String? fileName,
  String ext = '.exports',
  bool recursive = true,
}) {
  print('[GEN] Library: ${directory.path}');
  final items = directory.listSync()..sort((a, b) => (a is Directory) ? 0 : 1);
  final String directoryName = fileName ??
      directory.absolute.path.substring(
        directory.absolute.path.lastIndexOf(Platform.pathSeparator) + 1,
      );

  final File exportFile =
      File('${directory.absolute.path}/$directoryName$ext.dart');

  String exports = '';
  // ignore: prefer_iterable_wheretype
  for (var item in items.where((element) => element is Directory)) {
    if (item is Directory && recursive) {
      final res = generateExport(item);
      if (!res) continue;

      final String subDirName = item.absolute.path.substring(
        item.absolute.path.lastIndexOf(Platform.pathSeparator) + 1,
      );

      exports += "export '$subDirName/$subDirName.exports.dart';\n";
      continue;
    }
  }

  exports += '\n';

  // ignore: prefer_iterable_wheretype
  for (var item in items.where((element) => element is File)) {
    if (item is File &&
        item.path.toLowerCase().endsWith('.dart') &&
        !item.path.toLowerCase().endsWith('.g.dart') &&
        !item.path.toLowerCase().endsWith('generated_plugin_registrant.dart')) {
      if (item.absolute.path == exportFile.absolute.path) continue;

      fixImport(item);
      final path =
          item.absolute.path.substring(directory.absolute.path.length + 1);
      exports += "export '$path';\n";
      continue;
    }
  }

  if (exports.trim().isNotEmpty) {
    final content =
        '${_templateHeader}library ${directoryName.toLowerCase()};\n\n$exports';

    exportFile.writeAsStringSync(content, flush: true);
    return true;
  }

  return false;
}

void fixImport(File file) {
  print('[GEN] Fix Imports: ${file.path}');

  final lines = file.readAsLinesSync();
  String content = "";
  bool hasImport = false;

  for (final line in lines) {
    if (!line.trim().startsWith('//') && line.contains('package:oop_lsp')) {
      hasImport = true;
    } else {
      content += line + '\n';
    }
  }

  if (hasImport) {
    content = "import 'package:oop_lsp/oop_lsp.dart';\n$content";
  }

  file.writeAsStringSync(content, flush: true);
}
