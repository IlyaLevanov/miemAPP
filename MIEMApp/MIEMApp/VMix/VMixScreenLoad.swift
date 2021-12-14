//
//  vMixScreenLoad.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 11.01.2021.
//

import UIKit

class VMixScreenLoad: UIViewController, ScreenPayload {
  var controller: UIViewController {
    return self
  }
  private let bottomInset: Variable<CGFloat>

  init(bottomInset: Variable<CGFloat>) {
    self.bottomInset = bottomInset
    super.init(nibName: nil, bundle: nil)
    setupvMixComponents()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let hostSearch: UITextField = {
    let search = UITextField()
    search.placeholder = "Адрес хоста"
    search.clearButtonMode = UITextField.ViewMode.always
    search.clearsOnBeginEditing = true
    search.backgroundColor = Brandbook.Colors.lightGray
    search.borderStyle = UITextField.BorderStyle.roundedRect
    search.translatesAutoresizingMaskIntoConstraints = false
    return search
  }()
  
  let addImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 3
    imageView.clipsToBounds = true
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddImageView)))
    return imageView
  }()
  
  let deleteImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 3
    imageView.clipsToBounds = true
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDeleteImageView)))
    return imageView
  }()
  
  let recButton: UIButton = {
    let button = UIButton(type: .roundedRect)
    button.setTitle("REC", for: .normal)
    button.backgroundColor = Brandbook.Colors.tint
    button.tintColor = .white
//     button.addTarget(self, action: #selector(handleRecButton), for: .touchUpInside)
    button.layer.cornerRadius = 11
    button.layer.masksToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let leftStopButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("STOP", for: .normal)
    button.backgroundColor = Brandbook.Colors.tint
    button.tintColor = .white
//   button.addTarget(self, action: #selector(handleCutButton), for: .touchUpInside)
    button.layer.cornerRadius = 11
    button.layer.masksToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let strmButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("STRM", for: .normal)
    button.backgroundColor = Brandbook.Colors.tint
    button.tintColor = .white
//   button.addTarget(self, action: #selector(handleCutButton), for: .touchUpInside)
    button.layer.cornerRadius = 11
    button.layer.masksToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let rightStopButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("STOP", for: .normal)
    button.backgroundColor = Brandbook.Colors.tint
    button.tintColor = .white
//   button.addTarget(self, action: #selector(handleCutButton), for: .touchUpInside)
    button.layer.cornerRadius = 11
    button.layer.masksToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let cutButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("CUT", for: .normal)
    button.backgroundColor = Brandbook.Colors.tint
    button.tintColor = .white
//  button.addTarget(self, action: #selector(handleCutButton), for: .touchUpInside)
    button.layer.cornerRadius = 11
    button.layer.masksToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  let fadeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("FADE", for: .normal)
    button.backgroundColor = Brandbook.Colors.tint
    button.tintColor = .white
//     button.addTarget(nil, action: #selector(handleCutButton), for: .touchUpInside)
    button.layer.cornerRadius = 11
    button.layer.masksToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  let label1: UILabel = {
    let label = UILabel()
    label.text = "1"
    label.textColor = UIColor(red: 255/255, green: 31/255, blue: 34/255, alpha: 1.00)
    label.textAlignment = NSTextAlignment.center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let label2: UILabel = {
    let label = UILabel()
    label.text = "2"
    label.textColor = UIColor(red: 255/255, green: 135/255, blue: 0.255, alpha: 1.00)
    label.textAlignment = NSTextAlignment.center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let label3: UILabel = {
    let label = UILabel()
    label.text = "3"
    label.textColor = UIColor(red: 0/255, green: 168/255, blue: 52/255, alpha: 1.00)
    label.textAlignment = NSTextAlignment.center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let label4: UILabel = {
    let label = UILabel()
    label.text = "4"
    label.textColor = UIColor(red: 0/255, green: 131/255, blue: 244/255, alpha: 1.00)
    label.textAlignment = NSTextAlignment.center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var buttons: [UIButton] = []
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if touches.first != nil {
      self.view.endEditing(true)
    }
    super.touchesBegan(touches, with: event)
  }
  
  func setupvMixComponents() {
    self.view.backgroundColor = .white
    self.view.addSubview(containerView)

    containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -bottomInset.value).isActive = true
    containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
      
    containerView.addSubview(hostSearch)
    hostSearch.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding).isActive = true
    hostSearch.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding).isActive = true
    hostSearch.heightAnchor.constraint(equalToConstant: 30).isActive = true
  
    containerView.addSubview(addImageView)
    addImageView.leftAnchor.constraint(equalTo: hostSearch.rightAnchor, constant: padding).isActive = true
    addImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding).isActive = true
    addImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    addImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    addImageView.image = Brandbook.Images.Icons.addIcon
    
    containerView.addSubview(deleteImageView)
    deleteImageView.leftAnchor.constraint(equalTo: addImageView.rightAnchor, constant: padding).isActive = true
    deleteImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding).isActive = true
    deleteImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding).isActive = true
    deleteImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    deleteImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    deleteImageView.image = Brandbook.Images.Icons.deleteIcon
  
    let width2 = (UIScreen.main.bounds.width - 3 * padding) / 2
    let width4 = (UIScreen.main.bounds.width - 5 * padding) / 4
    
    containerView.addSubview(recButton)
    recButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding).isActive = true
    recButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    recButton.widthAnchor.constraint(equalToConstant: width4).isActive = true
    recButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    
    containerView.addSubview(leftStopButton)
    leftStopButton.leftAnchor.constraint(equalTo: recButton.rightAnchor, constant: padding).isActive = true
    leftStopButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    leftStopButton.widthAnchor.constraint(equalToConstant: width4).isActive = true
    leftStopButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    
    containerView.addSubview(strmButton)
    strmButton.leftAnchor.constraint(equalTo: leftStopButton.rightAnchor, constant: padding).isActive = true
    strmButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    strmButton.widthAnchor.constraint(equalToConstant: width4).isActive = true
    strmButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    
    containerView.addSubview(rightStopButton)
    rightStopButton.leftAnchor.constraint(equalTo: strmButton.rightAnchor, constant: padding).isActive = true
    rightStopButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    rightStopButton.widthAnchor.constraint(equalToConstant: width4).isActive = true
    rightStopButton.heightAnchor.constraint(equalToConstant: 35).isActive = true

    containerView.addSubview(cutButton)
    cutButton.bottomAnchor.constraint(equalTo: recButton.topAnchor, constant: -15).isActive = true
    cutButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding).isActive = true
    cutButton.widthAnchor.constraint(equalToConstant: width2).isActive = true
    cutButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    
    containerView.addSubview(fadeButton)
    fadeButton.bottomAnchor.constraint(equalTo: strmButton.topAnchor, constant: -15).isActive = true
    fadeButton.leftAnchor.constraint(equalTo: cutButton.rightAnchor, constant: padding).isActive = true
    fadeButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -padding).isActive = true
    fadeButton.widthAnchor.constraint(equalToConstant: width2).isActive = true
    fadeButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    
    let entries = ["4", "4", "4", "4", "3", "3", "3", "3", "2", "2", "2", "2", "1", "1", "1", "1", "PRGR", "PRGR", "PRGR", "PRGR", "PRVW", "PRVW", "PRVW", "PRVW"]
    for entry in entries {
      buttons.append(createButton(text: entry))
    }
    
    createButtonGrid(buttons: buttons)
    addButtonAction(buttons: buttons)
    
    containerView.addSubview(label1)
    label1.topAnchor.constraint(equalTo: buttons[12].bottomAnchor, constant: padding).isActive = true
    label1.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: padding).isActive = true
    label1.widthAnchor.constraint(equalToConstant: width4).isActive = true
    label1.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    containerView.addSubview(label2)
    label2.topAnchor.constraint(equalTo: buttons[13].bottomAnchor, constant: padding).isActive = true
    label2.leftAnchor.constraint(equalTo: label1.rightAnchor, constant: padding).isActive = true
    label2.widthAnchor.constraint(equalToConstant: width4).isActive = true
    label2.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    containerView.addSubview(label3)
    label3.topAnchor.constraint(equalTo: buttons[14].bottomAnchor, constant: padding).isActive = true
    label3.leftAnchor.constraint(equalTo: label2.rightAnchor, constant: padding).isActive = true
    label3.widthAnchor.constraint(equalToConstant: width4).isActive = true
    label3.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    containerView.addSubview(label4)
    label4.topAnchor.constraint(equalTo: buttons[15].bottomAnchor, constant: padding).isActive = true
    label4.leftAnchor.constraint(equalTo: label3.rightAnchor, constant: padding).isActive = true
    label4.widthAnchor.constraint(equalToConstant: width4).isActive = true
    label4.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }
  
  func createButton(text: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(text, for: .normal)
    button.tintColor = .white
    button.layer.cornerRadius = 11
    button.layer.masksToBounds = true
    button.isUserInteractionEnabled = true
    button.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }
  
  func addButtonAction(buttons: [UIButton]) {
    for idx in 0..<buttons.count {
    switch idx {
      case 0, 4, 8, 12, 16, 20:
        buttons[idx].addTarget(self, action: #selector(setRed), for: .touchUpInside)
        buttons[idx].backgroundColor = Brandbook.Colors.redColorInactive
      case 1, 5, 9, 13, 17, 21:
        buttons[idx].addTarget(self, action: #selector(setYellow), for: .touchUpInside)
        buttons[idx].backgroundColor = Brandbook.Colors.yellowColorInactive
      case 2, 6, 10, 14, 18, 22:
        buttons[idx].addTarget(self, action: #selector(setGreen), for: .touchUpInside)
        buttons[idx].backgroundColor = Brandbook.Colors.greenColorInactive
      case 3, 7, 11, 15, 19, 23:
        buttons[idx].addTarget(self, action: #selector(setBlue), for: .touchUpInside)
        buttons[idx].backgroundColor = Brandbook.Colors.blueColorInactive
      default:
        return
      }
    }
  }
   
  @objc
  func setRed(_ sender: UIButton) {
    if sender.backgroundColor == Brandbook.Colors.redColorInactive {
      sender.backgroundColor = Brandbook.Colors.redColor
     }
     else {
      sender.backgroundColor = Brandbook.Colors.redColorInactive
     }
  }
   
  @objc
  func setYellow(_ sender: UIButton) {
    if sender.backgroundColor == Brandbook.Colors.yellowColorInactive {
      sender.backgroundColor = Brandbook.Colors.yellowColor
    } else {
      sender.backgroundColor = Brandbook.Colors.yellowColorInactive
    }
  }
   
  @objc
  func setGreen(_ sender: UIButton) {
    if sender.backgroundColor == Brandbook.Colors.greenColorInactive {
      sender.backgroundColor = Brandbook.Colors.greenColor
    } else {
      sender.backgroundColor = Brandbook.Colors.greenColorInactive
    }
  }
   
  @objc
  func setBlue(_ sender: UIButton) {
    if sender.backgroundColor == Brandbook.Colors.blueColorInactive {
      sender.backgroundColor = Brandbook.Colors.blueColor
    } else {
      sender.backgroundColor = Brandbook.Colors.blueColorInactive
    }
  }
   
  @objc
  func handleAddImageView() {
  }
   
  @objc
  func handleDeleteImageView() {
  }
 
  func createButtonGrid(buttons: [UIButton]) {
    let width = (UIScreen.main.bounds.width - 5*padding)/4
    for idx in 0..<buttons.count {
      let button = buttons[idx]
      switch idx {
      case 0:
        self.containerView.addSubview(button)
        button.topAnchor.constraint(equalTo: hostSearch.bottomAnchor, constant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        
      case 1, 2:
        self.containerView.addSubview(button)
        button.topAnchor.constraint(equalTo: hostSearch.bottomAnchor, constant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: buttons[idx-1].rightAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        
      
      case 3:
        self.containerView.addSubview(button)
        button.topAnchor.constraint(equalTo: hostSearch.bottomAnchor, constant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: buttons[idx-1].rightAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        
      case 4, 8, 12:
        self.containerView.addSubview(button)
        button.topAnchor.constraint(equalTo: buttons[idx-4].bottomAnchor, constant: padding).isActive = true
        button.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        
      case 5...7, 9...11, 13...15:
        self.containerView.addSubview(button)
        button.topAnchor.constraint(equalTo: buttons[idx-4].bottomAnchor, constant: padding).isActive = true
        button.leftAnchor.constraint(equalTo: buttons[idx-1].rightAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        
      case 16:
        self.containerView.addSubview(button)
        button.topAnchor.constraint(equalTo: buttons[idx-4].bottomAnchor, constant: (2*padding + 40)).isActive = true
        button.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        
      case 17...19:
        self.containerView.addSubview(button)
        button.topAnchor.constraint(equalTo: buttons[idx-4].bottomAnchor, constant: (2*padding + 40)).isActive = true
        button.leftAnchor.constraint(equalTo: buttons[idx-1].rightAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        
      case 20:
        self.containerView.addSubview(button)
        button.topAnchor.constraint(equalTo: buttons[idx-4].bottomAnchor, constant: padding).isActive = true
        button.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
      case 21...23:
        self.containerView.addSubview(button)
        button.topAnchor.constraint(equalTo: buttons[idx-4].bottomAnchor, constant: padding).isActive = true
        button.leftAnchor.constraint(equalTo: buttons[idx-1].rightAnchor, constant: padding).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
      default:
        return
      }
    }
  }
}

private let padding = Brandbook.Paddings.normal
