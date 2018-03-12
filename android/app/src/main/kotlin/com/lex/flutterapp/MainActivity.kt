package com.lex.flutterapp

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.Intent

class MainActivity() : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


        io.flutter.plugin.common.MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "shareBeer") {
                val intent = Intent()
                intent.action = Intent.ACTION_SEND
                intent.putExtra(Intent.EXTRA_TEXT, "Try this new amazing beer: " + call.arguments)
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
        val CHANNEL = "beer.flutter/share"
    }
}
