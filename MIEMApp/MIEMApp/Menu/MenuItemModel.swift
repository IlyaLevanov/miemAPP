//
//  MenuItemModel.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 08.01.2021.
//

import UIKit

public enum MenuItemKind: Int {
//  case control
  case about
  case profile
  case projects
  case sandbox
}

struct MenuItemModel {
  let icon: UIImage
  let title: String
  let action: () -> Void
}
