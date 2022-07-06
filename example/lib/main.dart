import 'package:flutter/material.dart';
import 'package:rudder_sdk_flutter/RudderConfig.dart';
import 'package:rudder_sdk_flutter/RudderController.dart';
import 'package:rudder_sdk_flutter/RudderLogger.dart';
import 'package:rudder_sdk_flutter/RudderOption.dart';
import 'package:rudder_sdk_flutter/RudderProperty.dart';
import 'package:rudder_sdk_flutter/RudderTraits.dart';

class PlatformChannel extends StatefulWidget {
  const PlatformChannel({Key? key}) : super(key: key);
  @override
  _PlatformChannelState createState() => _PlatformChannelState();
}

class _PlatformChannelState extends State<PlatformChannel> {
  final RudderController rudderClient = RudderController.instance;
  void __identify() {
    RudderTraits traits = RudderTraits()
        .putName("Sai Venkat")
        .putAge("22")
        .putEmail("saivenkatdesu@gmail.com");
    rudderClient.identify("161FA04009", traits: traits);
  }

  void __track() {
    RudderProperty property = RudderProperty();
    property.put("colour", "red");
    property.put("manufacturer", "hyundai");
    property.put("model", "i20");
    RudderOption options = RudderOption();
    options.putIntegration("All", false);
    options.putIntegration("Mixpanel", false);
    rudderClient.track("Went on a drive",
        properties: property, options: options);
  }

  void __screen() {
    RudderProperty screenProperty = RudderProperty();
    screenProperty.put("browser", "chrome");
    screenProperty.put("device", "mac book pro");
    rudderClient.screen("Walmart Cart", properties: screenProperty);
  }

  void __optOut() {
    rudderClient.optOut(true);
  }

  void __optIn() {
    rudderClient.optOut(false);
  }

  void __group() {
    RudderTraits groupTraits = RudderTraits();
    groupTraits.put("place", "kolkata");
    groupTraits.put("size", "fiteen");
    rudderClient.group("Integrations-Rudder", groupTraits: groupTraits);
  }

  void __reset() {
    rudderClient.reset();
  }

  void __alias() {
    rudderClient.alias("4009");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Initialize SDK'),
              onPressed: () {
                RudderConfigBuilder builder = RudderConfigBuilder();
                builder.withDataPlaneUrl("");
                // builder.withControlPlaneUrl("https://56d9996d386b.ngrok.io");
                builder.withLogLevel(RudderLogger.DEBUG);
                RudderOption options = RudderOption();
                // options.putIntegration("Amplitude", true);
                final String _writeKey = "27Pr2YdYP6ziS6EOeFAcRMcj12A"; //28m4XFm1H3kbUs7kbE9mxzsRsjG, 27Pr2YdYP6ziS6EOeFAcRMcj12A
                Map<String, dynamic> params = {};
                params['writeKey'] = _writeKey;
                params['config'] = builder.build().toMap();
                params['options'] = options.toMap();
                rudderClient.initialize(_writeKey, params: params);
              },
            ),
            ElevatedButton(
              child: const Text('Identify call'),
              onPressed: __identify,
            ),
            ElevatedButton(
              child: const Text('Track'),
              onPressed: __track,
            ),
            ElevatedButton(
              child: const Text('Screen'),
              onPressed: __screen,
            ),
            ElevatedButton(
              child: const Text('Group'),
              onPressed: __group,
            ),
            ElevatedButton(
              child: const Text('Reset'),
              onPressed: __reset,
            ),
            ElevatedButton(
              child: const Text('Alias'),
              onPressed: __alias,
            ),
            ElevatedButton(
              child: const Text('Rudder Context'),
              onPressed: () async {
                Map? context = await rudderClient.getRudderContext();
                print(context);
              },
            ),
            ElevatedButton(
              child: const Text('Set Advertsing ID'),
              onPressed: () {
                rudderClient.putAdvertisingId("899jj-hguscb");
              },
            ),
            ElevatedButton(
              child: const Text('Set Device Token'),
              onPressed: () {
                rudderClient.putDeviceToken("device-token-format");
              },
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: PlatformChannel()));
}
