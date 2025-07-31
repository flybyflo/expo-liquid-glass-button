package expo.modules.liquidglassbutton

import android.content.Context
import android.graphics.Color
import android.widget.Button
import expo.modules.kotlin.AppContext
import expo.modules.kotlin.viewevent.EventDispatcher
import expo.modules.kotlin.views.ExpoView

class ExpoLiquidGlassButtonView(context: Context, appContext: AppContext) : ExpoView(context, appContext) {
  // Creates and initializes an event dispatcher for the `onPress` event.
  // The name of the event is inferred from the value and needs to match the event name defined in the module.
  private val onButtonPress by EventDispatcher()

  // Defines a Button that will be used as the root subview.
  internal val button = Button(context).apply {
    layoutParams = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)
    text = "Button"
    setBackgroundColor(Color.parseColor("#007AFF"))
    setTextColor(Color.WHITE)
    textSize = 16f
    
    setOnClickListener {
      // Sends an event to JavaScript. Triggers a callback defined on the view component in JavaScript.
      onButtonPress(mapOf("buttonPressed" to true))
    }
  }

  init {
    // Adds the Button to the view hierarchy.
    addView(button)
  }
  
  fun setIsRound(isRound: Boolean) {
    if (isRound) {
      val radius = minOf(width, height) / 2f
      button.radius = radius
    } else {
      button.radius = 0f
    }
  }
  
  fun setTextSize(textSize: Double) {
    button.textSize = textSize.toFloat()
  }
}
