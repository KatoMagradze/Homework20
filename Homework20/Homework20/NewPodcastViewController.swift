//
//  NewPodcastViewController.swift
//  Homework20
//
//  Created by Kato on 5/13/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreData

protocol CreatePodcastDelegate {
    func retrievePodcastObject(podcast: PodcastStruct)
}

class NewPodcastViewController: UIViewController {
    
    var pickerData = [String]()
    var selectedPicker = 0
    
    var podcastProtocol : CreatePodcastDelegate?

    @IBOutlet weak var newPodcastTitleTextField: UITextField!
    
    @IBOutlet weak var newDescriptionTextView: UITextView!
    
    
    @IBOutlet weak var durationPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        durationPicker.delegate = self
        durationPicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
        for i in 1...60 {
            pickerData.append("\(String(i)) min")
        }
        
        print(try! FileManager.default.url(for: .documentationDirectory, in: .allDomainsMask, appropriateFor: nil, create: false))
        
    }
    

    @IBAction func onSavePodcastTapped(_ sender: UIButton) {
        
        let newPodcast = PodcastStruct(title: newPodcastTitleTextField.text!, description: newDescriptionTextView.text!, duration: pickerData[selectedPicker], duration2: Int16(selectedPicker+1))
        
        podcastProtocol?.retrievePodcastObject(podcast: newPodcast)
        
        save()
    }
    
}

extension NewPodcastViewController {
    
    func save() {
//        let appDel = UIApplication.shared.delegate as! AppDelegate
        //container
//        let container = appDel.persistentContainer
        //context
//        let context = container.viewContext
        let context = AppDelegate.coreDataContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Podcast", in: context)
        
        let podcastObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        podcastObject.setValue(newPodcastTitleTextField.text!, forKey: "title")
        podcastObject.setValue(newDescriptionTextView.text!, forKey: "text")
        podcastObject.setValue(pickerData[selectedPicker], forKey: "duration")
        podcastObject.setValue(selectedPicker+1, forKey: "duration2")
        
        do {
            try context.save()
            print("podcast saved successfully")
        }
        catch {
            print("failed")
        }
        
    }
    
}

extension NewPodcastViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //the data to return for the row and component(column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedPicker = row
    }
 
    
    
}
