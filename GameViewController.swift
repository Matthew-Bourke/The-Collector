//
//  GameViewController.swift
//  The Collector
//
//  Created by Matthew Bourke on 19/8/17.
//  Copyright © 2017 Matthew Bourke. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // UIImagePickerController lets us choose images I guess?
    var imagePicker = UIImagePickerController()
    
    // No game yet?
    var game : Game? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Initialises imagePicker
        imagePicker.delegate = self
        
        // If game does exist, set name and image for said game
        if game != nil {
            gameImage.image = UIImage(data: game!.image! as Data)
            titleTF.text = game?.title
            
            // Sets the title for the add/update button to update, as a game already exists
            addUpdateButton.setTitle("Update", for: .normal)
            
        // If no game exists, hide the delete button
        } else {
            deleteButton.isHidden = true
        }
    }
    
    // Function for selecting photos from memory
    @IBAction func photosTapped(_ sender: Any) {
        // Sets the source for image as 'photoLibrary'
        imagePicker.sourceType = .photoLibrary
        
        // Photo library appears on screen for selecting photo
        present(imagePicker, animated: true, completion: nil)
    }
    
    // I have no idea what this is doing lol
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        gameImage.image = image
        
        // All I know is this dismisses the photo library
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // For taking a photo for image - not sure if this works because Apple wants me to pay $100 to test lol //
    @IBAction func cameraTapped(_ sender: Any) {
        // Sets source of image to camera
        imagePicker.sourceType = .camera
        
        // Presents camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Function for adding new game
    @IBAction func addTapped(_ sender: Any) {
        // If game does exist, title and image are as they were previously saved as
        if game != nil {
            game!.title = titleTF.text
            game!.image = UIImagePNGRepresentation(gameImage.image!) as NSData?
            
        // If no game exists...
        } else {
            // Again, not sure what this does
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            // Or this
            let game = Game(context: context)
            
            // Sets game title and image to input
            game.title = titleTF.text
            game.image = UIImagePNGRepresentation(gameImage.image!) as NSData?
        }
        
        
        // Saves new game
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Returns to original VC
        navigationController!.popViewController(animated: true)
    }
    
    // For deleting saved games
    @IBAction func deleteTapped(_ sender: Any) {
        // I'm starting to think this is just to access CoreData?
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Deletes game
        context.delete(game!)
        
        // Updates new content
       (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Returns to original VC
        navigationController!.popViewController(animated: true)
    }
    
    
    // This function is here by default
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
