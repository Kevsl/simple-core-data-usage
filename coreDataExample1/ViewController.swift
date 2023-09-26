//
//  ViewController.swift
//  coreDataExample1
//
//  Created by K on 26/09/2023.
//

import UIKit

class ViewController: UIViewController {

    var movies: [Movie] = []
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        setupTV()
        updateData()
        
    }
    @IBAction func addMovie(_ sender: UIButton) {
        if let name = nameTF.text{
            CoreDataHelper.shared.addMovie(name, nil)
        }
        updateData()
    }
    
    
    @IBAction func getMoviesAction(_ sender: UIButton) {
        
        
        
    }
}

  
    
    
extension ViewController: UITextFieldDelegate {
    func setupTF() {
        nameTF.delegate = self
  
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func setupTV(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateData(){
        
        CoreDataHelper.shared.getMovies{ movies in
            self.movies = movies
        }
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.item]
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        config.text = movie.name
        cell.contentConfiguration = config
        
        return cell
        
    }
 

    
 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let movie = movies[indexPath.item]
            CoreDataHelper.shared.deleteMovie(movie) {
                success in
                if success {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            updateData()
            
        }
        
        
        
    }
    
    
}
