//
//  ProjectModel.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 21.02.2021.
//

import UIKit

struct ProjectItemModel: Decodable, Equatable {
  let type: String
  let number: Int?
  let project_name: String
  let state: String
  let leader: String
  let team: [String]
  let approved: Int
  let role: String
  
  static func fetchProjects(projectsModel: [ProjectParsedModel]) -> [ProjectItemModel] {
    var projects = [ProjectItemModel]()
    for project in projectsModel {
      for projectInfo in project.data {
        projects.append(ProjectItemModel(type: projectInfo.type, number: projectInfo.number, project_name: projectInfo.project_name, state: projectInfo.state, leader: projectInfo.leader, team: projectInfo.team, approved: projectInfo.approved, role: projectInfo.role))
      }
    }
    return projects
  }
}

struct ProjectAndApplicationModel: Decodable, Equatable {
  let projects: ProjectParsedModel
  let applications: ApplicationParsedModel
}

struct ProjectStaffModel: Decodable, Equatable {
  let projects: [ProjectItemModel]
}

struct ProjectParsedModel: Decodable, Equatable {
  let data: [ProjectItemModel]
}

struct StaffParsedProjectsModel: Decodable, Equatable {
  let items: ProjectItemModel
}



