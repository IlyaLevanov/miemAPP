//
//  ProfileDataSource.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 12.03.2021.
//

import UIKit
import Alamofire

private struct ProfileResponse: Decodable {
  let data: [ProfileItemModel]
}

private struct ApplicationResponse: Decodable {
  let data: ProjectAndApplicationModel
}

private struct ProjectStaffResponse: Decodable {
  let data: ProjectStaffModel
}

private struct ApplicationStaffResponse: Decodable {
  let data: ApplicationParsedModel
}

final class ProfileDataSource {
  private let session = makeDefaultSession()
  private let user: Variable<User>
  private let token: Property<String>
  
  private var onUpdate: (([ProfileParsedModel]) -> Void)?
  private var onUpdateProject: (([ProjectParsedModel]) -> Void)?
  private var onUpdateApplication: (([ApplicationParsedModel]) -> Void)?
  private var isUpdating: Bool = false
  
  init(user: Variable<User>, token: Property<String>) {
    self.user = user
    self.token = token
//    self.setNeedsUpdate()
  }
  
  func setOnUpdate(onUpdate: @escaping ([ProfileParsedModel]) -> Void) {
    self.onUpdate = onUpdate
    
  }
  
  func setOnUpdateProject(onUpdateProject: @escaping ([ProjectParsedModel]) -> Void) {
    self.onUpdateProject = onUpdateProject
  }
  
  func setOnUpdateApplication(onUpdateApplication: @escaping ([ApplicationParsedModel]) -> Void) {
    self.onUpdateApplication = onUpdateApplication
  }
  
  func setNeedsUpdate() {
    guard !isUpdating else {
      return
    }
    update()
  }
  
  private func update() {
    isUpdating = true
    if (user.value.student) {
      
      profileInfoRequestStudent()
      applicationRequestStudent()
  
        
      }
    
    else {
      profileInfoRequestStaff()
      ProjectsStaff()
      ApplicationsStaff()
      
    }
    self.isUpdating = false
  }
  
  private func profileInfoRequestStudent() {
    
    let headers: HTTPHeaders = ["x-auth-token": self.token.value]
          session.request("https://devcabinet.miem.vmnet.top/api/student_profile", method: .get, headers: headers).response { response in
            print("profile debig print")
            debugPrint(response)
            
            guard let data = response.data, let parsedResponse = try? JSONDecoder().decode(ProfileResponse.self, from: data) else {

              return
            }
           
            var profileModel = [ProfileParsedModel]()
            var currentInfo: ProfileInfo
            currentInfo = parsedResponse.data[0].main
            profileModel.append(ProfileParsedModel(status: "Студент", items: currentInfo))
            self.onUpdate?(profileModel)
          }
            
  }
  
  private func applicationRequestStudent() {
    
    let headers: HTTPHeaders = ["x-auth-token": self.token.value]
    let url = "https://devcabinet.miem.vmnet.top/api/student/projects/and/applications/my"
    session.request(url, method: .get, headers: headers).response {
      print("debugg")
      debugPrint($0)
    }
    session.request(url, method: .get, headers: headers).response { response in
      guard let data = response.data, let parsedResponse = try? JSONDecoder().decode(ApplicationResponse.self, from: data) else {
                return
              }
     
      var projectsModel = [ProjectParsedModel]()
      var projectData = [ProjectItemModel]()
      for i in parsedResponse.data.projects.data {
        projectData.append(i)
      }
      projectsModel.append(ProjectParsedModel(data: projectData))
      self.onUpdateProject?(projectsModel)

      //applications
      var applicatoionsModel = [ApplicationParsedModel]()
      var applicationData = [ApplicationItemModel]()
      for info in parsedResponse.data.applications.data {
        applicationData.append(info)
      }
      applicatoionsModel.append(ApplicationParsedModel(data: applicationData))
      self.onUpdateApplication?(applicatoionsModel)
      
    
    }
  }

  
  private func profileInfoRequestStaff() {
    let headers: HTTPHeaders = ["x-auth-token": self.token.value]
    session.request("https://devcabinet.miem.vmnet.top/api/teacher_profile", method: .get, headers: headers).response
      { response in
        guard let data = response.data, let parsedResponse = try? JSONDecoder().decode(ProfileResponse.self, from: data) else {

          return
        }
        var profileModel = [ProfileParsedModel]()
        var currentInfo: ProfileInfo
        currentInfo = parsedResponse.data[0].main
        profileModel.append(ProfileParsedModel(status: "Руководитель", items: currentInfo))
        print(profileModel)
        self.onUpdate?(profileModel)
      }


    }
  
  private func ProjectsStaff() {
  let headers: HTTPHeaders = ["x-auth-token": self.token.value]
    session.request("https://devcabinet.miem.vmnet.top/api/leader/projects/my", method: .get, headers: headers).response { response in
      guard let data = response.data, let parsedResponse = try? JSONDecoder().decode(ProjectStaffResponse.self, from: data) else {
        return
      }
      
      var projectModel = [ProjectParsedModel]()
      var currentInfo = [ProjectItemModel]()
      for i in parsedResponse.data.projects {
        currentInfo.append(i)
        
      }
    
      projectModel.append(ProjectParsedModel(data: currentInfo))
      self.onUpdateProject?(projectModel)

    }
    
    }
  
  private func ApplicationsStaff() {
    let headers: HTTPHeaders = ["x-auth-token": self.token.value]
    session.request("https://devcabinet.miem.vmnet.top/api/leader/application/my", method: .get, headers: headers).response {
      response in
      guard let data = response.data, let parsedResponse = try? JSONDecoder().decode(ApplicationStaffResponse.self, from: data) else {
        return
      }
       var applicatoionsModel = [ApplicationParsedModel]()
       var applicationData = [ApplicationItemModel]()
      for info in parsedResponse.data.data {
             applicationData.append(info)
           }
      
      applicatoionsModel.append(ApplicationParsedModel(data: applicationData))
      self.onUpdateApplication?(applicatoionsModel)
    }
  }
  
}
