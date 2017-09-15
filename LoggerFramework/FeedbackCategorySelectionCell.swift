//  Licensed Materials -  Property of IBM
//
//  © Copyright   IBM Corp. 2016, 2017     All Rights Reserved.
//
//  US Government Users Restricted Rights - Use, duplication or
//  disclosure restricted by GSA ADP Schedule Contract
//  with IBM Corp.

import UIKit

class FeedbackCategorySelectionCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    func populate(_ state: FeedbackCategoryState) {
        title.text = state.appName
        if state.isSelected {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
    }
}
