////
////  MoreProjectGraph.swift
////  MIEMApp
////
////  Created by Melanie Kofman on 05.12.2021.
////
//
//import UIKit
//
//
//
//final class MoreProjectsGraph {
//  let screen: Screen
//  private let moreProjectLoad: MoreProjectScreenLoad
//  private let moreProjectDataSource: MoreProjectDataSource
//
//
//    init(id: Int,
//         nameRus: String,
//         vacancyData: [String],
//         team: [String],
//         status: String,
//         refreshAction: @escaping () -> Void,
//      bottomInset: Variable<CGFloat>,
//      user: Variable<User>,
//      token: Property<String>
//  ) {
//    moreProjectDataSource = MoreProjectDataSource(user: user, token: token, id: id)
//
//    moreProjectLoad = MoreProjectScreenLoad(id: id, nameRus: nameRus, vacancyData: vacancyData, team: team, status: status, bottomInset: bottomInset,  refreshAction: moreProjectDataSource.setNeedsUpdate)
//      screen = Screen(id: .projectsScreen, payload: moreProjectLoad as! ScreenPayload)
//    moreProjectDataSource.setOnUpdate { [unowned self] in
//      self.moreProjectLoad.model = $0
//    }
//
//  }
//
//  func setNeedsUpdate() {
//    moreProjectDataSource.setNeedsUpdate()
//  }
//}
