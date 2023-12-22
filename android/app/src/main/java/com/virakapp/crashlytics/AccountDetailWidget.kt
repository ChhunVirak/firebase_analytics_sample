package com.virakapp.crashlytics

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import java.io.File

/**
 * Implementation of App Widget functionality.
 */
class AccountDetailWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAccountDetailWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateAccountDetailWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    val widgetData = HomeWidgetPlugin.getData(context)


    val views = RemoteViews(context.packageName, R.layout.account_detail_widget)
        .apply {
            val imageName = widgetData.getString("qrcode", "")

            val imageFile = File(imageName)
            val imageExists = imageFile.exists()
            if (imageExists) {
                val myBitmap: Bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
                setImageViewBitmap(R.id.imageView, myBitmap)
            } else {
                println("image not found!, looked @: $imageName")
            }
        }


    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}