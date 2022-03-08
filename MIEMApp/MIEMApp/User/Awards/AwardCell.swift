//
//  AwardsCell.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 04.02.2022.
//

import UIKit
class AwardCell: UICollectionViewCell {
   static let reusedId = "AwardCell"
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = NSTextAlignment.justified
    label.numberOfLines = 0
    label.sizeToFit()
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let awardImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.backgroundColor = .clear
      imageView.contentMode = .scaleAspectFill
      imageView.layer.cornerRadius = 70
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
  }()
  
  let progressLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = NSTextAlignment.justified
    label.numberOfLines = 0
    label.sizeToFit()
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = NSTextAlignment.justified
    label.numberOfLines = 0
    label.sizeToFit()
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(nameLabel)
    addSubview(awardImageView)
    addSubview(progressLabel)
    addSubview(descriptionLabel)
    
    
    nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: light).isActive = true
    nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
    nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
    
    awardImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding).isActive = true
    awardImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    awardImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    awardImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    awardImageView.clipsToBounds = false
    awardImageView.layer.cornerRadius = 20
    
    progressLabel.topAnchor.constraint(equalTo: awardImageView.bottomAnchor, constant: small_padding).isActive = true
    progressLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
    
    descriptionLabel.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: small_padding).isActive = true
    descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
    
    
    clipsToBounds = false
    backgroundColor = Brandbook.Colors.lightGray
    layer.cornerRadius = 5
    layer.shadowRadius = 5
    layer.shadowOffset = CGSize(width: 3, height: 3)
    layer.shadowOpacity = 0.2
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
private let padding = Brandbook.Paddings.normal //16
private let small_padding = Brandbook.Paddings.small //4
private let light = Brandbook.Paddings.light //8
