//
//  NavigationScreenLoad.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 27.05.2022.
//

import UIKit
import Foundation
import NavigationModule
@available(iOS 13.0, *)
final class NavigationScreenLoad: UIViewController, ScreenPayload {
  var controller: UIViewController {
    self
  }
  var navController = UINavigationController()
  
  init (navController: NavigationController) {
    self.navController.addChild(navController)
//    self.navController.view.addSubview(navController.view)
    navController.didMove(toParent: self.navController)
    
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  override func viewDidLoad() {
    
    navController.view.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(navController.view)
    navController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    navController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    navController.view.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
