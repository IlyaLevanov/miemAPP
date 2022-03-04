//
//  MenuDataSource.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 09.01.2021.
//

import Foundation

final class MenuDataSource {
  private var menuItems: Property<[MenuItemKind]>
  private let user: Variable<User>
  
  private var onUpdate: (([MenuItemKind]) -> Void)?
  private var isUpdating: Bool = false
  
  var initialModel: [MenuItemKind] {
    menuItems.value
  }
  
  init(
    menuItems: Property<[MenuItemKind]>,
    user: Variable<User>
  ) {
    self.menuItems = menuItems
    self.user = user
  }
  
  func setOnUpdate(onUpdate: @escaping ([MenuItemKind]) -> Void) {
    self.onUpdate = onUpdate
  }
  
  func setNeedsUpdate() {
    guard !isUpdating else {
      return
    }
    update()
  }
  
  private func update() {
    isUpdating = true
    menuItems.value = user.value.isReview ? [.about] : [.profile, .projects, .about]
    onUpdate?(menuItems.value)
    isUpdating = false
  }
}
