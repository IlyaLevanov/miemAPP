//
//  Brandbook.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 16.11.2020.
//

import UIKit

enum Brandbook {
  enum Colors {
    static let tint = UIColor(red: 0.30, green: 0.69, blue: 0.31, alpha: 1.00)
    static let darkTint = UIColor(red: 0.30, green: 0.4, blue: 0.31, alpha: 1.00)
    static let dimming = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.00)
    static let redColor = UIColor(red: 255/255, green: 31/255, blue: 34/255, alpha: 1.00)
    static let yellowColor = UIColor(red: 255/255, green: 135/255, blue: 0.255, alpha: 1.00)
    static let greenColor = UIColor(red: 0/255, green: 168/255, blue: 52/255, alpha: 1.00)
    static let blueColor = UIColor(red: 0/255, green: 131/255, blue: 244/255, alpha: 1.00)
    static let redColorInactive = UIColor(red: 255/255, green: 31/255, blue: 34/255, alpha: 0.50)
    static let yellowColorInactive = UIColor(red: 255/255, green: 135/255, blue: 0.255, alpha: 0.50)
    static let greenColorInactive = UIColor(red: 0/255, green: 168/255, blue: 52/255, alpha: 0.50)
    static let blueColorInactive = UIColor(red: 0/255, green: 131/255, blue: 244/255, alpha: 0.50)
    static let lightGray = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    static let grey = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.00)
    static let blueStatus = UIColor(red: 65/255, green: 129/255, blue: 230/255, alpha: 1)
    static let greenStatus = UIColor(red: 0.30, green: 0.69, blue: 0.31, alpha: 0.50)
    static let greenBackround = UIColor(red: 196/255, green: 225/255, blue: 154/255, alpha: 0.30)
    
  }
  
  enum Images {
    enum Icons {
      static let recordTabBarIcon = UIImage(imageLiteralResourceName: "RecordTabBarIcon")
      static let timetabelTabBarIcon = UIImage(imageLiteralResourceName: "TimetableTabBarIcon")
      static let menuTabBarIcon = UIImage(imageLiteralResourceName: "MenuTabBarIcon")
      static let addIcon = UIImage(imageLiteralResourceName: "AddIcon")
      static let deleteIcon = UIImage(imageLiteralResourceName: "DeleteIcon")
      static let filterIcon = UIImage(imageLiteralResourceName: "filtericon")
      static let filterIcon1 = UIImage(imageLiteralResourceName: "filtericon1")
      
      static let zoomOutIcon = UIImage(imageLiteralResourceName: "ZoomOutIcon").withRenderingMode(.alwaysTemplate)
      static let zoomInIcon = UIImage(imageLiteralResourceName: "ZoomInIcon").withRenderingMode(.alwaysTemplate)
      
      static let controlMenuIcon = UIImage(imageLiteralResourceName: "AppLogo")
      static let vmixMenuIcon = UIImage(imageLiteralResourceName: "VmixMenuIcon")
      static let aboutMenuIcon = UIImage(imageLiteralResourceName: "AboutMenuIcon")
      static let userMenuIcon = UIImage(imageLiteralResourceName: "UserMenuIcon")
      
      static let closeIcon = UIImage(imageLiteralResourceName: "CloseIcon").withRenderingMode(.alwaysTemplate)
      
      static let emailIcon = UIImage(imageLiteralResourceName: "EmailIcon").withRenderingMode(.alwaysTemplate)
      static let departIcon = UIImage(imageLiteralResourceName: "DepartmentIcon").withRenderingMode(.alwaysTemplate)
    }
    
    enum CameraTutorial {
      static let page1 = UIImage(imageLiteralResourceName: "Page1")
      static let page2 = UIImage(imageLiteralResourceName: "Page2")
      static let page3 = UIImage(imageLiteralResourceName: "Page3")
      static let page4 = UIImage(imageLiteralResourceName: "Page4")
      static let page5 = UIImage(imageLiteralResourceName: "Page5")
      static let page67 = UIImage(imageLiteralResourceName: "Page67")
    }
    
    static let appLogo = UIImage(imageLiteralResourceName: "AppLogo")
  }
  
  enum Durations {
    static let short: Double = 0.15
    static let normal: Double = 0.3
  }
  
  enum Paddings {
    static let small: CGFloat = 4
    static let light: CGFloat = 8
    static let normal: CGFloat = 16
  }
  
  enum TextSize {
    static let small: CGFloat = 12
    static let normal: CGFloat = 14
    static let largeNormal: CGFloat = 16
    static let large: CGFloat = 18
    static let enormous: CGFloat = 25
  }
  
  enum LineSize {
    static let normal: CGFloat = 2
  }
}