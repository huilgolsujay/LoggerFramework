//  Licensed Materials -  Property of IBM
//
//  © Copyright   IBM Corp. 2016, 2017     All Rights Reserved.
//
//  US Government Users Restricted Rights - Use, duplication or
//  disclosure restricted by GSA ADP Schedule Contract
//  with IBM Corp.

import UIKit

class FeedbackRatingCell: UITableViewCell {
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    private var starButtons: [UIButton]! { return [star1, star2, star3, star4, star5] }
    
    public var currentRating = 0
    
    @IBAction func starButtonTapped(_ sender: UIButton!) {
        currentRating = sender.tag
        for i in 0..<sender.tag {
            let button = starButtons[i]
            button.setImage(UIImage(named:"feedback_star_selected"), for: .normal)
            
        }
        for i in sender.tag..<starButtons.count {
            let button = starButtons[i]
            button.setImage(UIImage(named:"feedback_star"), for: .normal)
        }
    }
}
