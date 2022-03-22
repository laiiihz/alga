# Alga

A powerful tool app for all developers.

> inspired by [DevToys](https://github.com/veler/DevToys).

[简体中文](./documents/README_ZH.md)

## Supported Tools

  * Converters
    * JSON<>YAML converter
    * Number Base Converter
  * Encoders/Decoders
    * Base64 Encoder/Decoder
    * URL Encoder/Decoder
    * GZip Encoder/Decoder
    * JWT Decoder
    * Uri Parser
  * Formatters
    * JSON formatter
    * Dart formatter
  * Generators
    * Hash Generator
    * UUID Generator
    * Lorem Ipsum Generator
    * Sass to Css Generator
  * Text
    * Markdown Preview
    * Regex Tester
  * Image Tools
    * Blurhash Tool
    * QR Code Tool
  * Server Tools
    * Static Server Tool

## APP Plan

* [ ] Rich `JSON` Editor
  * [ ] code with fold
* [ ] Launguage highlight
  * [ ] Regex
  * [ ] Uri
* [ ] sass to css generator
  * [ ] pick syntax config
  * [ ] show sourceMap config
* [ ] Web Support
* [ ] disable copy button when content is empty

## Getting Started

### before build app

#### Android

* place your own key and modify this file (`android/key.properties.example`) and rename to `key.properties`

### build app

```shell
flutter_distributor release --name release
```

> will generate apps at `dist/`

## Special Thanks

* [lijy91](https://github.com/lijy91) and his [flutter_distributor](https://github.com/leanflutter/flutter_distributor), [window_manager](https://github.com/leanflutter/window_manager)

## Privacy Policy

* [Usage Data] Your usage data only storage on your device.
* [Personal Data] We will not collecting or using Your Personal Data.
