//
//  ProfileGraph.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 18.02.2021.
//

import UIKit
final class ProfileGraph {
  let screen: Screen
  private let profileLoad: ProfileScreenLoad
  private let profileDataSource: ProfileDataSource
  
  init(
    bottomInset: Variable<CGFloat>,
    user: Variable<User>,
    token: Property<String>
  ) {
     profileDataSource = ProfileDataSource(user: user, token: token)
    profileLoad = ProfileScreenLoad(bottomInset: bottomInset, refreshAction: profileDataSource.setNeedsUpdate)
    screen = Screen(id: .profileScreen, payload: profileLoad)
    profileDataSource.setOnUpdate { [unowned self] in
    self.profileLoad.modelProfile = $0
    }
    print("profile data source set on update")
    profileDataSource.setOnUpdateProject { [unowned self] in
    self.profileLoad.modelProject = $0
    }
    profileDataSource.setOnUpdateApplication {
      [unowned self] in
      self.profileLoad.modelApplication = $0
    }

  }
  
    
  func setNeedsUpdate() {
    profileDataSource.setNeedsUpdate()
  }
    
    
}