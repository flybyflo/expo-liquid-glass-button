import ExpoModulesCore
import UIKit

class ExpoLiquidGlassButtonView: ExpoView {
  let onButtonPress = EventDispatcher()
  
  private var buttonImplementation: ButtonImplementation!
  private var isRound: Bool = false
  
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    buttonImplementation.layoutSubviews(bounds: bounds)
  }
}

protocol ButtonImplementation {
  func setup()
  func setTitle(_ title: String)
  func setIsRound(_ isRound: Bool)
  func layoutSubviews(bounds: CGRect)
}

@available(iOS 26.0, *)
class LiquidGlassButton: ButtonImplementation {
  private weak var parent: ExpoLiquidGlassButtonView?
  private var isRound: Bool = false
  
  private let glassButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    var config = UIButton.Configuration.glass()
    config.title = "Button"
    config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
      var outgoing = incoming
      outgoing.font = UIFont.systemFont(ofSize: 16, weight: .medium)
      return outgoing
    }
    
    button.configuration = config
    return button
  }()
  
  init(parent: ExpoLiquidGlassButtonView) {
    self.parent = parent
  }
  
  func setup() {
    guard let parent = parent else { return }
    
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
  
  func layoutSubviews(bounds: CGRect) {
    if isRound {
      glassButton.layer.cornerRadius = min(glassButton.bounds.width, glassButton.bounds.height) / 2
    }
  }
}

class FallbackButton: ButtonImplementation {
  private weak var parent: ExpoLiquidGlassButtonView?
  private var isRound: Bool = false
  
  private let button: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    
    var config = UIButton.Configuration.filled()
    config.title = "Button"
    config.baseBackgroundColor = UIColor.systemBlue
    config.baseForegroundColor = UIColor.white
    config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
      var outgoing = incoming
      outgoing.font = UIFont.systemFont(ofSize: 16, weight: .medium)
      return outgoing
    }
    config.cornerStyle = .capsule
    
    btn.configuration = config
    return btn
  }()
  
  init(parent: ExpoLiquidGlassButtonView) {
    self.parent = parent
  }
  
  func setup() {
    guard let parent = parent else { return }
    
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
  
  func layoutSubviews(bounds: CGRect) {
    if isRound {
      button.layer.cornerRadius = min(button.bounds.width, button.bounds.height) / 2
    }
  }
}
