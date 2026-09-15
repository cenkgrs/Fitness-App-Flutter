package com.silveroaktech.thrive

import io.flutter.embedding.android.FlutterFragmentActivity

// FlutterFragmentActivity (not FlutterActivity) is required by the `health`
// plugin's Health Connect permission flow on Android 14+, which needs
// registerForActivityResult — that requires casting Activity to
// ComponentActivity, only available via the Fragment-based embedding.
class MainActivity : FlutterFragmentActivity()
