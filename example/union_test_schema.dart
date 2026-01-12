import 'package:dart_tree/dart_tree.dart';

// Define a union type for values that can be either string or integer
@schema
const stringOrInt = $Union(title: 'StringOrInt', types: {$String(), $Integer()});

// Define a union type for values that can be string, int, or boolean
@schema
const mixedValue = $Union(title: 'MixedValue', types: {$String(), $Integer(), $Boolean()});

// Define an object that uses union types
@schema
const config = $Object(
  title: 'Config',
  properties: {
    'name': $String(),
    'port': stringOrInt, // Reference to union type
    'value': mixedValue, // Reference to another union type
  },
  required: ['name', 'port'],
);
