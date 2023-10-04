//
//  SuperHeroNameCell.swift
//  IGListKitDemo
//
//  Created by Vijay Parmar on 04/10/23.
//

import UIKit

class SuperHeroNameCell: UICollectionViewCell {

    @IBOutlet weak var superHeroNameLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWith(superHero: SuperHero) {
           superHeroNameLabel.text = superHero.superHeroName
       }

}
