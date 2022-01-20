//
//  VacancyView.swift
//  projectDescription
//
//  Created by Ilya on 20.01.2022.
//

import UIKit
import Foundation


//class VacancyView: UIView {
//    
//    var mandatorySkills = [""]
//    var desirableSkills = [""]
//
//    var vacancyNameLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .systemBlue
//        label.textColor = .white
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 18)
//        label.numberOfLines = 1
//        return label
//    }()
//    
//    var mandatoryLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Обязательно:"
//        label.backgroundColor = .white
//        label.textColor = .systemBlue
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.numberOfLines = 1
//        return label
//    }()
//    
//    var desirableLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Желательно:"
//        label.backgroundColor = .white
//        label.textColor = .systemBlue
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.numberOfLines = 1
//        return label
//    }()
//    
//    var mandatoryStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.backgroundColor = .white
//        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 3
//        return stackView
//    }()
//    
//    var desirableStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.backgroundColor = .white
//        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 3
//        return stackView
//    }()
//    
//    var registerButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .systemBlue
//        button.layer.cornerRadius = 10
//        button.setTitle("Записаться", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.contentHorizontalAlignment = .center
////        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchDown)
//        return button
//    }()
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    init(mandatorySkills: [String], desirableSkills: [String]) {
//        super.init(frame: CGRect.zero)
//        self.mandatorySkills = mandatorySkills
//        self.desirableSkills = desirableSkills
//        configureViews()
//        configureConstraints()
//    }
//    
//    func configureViews() {
//        self.addSubview(vacancyNameLabel)
//        self.addSubview(mandatoryLabel)
//        self.addSubview(mandatoryStackView)
//        self.addSubview(desirableLabel)
//        self.addSubview(desirableStackView)
//        self.addSubview(registerButton)
//    }
//
//    func configureConstraints() {
//        self.translatesAutoresizingMaskIntoConstraints = false
//        configureVacancyNameLabel()
//        configureMandatoryLabel()
//        configureMandatoryStackView()
//        configureDesirableLabel()
//        configureDesirableStackView()
//        configureRegisterButton()
//        
//    }
//    
//    func configureVacancyNameLabel() {
//        vacancyNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        vacancyNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        vacancyNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        vacancyNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
//    }
//    
//    func configureMandatoryLabel() {
//        mandatoryLabel.translatesAutoresizingMaskIntoConstraints = false
//        mandatoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        mandatoryLabel.topAnchor.constraint(equalTo: vacancyNameLabel.bottomAnchor, constant: 15).isActive = true
//        mandatoryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
//    }
//    
//    func configureMandatoryStackView() {
//        for mandatorySkill in mandatorySkills {
//            let mandatorySkillLabel = UILabel()
//            mandatoryStackView.addArrangedSubview(mandatorySkillLabel)
//            mandatorySkillLabel.backgroundColor = .white
//            mandatorySkillLabel.numberOfLines = 0
//            mandatorySkillLabel.text = "-\(mandatorySkill)"
//            mandatorySkillLabel.textColor = .black
//            mandatorySkillLabel.textAlignment = .left
//            mandatorySkillLabel.font = UIFont.boldSystemFont(ofSize: 14)
//        }
//        
//        mandatoryStackView.translatesAutoresizingMaskIntoConstraints = false
//        mandatoryStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        mandatoryStackView.topAnchor.constraint(equalTo: mandatoryLabel.bottomAnchor, constant: 5).isActive = true
//        mandatoryStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
//    }
//    
//    func configureDesirableLabel() {
//        desirableLabel.translatesAutoresizingMaskIntoConstraints = false
//        desirableLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        desirableLabel.topAnchor.constraint(equalTo: mandatoryStackView.bottomAnchor, constant: 5).isActive = true
//        desirableLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
//    }
//    
//    func configureDesirableStackView() {
//        for desirableSkill in desirableSkills {
//            let desirableSkillLabel = UILabel()
//            desirableStackView.addArrangedSubview(desirableSkillLabel)
//            desirableSkillLabel.backgroundColor = .white
//            desirableSkillLabel.numberOfLines = 0
//            desirableSkillLabel.text = "-\(desirableSkill)"
//            desirableSkillLabel.textColor = .black
//            desirableSkillLabel.textAlignment = .left
//            desirableSkillLabel.font = UIFont.boldSystemFont(ofSize: 14)
//        }
//        
//        desirableStackView.translatesAutoresizingMaskIntoConstraints = false
//        desirableStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        desirableStackView.topAnchor.constraint(equalTo: desirableLabel.bottomAnchor, constant: 5).isActive = true
//        desirableStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
//    }
//    
//    func configureRegisterButton() {
//        registerButton.translatesAutoresizingMaskIntoConstraints = false
//        registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        registerButton.topAnchor.constraint(equalTo: desirableStackView.bottomAnchor, constant: 15).isActive = true
//        registerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
//        registerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
//    }
//
//    //есть заглушка
//    @objc func didTapRegisterButton(sender : AnyObject) {
//        if let url = URL(string: "http://www.google.com"){
//            UIApplication.shared.open(url) }
//    }
//        
//}
