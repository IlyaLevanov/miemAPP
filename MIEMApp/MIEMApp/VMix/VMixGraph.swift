//
//  VMixGraph.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 24.01.2021.
//

import UIKit

final class VMixGraph {
  let screen: Screen
  private let vmixLoad: VMixScreenLoad
  
  init(
    bottomInset: Variable<CGFloat>
  ) {
    vmixLoad = VMixScreenLoad(bottomInset: bottomInset)
    screen = Screen(id: .vmixScreen, payload: vmixLoad)
  }
}
