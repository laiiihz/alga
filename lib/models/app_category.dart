// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/models/app_atom.dart';

class AppCategory {
  AppCategory({
    required this.name,
    required this.icon,
    required this.uuid,
  });
  final String Function(BuildContext context) name;

  final Widget icon;

  final String uuid;

  static final items = <AppCategory>[
    generator,
    photo,
    converter,
    text,
    design,
    encodersDecoders,
    formatter,
    frontEnd,
    infomation,
    server,
  ];

  static final allApps = AppCategory(
    name: (context) => context.tr.allApps,
    icon: const Icon(Icons.category_rounded),
    uuid: '02E2EC8E-7DBF-430B-980F-961196093854',
  );
  static final generator = AppCategory(
    name: (context) => context.tr.generatorApp,
    icon: const Icon(Icons.generating_tokens_rounded),
    uuid: 'D3234DE2-E4A3-4F65-B43F-9C0FAC046700',
  );
  static final photo = AppCategory(
    name: (context) => context.tr.photoApp,
    icon: const Icon(Icons.photo),
    uuid: 'E0C8566D-E909-4FC2-BAF3-14802246703A',
  );

  static final text = AppCategory(
    name: (context) => context.tr.textApp,
    icon: const Icon(Icons.text_format),
    uuid: 'E7ABE3D5-3C39-480A-AF54-C66C60AAE698',
  );

  static final converter = AppCategory(
    name: (context) => context.tr.converterApp,
    icon: const Icon(Icons.transform),
    uuid: 'FA96D3D2-6DF2-459E-9921-738B11C2440A',
  );

  static final design = AppCategory(
    name: (context) => context.tr.designApp,
    icon: const Icon(Icons.design_services),
    uuid: 'E1439FAC-A777-4A6F-A151-E08CA2095A37',
  );

  static final encodersDecoders = AppCategory(
    name: (context) => context.tr.encoderDecoderApp,
    icon: const Icon(Icons.compress),
    uuid: '5E55D9F0-43AC-4A0C-9E20-C29AA36C4154',
  );

  static final formatter = AppCategory(
    name: (context) => context.tr.formatterApp,
    icon: const Icon(Icons.compress),
    uuid: '18D220BF-CDE3-4772-99F9-542A8AEAC678',
  );

  static final frontEnd = AppCategory(
    name: (context) => context.tr.frontEndApp,
    icon: const Icon(Icons.front_hand),
    uuid: 'F0D73CED-9558-4AA8-9ADF-2D270C1E9024',
  );

  static final infomation = AppCategory(
    name: (context) => context.tr.infomationApp,
    icon: const Icon(Icons.info_outline),
    uuid: 'B1FDB707-D150-41E7-BE74-9B13C0882F76',
  );

  static final server = AppCategory(
    name: (context) => context.tr.serverApp,
    icon: const Icon(Icons.open_in_browser),
    uuid: 'DC50E43C-B312-432E-96A3-AD3878FC1C1C',
  );
}

final categoryMapping = <String, List<AppAtom>>{
  AppCategory.allApps.uuid: AppAtom.items.toList(),
  AppCategory.generator.uuid: AppAtom.generators,
  AppCategory.converter.uuid: AppAtom.converters,
  AppCategory.photo.uuid: AppAtom.photoApps,
  AppCategory.text.uuid: AppAtom.textApps,
  AppCategory.design.uuid: AppAtom.designApps,
  AppCategory.encodersDecoders.uuid: AppAtom.encoderDecoderApps,
  AppCategory.formatter.uuid: AppAtom.formatterApps,
  AppCategory.frontEnd.uuid: AppAtom.frontEndApps,
  AppCategory.infomation.uuid: AppAtom.infomationApps,
  AppCategory.server.uuid: AppAtom.serverApps,
};
