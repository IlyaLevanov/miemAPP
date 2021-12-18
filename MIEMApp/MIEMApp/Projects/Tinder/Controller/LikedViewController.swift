//
//  LikedViewController.swift
//  TinderStack
//
//  Created by Ilya on 16.11.2021.
//

import UIKit

private let padding = Brandbook.Paddings.normal

class LikedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var likedCardsData: [CardDataModel] = []
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        print(likedCardsData)
        print("kek")
        setupComponents()
//      for project in likedCardsData {
//        print(project)
//      }
      print(likedCardsData[0])
    }
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return likedCardsData.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListLikedGalleryCell.reusedId, for: indexPath) as! ListLikedGalleryCell
    
    let currentProject = likedCardsData[indexPath.row]
    
    cell.idLabel.text = "\(currentProject.project_id)"
    cell.nameLabel.text = currentProject.project_name_rus
    cell.vacancyLbl.text = "Вакансия: "
    cell.vacancyLabel.text = currentProject.vacancy_role
    cell.requirementsTxt.text = "Требования: "
  
//    cell.backgroundColor = Brandbook.Colors.greenBackround
    cell.backgroundColor = .white
    
    
//        cell.nameLabel.heightAnchor.constraint(equalToConstant: measureFrameForText(currentProject?.nameRus ?? "").height + 3*padding).isActive = true
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width - padding, height: 350)
  }
  
  func setupComponents() {
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    self.view.backgroundColor = Brandbook.Colors.grey
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.register(ListLikedGalleryCell.self, forCellWithReuseIdentifier: ListLikedGalleryCell.reusedId)
    collectionView?.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(collectionView!)
    collectionView?.backgroundColor = .white
    collectionView?.topAnchor.constraint(equalTo: self.navigationController?.navigationBar.bottomAnchor ?? self.view.topAnchor).isActive = true
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

      var textView  = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
      textView.text = text
      textView.font = font
      textView.sizeToFit()
      currentHeight = textView.frame

      return currentHeight
  }

}
