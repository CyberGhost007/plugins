// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$FirebaseVision', () {
    final List<MethodCall> log = <MethodCall>[];
    dynamic returnValue;

    setUp(() {
      FirebaseVision.channel
          .setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);

        switch (methodCall.method) {
          case 'TextDetector#detectInImage':
            return returnValue;
          case 'BarcodeDetector#detectInImage':
            return returnValue;
          default:
            return null;
        }
      });
      log.clear();
    });

    group('$BarcodeDetector', () {
      test('detectInImage unknown', () async {
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'hello:raw',
          'display_value': 'hello:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'hello:raw');
        expect(barcode.displayValue, 'hello:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
      });

      test('detectInImage email', () async {
        final Map<dynamic, dynamic> email = <dynamic, dynamic>{
          'address': 'a',
          'body': 'b',
          'subject': 's',
          'type': 0
        };
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'email:raw',
          'display_value': 'email:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
          'email': email
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'email:raw');
        expect(barcode.displayValue, 'email:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
        expect(barcode.email.address, 'a');
        expect(barcode.email.body, 'b');
        expect(barcode.email.subject, 's');
        expect(barcode.email.type, BarcodeEmailType.Unknown);
      });

      test('detectInImage phone', () async {
        final Map<dynamic, dynamic> phone = <dynamic, dynamic>{
          'number': '000',
          'type': 0
        };
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'phone:raw',
          'display_value': 'phone:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
          'phone': phone
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'phone:raw');
        expect(barcode.displayValue, 'phone:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
        expect(barcode.phone.number, '000');
        expect(barcode.phone.type, BarcodePhoneType.Unknown);
      });

      test('detectInImage sms', () async {
        final Map<dynamic, dynamic> sms = <dynamic, dynamic>{
          'phone_number': '000',
          'message': 'm'
        };
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'sms:raw',
          'display_value': 'sms:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
          'sms': sms
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'sms:raw');
        expect(barcode.displayValue, 'sms:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
        expect(barcode.sms.phoneNumber, '000');
        expect(barcode.sms.message, 'm');
      });

      test('detectInImage url', () async {
        final Map<dynamic, dynamic> url = <dynamic, dynamic>{
          'title': 't',
          'url': 'u'
        };
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'url:raw',
          'display_value': 'url:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
          'url': url
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'url:raw');
        expect(barcode.displayValue, 'url:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
        expect(barcode.url.title, 't');
        expect(barcode.url.url, 'u');
      });

      test('detectInImage wifi', () async {
        final Map<dynamic, dynamic> wifi = <dynamic, dynamic>{
          'ssid': 's',
          'password': 'p',
          'encryption_type': 0
        };
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'wifi:raw',
          'display_value': 'wifi:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
          'wifi': wifi
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'wifi:raw');
        expect(barcode.displayValue, 'wifi:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
        expect(barcode.wifi.ssid, 's');
        expect(barcode.wifi.password, 'p');
        expect(barcode.wifi.encryptionType, BarcodeWiFiEncryptionType.Unknown);
      });

      test('detectInImage geo_point', () async {
        final Map<dynamic, dynamic> geo = <dynamic, dynamic>{
          'latitude': 0.2,
          'longitude': 0.3,
        };
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'geo:raw',
          'display_value': 'geo:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
          'geo_point': geo
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'geo:raw');
        expect(barcode.displayValue, 'geo:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
        expect(barcode.geoPoint.latitude, 0.2);
        expect(barcode.geoPoint.longitude, 0.3);
      });

      test('detectInImage contact_info', () async {
        final Map<dynamic, dynamic> contact = <dynamic, dynamic>{
          'addresses': <dynamic>[
            <dynamic, dynamic>{
              'address_lines': <String>['al'],
              'type': 0,
            }
          ],
          'emails': <dynamic>[
            <dynamic, dynamic>{
              'type': 0,
              'address': 'a',
              'body': 'b',
              'subject': 's'
            },
          ],
          'name': <dynamic, dynamic>{
            'formatted_name': 'fn',
            'first': 'f',
            'last': 'l',
            'middle': 'm',
            'prefix': 'p',
            'pronounciation': 'pn',
            'suffix': 's',
          },
          'phones': <dynamic>[
            <dynamic, dynamic>{
              'number': '012',
              'type': 0,
            }
          ],
          'urls': <String>['url'],
          'job_title': 'j',
          'organization': 'o'
        };
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'contact:raw',
          'display_value': 'contact:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
          'contact_info': contact
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'contact:raw');
        expect(barcode.displayValue, 'contact:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
        expect(
            barcode.contactInfo.addresses[0].type, BarcodeAddressType.Unknown);
        expect(barcode.contactInfo.addresses[0].addressLines[0], 'al');
        expect(barcode.contactInfo.emails[0].type, BarcodeEmailType.Unknown);
        expect(barcode.contactInfo.emails[0].address, 'a');
        expect(barcode.contactInfo.emails[0].body, 'b');
        expect(barcode.contactInfo.emails[0].subject, 's');
        expect(barcode.contactInfo.name.first, 'f');
        expect(barcode.contactInfo.name.last, 'l');
        expect(barcode.contactInfo.name.middle, 'm');
        expect(barcode.contactInfo.name.formattedName, 'fn');
        expect(barcode.contactInfo.name.prefix, 'p');
        expect(barcode.contactInfo.name.suffix, 's');
        expect(barcode.contactInfo.name.pronounciation, 'pn');
        expect(barcode.contactInfo.phones[0].type, BarcodePhoneType.Unknown);
        expect(barcode.contactInfo.phones[0].number, '012');
        expect(barcode.contactInfo.urls[0], 'url');
        expect(barcode.contactInfo.jobTitle, 'j');
        expect(barcode.contactInfo.organization, 'o');
      });

      test('detectInImage calendar_event', () async {
        final Map<dynamic, dynamic> calendar = <dynamic, dynamic>{
          'event_description': 'e',
          'location': 'l',
          'organizer': 'o',
          'status': 'st',
          'summary': 'sm',
          'start': '2017-07-04 12:34:56.123',
          'end': '2018-08-05 01:23:45.456',
        };
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'calendar:raw',
          'display_value': 'calendar:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
          'calendar_event': calendar
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'calendar:raw');
        expect(barcode.displayValue, 'calendar:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
        expect(barcode.calendarEvent.eventDescription, 'e');
        expect(barcode.calendarEvent.location, 'l');
        expect(barcode.calendarEvent.organizer, 'o');
        expect(barcode.calendarEvent.status, 'st');
        expect(barcode.calendarEvent.summary, 'sm');
        expect(
            barcode.calendarEvent.start, DateTime(2017, 7, 4, 12, 34, 56, 123));
        expect(barcode.calendarEvent.end, DateTime(2018, 8, 5, 1, 23, 45, 456));
      });

      test('detectInImage driver_license', () async {
        final Map<dynamic, dynamic> driver = <dynamic, dynamic>{
          'first_name': 'fn',
          'middle_name': 'mn',
          'last_name': 'ln',
          'gender': 'g',
          'address_city': 'ac',
          'address_state': 'a',
          'address_street': 'st',
          'address_zip': 'az',
          'birth_date': 'bd',
          'document_type': 'dt',
          'license_number': 'l',
          'expiry_date': 'ed',
          'issuing_date': 'id',
          'issuing_country': 'ic'
        };
        final Map<dynamic, dynamic> _barcode = <dynamic, dynamic>{
          'raw_value': 'driver:raw',
          'display_value': 'driver:display',
          'value_type': 0,
          'format': 0,
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
          'driver_license': driver
        };

        returnValue = <dynamic>[_barcode];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(barcode.rawValue, 'driver:raw');
        expect(barcode.displayValue, 'driver:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
        expect(barcode.driverLicense.firstName, 'fn');
        expect(barcode.driverLicense.middleName, 'mn');
        expect(barcode.driverLicense.lastName, 'ln');
        expect(barcode.driverLicense.gender, 'g');
        expect(barcode.driverLicense.addressCity, 'ac');
        expect(barcode.driverLicense.addressState, 'a');
        expect(barcode.driverLicense.addressStreet, 'st');
        expect(barcode.driverLicense.addressZip, 'az');
        expect(barcode.driverLicense.birthDate, 'bd');
        expect(barcode.driverLicense.documentType, 'dt');
        expect(barcode.driverLicense.licenseNumber, 'l');
        expect(barcode.driverLicense.expiryDate, 'ed');
        expect(barcode.driverLicense.issuingDate, 'id');
        expect(barcode.driverLicense.issuingCountry, 'ic');
      });

      test('detectInImage no blocks', () async {
        returnValue = <dynamic>[];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> blocks = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        expect(blocks, isEmpty);
      });

      test('close', () async {
        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        await detector.close();

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#close',
            arguments: null,
          ),
        ]);
      });

      test('detectInImage no bounding box', () async {
        returnValue = <dynamic>[
          <dynamic, dynamic>{
            'raw_value': 'potato:raw',
            'display_value': 'potato:display',
            'value_type': 0,
            'format': 0,
            'points': <dynamic>[
              <dynamic>[17, 18],
              <dynamic>[19, 20],
            ],
          },
        ];

        final BarcodeDetector detector =
            FirebaseVision.instance.barcodeDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<Barcode> barcodes = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'BarcodeDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final Barcode barcode = barcodes[0];
        expect(barcode.boundingBox, null);
        expect(barcode.rawValue, 'potato:raw');
        expect(barcode.displayValue, 'potato:display');
        expect(barcode.cornerPoints, <Point<num>>[
          const Point<num>(17, 18),
          const Point<num>(19, 20),
        ]);
      });
    });

    group('$FaceDetector', () {});

    group('$LabelDetector', () {});

    group('$TextDetector', () {
      test('detectInImage', () async {
        final Map<dynamic, dynamic> textElement = <dynamic, dynamic>{
          'text': 'hello',
          'left': 1,
          'top': 2,
          'width': 3,
          'height': 4,
          'points': <dynamic>[
            <dynamic>[5, 6],
            <dynamic>[7, 8],
          ],
        };

        final Map<dynamic, dynamic> textLine = <dynamic, dynamic>{
          'text': 'my',
          'left': 5,
          'top': 6,
          'width': 7,
          'height': 8,
          'points': <dynamic>[
            <dynamic>[9, 10],
            <dynamic>[11, 12],
          ],
          'elements': <dynamic>[
            textElement,
          ],
        };

        final List<dynamic> textBlocks = <dynamic>[
          <dynamic, dynamic>{
            'text': 'friend',
            'left': 13,
            'top': 14,
            'width': 15,
            'height': 16,
            'points': <dynamic>[
              <dynamic>[17, 18],
              <dynamic>[19, 20],
            ],
            'lines': <dynamic>[
              textLine,
            ],
          },
        ];

        returnValue = textBlocks;

        final TextDetector detector = FirebaseVision.instance.textDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<TextBlock> blocks = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'TextDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final TextBlock block = blocks[0];
        expect(block.boundingBox, const Rectangle<num>(13, 14, 15, 16));
        expect(block.text, 'friend');
        expect(block.cornerPoints, <Point<num>>[
          const Point<num>(17, 18),
          const Point<num>(19, 20),
        ]);

        final TextLine line = block.lines[0];
        expect(line.boundingBox, const Rectangle<num>(5, 6, 7, 8));
        expect(line.text, 'my');
        expect(line.cornerPoints, <Point<num>>[
          const Point<num>(9, 10),
          const Point<num>(11, 12),
        ]);

        final TextElement element = line.elements[0];
        expect(element.boundingBox, const Rectangle<num>(1, 2, 3, 4));
        expect(element.text, 'hello');
        expect(element.cornerPoints, <Point<num>>[
          const Point<num>(5, 6),
          const Point<num>(7, 8),
        ]);
      });

      test('detectInImage no blocks', () async {
        returnValue = <dynamic>[];

        final TextDetector detector = FirebaseVision.instance.textDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<TextBlock> blocks = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'TextDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        expect(blocks, isEmpty);
      });

      test('close', () async {
        final TextDetector detector = FirebaseVision.instance.textDetector();
        await detector.close();

        expect(log, <Matcher>[
          isMethodCall(
            'TextDetector#close',
            arguments: null,
          ),
        ]);
      });

      test('detectInImage no bounding box', () async {
        returnValue = <dynamic>[
          <dynamic, dynamic>{
            'text': 'potato',
            'points': <dynamic>[
              <dynamic>[17, 18],
              <dynamic>[19, 20],
            ],
            'lines': <dynamic>[],
          },
        ];

        final TextDetector detector = FirebaseVision.instance.textDetector();
        final FirebaseVisionImage image =
            new FirebaseVisionImage.fromFilePath('empty');

        final List<TextBlock> blocks = await detector.detectInImage(image);

        expect(log, <Matcher>[
          isMethodCall(
            'TextDetector#detectInImage',
            arguments: 'empty',
          ),
        ]);

        final TextBlock block = blocks[0];
        expect(block.boundingBox, null);
        expect(block.text, 'potato');
        expect(block.cornerPoints, <Point<num>>[
          const Point<num>(17, 18),
          const Point<num>(19, 20),
        ]);
      });
    });
  });
}
