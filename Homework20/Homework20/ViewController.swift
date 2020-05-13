//
//  ViewController.swift
//  Homework20
//
//  Created by Kato on 5/13/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, CreatePodcastDelegate {
    
    var podcasts = [PodcastStruct]()
    var selectedRow = 0
    var filterValue = 0

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == "new_podcast_segue" {
            if let destinationVC = segue.destination as? NewPodcastViewController {
                destinationVC.podcastProtocol = self
            }
        }
    }
    
    func retrievePodcastObject(podcast: PodcastStruct) {
        podcasts.append(podcast)
        tableView.reloadData()
    }


}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcasts_cell", for: indexPath) as! PodcastsCell
        
        cell.titleLabel.text = podcasts[indexPath.row].title
        cell.descriptionLabel.text = podcasts[indexPath.row].description
        cell.durationLabel.text = String(podcasts[indexPath.row].duration) //+ " min"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = indexPath.row
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let displayVC = storyboard.instantiateViewController(withIdentifier: "display_podcast_vc")

        if let vc = displayVC as? DisplayPodcastViewController {
            
            vc.titleToDisplay = podcasts[indexPath.row].title
            vc.descriptionToDisplay = podcasts[indexPath.row].description
            vc.durationToDisplay = String(podcasts[indexPath.row].duration)
           
        }

        present(displayVC, animated: true, completion: nil)
    }
    
    func fetch() {
        let container = AppDelegate.coreDataContainer
        
        //context
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Podcast")
        self.podcasts.removeAll()
        do {
            let result = try context.fetch(fetchRequest)
            
            guard let data = result as? [NSManagedObject] else {return}
            
            print(data)
            for item in data {
                if let p = item as? Podcast {
                    if p.duration2 >= self.filterValue {
                        let myPodcast = PodcastStruct(title: p.title!, description: p.text!, duration: p.duration!, duration2: p.duration2)
                        self.podcasts.append(myPodcast)
                    }
                }
            }
        }
        catch {}
        self.tableView.reloadData()
    }

    
}

struct PodcastStruct {
    var title: String
    var description: String
    var duration: String
    var duration2: Int16
}
