//
//  ContentView.swift
//  1
//
//  Created by Melanie Kofman on 07.11.2021.
//  Copyright © 2021 Melanie Kofman. All rights reserved.
//

import TinyConstraints

import SwiftUI

final class CustomController: UIViewController {
    
    let labelFont = UIFont.systemFont(ofSize: 16)
    let labelFont1 = UIFont.systemFont(ofSize: 10)
    let labelText = "jfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksj"
    
    let labelText1 = "jfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsdkjfsdkjhfskjdhfsjkdfhskjdhfskdjfhskjhfsdjkhfksjjfhsdkfhsd"
    
    lazy var constrainerViewFrame: CGRect = DynamicLabelSize.height(text: labelText, font: labelFont , width: view.frame.width)

    lazy var constrainerViewFrame1: CGRect = DynamicLabelSize.height(text: labelText1, font: labelFont1 , width: view.frame.width)
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var containerView1: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.font = labelFont
        label.text = labelText
        label.numberOfLines = 0
        return label
    }()
    
    lazy var label1: UILabel = {
       let label = UILabel()
        label.font = labelFont1
        label.text = labelText1
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        view.addSubview(label)
        
        view.addSubview(containerView1)
        view.addSubview(label1)
        
        
        containerView.edgesToSuperview(excluding: .bottom, insets: .top(36), usingSafeArea: true)
        containerView.height(constrainerViewFrame.height)

        containerView1.edgesToSuperview(excluding: .bottom, insets: .top(constrainerViewFrame.height + 60), usingSafeArea: true)
        containerView1.height(constrainerViewFrame1.height)
        
        label.edges(to: containerView)
        label1.edges(to: containerView1)
    }
}
