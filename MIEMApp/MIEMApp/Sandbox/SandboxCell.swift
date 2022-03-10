//
//  SandboxCell.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 10.03.2022.
//

import UIKit
class SandboxCell: UICollectionViewCell {
  
  static let reusedId = "SandboxCell"
  
  let idLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: Brandbook.TextSize.largeNormal, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemBlue
    return label
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.sizeToFit()
    label.lineBreakMode = .byWordWrapping
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: Brandbook.TextSize.largeNormal, weight: .bold)
    label.textAlignment = NSTextAlignment.left
    label.backgroundColor = .clear
    return label
  }()
  
  let headLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let statusLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let numVacancyLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let typeLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
private let padding = Brandbook.Paddings.normal //16
private let small_padding = Brandbook.Paddings.small //4
private let light = Brandbook.Paddings.light //8
