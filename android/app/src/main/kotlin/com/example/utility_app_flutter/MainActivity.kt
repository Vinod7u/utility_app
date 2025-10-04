package com.example.utility_app_flutter

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "aeps_scanner_channel"
    private val REQUEST_CODE_CAPTURE = 999
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "captureFingerprint" -> {
                        pendingResult = result
                        startBiometricCapture()
                    }
                    "checkScanner" -> {
                        result.success(isScannerAvailable())
                    }
                    "cancelScan" -> {
                        cancelScan()
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun startBiometricCapture() {
        try {
            val intent = Intent("com.mantra.rdservice.CAPTURE")
            intent.putExtra("PID_OPTIONS", getPidOptions())
            startActivityForResult(intent, REQUEST_CODE_CAPTURE)
        } catch (e: Exception) {
            pendingResult?.let {
                it.error("SCANNER_ERROR", "Scanner app not found: ${e.message}", null)
                pendingResult = null
            }
        }
    }

    private fun isScannerAvailable(): Boolean {
        return try {
            val intent = Intent("com.mantra.rdservice.CAPTURE")
            val activities = packageManager.queryIntentActivities(intent, 0)
            activities.isNotEmpty()
        } catch (e: Exception) {
            false
        }
    }

    private fun cancelScan() {
        // Implement if your scanner supports cancellation
        pendingResult?.let {
            it.error("CANCELLED", "Scan cancelled", null)
            pendingResult = null
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        if (requestCode == REQUEST_CODE_CAPTURE) {
            pendingResult?.let { result ->
                try {
                    when (resultCode) {
                        RESULT_OK -> {
                            val pidData = data?.getStringExtra("PID_DATA") ?: ""
                            if (pidData.isNotEmpty()) {
                                result.success(mapOf(
                                    "success" to true,
                                    "data" to pidData,
                                    "message" to "Capture successful"
                                ))
                            } else {
                                result.error("NO_DATA", "No biometric data received", null)
                            }
                        }
                        RESULT_CANCELED -> {
                            result.error("CANCELLED", "Capture cancelled by user", null)
                        }
                        else -> {
                            result.error("FAILED", "Capture failed with code: $resultCode", null)
                        }
                    }
                } catch (e: Exception) {
                    result.error("ERROR", "Processing error: ${e.message}", null)
                } finally {
                    pendingResult = null
                }
            }
        }
    }

    private fun getPidOptions(): String {
        return """<?xml version="1.0"?>
            <PidOptions ver="1.0">
                <Opts fCount="1" fType="0" iCount="0" pCount="0" format="0" 
                      pidVer="2.0" timeout="10000" posh="UNKNOWN" env="P" />
            </PidOptions>"""
    }
}