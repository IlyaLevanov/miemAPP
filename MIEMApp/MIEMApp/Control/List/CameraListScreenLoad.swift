////
////  CameraListScreenLoad.swift
////  MIEMApp
////
////  Created by Тимофей Фёдоров on 10.01.2021.
////
//
//import UIKit
//
//final class CameraListScreenLoad: UICollectionViewController, UICollectionViewDelegateFlowLayout, ScreenPayload {
//  private let bottomInset: Variable<CGFloat>
//  private let refreshAction: () -> Void
//  private let onPick: (CameraItemModel) -> Void
//  private let onClose: () -> Void
//  private let layout: UICollectionViewFlowLayout
//
//  var model: [RoomModel]? {
//    didSet {
//      guard !collectionView.isDragging else {
//        return
//      }
//      endRefresh()
//    }
//  }
//
//  var controller: UIViewController {
//    self
//  }
//
//  init(
//    bottomInset: Variable<CGFloat>,
//    refreshAction: @escaping () -> Void,
//    onPick: @escaping (CameraItemModel) -> Void,
//    onClose: @escaping () -> Void
//  ) {
//    self.bottomInset = bottomInset
//    self.refreshAction = refreshAction
//    self.onPick = onPick
//    self.onClose = onClose
//    layout = UICollectionViewFlowLayout()
//    super.init(collectionViewLayout: layout)
//    collectionView.contentInsetAdjustmentBehavior = .never
//    collectionView.showsVerticalScrollIndicator = false
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    collectionView.register(CameraItemCell.self, forCellWithReuseIdentifier: cameraItemCellIdentifier)
//    collectionView.register(
//      CameraListSectionHeader.self,
//      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//      withReuseIdentifier: cameraListSectionHeaderIdentifier
//    )
//    collectionView.register(
//      CameraListFirstHeader.self,
//      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//      withReuseIdentifier: cameraListFirstHeaderIdentifier
//    )
//    collectionView.backgroundColor = .white
//    collectionView.refreshControl = UIRefreshControl()
//    collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
//    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset.value, right: 0)
//  }
//
//  @objc private func refreshControlAction() {
//    refreshAction()
//  }
//
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//    if model == nil {
//      collectionView.refreshControl?.beginRefreshing()
//    }
//  }
//
//  override func viewWillLayoutSubviews() {
//    let availableWidth = collectionView.bounds.width - CGFloat(padding * (elementsInRow + 1))
//    let widthPerItem = floor(availableWidth / elementsInRow)
//    layout.estimatedItemSize = CGSize(width: widthPerItem, height: 10)
//    super.viewWillLayoutSubviews()
//  }
//
//  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//    guard let isRefreshing = collectionView.refreshControl?.isRefreshing, isRefreshing else {
//      return
//    }
//    endRefresh()
//  }
//
//  override func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return (model?.count ?? 0) + 1
//  }
//
//  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return section == 0 ? 0 : model?[section - 1].cameras.count ?? 0
//  }
//
//  override func collectionView(
//    _ collectionView: UICollectionView,
//    cellForItemAt indexPath: IndexPath
//  ) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(
//      withReuseIdentifier: cameraItemCellIdentifier,
//      for: indexPath
//    ) as! CameraItemCell
//    guard indexPath.section != 0, let model = model?[indexPath.section - 1].cameras[indexPath.item] else {
//      return cell
//    }
//    cell.model = CameraCellModel(
//      data: model,
//      action: onPick
//    )
//    return cell
//  }
//
//  func collectionView(
//    _ collectionView: UICollectionView,
//    layout collectionViewLayout: UICollectionViewLayout,
//    insetForSectionAt section: Int
//  ) -> UIEdgeInsets {
//    return section == 0
//      ? UIEdgeInsets(top: 0, left: 0, bottom: padding, right: 0)
//      : UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//  }
//
//  func collectionView(
//    _ collectionView: UICollectionView,
//    layout collectionViewLayout: UICollectionViewLayout,
//    minimumLineSpacingForSectionAt section: Int
//  ) -> CGFloat {
//    return padding
//  }
//
//  override func collectionView(
//    _ collectionView: UICollectionView,
//    viewForSupplementaryElementOfKind kind: String,
//    at indexPath: IndexPath
//  ) -> UICollectionReusableView {
//    let header = collectionView.dequeueReusableSupplementaryView(
//      ofKind: kind,
//      withReuseIdentifier: indexPath.section == 0 ? cameraListFirstHeaderIdentifier : cameraListSectionHeaderIdentifier,
//      for: indexPath
//    )
//    if indexPath.section == 0 {
//      let closeView = header as! CameraListFirstHeader
//      closeView.label.text = "Закрыть"
//      closeView.action = onClose
//      return closeView
//    } else {
//      let headerView = header as! CameraListSectionHeader
//      guard let room = model?[indexPath.section - 1].room else {
//        return headerView
//      }
//      headerView.label.text = "\(room)"
//      return headerView
//    }
//  }
//
//  func collectionView(
//    _ collectionView: UICollectionView,
//    layout collectionViewLayout: UICollectionViewLayout,
//    referenceSizeForHeaderInSection section: Int
//  ) -> CGSize {
//    let indexPath = IndexPath(row: 0, section: section)
//    let headerView = self.collectionView(
//      collectionView,
//      viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
//      at: indexPath
//    )
//    let size = headerView.systemLayoutSizeFitting(
//      CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
//      withHorizontalFittingPriority: .required,
//      verticalFittingPriority: .fittingSizeLevel
//    )
//    return size
//  }
//
//  private func endRefresh() {
//    collectionView.reloadData()
//    collectionView.refreshControl?.endRefreshing()
//  }
//}
//
//private let cameraItemCellIdentifier = "CameraItemCellIdentifier"
//private let cameraListSectionHeaderIdentifier = "CameraListSectionHeaderIdentifier"
//private let cameraListFirstHeaderIdentifier = "CameraListFirstHeaderIdentifier"
//private let padding = Brandbook.Paddings.normal
//private let elementsInRow: CGFloat = 1
