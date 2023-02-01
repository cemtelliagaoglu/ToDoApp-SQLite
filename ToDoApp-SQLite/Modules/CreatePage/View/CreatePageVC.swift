//
//  CreatePageVC.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import UIKit

class CreatePageVC: UIViewController{
    //MARK: - Properties
    
    var createPagePresenterObject: CreatePageViewToPresenter?
    
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor(named: "bgColor2"), for: .normal)
        button.addTarget(self, action: #selector(handleCreateTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "What do you want to add?"
        textField.font = UIFont(name: "Helvetica Neue", size: 25)
        textField.textAlignment = .center
        textField.textColor = UIColor(named: "bgColor2")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // create module
        CreatePageRouter.createModule(ref: self)
        
        configUI()
        
    }
    
    //MARK: - Handlers
  
    
    @objc func handleCreateTapped(){
        // create
        if textField.text != ""{
            DispatchQueue.main.async {
                self.createPagePresenterObject?.createToDo(self.textField.text!)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }else{
            let alert = UIAlertController(title: "Warning", message: "Can't Create Empty Text", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    
    func configUI(){
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationItem.title = "Create"
        
        view.backgroundColor = UIColor(named: "bgColor2")
        view.addSubview(createButton)
        view.addSubview(textField)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // set button
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 100),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            // set textField
            textField.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 32),
            textField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -32),
            textField.bottomAnchor.constraint(equalTo: createButton.topAnchor,constant: -50)
        ])
    }
}

