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
  
  required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)
    clipsToBounds = true
    setupButtonImplementation()
  }
  
  private func setupButtonImplementation() {
    if #available(iOS 26.0, *) {
      buttonImplementation = LiquidGlassButton(parent: self)
    } else {
      buttonImplementation = FallbackButton(parent: self)
    }
    buttonImplementation.setup()
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
  func layoutSubviews(bounds: CGRect)
}

@available(iOS 26.0, *)
class LiquidGlassButton: ButtonImplementation {
  private weak var parent: ExpoLiquidGlassButtonView?
  private var isRound: Bool = false
  private var textSize: CGFloat = 16.0
  private var icon: String?
  private var iconSize: CGFloat = 16.0
  
  private var glassButton: UIButton!
  
  private func createGlassButton() -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    var config = UIButton.Configuration.prominentGlass()
    config.title = ""
    config.baseBackgroundColor = UIColor(red: 1.0, green: 0.455, blue: 0.529, alpha: 1.0)
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
  
  private var button: UIButton!
  
  private func createButton() -> UIButton {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    
    var config = UIButton.Configuration.filled()
    config.title = ""
    config.baseBackgroundColor = UIColor.systemBlue
    config.baseForegroundColor = UIColor.white
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
  
  func layoutSubviews(bounds: CGRect) {
    if isRound {
      button.layer.cornerRadius = min(button.bounds.width, button.bounds.height) / 2
    }
  }
}
