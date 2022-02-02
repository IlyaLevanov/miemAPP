////
////  CrosshairView.swift
////  MIEMApp
////
////  Created by Тимофей Фёдоров on 21.01.2021.
////
//
//import UIKit
//
//final class CrosshairView: UIView {
//  override func draw(_ rect: CGRect) {
//    guard let context = UIGraphicsGetCurrentContext() else { return }
//    context.setLineWidth(Brandbook.LineSize.normal)
//    context.setStrokeColor(Brandbook.Colors.grey.cgColor)
//    context.setLineCap(.round)
//    
//    let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
//    context.beginPath()
//    context.move(to: center.offsetBy(dx: -crosshairSize, dy: 0))
//    context.addLine(to: center.offsetBy(dx: crosshairSize, dy: 0))
//    context.strokePath()
//    context.beginPath()
//    context.move(to: center.offsetBy(dx: 0, dy: -crosshairSize))
//    context.addLine(to: center.offsetBy(dx: 0, dy: crosshairSize))
//    context.strokePath()
//  }
//}
//
//private extension CGPoint {
//  func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
//    CGPoint(x: self.x + dx, y: self.y + dy)
//  }
//}
//
//private let crosshairSize: CGFloat = 10
