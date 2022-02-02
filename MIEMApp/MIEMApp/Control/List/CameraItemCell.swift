////
////  CameraItemCell.swift
////  MIEMApp
////
////  Created by Тимофей Фёдоров on 10.01.2021.
////
//
//import UIKit
//
//struct CameraCellModel {
//  let data: CameraItemModel
//  let action: (CameraItemModel) -> Void
//}
//
//final class CameraItemCell: UICollectionViewCell {
//  private let nameLabel = makeLabel()
//  
//  private lazy var width: NSLayoutConstraint = {
//      let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
//      width.isActive = true
//      return width
//  }()
//  
//  var model: CameraCellModel? {
//    didSet {
//      updateView()
//    }
//  }
//  
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    contentView.addSubview(nameLabel)
//    nameLabel.translatesAutoresizingMaskIntoConstraints = false
//    nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//    nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingPadding).isActive = true
//    nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
//    addGestureRecognizer(tapGesture)
//  }
//      
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  @objc private func onTap(sender: UITapGestureRecognizer) {
//    guard let model = model else {
//      return
//    }
//    model.action(model.data)
//  }
//  
//  override func systemLayoutSizeFitting(
//    _ targetSize: CGSize,
//    withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
//    verticalFittingPriority: UILayoutPriority
//  ) -> CGSize {
//    width.constant = bounds.size.width
//    return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
//  }
//  
//  private func updateView() {
//    guard let model = model else {
//      return
//    }
//    nameLabel.text = model.data.name
//  }
//}
//
//private func makeLabel() -> UILabel {
//  let label = UILabel()
//  label.numberOfLines = 0
//  return label
//}
//
//private let leadingPadding: CGFloat = 50
