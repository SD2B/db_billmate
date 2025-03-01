import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class QuoteSection extends HookWidget {
  const QuoteSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> businessMotivationalQuotes = [
      "യഥാർത്ഥ സമ്പന്നൻ കൈ നിറയെ പണമുള്ളവനല്ല, മനസ്സ് നിറയെ സമാധാനമുള്ളവനാണ്.",
      "ഉള്ളവനിലേക്ക് നോക്കിയാൽ നിങ്ങൾക്ക് ഒരുപാട്ട് നേടാനാകും ഇല്ലാത്തവനിലേക്ക് നോക്കിയാൽ നിങ്ങൾ ഒരുപാട് നേടിയവനാകും.",
      "നിന്റെ മാനസിക ശക്തിയാണ് വിജയം നേടാനുള്ള ആദ്യത്തെ പടി.",
      "നിന്റെ കയ്യിൽ മാത്രമാണ് നിന്റെ ജീവിതത്തിന്റെ താളം.",
      "വിജയത്തെ സ്വപ്നം കാണാതെ അതിനെ സാക്ഷാത്കരിക്കാൻ കഴിയില്ല.",
      "നിന്റെ സ്വപ്നങ്ങൾ എത്ര വലിയവയാണോ അത്ര കഠിനമായി പ്രവർത്തിക്കാൻ തയ്യാറാകണം.",
      "അർത്ഥ ശൂന്യമായ ആയിരം വാക്കുകളേക്കാൾ മികച്ചതാണ് ആശ്വാസം നൽകുന്ന ഒരു വാക്ക്.",
    ];

    final quoteIndex = useState(0);

    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 4), (timer) {
        quoteIndex.value =
            (quoteIndex.value + 1) % businessMotivationalQuotes.length;
      });
      return timer.cancel;
    }, []);
    return Container(
      padding: EdgeInsets.all(50),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: Text(
                  "\"${businessMotivationalQuotes[quoteIndex.value]}\"",
                  key: ValueKey<String>(
                      businessMotivationalQuotes[quoteIndex.value]),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Tilt(
            tiltConfig: TiltConfig(enableReverse: true),
            shadowConfig: ShadowConfig(enableReverse: true),
            lightConfig: LightConfig(enableReverse: true),
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/image/logo_white.png",
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}
