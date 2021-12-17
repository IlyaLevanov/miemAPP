//
//  MoreProjectInfo.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 04.12.2021.
//

import UIKit

class MoreProjectScreenLoad: UIViewController {
  var controller: UIViewController {
    self
  }
  
  let idLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: Brandbook.TextSize.normal)
    label.textColor = UIColor.black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let id: Int
  
  init(id: Int) {
    self.id = id
    super.init(nibName: nil, bundle: nil)
    setUpComponents()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setUpComponents() {
    controller.view.backgroundColor = .blue
    controller.view.addSubview(idLabel)
    idLabel.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 16).isActive = true
    idLabel.text = String(id)
  }
}
