//
//  Test.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 07.11.2021.
//

import UIKit

class TestViewController: UIViewController, ScreenPayload {
  var controller: UIViewController {
    return self
  }
  
  init()
  {
    setup()
    super.init(nibName: nil, bundle: nil)
  }
  let button: UIButton = {
      let button = UIButton()
      return button
  }()
  
  let label: UILabel = {
      let label = UILabel()
      return label
  }()
  
  func setup() {
    
  }
  
  
}
