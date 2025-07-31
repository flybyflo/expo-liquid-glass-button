import ExpoModulesCore

public class ExpoLiquidGlassButtonModule: Module {
  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.
  public func definition() -> ModuleDefinition {
    // Sets the name of the module that JavaScript code will use to refer to the module. Takes a string as an argument.
    // Can be inferred from module's class name, but it's recommended to set it explicitly for clarity.
    // The module will be accessible from `requireNativeModule('ExpoLiquidGlassButton')` in JavaScript.
    Name("ExpoLiquidGlassButton")

    // Sets constant properties on the module. Can take a dictionary or a closure that returns a dictionary.
    Constants([
      "PI": Double.pi
    ])

    // Defines event names that the module can send to JavaScript.
    Events("onChange")

    // Defines a JavaScript synchronous function that runs the native code on the JavaScript thread.
    Function("hello") {
      return "Hello world! 👋"
    }

    // Defines a JavaScript function that always returns a Promise and whose native code
    // is by default dispatched on the different thread than the JavaScript runtime runs on.
    AsyncFunction("setValueAsync") { (value: String) in
      // Send an event to JavaScript.
      self.sendEvent("onChange", [
        "value": value
      ])
    }

    // Enables the module to be used as a native view. Definition components that are accepted as part of the
    // view definition: Prop, Events.
    View(ExpoLiquidGlassButtonView.self) {
      // Defines a setter for the `title` prop.
      Prop("title") { (view: ExpoLiquidGlassButtonView, title: String) in
        view.setTitle(title)
      }

      // Defines a setter for the `isRound` prop.
      Prop("isRound") { (view: ExpoLiquidGlassButtonView, isRound: Bool) in
        view.setIsRound(isRound)
      }

      // Defines a setter for the `textSize` prop.
      Prop("textSize") { (view: ExpoLiquidGlassButtonView, textSize: Double) in
        view.setTextSize(textSize)
      }

      Events("onButtonPress")
    }
  }
}
