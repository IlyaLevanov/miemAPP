//
//  CameraListGraph.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 10.01.2021.
//

import UIKit

final class CameraListGraph {
  let screen: Screen
  private let cameraListLoad: CameraListScreenLoad
  private let cameraListDataSource: CameraListDataSource
  
  init(
    bottomInset: Variable<CGFloat>,
    token: Variable<String>,
    onPick: @escaping (CameraItemModel) -> Void,
    onClose: @escaping () -> Void
  ) {
    cameraListDataSource = CameraListDataSource(token: token)
    cameraListLoad = CameraListScreenLoad(
      bottomInset: bottomInset,
      refreshAction: cameraListDataSource.setNeedsUpdate,
      onPick: onPick,
      onClose: onClose
    )
    screen = Screen(id: .cameraListScreen, payload: cameraListLoad)
    cameraListDataSource.setOnUpdate { [unowned self] in
      self.cameraListLoad.model = $0
    }
  }
  
  func setNeedsUpdate() {
    cameraListDataSource.setNeedsUpdate()
  }
}
