//
//  ViewController.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import UIKit

class HomepageVC: UIViewController {
    //MARK: - Properties
    private let reuseIdentifier = "reuseIdentifier"
    
    var toDoList = [ToDoModel]()
    
    var homepagePresenterObject: HomepageViewToPresenter?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        copyDatabase()
        toDoList = [ToDoModel(id: 1, name: "Cem")]
        HomepageRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homepagePresenterObject?.loadList()
        
    }
    
    //MARK: - Handlers
    
    func copyDatabase(){
        
        let bundlePath = Bundle.main.path(forResource: "to-do", ofType: ".sqlite")
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let PathToBeCopied = URL(fileURLWithPath: targetPath).appendingPathComponent("to-do.sqlite")
        
        let fm = FileManager.default
        
        if fm.fileExists(atPath: PathToBeCopied.path){
            print("Database already exists")
        }else{
            do{
                try fm.copyItem(atPath: bundlePath!, toPath: PathToBeCopied.path)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func configUI(){
        //tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        // searchBar
        searchBar.searchTextField.textColor = .white
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let createPageVC = CreatePageVC()
        navigationController?.pushViewController(createPageVC, animated: true)
    }
}

//MARK: - TableView
extension HomepageVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = toDoList[indexPath.row]
        cell.backgroundColor = UIColor(named: "bgColor2")
        cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 25)
        cell.textLabel?.textColor = .white
        
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsPageVC = DetailsPageVC()
        let item = toDoList[indexPath.row]
        detailsPageVC.item = item
        navigationController?.pushViewController(detailsPageVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Sil"){ (contextualAction, view, bool) in
            let itemName = self.toDoList[indexPath.row].name
            
            let alert = UIAlertController(title: "Deleting", message: "Would you like to delete \(itemName)?", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(actionCancel)
            
            let actionYes = UIAlertAction(title: "Yes", style: .destructive){ action in
                self.homepagePresenterObject?.delete(itemName)
            }
            alert.addAction(actionYes)
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
//MARK: - PresenterToView Method
extension HomepageVC: HomepagePresenterToView{
    func sendDataToView(list: [ToDoModel]) {
        self.toDoList = list
        tableView.reloadData()
    }
}

//MARK: - UISearchBarDelegate Methods
extension HomepageVC: UISearchBarDelegate, UISearchTextFieldDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homepagePresenterObject?.search(searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.searchTextField.endEditing(true)
    }
}

