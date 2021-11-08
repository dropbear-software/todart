import 'dart:typed_data';

import 'package:todart_common/src/types/cloud_resource_identity.dart';
import 'package:test/test.dart';

void main() {
  group('Serialization methods', () {
    final identity = CloudResouceIdentity();

    test('.toRawBytes returns a value of the correct type', () {
      expect(identity.toRawBytes(), isNotEmpty);
      expect(identity.toRawBytes(), isA<Uint8List>());
    });

    test('.toString returns a value of the correct type', () {
      expect(identity.toString(), isNotEmpty);
      expect(identity.toString(), isA<String>());
    });

    test('.toReadableString returns a value of the correct type', () {
      expect(identity.toReadableString(), isNotEmpty);
      expect(identity.toReadableString(), isA<String>());
    });
  });

  group('Validation', () {
    final identity = CloudResouceIdentity();

    test('Validates its own toString method correctly', () {
      expect(CloudResouceIdentity.isValid(identity.toString()), isTrue);
    });

    test('Validates its own toReadableString method correctly', () {
      expect(CloudResouceIdentity.isValid(identity.toReadableString()), isTrue);
    });

    test('Validates a known good string correctly', () {
      // Hello World string from https://www.dcode.fr/crockford-base-32-encoding
      const knownGoodValue = '91JPRV3F41BPYWKCCG8';
      expect(CloudResouceIdentity.isValid(knownGoodValue), isTrue);
    });
  });

  group('Constructor options', () {
    test('Rejects a size that is too small', () {
      expect(() => CloudResouceIdentity(sizeInBytes: -1),
          throwsA(isA<RangeError>()));

      expect(() => CloudResouceIdentity(sizeInBytes: 9),
          throwsA(isA<RangeError>()));
    });

    test('Rejects a size that is too big', () {
      expect(() => CloudResouceIdentity(sizeInBytes: 100),
          throwsA(isA<RangeError>()));
    });

    test('Accepts minimum and maximum sizes', () {
      expect(() => CloudResouceIdentity(sizeInBytes: 10), returnsNormally);

      expect(() => CloudResouceIdentity(sizeInBytes: 32), returnsNormally);
    });
  });
}
