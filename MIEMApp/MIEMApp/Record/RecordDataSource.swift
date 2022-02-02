////
////  RecordDataSource.swift
////  MIEMApp
////
////  Created by Тимофей Фёдоров on 08.03.2021.
////
//
//import Alamofire
//import Foundation
//
//final class RecordDataSource {
//  private struct NvrRooms: Decodable {
//    let id: Int
//    let name: String
//  }
//  
//  private let user: Variable<User>
//  private let session = makeDefaultSession()
//  
//  private var onUpdate: (([String]) -> Void)?
//  private var isUpdating: Bool = false
//  private var rooms = [NvrRooms]()
//  
//  init(user: Variable<User>) {
//    self.user = user
//  }
//  
//  func setOnUpdate(onUpdate: @escaping ([String]) -> Void) {
//    self.onUpdate = onUpdate
//  }
//  
//  func setNeedsUpdate() {
//    guard !isUpdating else {
//      return
//    }
//    update()
//  }
//  
//  private func update() {
//    isUpdating = true
//    let headers: HTTPHeaders = ["key": "c164939186104eff94b525085d4b5291"]
//    session.request("https://nvr.miem.hse.ru/api/rooms", headers: headers).response { response in
//      guard let data = response.data,
//        let parsedResponse = try? JSONDecoder().decode([NvrRooms].self, from: data),
//        !parsedResponse.isEmpty else {
//        self.isUpdating = false
//        return
//      }
//      self.rooms = parsedResponse
//      let sorted = parsedResponse.sorted {
//        $0.name < $1.name
//      }.map { $0.name }
//      self.onUpdate?(sorted)
//      self.isUpdating = false
//    }
//  }
//  
//  func requestRecord(_ record: RecordModel, completion: @escaping (Bool) -> Void) {
//    let headers: HTTPHeaders = ["key": "c164939186104eff94b525085d4b5291"]
//    guard let room = record.room,
//      let start = record.startTime,
//      let end = record.endTime,
//      let date = record.date,
//      let name = record.eventName else {
//      completion(false)
//      return
//    }
//    guard let roomData = rooms.first(where: { $0.name == room }) else {
//      completion(false)
//      return
//    }
//    let parameters = [
//      "start_time": start,
//      "end_time": end,
//      "date": date,
//      "event_name": name,
//      "user_email": user.value.email
//    ]
//    session.request("https://nvr.miem.hse.ru/api/montage-event/\(roomData.id)", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { response in
//      guard response.response?.statusCode == 201 else {
//        completion(false)
//        return
//      }
//      completion(true)
//    }
//  }
//}
