import ExpoModulesCore
import UIKit

class ExpoLiquidGlassButtonView: ExpoView {
  let onButtonPress = EventDispatcher()
  
  private var buttonImplementation: ButtonImplementation!
  private var isRound: Bool = false
  private var textSize: CGFloat = 16.0
  private var icon: String?
  private var iconOnly: Bool = false
  private var iconSize: CGFloat = 16.0
  private var buttonBackgroundColor: UIColor = UIColor(red: 1.0, green: 0.455, blue: 0.529, alpha: 1.0)
  private var buttonTextColor: UIColor = UIColor.white
  private var buttonIconColor: UIColor = UIColor.white
  private var hasCustomBackgroundColor: Bool = false
  private var hasCustomTextColor: Bool = false
  
  required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)
    clipsToBounds = true
    backgroundColor = UIColor.clear
    setupButtonImplementation()
  }
  
  private func setupButtonImplementation() {
    if #available(iOS 26.0, *) {
      buttonImplementation = LiquidGlassButton(parent: self)
    } else {
      buttonImplementation = FallbackButton(parent: self)
    }
    buttonImplementation.setup()
    
    // Apply current color values after setup
    buttonImplementation.setBackgroundColor(buttonBackgroundColor, isCustom: hasCustomBackgroundColor)
    buttonImplementation.setTextColor(buttonTextColor, isCustom: hasCustomTextColor)
    buttonImplementation.setIconColor(buttonIconColor)
  }
  
  @objc internal func buttonTapped() {
    onButtonPress(["buttonPressed": true])
  }
  
  func setTitle(_ title: String) {
    buttonImplementation.setTitle(title)
  }
  
  func setIsRound(_ isRound: Bool) {
    self.isRound = isRound
    buttonImplementation.setIsRound(isRound)
  }
  
  func setTextSize(_ textSize: Double) {
    self.textSize = CGFloat(textSize)
    buttonImplementation.setTextSize(self.textSize)
  }
  
  func setIcon(_ icon: String) {
    self.icon = icon
    buttonImplementation.setIcon(icon)
    
    // If no title is set, show icon only
    if buttonImplementation.getTitle()?.isEmpty ?? true {
      buttonImplementation.setIconOnly(true)
    }
  }
  
  func setIconOnly(_ iconOnly: Bool) {
    self.iconOnly = iconOnly
    buttonImplementation.setIconOnly(iconOnly)
  }
  
  func setIconSize(_ iconSize: Double) {
    self.iconSize = CGFloat(iconSize)
    buttonImplementation.setIconSize(self.iconSize)
  }
  
  func setBackgroundColor(_ colorString: String) {
    self.buttonBackgroundColor = UIColor(hexString: colorString) ?? UIColor(red: 1.0, green: 0.455, blue: 0.529, alpha: 1.0)
    self.hasCustomBackgroundColor = true
    buttonImplementation.setBackgroundColor(self.buttonBackgroundColor, isCustom: self.hasCustomBackgroundColor)
  }
  
  func setTextColor(_ colorString: String) {
    self.buttonTextColor = UIColor(hexString: colorString) ?? UIColor.white
    self.hasCustomTextColor = true
    buttonImplementation.setTextColor(self.buttonTextColor, isCustom: self.hasCustomTextColor)
  }
  
  func setIconColor(_ colorString: String) {
    self.buttonIconColor = UIColor(hexString: colorString) ?? UIColor.white
    buttonImplementation.setIconColor(self.buttonIconColor)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    buttonImplementation.layoutSubviews(bounds: bounds)
  }
}

protocol ButtonImplementation {
  func setup()
  func setTitle(_ title: String)
  func getTitle() -> String?
  func setIsRound(_ isRound: Bool)
  func setTextSize(_ textSize: CGFloat)
  func setIcon(_ icon: String)
  func setIconOnly(_ iconOnly: Bool)
  func setIconSize(_ iconSize: CGFloat)
  func setBackgroundColor(_ color: UIColor, isCustom: Bool)
  func setTextColor(_ color: UIColor, isCustom: Bool)
  func setIconColor(_ color: UIColor)
  func layoutSubviews(bounds: CGRect)
}

