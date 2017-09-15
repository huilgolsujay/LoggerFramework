//  Licensed Materials -  Property of IBM
//
//  © Copyright   IBM Corp. 2016, 2017     All Rights Reserved.
//
//  US Government Users Restricted Rights - Use, duplication or
//  disclosure restricted by GSA ADP Schedule Contract
//  with IBM Corp.

import UIKit

class FeedbackNoteCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    weak var tableView: UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        UITextView.appearance().tintColor = UIColor.blue
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
        tableView?.scrollToRow(at: IndexPath(row: 0, section: FeedbackSectionType.noteSection.rawValue), at: .top, animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
}
