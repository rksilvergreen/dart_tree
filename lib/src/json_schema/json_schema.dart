// enum ????

class _ {
  const _();
}

const jsonSchema = const _();

abstract class $Schema {
  final String? title;

  const $Schema({this.title});
}

class $Union extends $Schema {
  final Set<$Schema> types;
  const $Union({required super.title, required this.types});
}

class $Integer extends $Schema {
  final int? minimum;
  final int? exclusiveMinimum;
  final int? maximum;
  final int? exclusiveMaximum;
  final int? multipleOf;

  const $Integer({
    super.title,
    this.minimum,
    this.exclusiveMinimum,
    this.maximum,
    this.exclusiveMaximum,
    this.multipleOf,
  });
}

class $Number extends $Schema {
  final double? minimum;
  final double? exclusiveMinimum;
  final double? maximum;
  final double? exclusiveMaximum;
  final double? multipleOf;

  const $Number({
    super.title,
    this.minimum,
    this.exclusiveMinimum,
    this.maximum,
    this.exclusiveMaximum,
    this.multipleOf,
  });
}

class $String extends $Schema {
  final String? pattern;
  final int? minLength;
  final int? maxLength;
  final String? format;

  const $String({super.title, this.pattern, this.minLength, this.maxLength, this.format});
}

class $Boolean extends $Schema {
  const $Boolean({super.title});
}

class $Array extends $Schema {
  final $Schema? items;
  final int? minItems;
  final int? maxItems;
  final bool? uniqueItems;

  const $Array({super.title, this.items, this.minItems, this.maxItems, this.uniqueItems});
}

class $Object extends $Schema {
  final int? minProperties;
  final int? maxProperties;
  final List<String>? required;
  final Map<String, $Schema>? properties;
  final Map<String, $Schema>? patternProperties;
  final bool? additionalProperties;

  const $Object({
    super.title,
    this.minProperties,
    this.maxProperties,
    this.required,
    this.properties,
    this.patternProperties,
    this.additionalProperties,
  });
}