@available(iOS 26.0, *)
class LiquidGlassButton: ButtonImplementation {
  private weak var parent: ExpoLiquidGlassButtonView?
  private var isRound: Bool = false
  private var textSize: CGFloat = 16.0
  private var icon: String?
  private var iconSize: CGFloat = 16.0
  private var buttonBackgroundColor: UIColor = UIColor(red: 1.0, green: 0.455, blue: 0.529, alpha: 1.0)
  private var buttonTextColor: UIColor = UIColor.white
  private var buttonIconColor: UIColor = UIColor.white
  private var hasCustomColors: Bool = false
  
  private var glassButton: UIButton!
  
  private func createGlassButton() -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    var config: UIButton.Configuration
    if hasCustomColors {
      config = UIButton.Configuration.prominentGlass()
      config.baseBackgroundColor = buttonBackgroundColor
      config.baseForegroundColor = buttonTextColor
    } else {
      config = UIButton.Configuration.glass()
    }
    config.title = ""
    config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [weak self] incoming in
      var outgoing = incoming
      outgoing.font = UIFont.systemFont(ofSize: self?.textSize ?? 16, weight: .medium)
      return outgoing
    }
    
    button.configuration = config
    return button
  }
  
  init(parent: ExpoLiquidGlassButtonView) {
    self.parent = parent
  }
  
  func setup() {
    guard let parent = parent else { return }
    
    glassButton = createGlassButton()
    parent.addSubview(glassButton)
    
    NSLayoutConstraint.activate([
      glassButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 16),
      glassButton.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -16),
      glassButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 16),
      glassButton.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -16)
    ])
    
    glassButton.addTarget(parent, action: #selector(parent.buttonTapped), for: .touchUpInside)
  }
  
  func setTitle(_ title: String) {
    glassButton.configuration?.title = title
  }
  
  func getTitle() -> String? {
    return glassButton.configuration?.title
  }
  
  func setIsRound(_ isRound: Bool) {
    self.isRound = isRound
    if isRound {
      glassButton.layer.cornerRadius = min(glassButton.bounds.width, glassButton.bounds.height) / 2
      glassButton.clipsToBounds = true
    } else {
      glassButton.layer.cornerRadius = 0
      glassButton.clipsToBounds = false
    }
  }
  
  func setTextSize(_ textSize: CGFloat) {
    self.textSize = textSize
    var config = glassButton.configuration
    config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [weak self] incoming in
      var outgoing = incoming
      outgoing.font = UIFont.systemFont(ofSize: self?.textSize ?? 16, weight: .medium)
      return outgoing
    }
    glassButton.configuration = config
  }
  
  func setIcon(_ icon: String) {
    self.icon = icon
    var config = glassButton.configuration
    config?.image = UIImage(systemName: icon)
    config?.imagePlacement = .leading
    config?.imagePadding = 4
    config?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: iconSize)
    glassButton.configuration = config
  }
  
  func setIconOnly(_ iconOnly: Bool) {
    var config = glassButton.configuration
    if iconOnly {
      config?.title = ""
      config?.imagePlacement = .top
      config?.imagePadding = 0
    } else {
      config?.imagePlacement = .leading
      config?.imagePadding = 4
    }
    glassButton.configuration = config
  }
  
  func setIconSize(_ iconSize: CGFloat) {
    self.iconSize = iconSize
    var config = glassButton.configuration
    config?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: iconSize)
    glassButton.configuration = config
  }
  
  func setBackgroundColor(_ color: UIColor, isCustom: Bool) {
    self.buttonBackgroundColor = color
    self.hasCustomColors = isCustom
    
    // Recreate button with appropriate configuration
    if let parent = parent {
      glassButton.removeFromSuperview()
      glassButton = createGlassButton()
      parent.addSubview(glassButton)
      
      NSLayoutConstraint.activate([
        glassButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 16),
        glassButton.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -16),
        glassButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 16),
        glassButton.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -16)
      ])
      
      glassButton.addTarget(parent, action: #selector(parent.buttonTapped), for: .touchUpInside)
    }
  }
  
  func setTextColor(_ color: UIColor, isCustom: Bool) {
    self.buttonTextColor = color
    self.hasCustomColors = isCustom
    
    var config = glassButton.configuration
    if hasCustomColors {
      config?.baseForegroundColor = color
    }
    glassButton.configuration = config
  }
  
  func setIconColor(_ color: UIColor) {
    self.buttonIconColor = color
    var config = glassButton.configuration
    config?.baseForegroundColor = color
    glassButton.configuration = config
  }
  
  func layoutSubviews(bounds: CGRect) {
    if isRound {
      glassButton.layer.cornerRadius = min(glassButton.bounds.width, glassButton.bounds.height) / 2
    }
  }
}

