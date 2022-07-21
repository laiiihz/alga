part of './tool_category.dart';

class ToolCategories {
  ToolCategories._();

  static final converters = ToolCategory(
    icon: const Icon(Icons.transform),
    name: (context) => context.tr.converters,
  );

  static final encodersDecoders = ToolCategory(
    icon: const Icon(Icons.compress),
    name: (context) => context.tr.encodersDecoders,
  );

  static final formatters = ToolCategory(
    icon: const Icon(Icons.format_align_left),
    name: (context) => context.tr.formatters,
  );

  static final generators = ToolCategory(
    icon: const Icon(Icons.generating_tokens),
    name: (context) => context.tr.generators,
  );

  static final textTool = ToolCategory(
    icon: const Icon(Icons.text_format),
    name: (context) => context.tr.textTool,
  );

  static final imageTools = ToolCategory(
    icon: const Icon(Icons.image),
    name: (context) => context.tr.imageTools,
  );

  static final serverTools = ToolCategory(
    icon: const Icon(Icons.open_in_browser),
    name: (context) => context.tr.serverTools,
  );

  static final systemInfos = ToolCategory(
    icon: const Icon(Icons.info),
    name: (context) => context.tr.systemInfos,
  );

  static final jsTools = ToolCategory(
    icon: const Icon(Icons.javascript_rounded),
    name: (context) => context.tr.jsTools,
  );

  static List<ToolCategory> items = [
    converters,
    encodersDecoders,
    formatters,
    generators,
    textTool,
    imageTools,
    serverTools,
    systemInfos,
    jsTools,
  ];
}
