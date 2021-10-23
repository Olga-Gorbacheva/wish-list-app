//
//  ViewController.swift
//  WishListApp
//
//  Created by Ольга Горбачева on 23.10.21.
//

import UIKit

class StartViewController: UIViewController {
    
    let startButton = UIButton()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            startButton.topAnchor.constraint(equalTo: view.topAnchor),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 650)
            
        ])
        
        startButton.setTitle("Start!", for: .normal)
        //startButton.clipsToBounds = true
        //startButton.contentMode = .scaleAspectFill
        //startButton.setBackgroundImage(UIImage(named: "startbutton"), for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        startButton.setTitleColor(.gray, for: .normal)
        
        // startButton.layer.cornerRadius = 3
//        startButton.layer.borderWidth = 1
//        startButton.layer.borderColor = UIColor.red.cgColor
        
        let backGroundImage = UIImageView(frame: UIScreen.main.bounds)
        backGroundImage.image = UIImage(named: "mainpicture")
        backGroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backGroundImage, at: 0)
        
        backGroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backGroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backGroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
        
    }


}

