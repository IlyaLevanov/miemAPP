//
//  LikedViewController.swift
//  TinderStack
//
//  Created by Ilya on 16.11.2021.
//

import UIKit

private let padding = Brandbook.Paddings.normal
private let light = Brandbook.Paddings.light

class LikedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  var likedCardsData: [CardDataModel] = []
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
    }
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return likedCardsData.count
  }
  
  let noFavouriteLabel: UILabel = {
     let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.textColor = .gray
     label.text = "Вам еще не понравился ни один проект :("
     label.backgroundColor = .clear
     return label
   }()
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListLikedGalleryCell.reusedId, for: indexPath) as! ListLikedGalleryCell
    
    let currentProject = likedCardsData[indexPath.row]

    
    cell.idLabel.text = "\(currentProject.project_id)"
    cell.nameLabel.text = currentProject.project_name_rus
    cell.vacancyLbl.text = "Вакансия: "
    cell.vacancyLabel.text = currentProject.vacancy_role
    cell.backgroundColor = .white
    
    cell.nameLabel.heightAnchor.constraint(equalToConstant: LikedViewController.height(text: cell.nameLabel.text, font: cell.nameLabel.font!, width: cell.frame.width).height).isActive = true

    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let id: Int
    id = likedCardsData[indexPath.row].project_id
    let moreProjectGraph = MoreProjectsGraph(id: id)
    moreProjectGraph.setNeedsUpdate()

    
    
    
    self.modalPresentationStyle = .popover
    
    self.present(moreProjectGraph.getScreenLoad(), animated: true, completion: moreProjectGraph.getScreenLoad().reloadViews)

  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width - padding, height: 200)
  }
  
  func setupComponents() {
    self.view.addSubview(noFavouriteLabel)
    noFavouriteLabel.topAnchor.constraint(equalTo: self.navigationController?.navigationBar.bottomAnchor ?? self.view.topAnchor, constant: padding).isActive = true
    noFavouriteLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: light).isActive = true
    noFavouriteLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: light).isActive = true
    
    if likedCardsData.isEmpty {
      noFavouriteLabel.heightAnchor.constraint(equalToConstant: measureFrameForText("Hello").height).isActive = true
    }
    else {
      noFavouriteLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    self.view.backgroundColor = .white
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.register(ListLikedGalleryCell.self, forCellWithReuseIdentifier: ListLikedGalleryCell.reusedId)
    collectionView?.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(collectionView!)
    collectionView?.backgroundColor = .white
    collectionView?.topAnchor.constraint(equalTo: noFavouriteLabel.bottomAnchor).isActive = true
    collectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    collectionView?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    collectionView?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    collectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true

    
  }
  
  private func measureFrameForText(_ text: String) -> CGRect{
    let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
      let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
      return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], context: nil)
  }
  
  
}

extension LikedViewController {

  static func height(text: String?, font: UIFont, width: CGFloat) -> CGRect {
      var currentHeight: CGRect!

      let textView  = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
      textView.text = text
      textView.font = font
      textView.sizeToFit()
      currentHeight = textView.frame

      return currentHeight
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    print("here defaults")
    LikedSettings.likedCards = likedCardsData
    print(LikedSettings.likedCards)
  }

}
