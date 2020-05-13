//
//  DisplayPodcastViewController.swift
//  Homework20
//
//  Created by Kato on 5/13/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class DisplayPodcastViewController: UIViewController {

    @IBOutlet weak var displayTitleLabel: UILabel!
    @IBOutlet weak var displayDescriptionLabel: UILabel!
    @IBOutlet weak var displayDurationLabel: UILabel!
    
    var titleToDisplay = ""
    var descriptionToDisplay = ""
    var durationToDisplay = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayTitleLabel.text = titleToDisplay
        self.displayDescriptionLabel.text = descriptionToDisplay
        self.displayDurationLabel.text = durationToDisplay

        // Do any additional setup after loading the view.
    }
    



}
