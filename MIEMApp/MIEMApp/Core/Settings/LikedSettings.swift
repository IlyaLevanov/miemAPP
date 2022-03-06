//
//  LikedSettings.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 04.03.2022.
//

import Foundation
final class LikedSettings {
  private enum LikedKeys: String {
    case likedCards
  }
  
  static var likedCards: [CardDataModel]! {
    get {
      if let data = UserDefaults.standard.value(forKey:LikedKeys.likedCards.rawValue) as? Data {
          let likedCardsArray = try? PropertyListDecoder().decode(Array<CardDataModel>.self, from: data)
        print("success")
        return likedCardsArray
      } else {
        print("fffuck")
        return nil
      }
    }
    set {
      let defaults = UserDefaults.standard
      let key = LikedKeys.likedCards.rawValue
      if let likedArray = newValue {
//        defaults.set(likedArray, forKey: key)
        if let property = try? PropertyListEncoder().encode(likedArray) {
//          if likedArray.contains(where: defaults) {
//            
//          }
          defaults.set(property, forKey:key)
        } else {
          print("fuccccc")
        }
       
        UserDefaults.standard.synchronize()
        print("values \(likedArray) was added for key-\(key)")
      } else {
        defaults.removeObject(forKey: key)
      }
      
    }
    
  }
  static func clear() {
    UserDefaults.standard.removeObject(forKey: LikedKeys.likedCards.rawValue)
  }
  
}
