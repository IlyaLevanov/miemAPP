//
//  TinderViewController.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 06.11.2021.
//

import UIKit

class TinderViewController: UIViewController {
  var model: [ProjectsListModel]
  
  init(model: [ProjectsListModel]) {
    self.model = model
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
