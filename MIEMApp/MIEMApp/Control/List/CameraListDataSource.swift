//
//  CameraListDataSource.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 10.01.2021.
//

import Alamofire
import Foundation

final class CameraListDataSource {
  private let token: Variable<String>
  private let session = makeDefaultSession()
  
  private var onUpdate: (([RoomModel]) -> Void)?
  private var isUpdating: Bool = false
  
  init(token: Variable<String>) {
    self.token = token
  }
  
  func setOnUpdate(onUpdate: @escaping ([RoomModel]) -> Void) {
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
    let headers: HTTPHeaders = ["key": self.token.value]
    session.request("http://19111.miem.vmnet.top/return_cams", headers: headers).response { response in
      guard let data = response.data,
        let parsedResponse = try? JSONDecoder().decode([CameraItemModel].self, from: data),
        !parsedResponse.isEmpty else {
        self.isUpdating = false
        return
      }
      let sorted = parsedResponse.sorted(by: {
        $0.room < $1.room
      })
      var roomModels = [RoomModel]()
      var currentRoom = sorted[0].room
      var currentCameras = [CameraItemModel]()
      sorted.forEach {
        if $0.room == currentRoom {
          currentCameras.append($0)
        } else {
          roomModels.append(RoomModel(room: currentRoom, cameras: currentCameras))
          currentRoom = $0.room
          currentCameras = [$0]
        }
      }
      if !currentCameras.isEmpty {
        roomModels.append(
          RoomModel(room: currentRoom, cameras: currentCameras)
        )
      }
      self.onUpdate?(roomModels)
      self.isUpdating = false
    }
  }
}
