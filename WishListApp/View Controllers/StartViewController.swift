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
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        startButton.setTitleColor(.gray, for: .normal)
        
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
       
        startButton.addTarget(self, action: #selector(buttonStart), for: .touchUpInside)
        
    }
    
    @objc func buttonStart(sender: UIButton!) {
        
        
        let tabBarVC = UITabBarController()
        
        
        let mainScreen = UINavigationController(rootViewController: HomeViewController())
        let recipeScreen = UINavigationController(rootViewController: RecipeViewController())
        let counterCaloriesScreen = UINavigationController(rootViewController: CounterViewController())
        
        mainScreen.title = "Counter"
        recipeScreen.title = "Home"
        counterCaloriesScreen.title = "Recipes"
        
        
        tabBarVC.setViewControllers([mainScreen, recipeScreen, counterCaloriesScreen ], animated: false)
        
//        guard let items = tabBarVC.tabBar.items else {
//            return
//        }
//        
//        let images = ["star","house","heart"]
//     
//        
//        for x in 0..<items.count {
//            items[x].image = UIImage(systemName: images [x])
//        }
//            
            
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
         
    }


}

