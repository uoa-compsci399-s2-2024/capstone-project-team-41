package com.uoa.capstone.team41.untitled

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability

/* I'm unsure if my Kotlin code is 100% */

class MainActivity: FlutterActivity() {

    private val PLAY_SERVICES_RESOLUTION_REQUEST = 9000

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        checkGooglePlayServices()
    }

    override fun onResume() {
        super.onResume()
        checkGooglePlayServices()
    }

    private fun checkGooglePlayServices() {
        val apiAvailability = GoogleApiAvailability.getInstance()
        val resultCode = apiAvailability.isGooglePlayServicesAvailable(this)

        if (resultCode != ConnectionResult.SUCCESS) {
            if (apiAvailability.isUserResolvableError(resultCode)) {
                // prompt the user to download Google Play services.
                apiAvailability.getErrorDialog(this, resultCode, PLAY_SERVICES_RESOLUTION_REQUEST)?.show()
            } else {
                // Google Play services is not supported on this device
                // alert the user that the app will not work as intended somehow?
                // hardly any phones are < android 4.4 so shouldn't have to worry
            }
        }
    }
}