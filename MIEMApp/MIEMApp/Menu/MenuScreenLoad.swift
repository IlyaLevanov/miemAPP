//
//  MenuScreen.swift
//  MIEMApp
//
//  Created by Тимофей Фёдоров on 08.01.2021.
//

import UIKit

final class MenuScreenLoad: UICollectionViewController, UICollectionViewDelegateFlowLayout, ScreenPayload {
  private unowned let wireframe: Wireframe
  private let bottomInset: Variable<CGFloat>
  private let maxLabelHeight: CGFloat
  
  var model: [MenuItemKind] {
    didSet {
      guard oldValue != model else {
        return
      }
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  var controller: UIViewController {
    self
  }
  
  
  
  init(wireframe: Wireframe, bottomInset: Variable<CGFloat>, model: [MenuItemKind]) {
    self.wireframe = wireframe
    self.bottomInset = bottomInset
    self.model = model
    self.maxLabelHeight = MenuItemCell.maxLabelHeight()
    let layout = UICollectionViewFlowLayout()
    super.init(collectionViewLayout: layout)
    collectionView.bounces = false
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.showsVerticalScrollIndicator = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: menuItemCellIdentifier)
    collectionView.backgroundColor = .white
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset.value, right: 0)
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.count
  }
  
  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: menuItemCellIdentifier,
      for: indexPath
    ) as! MenuItemCell
    cell.model = model[indexPath.item].makeModel(wireframe: wireframe)
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let availableWidth = collectionView.bounds.width - CGFloat(padding * (elementsInRow + 1))
    let widthPerItem = floor(availableWidth / elementsInRow)
    return CGSize(width: widthPerItem, height: widthPerItem + maxLabelHeight)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return padding
  }
}

extension MenuScreenLoad: ScrollOffsetProviding {
  var scrollOffset: CGPoint {
    collectionView.contentOffset
  }
}

private extension MenuItemKind {
  func makeModel(wireframe: Wireframe) -> MenuItemModel {
    switch self {
    case .vmix:
      return MenuItemModel(
        icon: Brandbook.Images.Icons.vmixMenuIcon,
        title: "VMix",
        action: {
          wireframe.showVmixScreen()
        }
      )
    case .control:
      return MenuItemModel(
        icon: Brandbook.Images.Icons.controlMenuIcon,
        title: "Управление камерами",
        action: {
          wireframe.showControlScreen()
        }
      )
    case .about:
      return MenuItemModel(
        icon: Brandbook.Images.Icons.aboutMenuIcon,
        title: "О приложении",
        action: {
          wireframe.pushAboutScreen()
        }
      )
    case .profile:
      return MenuItemModel(
        icon: Brandbook.Images.Icons.userMenuIcon,
        title: "Профиль",
        action: {
          wireframe.showProfileScreen()
        }
      )
    case .projects:
      return MenuItemModel(
        icon: Brandbook.Images.Icons.userMenuIcon,
        title: "Проекты",
        action: {
          wireframe.pushProjectListScreen()
//          wireframe.showProjectsScreen()
      })
    }
  }
  
}

private let menuItemCellIdentifier = "MenuItemCellIdentifier"
private let padding = Brandbook.Paddings.normal
private let elementsInRow: CGFloat = 4