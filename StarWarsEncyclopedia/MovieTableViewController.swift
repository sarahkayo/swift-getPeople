//
//  MovieTableViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Placoderm on 7/17/17.
//  Copyright © 2017 Placoderm. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    var films = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsModel.getAllFilms(completionHandler: {
            
            data, response, error in
            do {
                
                //try converting the JSON object to "Foundation Tyes" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    if let results = jsonResult["results"] as? NSArray {
                        
                        let resultsArray = results as! [NSDictionary]
                        self.films = resultsArray
                        self.tableView.reloadData()
                        
                        //for person in results {
                        //let personDict = person as! NSDictionary
                        //self.people.append(personDict["name"]! as! String)
                        //}
                    }
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print ("Something went wrong")
            }
        })

        //let url = URL(string: "http://swapi.co/api/films")
        //let session = URLSession.shared
        //let task = session.dataTask(with: url!, completionHandler: {
            
            //data, response, error in //data = JSON data//response = headers/meta// error = error//
            
            //do {

                //if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    //print(jsonResult)
                    //if let results = jsonResult["results"] {
                        
                        //let resultsArray = results as! [NSDictionary]
                        
                        //print (resultsArray)
                        //self.films = resultsArray
                        //self.tableView.reloadData()
                        
                    //}
                //}
                //run on the main queue - speed up UI
                //DispatchQueue.main.async {
                    //self.tableView.reloadData()
                //}
            //} catch {
                //print(error)
            //}
        //})
        
        //execute task, wait for response to run completion handler (async)
        //task.resume()
    }
    
    //navigate to info about particular character -
    //listen for tap on accessory button
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "LookAtFilm", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //check for sender
        if sender != nil {
            
            let navigationController = segue.destination as! UINavigationController
            let filmViewController = navigationController.topViewController as! FilmViewController
            
            let indexPath = sender as! NSIndexPath
            print("SENDER: \(indexPath)")
            let film = films[indexPath.row]
            print("MOVIE: \(film)")
            
            filmViewController.filmInfo = film
            filmViewController.indexPath = indexPath
        }
        //if sender doesn't exist somehow
        else {
            
            let navigationController = segue.destination as! UINavigationController
            let filmViewController = navigationController.topViewController as! FilmViewController
            
            filmViewController.filmInfo = nil
            filmViewController.indexPath = nil
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MovieTableViewController viewWillAppear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        
        cell.textLabel?.text = films[indexPath.row]["title"]! as? String
        cell.accessoryType = UITableViewCellAccessoryType.detailButton
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
