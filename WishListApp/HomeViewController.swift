//
//  HomeViewController.swift
//  WishListApp
//
//  Created by Ольга Горбачева on 2.11.21.
//

import UIKit
import Lottie
import CoreData


class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentTasks: [Task] = []
    var completedTasks: [Task] = []
    private let cell = "task"
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//
        let jsonName = "bee"
        let animation = Animation.named(jsonName)
        let animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: 100, y: 350, width: 200, height: 200)
        view.addSubview(animationView)
        animationView.play(fromProgress: 0, toProgress: 1, loopMode: LottieLoopMode.repeat(1000), completion: nil)

        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setUpNavigationItem()
    }
    
    private func setupTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell)
        tableView.rowHeight = 80
        view.backgroundColor = .systemGray6
       
    }
    
    private func setUpNavigationItem () {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTask))
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
     
    }
    
    @objc private func newTask() {
       let newTaskVc = NewTaskViewController()
        newTaskVc.modalPresentationStyle = .fullScreen
        navigationController?.present(newTaskVc, animated: true)
    }
    
    private func fetchData() {
        StorageManager.shared.fetchData { [unowned self] result in
            switch result {
            case .success(let tasks):
                self.currentTasks = tasks.filter({ $0.done == false })
                self.completedTasks = tasks.filter({ $0.done == true })
                tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentTasks.count : completedTasks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Current Task" : "Done Task"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath)
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        content.secondaryText = task.note
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newTaskVc = NewTaskViewController()
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        newTaskVc.isEdit = true
        newTaskVc.task = task
        newTaskVc.modalPresentationStyle = .fullScreen
        newTaskVc.titleTextField.text = task.title
        newTaskVc.noteTextView.text = task.note
        navigationController?.present(newTaskVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
            if indexPath.section == 0 {
                currentTasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                StorageManager.shared.delete(task: task)
            } else {
                completedTasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                StorageManager.shared.delete(task: task)
            }
        }
        
        let doneAction = UIContextualAction(style: .normal, title: "Done") { [unowned self] _, _, _ in
            self.currentTasks.remove(at: indexPath.row)
            self.completedTasks.append(task)
            tableView.reloadData()
            task.done = true
            StorageManager.shared.saveContext()
        }
        
        doneAction.backgroundColor = .systemMint
        
        if indexPath.section == 0 {
            return UISwipeActionsConfiguration(actions: [doneAction, deleteAction])
        } else {
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }

}
    
}

    

   
    