class FallbackButton: ButtonImplementation {
  private weak var parent: ExpoLiquidGlassButtonView?
  private var isRound: Bool = false
  private var textSize: CGFloat = 16.0
  private var icon: String?
  private var iconSize: CGFloat = 16.0
  private var buttonBackgroundColor: UIColor = UIColor.systemBlue
  private var buttonTextColor: UIColor = UIColor.white
  private var buttonIconColor: UIColor = UIColor.white
  
  private var button: UIButton!
  
  private func createButton() -> UIButton {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    
    var config = UIButton.Configuration.filled()
    config.title = ""
    config.baseBackgroundColor = buttonBackgroundColor
    config.baseForegroundColor = buttonTextColor
    config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [weak self] incoming in
      var outgoing = incoming
      outgoing.font = UIFont.systemFont(ofSize: self?.textSize ?? 16, weight: .medium)
      return outgoing
    }
    config.cornerStyle = .capsule
    
    btn.configuration = config
    return btn
  }
  
  init(parent: ExpoLiquidGlassButtonView) {
    self.parent = parent
  }
  
  func setup() {
    guard let parent = parent else { return }
    
    button = createButton()
    parent.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: parent.topAnchor, constant: 16),
      button.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -16),
      button.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 16),
      button.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -16)
    ])
    
    button.addTarget(parent, action: #selector(parent.buttonTapped), for: .touchUpInside)
  }
  
  func setTitle(_ title: String) {
    button.configuration?.title = title
  }
  
  func getTitle() -> String? {
    return button.configuration?.title
  }
  
  func setIsRound(_ isRound: Bool) {
    self.isRound = isRound
    if isRound {
      button.layer.cornerRadius = min(button.bounds.width, button.bounds.height) / 2
      button.clipsToBounds = true
    } else {
      button.layer.cornerRadius = 0
      button.clipsToBounds = false
    }
  }
  
  func setTextSize(_ textSize: CGFloat) {
    self.textSize = textSize
    var config = button.configuration
    config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [weak self] incoming in
      var outgoing = incoming
      outgoing.font = UIFont.systemFont(ofSize: self?.textSize ?? 16, weight: .medium)
      return outgoing
    }
    button.configuration = config
  }
  
  func setIcon(_ icon: String) {
    self.icon = icon
    var config = button.configuration
    config?.image = UIImage(systemName: icon)
    config?.imagePlacement = .leading
    config?.imagePadding = 4
    config?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: iconSize)
    button.configuration = config
  }
  
  func setIconOnly(_ iconOnly: Bool) {
    var config = button.configuration
    if iconOnly {
      config?.title = ""
      config?.imagePlacement = .top
      config?.imagePadding = 0
    } else {
      config?.imagePlacement = .leading
      config?.imagePadding = 4
    }
    button.configuration = config
  }
  
  func setIconSize(_ iconSize: CGFloat) {
    self.iconSize = iconSize
    var config = button.configuration
    config?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: iconSize)
    button.configuration = config
  }
  
  func setBackgroundColor(_ color: UIColor, isCustom: Bool) {
    self.buttonBackgroundColor = color
    var config = button.configuration
    config?.baseBackgroundColor = color
    button.configuration = config
  }
  
  func setTextColor(_ color: UIColor, isCustom: Bool) {
    self.buttonTextColor = color
    var config = button.configuration
    config?.baseForegroundColor = color
    button.configuration = config
  }
  
  func setIconColor(_ color: UIColor) {
    self.buttonIconColor = color
    var config = button.configuration
    config?.baseForegroundColor = color
    button.configuration = config
  }
  
  func layoutSubviews(bounds: CGRect) {
    if isRound {
      button.layer.cornerRadius = min(button.bounds.width, button.bounds.height) / 2
    }
  }
}

// MARK: - UIColor Extension for Hex String Support
extension UIColor {
    convenience init?(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b, a: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b, a) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17, 255)
        case 6: // RGB (24-bit)
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // RGBA (32-bit)
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }
        
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            alpha: Double(a) / 255
        )
    }
}
