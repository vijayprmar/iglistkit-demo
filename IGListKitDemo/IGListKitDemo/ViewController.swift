//
//  ViewController.swift
//  IGListKitDemo
//
//  Created by Vijay Parmar on 04/10/23.
//

import UIKit
import IGListKit

class SuperHero{
    
    private var identifier: String = UUID().uuidString
       private(set) var firstName: String
       private(set) var lastName: String
       private(set) var superHeroName: String
       private(set) var icon: String
       init(firstName: String,
             lastName: String,
        superHeroName: String,
                 icon: String) {
           self.firstName = firstName
           self.lastName = lastName
           self.superHeroName = superHeroName
           self.icon = icon
       }
    
}


extension SuperHero : ListDiffable{
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SuperHero else{
            return false
        }
        
        return self.identifier == object.identifier
    }
    
}

class SuperHeroDataSource : NSObject,ListAdapterDataSource{
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [SuperHero(firstName: "Peter",
                             lastName: "Parker",
                             superHeroName: "SpiderMan",
                             icon: "🕷"),
                   SuperHero(firstName: "Bruce",
                             lastName: "Wayne",
                             superHeroName: "Batman",
                             icon: "🦇"),
                   SuperHero(firstName: "Tony",
                             lastName: "Stark",
                             superHeroName: "Ironman",
                             icon: "🤖"),
                   SuperHero(firstName: "Bruce",
                             lastName: "Banner",
                             superHeroName: "Incredible Hulk",
                             icon: "🤢")]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SuperHeroSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}


class SuperHeroSectionController:ListSectionController{
    
    var currentHero : SuperHero?
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? SuperHero else{
            return
        }
        
        currentHero = superHero
        
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: SuperHeroNameCell.self)
        
        guard let ctx = collectionContext, let hero = currentHero else{
            return UICollectionViewCell()
        }
        
        let cell = ctx.dequeueReusableCell(withNibName:nibName,bundle: nil, for: self, at: index)
        
        
        guard let superHeroCell = cell as? SuperHeroNameCell else{
            return cell
        }
        
        superHeroCell.updateWith(superHero: hero)
        return superHeroCell
        
        
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width, height: 50)
    }
    
    
}


class ViewController: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!
    
    lazy var adapter : ListAdapter = {
        
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self,workingRangeSize: 1)
        adapter.collectionView = collectionview
        adapter.dataSource = SuperHeroDataSource()
        return adapter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = adapter
    }


}

