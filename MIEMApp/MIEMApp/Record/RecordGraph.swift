//
//  RecordGraph.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 24.01.2021.
//

import UIKit

final class RecordGraph {
  let screen: Screen
  private let recordLoad: RecordScreenLoad
  
  init(
    bottomInset: Variable<CGFloat>,
    user: Variable<User>
  ) {
    let recordDataSource = RecordDataSource(user: user)
    recordLoad = RecordScreenLoad(bottomInset: bottomInset, requestRecord: recordDataSource.requestRecord)
    screen = Screen(id: .recordScreen, payload: recordLoad)
    recordDataSource.setOnUpdate { [recordLoad] in
      recordLoad.rooms = $0
    }
    recordDataSource.setNeedsUpdate()
  }
}
