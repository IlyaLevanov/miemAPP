//
//  Theme.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 11.04.2022.
//

import UIKit
enum Theme: Int, CaseIterable {
//    case system = 0
    case light = 0
    case dark
}
extension Theme {
    
    // Обертка для UserDefaults
//    @Persist(key: "app_theme", defaultValue: Theme.light.rawValue)
//    private static var appTheme: Int
  private static var appTheme = Int()
    
    // Сохранение темы в UserDefaults
    func save() {
        Theme.appTheme = self.rawValue
    }
    
    // Текущая тема приложения
    static var current: Theme {
        Theme(rawValue: appTheme) ?? .light
    }
  
  @available(iOS 13.0, *)
     var userInterfaceStyle: UIUserInterfaceStyle {
         switch self {
         case .light: return .light
         case .dark: return .dark
//         case .system: return themeWindow.traitCollection.userInterfaceStyle
         }
     }
     
     func setActive() {
         // Сохраняем активную тему
         save()
         
         guard #available(iOS 13.0, *) else { return }
         
         // Устанавливаем активную тему для всех окон приложения
         UIApplication.shared.windows
             .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
     }
}

//final class ThemeWindow: UIWindow {
//
//    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//
//        // Если текущая тема системная и поменяли оформление в iOS, опять меняем тему на системную.
//        // Например: Пользователь поменял светлое оформление на темное.
////        if Theme.current == .system {
////            Theme.system.setActive()
////        }
//    }
//}
//
//let themeWindow = ThemeWindow()


