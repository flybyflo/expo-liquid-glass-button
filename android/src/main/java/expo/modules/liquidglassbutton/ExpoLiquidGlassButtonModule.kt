package expo.modules.liquidglassbutton

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

class ExpoLiquidGlassButtonModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("ExpoLiquidGlassButton")

    Constants {
      "PI" to kotlin.math.PI
    }

    Function("hello") {
      "Hello world! 👋"
    }

    AsyncFunction("setValueAsync") { value: String ->
      println(value)
    }

    View(ExpoLiquidGlassButtonView::class) {
      Prop("title") { view: ExpoLiquidGlassButtonView, title: String ->
        view.setTitle(title)
      }

      Prop("backgroundColor") { view: ExpoLiquidGlassButtonView, color: String ->
        view.setBackgroundColor(color)
      }

      Prop("textColor") { view: ExpoLiquidGlassButtonView, color: String ->
        view.setTextColor(color)
      }

      Prop("textSize") { view: ExpoLiquidGlassButtonView, size: Float ->
        view.setTextSize(size)
      }

      Prop("icon") { view: ExpoLiquidGlassButtonView, icon: String? ->
        view.setIcon(icon)
      }

      Prop("iconSize") { view: ExpoLiquidGlassButtonView, size: Float ->
        view.setIconSize(size)
      }

      Prop("iconOnly") { view: ExpoLiquidGlassButtonView, iconOnly: Boolean ->
        view.setIconOnly(iconOnly)
      }

      Prop("isRound") { view: ExpoLiquidGlassButtonView, isRound: Boolean ->
        view.setIsRound(isRound)
      }

      Events("onButtonPress")
    }
  }
}