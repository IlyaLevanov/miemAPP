//
//  LikedViewController.swift
//  TinderStack
//
//  Created by Ilya on 16.11.2021.
//

import UIKit

class LikedViewController: UIViewController{

    var likedCardsData: [CardDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        print(likedCardsData)
    }
    
}
