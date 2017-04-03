//
//  CarouselItem.swift
//  Pods
//
//  Created by Kunal Pandey on 4/3/17.
//
//

import UIKit

class CarouselItem: UICollectionViewCell {

    @IBOutlet weak var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    class func nibForCell()->UINib {
        let mainBundle = Bundle(for: CarouselView.self)
        return UINib(nibName: "CarouselItem", bundle: mainBundle)
    }
    
//    let mainBundle = Bundle(for: CarouselView.self)
//    if let bundle = mainBundle as? Bundle {
//        let pathfinder = bundle.path(forResource: "CarouselItem", ofType: "xib")
//        print("Path Finder  =\(pathfinder)")
//    }
}




