////
////  VideoView.swift
////  MIEMApp
////
////  Created by Тимофей Фёдоров on 20.01.2021.
////
//
//import UIKit
//import WebKit
//
//protocol TouchHandler {
//  func touched(_ point: CGPoint)
//  func released()
//}
//
//final class VideoView: WKWebView {
//  private let videoStartQueue = OperationQueue()
//  private let socketBloackingOperation = Operation()
//  private var touchHandler: TouchHandler?
//  private var onVideoResult: ((Bool) -> Void)?
//  private var operation: Operation?
//  
//  init() {
//    let webConfiguration = WKWebViewConfiguration()
//    webConfiguration.allowsInlineMediaPlayback = true
//    super.init(frame: .zero, configuration: webConfiguration)
//    webConfiguration.userContentController.add(self, name: onSocketConnectedHandler)
//    webConfiguration.userContentController.add(self, name: onVideoResultHandler)
//    load()
//    scrollView.delegate = self
//    scrollView.isScrollEnabled = false
//    let touchRecognizer = TouchGestureRecognizer(target: self, action: #selector(onTouch(_:)))
//    touchRecognizer.delegate = self
//    addGestureRecognizer(touchRecognizer)
//  }
//  
//  func setTouchHandler(_ touchHandler: TouchHandler) {
//    self.touchHandler = touchHandler
//  }
//  
//  @objc private func onTouch(_ recogizer: TouchGestureRecognizer) {
//    if recogizer.state == .ended || recogizer.state == .failed {
//      touchHandler?.released()
//    } else {
//      let point = recogizer.location(in: self)
//      touchHandler?.touched(
//        CGPoint(
//          x: (point.x / (bounds.width / 2) - 1).clamp(min: -1, max: 1),
//          y: (1 - point.y / (bounds.height / 2)).clamp(min: -1, max: 1)
//        )
//      )
//    }
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  func start(url: URL, onVideoResult: @escaping (Bool) -> Void) {
//    operation?.cancel()
//    let op = BlockOperation {
//      self.onVideoResult = onVideoResult
//      DispatchQueue.main.async {
//        self.evaluateJavaScript("start(\"\(url.absoluteString)\");", completionHandler: nil)
//      }
//    }
//    op.addDependency(socketBloackingOperation)
//    operation = op
//    videoStartQueue.addOperation(op)
//  }
//  
//  func stop() {
//    evaluateJavaScript("stop();", completionHandler: nil)
//  }
//  
//  func load() {
//    if let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "VideoPlayerResource") {
//      loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
//    }
//  }
//}
//
//extension VideoView: WKScriptMessageHandler {
//  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//    switch message.name {
//    case onSocketConnectedHandler:
//      if !socketBloackingOperation.isFinished {
//        socketBloackingOperation.start()
//      }
//    case onVideoResultHandler:
//      if let body = message.body as? [String: Any],
//         let success = body["started"] as? Bool {
//        onVideoResult?(success)
//      }
//    default:
//      break
//    }
//  }
//}
//
//extension VideoView: UIScrollViewDelegate {
//  func scrollViewDidZoom(_ scrollView: UIScrollView) {
//    scrollView.contentOffset = CGPoint(
//      x: (scrollView.contentSize.width - bounds.width) / 2,
//      y: (scrollView.contentSize.height - bounds.height) / 2
//    )
//  }
//  
//  func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//    if scale > maxZoomScale {
//      scrollView.setZoomScale(maxZoomScale, animated: true)
//    }
//  }
//}
//
//extension VideoView: UIGestureRecognizerDelegate {
//  func gestureRecognizer(
//    _ gestureRecognizer: UIGestureRecognizer,
//    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
//  ) -> Bool {
//    true
//  }
//}
//
//private let onSocketConnectedHandler = "onSocketConnectedHandler"
//private let onVideoResultHandler = "onVideoResultHandler"
//private let maxZoomScale: CGFloat = 0.9
