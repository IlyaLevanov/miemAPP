//
//  SandboxScreenLoad.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 10.03.2022.
//

import Foundation
import UIKit
class SandboxSreenLoad: UIViewController, ScreenPayload, UICollectionViewDelegate, UICollectionViewDataSource {
  
  private unowned let wireframe: Wireframe
  var controller: UIViewController {
    self
  }
  var modelSandbox: [ListProjectInfoModel]?
  var collectionView: UICollectionView?
  var isFiltering = false
  var filteredProjects = [ListProjectInfoModel]()
  
  lazy var search: UISearchController = {
      let search = UISearchController()
      search.searchBar.placeholder = "Поиск"
//      search.searchResultsUpdater = self
      
//      search.obscuresBackgroundDuringPresentation = false
      search.searchBar.sizeToFit()
      search.searchBar.searchBarStyle = .default


//      search.searchBar.delegate = self
      return search
  }()
  
  private let bottomInset: Variable<CGFloat>
  init(wireframe: Wireframe, bottomInset: Variable<CGFloat>) {
    self.wireframe = wireframe
    self.bottomInset = bottomInset

    super.init(nibName: nil, bundle: nil)
    setUpComponent()
    

  }
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  func setUpComponent() {
    print("model=\(modelSandbox)")
    self.view.backgroundColor = .red
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    self.view.backgroundColor = Brandbook.Colors.grey
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.register(SandboxCell.self, forCellWithReuseIdentifier: SandboxCell.reusedId)
    collectionView?.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(collectionView!)
    collectionView?.backgroundColor = .white
    collectionView?.topAnchor.constraint(equalTo: self.navigationController?.navigationBar.bottomAnchor ?? self.view.topAnchor).isActive = true
    collectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    collectionView?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    collectionView?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    collectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if isFiltering {
      return filteredProjects.count
    }
    else {
    return modelSandbox?.count ?? 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width - padding, height: 350)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let id: Int
    let nameRus: String
    let vacancyData: Int
    let status: String
  
    if isFiltering {
      id = Int(filteredProjects[indexPath.row].number) ?? 0
      nameRus = filteredProjects[indexPath.row].nameRus
      vacancyData = filteredProjects[indexPath.row].vacancies
      status = filteredProjects[indexPath.row].statusDesc
    } else {
      id = Int(modelSandbox![indexPath.row].number) ?? 0
      nameRus = modelSandbox![indexPath.row].nameRus
      vacancyData = modelSandbox![indexPath.row].vacancies
      status = modelSandbox![indexPath.row].statusDesc
    }
    
    let moreProjectGraph = MoreProjectsGraph(id: id)
    moreProjectGraph.setNeedsUpdate()

  
    self.modalPresentationStyle = .popover
    
    self.present(moreProjectGraph.getScreenLoad(), animated: true, completion: moreProjectGraph.getScreenLoad().reloadViews)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SandboxCell.reusedId, for: indexPath) as! SandboxCell

    cell.idLabel.text = modelSandbox?[indexPath.row].number
    cell.nameLabel.text = modelSandbox?[indexPath.row].nameRus
    cell.headLabel.text = modelSandbox?[indexPath.row].head
    cell.statusLabel.text = modelSandbox?[indexPath.row].statusDesc
    cell.numVacancyLabel.text = ("\(String(describing: modelSandbox?[indexPath.row].vacancies))")
    cell.typeLabel.text = modelSandbox?[indexPath.row].typeDesc
        return cell
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isFiltering = false
    filteredProjects.removeAll()
    collectionView?.reloadData()
  }
  
}
private let padding = Brandbook.Paddings.normal
