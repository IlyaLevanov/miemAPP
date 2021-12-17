//
//  ProjectsScreenLoad.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 03.11.2021.
//

import UIKit
import TinyConstraints

private let padding = Brandbook.Paddings.normal

final class ProjectsScreenLoad: UIViewController, ScreenPayload, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating {
  

  private unowned let wireframe: Wireframe
  var controller: UIViewController {
    self
  }
  
  private let refreshAction: () -> Void
  private let bottomInset: Variable<CGFloat>
  var model: [ProjectsListModel]?
  var types: [String]?
  var status: [String]?
  var vacancies: Bool?
  
  var collectionView: UICollectionView?

  var isFiltering = false
  var filteredProjects = [ProjectsListModel]()
  
  init(wireframe: Wireframe, bottomInset: Variable<CGFloat>, refreshAction: @escaping () -> Void) {
    self.wireframe = wireframe
    self.bottomInset = bottomInset
    self.refreshAction = refreshAction
    super.init(nibName: nil, bundle: nil)
    
    setupComponents()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  lazy var search: UISearchController = {
      let search = UISearchController()
      search.searchBar.placeholder = "Поиск по проекту"
      search.searchResultsUpdater = self
      
      search.obscuresBackgroundDuringPresentation = false
      search.searchBar.sizeToFit()
      search.searchBar.searchBarStyle = .default
      search.searchBar.delegate = self
      return search
  }()
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if isFiltering {
      return filteredProjects.count
    }
    else {
    return model?.count ?? 0
    }
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    
    let searchText = searchController.searchBar.text!
    if !searchText.isEmpty {
      isFiltering = true
      filteredProjects.removeAll()
      for project in model! {
        
        let idToString = String(project.id)
        
        if project.head.lowercased().contains(searchText.lowercased()) || project.typeDesc.lowercased().contains(searchText.lowercased()) || project.nameRus.lowercased().contains(searchText.lowercased()) || idToString.contains(searchText) {
          filteredProjects.append(project)
        }
      }
    } else {
      isFiltering = false
      filteredProjects.removeAll()
      filteredProjects = model!
    }
    collectionView?.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isFiltering = false
    filteredProjects.removeAll()
    collectionView?.reloadData()
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width - padding, height: 350)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath)
    print(model![indexPath.row])
    let id: Int
    if isFiltering {
      id = filteredProjects[indexPath.row].id
    } else {
      id = model![indexPath.row].id
    }
    let moreVC = MoreProjectScreenLoad(id: id)
    self.modalPresentationStyle = .popover
    self.present(moreVC, animated: true, completion: nil)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListProjectsGalleryCell.reusedId, for: indexPath) as! ListProjectsGalleryCell
    var currentProject: ProjectsListModel?

        
        if isFiltering {
          
          currentProject = filteredProjects[indexPath.row]
          
        } else {
          
          currentProject = model?[indexPath.row]
          
        }
        
        cell.idLabel.text = "\(currentProject!.id)"
        cell.nameLabel.text = currentProject?.nameRus
        cell.headLabel.text = currentProject?.head
        cell.typeLabel.text = currentProject?.typeDesc
        cell.statusLabel.text = currentProject!.statusDesc
        cell.vacanciesLabel.text = ("\(currentProject!.vacancies) вакансий(я)")
        cell.managerTxt.text = "Руководитель: "
        cell.typeTxt.text = "Тип: "
    //    cell.backgroundColor = Brandbook.Colors.greenBackround
        cell.backgroundColor = .white

        
    
  
    
//        cell.nameLabel.heightAnchor.constraint(equalToConstant: measureFrameForText(currentProject?.nameRus ?? "").height + 3*padding).isActive = true
    cell.nameLabel.heightAnchor.constraint(equalToConstant: ProjectsScreenLoad.height(text: cell.nameLabel.text, font: cell.nameLabel.font!, width: cell.frame.width).height).isActive = true
    
    
    
        return cell
  }
  
  override func viewWillAppear(_ animated: Bool) {
     navigationController?.setNavigationBarHidden(false, animated: animated)
     
//     navigationItem.rightBarButtonItem = UIBarButtonItem(image: Brandbook.Images.Icons.filterIcon1, style: .plain, target: self, action: #selector(open_filter))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: Brandbook.Images.Icons.filterIcon, style: .plain, target: self, action: #selector(open_filter))
    navigationItem.searchController = search
   }
  
  @objc
  func open_filter() {
    
    let filterViewController = FilterViewController(bottomInset: self.bottomInset, types: self.types ?? [], status: self.status ?? [], parentVC: self)
//    self.modalPresentationStyle = .overCurrentContext
    self.modalPresentationStyle = .popover
    self.present(filterViewController, animated: false, completion: nil)
  }
  
  func filter(type: String, status: String, vacancy: Bool) {
    print("fffilter")
    print(type)
    print(status)
    print(vacancy)
    
  }
  
  
  

  func setupComponents() {
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    self.view.backgroundColor = Brandbook.Colors.grey
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.register(ListProjectsGalleryCell.self, forCellWithReuseIdentifier: ListProjectsGalleryCell.reusedId)
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


extension ProjectsScreenLoad {

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
