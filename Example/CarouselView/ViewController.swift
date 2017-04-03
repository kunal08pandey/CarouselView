//
//  ViewController.swift
//  CarouselView
//
//  Created by kunal08pandey on 03/30/2017.
//  Copyright (c) 2017 kunal08pandey. All rights reserved.
//

import UIKit
import CarouselView

class ViewController: UIViewController {
    
    @IBOutlet weak var carouselView: CarouselView!
    
    var items = ["Landscape1","Landscape2","Landscape3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carouselView.setCarouselItems(self.items)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

