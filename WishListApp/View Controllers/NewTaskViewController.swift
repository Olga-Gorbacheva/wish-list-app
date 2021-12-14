//
//  NewTaskViewController.swift
//  WishListApp
//
//  Created by Ольга Горбачева on 12.12.21.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    var isEdit = false
    var task: Task? = nil
    
    var titleTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Write your Task"
        textField.font = UIFont(name: "PingFangHK-Light", size: 20)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    var noteTextView: UITextView = {
        
        let textView = UITextView()
        textView.layer.cornerRadius = 20
        textView.font = UIFont(name: "PingFangHK-Light", size: 20)
        return textView
    }()
    
    private var saveButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: "PingFangHK-Light", size: 15)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
        
    } ()
    
    private var cancelButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: "PingFangHK-Light", size: 15)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    } ()
    
    private func setUpViews () {
        
        view.addSubview(titleTextField)
        view.addSubview(noteTextView)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
    }
    
    private func setUpConstraints() {
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            noteTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            noteTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            noteTextView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            
            saveButton.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor)
        ])
        
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        view.backgroundColor = .systemIndigo
    }
    
    @objc private func save() {
        
        if titleTextField.text == "" {
            
            let alert = UIAlertController(title: "Task is empty", message: "Please, write your task!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        
        // проверяем условие
        
        guard let title = titleTextField.text else { return }
        guard let note = noteTextView.text else { return }
        let homeVC = HomeViewController ()
        
        if isEdit {
            StorageManager.shared.edit(task: task ?? Task(), newTitle: title, newNote: note)
            isEdit = false
        } else {
            StorageManager.shared.save(title: title, note: note, done: false) { task in
                homeVC.currentTasks.append(task)
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
}

extension NewTaskViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        noteTextView.becomeFirstResponder()
        noteTextView.text = ""
        return true
    }
}

