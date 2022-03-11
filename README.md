# Alga

A flutter implement of [DevToys[veler]](https://github.com/veler/DevToys).


## Supported Tools

  * Converters
    * JSON<>YAML converter
    * Number Base Converter
  * Encoders/Decoders
    * Base64 Encoder/Decoder
    * URL Encoder/Decoder
    * GZip Encoder/Decoder
    * JWT Decoder
  * Formatters
    * JSON formatter
    * Dart formatter
  * Generators
    * Hash Generator
    * UUID Generator
    * Lorem Ipsum Generator
  * Text
    * Markdown Preview
    * Regex Tester

## APP Plan

* [ ] Rich `JSON` Editor
  * [x] hightlight
  * [ ] code with fold
* [ ] Launguage highlight
  * [x] Dart lang
  * [x] Yaml
  * [x] Markdown
  * [ ] Regex
  * [x] JWT(custom support)
* [ ] static server
  * [x] a working static server
  * [ ] UI update
  * [ ] listDirectories config
  * [ ] port config
  * [ ] accessible on internet config
  * [ ] default path config
* [ ] sass to css generator
  * [x] working sass to css generator
  * [ ] pick syntax config
  * [ ] OutputStyle config
  * [ ] show sourceMap config
* [ ] Web Support

## Getting Started

### before build app

* place your own key and modify this file (`android/key.properties.example`) and rename to `key.properties`

### build app

```shell
flutter_distributor release --name release
```

> will generate apps at `dist/`

## Special Thanks

* [lijy91](https://github.com/lijy91) and his [flutter_distributor](https://github.com/leanflutter/flutter_distributor), [window_manager](https://github.com/leanflutter/window_manager)
