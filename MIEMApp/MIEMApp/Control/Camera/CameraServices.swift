//
//  CameraServices.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 24.01.2021.
//

import Alamofire
import Foundation

final class CameraServices {
  private struct Preset: Encodable {
    let s_pres: Int
    let button_clr: String
  }
  private let session = makeDefaultSession()
  private let token: Variable<String>
  
  init(token: Variable<String>) {
    self.token = token
  }
  
  func chooseCam(uid: String, completion: @escaping (Bool) -> Void) {
    let parameters = ["uid": uid, "date_on": Date().string(format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"), "date_off": Date().addingTimeInterval(5 * 60).string(format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX")]
    let headers: HTTPHeaders = ["key": token.value]
    session.request("http://19111.miem.vmnet.top/chose_cam", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { response in
      Logger.shared.log(response.debugDescription)
      guard response.response?.statusCode == 200 else {
        completion(false)
        debugPrint(response)
        return
      }
      completion(true)
    }
  }
  
  func ptz(point: CGPoint = .zero, zoom: CGFloat = 0) {
    let parameters = ["ptz": [point.x, point.y, zoom]]
    let headers: HTTPHeaders = ["key": token.value]
    session.request("http://19111.miem.vmnet.top/continuous_move", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response {
      Logger.shared.log($0.debugDescription)
      debugPrint($0)
    }
  }
  
  func released() {
    let headers: HTTPHeaders = ["key": token.value]
    session.request("http://19111.miem.vmnet.top/stop", headers: headers).response {
      Logger.shared.log($0.debugDescription)
      debugPrint($0)
    }
  }
  
  func setPreset(id: Int) {
    guard (1...9).contains(id) else {
      return
    }
    let parameters = Preset(s_pres: id, button_clr: "red")
    let headers: HTTPHeaders = ["key": token.value]
    session.request("http://19111.miem.vmnet.top/set_preset", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response {
      Logger.shared.log($0.debugDescription)
      debugPrint($0)
    }
  }

  func execPreset(id: Int) {
    guard (1...9).contains(id) else {
      return
    }
    let parameters = ["go_pres": id]
    let headers: HTTPHeaders = ["key": token.value]
    session.request("http://19111.miem.vmnet.top/goto_preset", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response {
      Logger.shared.log($0.debugDescription)
      debugPrint($0)
    }
  }
}
