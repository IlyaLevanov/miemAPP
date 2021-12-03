//
//  AboutScreenLoad.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 29.11.2020.
//

import UIKit

final class AboutScreenLoad: UIViewController, ScreenPayload {
  private let onExitClicked: () -> Void
  
  var controller: UIViewController {
    self
  }
  
  init(onExitClicked: @escaping () -> Void) {
    self.onExitClicked = onExitClicked
    super.init(nibName: nil, bundle: nil)
    setupAboutComponents()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  
  func setupAboutComponents() {
    controller.view.backgroundColor = .white
    controller.edgesForExtendedLayout = []
    controller.title = "О приложении"

    let imageView = UIImageView(frame: .zero)
    imageView.image = Brandbook.Images.appLogo
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    controller.view.addSubview(imageView)
    imageView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
    imageView.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    let mainText: String = "Приложение позволяет удаленно управлять камерами в МИЭМ, добавлять новые камеры и записывать сценарии."
    let mainLabel = UILabel()
    mainLabel.text = mainText
    mainLabel.numberOfLines = 0
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    controller.view.addSubview(mainLabel)
    mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding).isActive = true
    mainLabel.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: padding).isActive = true
    mainLabel.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -padding).isActive = true

    let lableBottom = UILabel()
    let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "🤡"
    lableBottom.text = "Версия 1.0 (\(build))"
    lableBottom.font = lableBottom.font.withSize(Brandbook.TextSize.normal)
    lableBottom.textColor = Brandbook.Colors.grey
    lableBottom.translatesAutoresizingMaskIntoConstraints = false
    controller.view.addSubview(lableBottom)
    lableBottom.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    lableBottom.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(getLogs))
    lableBottom.isUserInteractionEnabled = true
    lableBottom.addGestureRecognizer(tap)
    
    let exitButton = Button("Выйти из аккаунта")
    exitButton.backgroundColor = Brandbook.Colors.redColor
    exitButton.addTarget(self, action: #selector(onExitBtnClicked), for: .touchUpInside)
    exitButton.translatesAutoresizingMaskIntoConstraints = false
    controller.view.addSubview(exitButton)
    exitButton.bottomAnchor.constraint(equalTo: lableBottom.topAnchor, constant: -padding).isActive = true
    exitButton.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
  }
  
  @objc private func onExitBtnClicked() {
    onExitClicked()
  }
  
  @objc private func getLogs() {
    UIPasteboard.general.string = Logger.shared.logString
    let message = "Логи скопированы"
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    self.present(alert, animated: true)
        
    let duration: Double = 2
        
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
      alert.dismiss(animated: true)
    }
  }
}

private let padding = Brandbook.Paddings.normal
