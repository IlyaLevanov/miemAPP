//
//  AppGraph.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 16.11.2020.
//

import UIKit

final class AppGraph {
  let screenRouter: ScreenRouter
  private let tabBarController = TabBarController()
  private let wireframe: Wireframe
  private let settings = Settings()
  
  private let authGraph: AuthGraph
  private let menuGraph: MenuGraph
  private let timetableGraph: TimetableGraph
//  private let controlGraph: ControlGraph
//  private let recordGraph: RecordGraph
  private let profileGraph: ProfileGraph
  private let projectsGraph: ProjectsGraph
  
  init() {
    screenRouter = ScreenRouter(rootController: MainController(tabController: tabBarController))
    wireframe = Wireframe(screenRouter: screenRouter)
    menuGraph = MenuGraph(
      wireframe: wireframe,
      bottomInset: tabBarController.tabBarHeight,
      menuItems: settings.menuItems,
      user: settings.user.asVariable()
    )
    timetableGraph = TimetableGraph(
      bottomInset: tabBarController.tabBarHeight,
      user: settings.user.asVariable()
    )
//    controlGraph = ControlGraph(
//      wireframe: wireframe,
//      bottomInset: tabBarController.tabBarHeight,
//      token: settings.authToken.asVariable(),
//      tutorialShown: settings.camerasTutorialShown,
//      showTutorial: wireframe.showTutorial
//    )
//    recordGraph = RecordGraph(
//      bottomInset: tabBarController.tabBarHeight,
//      user: settings.user.asVariable()
//    )
    projectsGraph = ProjectsGraph(wireframe: wireframe, bottomInset: tabBarController.tabBarHeight, user: settings.user.asVariable(), token: settings.authToken)
    profileGraph = ProfileGraph(bottomInset: tabBarController.tabBarHeight, user: settings.user.asVariable(), token: settings.authToken)
    authGraph = AuthGraph(
      wireframe: wireframe,
      token: settings.authToken,
      user: settings.user,
      onLogIn: { [
        unowned menuGraph,
        unowned timetableGraph,
        unowned profileGraph,
        unowned projectsGraph,
//        unowned controlGraph,
        unowned settings,
        unowned tabBarController,
        unowned wireframe
      ] in
        menuGraph.setNeedsUpdate()
        timetableGraph.setNeedsUpdate()
        profileGraph.setNeedsUpdate()
//        controlGraph.setNeedsUpdate()
        projectsGraph.setNeedsUpdate()
        
        tabBarController.setItems(makeTabBarItems(wireframe: wireframe, isReview: settings.user.value.isReview))
        tabBarController.selectItem(at: 0)
        wireframe.showTimetableScreen()
//        wireframe.reloadProfile()
      }
    )
    wireframe.setUpMenu(menuScreen: menuGraph.screen)
    wireframe.setScreens([
      authGraph.screen,
      timetableGraph.screen,
//      controlGraph.cameraScreen,
//      controlGraph.listScreen,
//      recordGraph.screen,
      projectsGraph.screen,
      profileGraph.screen,
      Screen(id: .aboutScreen, payload: AboutScreenLoad(onExitClicked: authGraph.logOut))
    ])
    authGraph.logIn()
  }
  
  func refreshProfile() {
    profileGraph.setNeedsUpdate()
  }
  
  func applicationWillTerminate() {
    settings.close()
  }
}
