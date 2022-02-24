import 'package:flutter/material.dart';
import 'package:rudder_sdk_flutter_platform_interface/rudder_plugin_platform_interface.dart';
import 'package:rudder_sdk_flutter/RudderController.dart';

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

  /**
   * only available for web
   */
  void __load() {
    rudderClient.load("writeKey", "dataPlaneUrl");
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
                builder.withDataPlaneUrl("https://rudderstacgwyx.dataplane.rudderstack.com");
                builder.withControlPlaneUrl("https://api.rudderlabs.com");
                builder.withLogLevel(RudderLogger.VERBOSE);
                RudderOption options = RudderOption();
                options.putIntegration("Amplitude", true);
                //builder.withFactory(Appcenter());
                // 1. with RudderConfig Object
                //RudderClient.getInstance("1n0JdVPZTRUIkLXYccrWzZwdGSx",
                //   config: builder.build());
                //2. With RudderConfigBuilder object
                rudderClient.initialize("25YL7MIwWWL3HPeEFT53GI5MxVh",
                    config: builder.build(), options: options);
              },
            ),
            //load for web
            ElevatedButton(
              child: const Text('Load for Web'),
              onPressed: __load,
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