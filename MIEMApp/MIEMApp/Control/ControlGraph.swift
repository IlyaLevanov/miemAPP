//
//  ControlGraph.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 24.01.2021.
//

import UIKit

final class ControlGraph {
  let cameraScreen: Screen
  let listScreen: Screen
  private let cameraListGraph: CameraListGraph
  private let cameraScreenLoad: CameraScreenLoad
  
  init(
    wireframe: Wireframe,
    bottomInset: Variable<CGFloat>,
    token: Variable<String>,
    tutorialShown: Property<Bool>,
    showTutorial: @escaping (TutorialViewModel, @escaping () -> Void) -> Void
  ) {
    cameraScreenLoad = CameraScreenLoad(
      bottomInset: bottomInset,
      token: token,
      tutorialShown: tutorialShown,
      showTutorial: showTutorial,
      openList: { [unowned wireframe] in
        wireframe.openCamerasList()
      }
    )
    cameraListGraph = CameraListGraph(
      bottomInset: bottomInset,
      token: token,
      onPick: { [unowned wireframe, cameraScreenLoad] in
        cameraScreenLoad.onPick(camera: $0)
        wireframe.closeCamerasList()
      },
      onClose: { [unowned wireframe] in
        wireframe.closeCamerasList()
      }
    )
    cameraScreen = Screen(id: .cameraScreen, payload: cameraScreenLoad)
    listScreen = cameraListGraph.screen
  }
  
  func setNeedsUpdate() {
    cameraListGraph.setNeedsUpdate()
  }
}
