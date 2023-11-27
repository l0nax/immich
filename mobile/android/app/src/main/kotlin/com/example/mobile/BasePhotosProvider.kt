package app.alextran.immich

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.os.Bundle
import android.content.Intent

class BasePhotosProvider : FlutterActivity() {
    private val CHANNEL = "app.alextran.immich/file_provider"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getSharedFiles") {
                val files = getSharedFiles()
                
                if (files != null) {
                    result.success(files)
                } else {
                    result.error("UNAVAILABLE", "Shared files not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getSharedFiles(): List<String>? {
        // Your implementation to get shared files
    }
}
}