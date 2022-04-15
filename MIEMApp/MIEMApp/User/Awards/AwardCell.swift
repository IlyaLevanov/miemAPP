//
//  AwardsCell.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 04.02.2022.
//

import UIKit
import Charts
class AwardCell: UICollectionViewCell, ChartViewDelegate {
   static let reusedId = "AwardCell"
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = NSTextAlignment.justified
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 16)
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
  
  let progressBar: UIProgressView = {
    let progressView = UIProgressView(progressViewStyle: .bar)
    progressView.trackTintColor = .gray
    progressView.progressTintColor = .systemBlue
    progressView.translatesAutoresizingMaskIntoConstraints = false
    return progressView
  }()
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = NSTextAlignment.center
    label.numberOfLines = 2
    label.sizeToFit()
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
//  var chartView = HorizontalBarChartView()
//  var chartView = LineChartView()

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(awardImageView)
    addSubview(nameLabel)
    addSubview(descriptionLabel)
    addSubview(progressBar)

    
    awardImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
    awardImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    awardImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    awardImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    awardImageView.clipsToBounds = false
    awardImageView.layer.cornerRadius = 20
    
    nameLabel.topAnchor.constraint(equalTo: awardImageView.bottomAnchor, constant: light).isActive = true
    nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
//    chartView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 50)
//    chartView.center = center
//    chartView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: light).isActive = true

   
    
    descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: small_padding).isActive = true
    descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
    descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
    
    
    progressBar.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: small_padding).isActive = true
    progressBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    progressBar.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
    
    
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
  
  
//  private func setUpChart() {
//    chartView.delegate = self
////    chartView.drawBarShadowEnabled = false
////    chartView.fitBars = true
//    let chartData = BarChartDataSet(entries: [
//      BarChartDataEntry(x: 12, y: 0),
//      BarChartDataEntry(x: 10, y: 1),
//      BarChartDataEntry(x: 5, y: 2)
//    ])
//    chartData.colors = ChartColorTemplates.pastel()
//    chartView.data = BarChartData(dataSet: chartData)
//  }
  
}
private let padding = Brandbook.Paddings.normal //16
private let small_padding = Brandbook.Paddings.small //4
private let light = Brandbook.Paddings.light //8
