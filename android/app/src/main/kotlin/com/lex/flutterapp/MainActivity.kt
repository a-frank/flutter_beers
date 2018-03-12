package com.lex.flutterapp

import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity() : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "shareBeer") {
                val intent = Intent()
                intent.action = Intent.ACTION_SEND
                @Suppress("UNCHECKED_CAST")
                val args = call.arguments as Map<String, String>
                intent.putExtra(Intent.EXTRA_TEXT, "Try this new amazing beer " + args["name"] + ": " + args["tagLine"])
                intent.type = "text/plain"
                startActivity(intent)
                result.success("OK")
            } else {
                result.notImplemented()
            }

        }

        GeneratedPluginRegistrant.registerWith(this)
    }

    companion object {
        const val CHANNEL = "beer.flutter/share"
    }
}
