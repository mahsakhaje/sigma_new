package ir.sigmatec.sigma

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.pm.PackageManager

class MainActivity: FlutterActivity() {
    private val APP_INSTALLER_CHANNEL = "app_installer_channel"
    private val BUILD_CONFIG_CHANNEL = "build_config_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Channel برای تشخیص installer package
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, APP_INSTALLER_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getInstallerPackageName" -> {
                        val packageName = call.argument<String>("packageName")
                        if (packageName != null) {
                            val installerPackage = getInstallerPackageName(packageName)
                            result.success(installerPackage)
                        } else {
                            result.error("INVALID_ARGUMENT", "Package name is null", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }

        // Channel برای دسترسی به BuildConfig
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BUILD_CONFIG_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getStoreType" -> {
                        result.success(BuildConfig.STORE_TYPE)
                    }
                    "getStoreName" -> {
                        result.success(BuildConfig.STORE_NAME)
                    }
                    "getStorePackage" -> {
                        result.success(BuildConfig.STORE_PACKAGE)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun getInstallerPackageName(packageName: String): String? {
        return try {
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.R) {
                packageManager.getInstallSourceInfo(packageName).installingPackageName
            } else {
                @Suppress("DEPRECATION")
                packageManager.getInstallerPackageName(packageName)
            }
        } catch (e: Exception) {
            null
        }
    }
}