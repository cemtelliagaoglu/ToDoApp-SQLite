//
//  DetailsPageVC.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import UIKit

class DetailsPageVC: UIViewController{
    //MARK: - Properties
    
    var item: ToDoModel?{
        didSet{
            textField.text = item?.name
        }
    }
    
    var detailsPagePresenterObject: DetailsPageViewToPresenter?
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Helvetica Neue", size: 30)
        textField.textColor = UIColor(named: "bgColor2")
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitle("Update", for: .normal)
        button.setTitleColor(UIColor(named: "bgColor2"), for: .normal)
        button.addTarget(self, action: #selector(handleUpdateTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    let editLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit Your Item"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        DetailsPageRouter.createModule(ref: self)
    }
    
    //MARK: - Handlers
    @objc func handleUpdateTapped(){
        // update data
        if textField.text != ""{
            DispatchQueue.main.async {
                let newName = self.textField.text!
                self.detailsPagePresenterObject?.updateItem(self.item!, withNewName: newName)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }else{
            let alert = UIAlertController(title: "Warning", message: "Can't Update with Empty Text", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    @objc func handleBackgroundTapped(){
        textField.endEditing(true)
    }
    
    func configUI(){
        // config navBar and background
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "bgColor2")
        navigationItem.title = "Details"
        view.backgroundColor = UIColor(named: "bgColor2")
        // add subviews
        view.addSubview(editLabel)
        view.addSubview(updateButton)
        view.addSubview(textField)
        
        // set constraints
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // set button
            updateButton.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            updateButton.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            updateButton.widthAnchor.constraint(equalToConstant: 100),
            updateButton.heightAnchor.constraint(equalToConstant: 50),
            // set textField
            textField.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -50),
            textField.bottomAnchor.constraint(equalTo: updateButton.topAnchor,constant: -50),
            // set editLabel
            editLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -50),
            editLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTapped))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
    
}
