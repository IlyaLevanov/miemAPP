//
//  TouchGestureRecognizer.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 20.01.2021.
//

import UIKit.UIGestureRecognizerSubclass

final class TouchGestureRecognizer: UIGestureRecognizer {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    super.touchesBegan(touches, with: event)
    guard touches.count == 1 else {
      state = .failed
      return
    }
    state = .began
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
    super.touchesEnded(touches, with: event)
    state = .ended
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
    super.touchesMoved(touches, with: event)
    guard touches.count == 1 else {
      state = .failed
      return
    }
    guard state != .failed else {
      return
    }
    state = .changed
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
    super.touchesCancelled(touches, with: event)
    state = .failed
  }
}
