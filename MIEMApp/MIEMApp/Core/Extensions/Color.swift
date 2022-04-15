////
////  Color.swift
////  MIEMApp
////
////  Created by Melanie Kofman on 11.04.2022.
////
//
//import UIKit
//extension UIColor {
//
//    static func color(light: UIColor, dark: UIColor) -> UIColor {
//        if #available(iOS 13, *) {
//            return UIColor.init { traitCollection in
//                return traitCollection.userInterfaceStyle == .dark ? dark : light
//            }
//        } else {
//            return light
//        }
//    }
//}
