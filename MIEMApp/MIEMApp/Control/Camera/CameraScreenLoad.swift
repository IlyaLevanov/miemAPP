////
////  CameraScreenLoad.swift
////  MIEMApp
////
////  Created by Тимофей Фёдоров on 20.01.2021.
////
//
//import UIKit
//import WebKit
//
//final class CameraScreenLoad: UIViewController, ScreenPayload {
//  private let services: CameraServices
//  private let crosshairView = CrosshairView()
//  private let titleButton = Button("MIEMApp")
//  private let buttonsStack = UIStackView()
//  private let videoView: VideoView
//  private let activityIndicator = UIActivityIndicatorView(style: .gray)
//  private let bottomInset: Variable<CGFloat>
//  private var tutorialShown: Property<Bool>
//  private let showTutorial: (TutorialViewModel, @escaping () -> Void) -> Void
//  private let openList: () -> Void
//  
//  private var prev = unreachablePoint
//  private var isLeavingControl = true
//  
//  init(
//    bottomInset: Variable<CGFloat>,
//    token: Variable<String>,
//    tutorialShown: Property<Bool>,
//    showTutorial: @escaping (TutorialViewModel, @escaping () -> Void) -> Void,
//    openList: @escaping () -> Void
//  ) {
//    self.bottomInset = bottomInset
//    self.openList = openList
//    self.services = CameraServices(token: token)
//    self.tutorialShown = tutorialShown
//    self.showTutorial = showTutorial
//    videoView = VideoView()
//    super.init(nibName: nil, bundle: nil)
//    videoView.setTouchHandler(self)
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  var controller: UIViewController {
//    self
//  }
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.addSubview(titleButton)
//    view.addSubview(activityIndicator)
//    view.addSubview(videoView)
//    view.addSubview(crosshairView)
//    view.addSubview(buttonsStack)
//    videoView.layer.cornerRadius = 10
//    videoView.layer.masksToBounds = true
//    crosshairView.layer.cornerRadius = 5
//    crosshairView.layer.masksToBounds = true
//    crosshairView.layer.borderColor = Brandbook.Colors.grey.cgColor
//    crosshairView.layer.borderWidth = Brandbook.LineSize.normal
//    crosshairView.backgroundColor = .clear
//    crosshairView.isUserInteractionEnabled = false
//    
//    titleButton.addTarget(self, action: #selector(onTitleClicked), for: .touchUpInside)
//    titleButton.backgroundColor = .none
//    titleButton.setTitleColor(Brandbook.Colors.tint, for: .normal)
//    titleButton.titleLabel?.font = titleButton.titleLabel?.font.withSize(Brandbook.TextSize.large).bold
//    titleButton.contentHorizontalAlignment = .left
//    titleButton.translatesAutoresizingMaskIntoConstraints = false
//    titleButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//    titleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
//    let height = titleButton.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 1)).height
//    titleButton.heightAnchor.constraint(equalToConstant: height).isActive = true
//    
//    activityIndicator.hidesWhenStopped = true
//    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//    activityIndicator.leadingAnchor.constraint(equalTo: titleButton.trailingAnchor).isActive = true
//    activityIndicator.centerYAnchor.constraint(equalTo: titleButton.centerYAnchor).isActive = true
//    
//    videoView.translatesAutoresizingMaskIntoConstraints = false
//    videoView.topAnchor.constraint(equalTo: titleButton.bottomAnchor, constant: padding).isActive = true
//    videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
//    videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
//    videoView.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -padding).isActive = true
//    
//    crosshairView.translatesAutoresizingMaskIntoConstraints = false
//    crosshairView.topAnchor.constraint(equalTo: videoView.topAnchor).isActive = true
//    crosshairView.leadingAnchor.constraint(equalTo: videoView.leadingAnchor).isActive = true
//    crosshairView.trailingAnchor.constraint(equalTo: videoView.trailingAnchor).isActive = true
//    crosshairView.bottomAnchor.constraint(equalTo: videoView.bottomAnchor).isActive = true
//    
//    buttonsStack.translatesAutoresizingMaskIntoConstraints = false
//    buttonsStack.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true
//    buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
//    buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
//    buttonsStack.bottomAnchor.constraint(
//      equalTo: view.bottomAnchor,
//      constant: -padding - bottomInset.value
//    ).isActive = true
//    setUpButtons()
//  }
//  
//  override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    isLeavingControl = true
//    if !tutorialShown.value {
//      showTutorial(
//        TutorialViewModel(pages: cameraTutorialPages),
//        { [weak self] in
//          self?.tutorialShown.value = true
//        }
//      )
//    }
//  }
//  
//  override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//    if isLeavingControl {
//      titleButton.setTitle("MIEMApp", for: .normal)
//      onStop()
//    }
//  }
//  
//  @objc private func onTitleClicked() {
//    isLeavingControl = false
//    openList()
//  }
//  
//  private func setUpButtons() {
//    buttonsStack.axis = .vertical
//    buttonsStack.spacing = padding
//    buttonsStack.distribution = .fillEqually
//
//    let zoomOut = Button()
//    let zoomIn = Button()
//    zoomOut.setImage(Brandbook.Images.Icons.zoomOutIcon, for: .normal)
//    zoomIn.setImage(Brandbook.Images.Icons.zoomInIcon, for: .normal)
//    zoomOut.tag = 10
//    zoomIn.tag = 11
//    zoomOut.addTarget(self, action: #selector(onZoom(_:)), for: .touchDown)
//    zoomIn.addTarget(self, action: #selector(onZoom(_:)), for: .touchDown)
//    zoomOut.addTarget(self, action: #selector(onZoomReleased), for: .touchUpInside)
//    zoomIn.addTarget(self, action: #selector(onZoomReleased), for: .touchUpInside)
//    zoomOut.addTarget(self, action: #selector(onZoomReleased), for: .touchUpOutside)
//    zoomIn.addTarget(self, action: #selector(onZoomReleased), for: .touchUpOutside)
//    let zoomStack = makeRow(arrangedSubviews: [zoomOut, zoomIn])
//    buttonsStack.addArrangedSubview(zoomStack)
//    
//    let rows = [makeRow(), makeRow(), makeRow()]
//    for i in 0...8 {
//      let button = Button(String(i + 1))
//      button.tag = i + 1
//      switch i {
//      case 0..<3:
//        rows[0].addArrangedSubview(button)
//      case 3..<6:
//        rows[1].addArrangedSubview(button)
//      case 6..<9:
//        rows[2].addArrangedSubview(button)
//      default:
//        assertionFailure("Only 9 buttons allowed")
//      }
//      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onPreset))
//      let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(onPresetLong))
//      button.addGestureRecognizer(tapGesture)
//      button.addGestureRecognizer(longGesture)
//    }
//    rows.forEach {
//      buttonsStack.addArrangedSubview($0)
//    }
//  }
//  
//  @objc private func onZoom(_ sender: UIButton) {
//    services.ptz(zoom: sender.tag == 10 ? -0.5 : 0.5)
//  }
//  
//  @objc private func onZoomReleased() {
//    services.released()
//  }
//  
//  @objc private func onPreset(_ sender: UIGestureRecognizer) {
//    guard sender.state == .ended else {
//      return
//    }
//    guard let button = sender.view as? UIButton else {
//      return
//    }
//    services.execPreset(id: button.tag)
//  }
//  
//  @objc private func onPresetLong(_ sender: UIGestureRecognizer) {
//    guard sender.state == .began else {
//      return
//    }
//    let generator = UIImpactFeedbackGenerator(style: .medium)
//    generator.prepare()
//    generator.impactOccurred()
//    guard let button = sender.view as? UIButton else {
//      return
//    }
//    services.setPreset(id: button.tag)
//  }
//  
//  func onPick(camera: CameraItemModel) {
//    onStop()
//    titleButton.setTitle(camera.name, for: .normal)
//    videoView.isHidden = true
//    activityIndicator.startAnimating()
//    if let url = URL(string: camera.rtsp) {
//      videoView.start(url: url, onVideoResult: { [weak self] success in
//        Logger.shared.log("started \(success)")
//        guard success else {
//          self?.videoView.isHidden = false
//          self?.activityIndicator.stopAnimating()
//          self?.parent?.present(makeAlert(), animated: true, completion: nil)
//          return
//        }
//        DispatchQueue.main.async {
//          print("started \(success)")
//          self?.services.chooseCam(uid: camera.uid) { success in
//            if !success {
//              self?.videoView.stop()
//              self?.parent?.present(makeAlert(), animated: true, completion: nil)
//            }
//            self?.videoView.isHidden = !success
//            self?.activityIndicator.stopAnimating()
//          }
//        }
//      })
//    }
//  }
//  
//  private func onStop() {
//    videoView.stop()
//  }
//}
//
//private func makeRow(arrangedSubviews: [UIView]? = nil) -> UIStackView {
//  let stack: UIStackView
//  if let arrangedSubviews = arrangedSubviews {
//    stack = UIStackView(arrangedSubviews: arrangedSubviews)
//  } else {
//    stack = UIStackView()
//  }
//  
//  stack.spacing = padding
//  stack.distribution = .fillEqually
//  return stack
//}
//
//private func makeAlert() -> UIAlertController {
//  let alertController = UIAlertController(
//    title: "",
//    message: "Не удалось получить доступ к камере",
//    preferredStyle: .alert
//  )
//  let defaultAction = UIAlertAction(
//    title: "OK",
//    style: .default,
//    handler: nil
//  )
//  alertController.addAction(defaultAction)
//  alertController.modalPresentationStyle = .popover
//  return alertController
//}
//
//extension CameraScreenLoad: TouchHandler {
//  func touched(_ point: CGPoint) {
//    if (abs(point.x  - prev.x) > 0.05 || abs(point.y  - prev.y) > 0.05 || prev == unreachablePoint) {
//      services.ptz(point: point)
//    }
//  }
//  
//  func released() {
//    services.released()
//    prev = unreachablePoint
//  }
//}
//
//private let unreachablePoint = CGPoint(x: 2, y: 2)
//private let padding = Brandbook.Paddings.normal
//private let buttonsHeight: CGFloat = 215
