package expo.modules.liquidglassbutton

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.util.TypedValue
import android.view.Gravity
import android.widget.Button
import android.widget.LinearLayout
import expo.modules.kotlin.AppContext
import expo.modules.kotlin.views.ExpoView

class ExpoLiquidGlassButtonView(context: Context, appContext: AppContext) : ExpoView(context, appContext) {
  private val button: Button = Button(context)
  
  init {
    // Set up the layout
    layoutParams = LinearLayout.LayoutParams(
      LinearLayout.LayoutParams.WRAP_CONTENT,
      LinearLayout.LayoutParams.WRAP_CONTENT
    )
    
    // Configure the button
    button.gravity = Gravity.CENTER
    button.setPadding(dpToPx(24), dpToPx(12), dpToPx(24), dpToPx(12))
    
    // Set default background
    setButtonBackground("#FF7487", false)
    
    // Set click listener
    button.setOnClickListener {
      onButtonPress()
    }
    
    addView(button)
  }
  
  fun setTitle(title: String) {
    button.text = title
  }
  
  fun setBackgroundColor(color: String) {
    setButtonBackground(color, button.background is GradientDrawable && (button.background as GradientDrawable).cornerRadius > 0)
  }
  
  fun setTextColor(color: String) {
    button.setTextColor(Color.parseColor(color))
  }
  
  fun setTextSize(size: Float) {
    button.setTextSize(TypedValue.COMPLEX_UNIT_SP, size)
  }
  
  fun setIcon(icon: String?) {
    // For simplicity, just prepend icon to text if provided
    val currentText = button.text?.toString()?.replace(Regex("^[^A-Za-z0-9\\s]+\\s*"), "") ?: ""
    button.text = if (icon != null) "$icon $currentText" else currentText
  }
  
  fun setIconSize(size: Float) {
    // Icon size handling could be more sophisticated in a real implementation
    setTextSize(size)
  }
  
  fun setIconOnly(iconOnly: Boolean) {
    if (iconOnly) {
      val text = button.text?.toString() ?: ""
      val iconPart = text.split(" ").firstOrNull() ?: ""
      button.text = iconPart
      button.setPadding(dpToPx(16), dpToPx(16), dpToPx(16), dpToPx(16))
    }
  }
  
  fun setIsRound(isRound: Boolean) {
    val color = if (button.background is GradientDrawable) {
      "#FF7487" // default color
    } else {
      "#FF7487"
    }
    setButtonBackground(color, isRound)
  }
  
  private fun setButtonBackground(color: String, isRound: Boolean) {
    val drawable = GradientDrawable()
    drawable.setColor(Color.parseColor(color))
    drawable.cornerRadius = if (isRound) dpToPx(50).toFloat() else dpToPx(12).toFloat()
    
    // Add shadow effect
    drawable.setStroke(0, Color.TRANSPARENT)
    
    button.background = drawable
    button.elevation = dpToPx(3).toFloat()
  }
  
  private fun onButtonPress() {
    // Send event to React Native
    sendEvent("onButtonPress", mapOf("buttonPressed" to true))
  }
  
  private fun dpToPx(dp: Int): Int {
    return TypedValue.applyDimension(
      TypedValue.COMPLEX_UNIT_DIP,
      dp.toFloat(),
      context.resources.displayMetrics
    ).toInt()
  }
}