//
//  TaskViewController.swift
//  MyCoreDate
//
//  Created by Aleksandr Rybachev on 19.04.2022.
//

import UIKit

class TaskViewController: UIViewController {
    
    // MARK: - Private Properties
    private lazy var taskTextFiled: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add New Task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        createButton(
            with: "Save Task",
            and: UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 194/255),
            action: UIAction { _ in
                self.dismiss(animated: true)
            }
        )
    }()
    
    private lazy var cancelButton: UIButton = {
        createButton(
            with: "Cancel",
            and: .systemRed,
            action: UIAction { _ in
                self.dismiss(animated: true)
            }
        )
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews(taskTextFiled, saveButton, cancelButton)
        setConstraints()
    }
    
    // MARK: - Private Methods
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        taskTextFiled.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskTextFiled.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            taskTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            taskTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: taskTextFiled.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func createButton(with title: String, and color: UIColor, action: UIAction) -> UIButton {
        var attributes = AttributeContainer()
        attributes.font = .boldSystemFont(ofSize: 18)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: attributes)
        buttonConfiguration.baseBackgroundColor = color
        
        return UIButton(configuration: buttonConfiguration, primaryAction: action)
    }
}
