//
//  ViewController.swift
//  The Collector
//
//  Created by Matthew Bourke on 19/8/17.
//  Copyright © 2017 Matthew Bourke. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var gameList: UITableView!
    
    // Create array of type 'Game' defined in CoreData ?I think?
    var games : [Game] = []
    
    // viewDidLoad runs first time VC appears
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialisation for tableviews
        gameList.delegate = self
        gameList.dataSource = self
    }
    
    // Function defines number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows is equal to number of elements in 'games' array
        return games.count
    }
    
    // Function puts correct information in corresponding cell of tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Define cell as a 'UITableViewCell()
        let cell = UITableViewCell()
        
        // Constant game is equal to corresponding item in 'games' array
        let game = games[indexPath.row]
        
        // Text in tableview cell is the title of constant 'game'
        cell.textLabel?.text = game.title
        
        // Image in tableview cell is the image of 'game'
        cell.imageView?.image = UIImage(data: game.image! as Data)
        
        // Function returns cell to display information we just put into it
        return cell
    }
    
    // Function to select the chosen cell in tableview and segue accordingly
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Constant game is has information of corresponding item in 'games' array
        let game = games[indexPath.row]
        
        // Performs segue called 'gameSegue' in storyboard. Sends 'game' to next VC
        performSegue(withIdentifier: "gameSegue", sender: game)
    }
    
    // Sets up segue I guess???
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Defines next VC 'GameViewController' as destination for segue
        let nextVC = segue.destination as! GameViewController
        
        // Not sure about this yet, probably intertwines with other VC //
        nextVC.game = sender as? Game
    }
    
    // Function runs everytime VC appears
    override func viewWillAppear(_ animated: Bool) {
        // This line is for CoreData, and I'm not exactly sure what's happening
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            // Array 'games' fetches data from CoreData
            games = try context.fetch(Game.fetchRequest())
            
            // This line reloads the correct data into the tableview
            gameList.reloadData()
        } catch {
            // Not sure why nothing is in here?
        }
    }
    
    // This function is here by default
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

