//
//  ApplicationModel.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 21.02.2021.
//

import UIKit
struct ApplicationParsedModel: Decodable, Equatable {
  let data: [ApplicationItemModel]
}

struct ApplicationItemModel: Decodable, Equatable {
  let name: String
  let email: [String]
  let studentComment: String
  let leaderComment: String
  let group: String
  let role: String
  let leader: String
  let project_name: String
  
  static func fetchProjects(modelApplication: [ApplicationParsedModel]) -> [ApplicationItemModel] {
    var applications = [ApplicationItemModel]()
    for application in modelApplication {
      for applicationInfo in application.data {
        applications.append(ApplicationItemModel(name: applicationInfo.name, email: applicationInfo.email, studentComment: applicationInfo.studentComment, leaderComment: applicationInfo.leaderComment, group: applicationInfo.group, role: applicationInfo.role, leader: applicationInfo.leader, project_name: applicationInfo.project_name))
      }
    }
    return applications
  }
}
