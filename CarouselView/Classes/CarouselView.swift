//
//  CarouselView.swift
//  Pods
//
//  Created by Kunal Pandey on 3/30/17.
//
//

import UIKit



protocol CarouselViewDataSource {
    func numberOfItems(in carouselView:CarouselView)->Int
    func carouselView(_ carouselView:CarouselView,cellItemAtIndex:Int)->CarouselItem
}

protocol CarouselViewDelegate {
    func carouselView(_ carouselView:CarouselView, didSelectItemAtIndex:Int)
}

public class CarouselView: UIView {
    
    @IBOutlet weak var galleryView : UICollectionView!
    @IBOutlet weak var thumbnailView : UICollectionView!
    
    var datasource : CarouselViewDataSource?
    var delegate : CarouselViewDelegate?
    var scrollIndicatorView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 5))
    var nibView:UIView!
    
    var items:[String] = []
    func loadNibView() {
        let mainBundle = Bundle(for: CarouselView.self)
        if let bundle = mainBundle as? Bundle{
            let pathfinder = bundle.path(forResource: "CarouselView", ofType: "xib")
            print("Path Finder  =\(pathfinder)")
            if let nibView = UINib(nibName: "CarouselView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView {
                self.nibView = nibView
                self.addSubview(self.nibView)
                self.initialSetup()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibView()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.nibView.frame = self.bounds
    }
    
    func initialSetup() {
        self.thumbnailView.dataSource = self
        self.galleryView.dataSource = self
        self.thumbnailView.delegate = self
        self.galleryView.delegate = self
        self.scrollIndicatorView.backgroundColor = UIColor.gray
        self.thumbnailView.addSubview(self.scrollIndicatorView)
        self.thumbnailView.register(CarouselItem.nibForCell(), forCellWithReuseIdentifier: "CarouselItem")
        self.galleryView.register(CarouselItem.nibForCell(), forCellWithReuseIdentifier: "CarouselItem")
    }
    
    public func setCarouselItems(_ items:[String]) {
        self.items = items
        self.galleryView.reloadData()
        self.thumbnailView.reloadData()
    }
}


extension CarouselView : UICollectionViewDataSource  {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        if let numberOfItems = self.datasource?.numberOfItems(in: self) {
        //            return numberOfItems
        //        }
        return self.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselItem", for: indexPath) as? CarouselItem {
            //            if let view = self.datasource?.carouselView(self, cellItemAtIndex: indexPath.item) as? UIView {
            //                view.frame = cell.bounds
            //                cell.addSubview(view)
            //            }
            let image = self.items[indexPath.item]
            cell.imageView.image = UIImage(named: image)
            return cell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
}

extension CarouselView : UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == thumbnailView {
            let thumbnailCell = collectionView.cellForItem(at: indexPath)
            UIView.animate(withDuration: 0.2, animations: {
                self.scrollIndicatorView.frame = CGRect(x: (thumbnailCell?.frame.origin.x)!, y: (thumbnailCell?.frame.origin.y)!, width: (thumbnailCell?.frame.size.width)!, height: self.scrollIndicatorView.frame.size.height)
            })
            
            self.galleryView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
        else {
            let thumbnailCell = collectionView.cellForItem(at: indexPath)
            UIView.animate(withDuration: 0.2, animations: {
                self.scrollIndicatorView.frame = CGRect(x: (thumbnailCell?.frame.origin.x)!, y: (thumbnailCell?.frame.origin.y)!, width: (thumbnailCell?.frame.size.width)!, height: self.scrollIndicatorView.frame.size.height)
            })
            
            self.thumbnailView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
        self.datasource?.carouselView(self, cellItemAtIndex: indexPath.item)
    }
}

extension CarouselView : UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.thumbnailView {
            let size = self.thumbnailView.frame.size.height
            return CGSize(width: size, height: size)
        }
        else {
            return self.galleryView.frame.size
        }
    }
}
