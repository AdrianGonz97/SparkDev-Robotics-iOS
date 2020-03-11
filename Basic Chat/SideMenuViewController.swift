//
//  SideMenuViewController.swift
//  Basic Chat
//
//  Created by Danny Mato on 3/11/20.
//  Copyright © 2020 Vanguard Logic LLC. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SideMenuViewController : UITableViewController {
    
    
    @IBOutlet weak var temperatureCell: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tempGraph = SensorGraphUIView()
        
        temperatureCell = tempGraph
        
        
    }
    
}
