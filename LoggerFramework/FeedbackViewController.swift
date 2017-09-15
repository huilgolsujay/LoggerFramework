//  Licensed Materials -  Property of IBM
//
//  © Copyright   IBM Corp. 2016, 2017     All Rights Reserved.
//
//  US Government Users Restricted Rights - Use, duplication or
//  disclosure restricted by GSA ADP Schedule Contract
//  with IBM Corp.

import UIKit
//import TravelAndTransportationDataAdapter

struct FeedbackCategoryState {
    let appName: String
    let appId: String
    var isSelected: Bool
}

enum FeedbackSectionType: Int {
    case categorySection
    case ratingSection
    case noteSection
    static let count: Int = {
        var max: Int = 0
        while let _ = FeedbackSectionType(rawValue: max) { max += 1 }
        return max
    }()
}

let dismissStr = NSLocalizedString("Dismiss", comment: "Dismiss")
let noteRequestStr = NSLocalizedString("Please tell us what could be done to improve this app.", comment: "Please tell us what could be done to improve this app.")
let youRatedStr = NSLocalizedString("You Rated", comment: "You Rated")
let starStr = NSLocalizedString("Star", comment: "Star")
let starsStr = NSLocalizedString("Stars", comment: "Stars")
let ratingRequestStr = NSLocalizedString("Please Enter Your Rating", comment: "Please Enter Your Rating")
let categoryRequestStr = NSLocalizedString("Please Select a Category", comment: "Please Select a Category")
let sendFailedStr = NSLocalizedString("Failed to send feedback, please try again", comment: "Failed to send feedback, please try again")
let reviewOptionalStr = NSLocalizedString("Review (Optional)", comment: "Review (Optional)")
let reviewRequiredStr = NSLocalizedString("Review (Required)", comment: "Review (Required)")

class FeedbackViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var categoryStates = [FeedbackCategoryState]()
    
    let estimatedCategoryRowHeight: CGFloat = 44.0
    let estimatedSectionHeaderHeight: CGFloat = 56.0
    let estimatedRatingRowHeight: CGFloat = 66.0
    
    var refreshTokenCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.reloadData()
        var states = [FeedbackCategoryState]()
        states.append(FeedbackCategoryState(appName: "General", appId: "general", isSelected: false))
//        for app in self.appManager.permittedPortalApps {
//            states.append(FeedbackCategoryState(appName: app.appDisplayName, appId: app.appId, isSelected: false))
//        }
        self.categoryStates = states
        
        
    }
    
    @IBAction func sendButtonPressed(_ sender: UIBarButtonItem) {
        self.refreshTokenCounter = 0
        if let ratingCell = tableView.cellForRow(at: IndexPath(row: 0, section: FeedbackSectionType.ratingSection.rawValue)) as? FeedbackRatingCell {
            switch ratingCell.currentRating {
            case 0:
                self.showAlertWithTitle(ratingRequestStr, message: nil)
                break
            case 1:
                if isNoteSectionEmpty() {
                    let title = youRatedStr + " \(ratingCell.currentRating) " + starStr
                    self.showAlertWithTitle(title, message: noteRequestStr)
                } else {
                    self.saveFeedback()
                }
                break
            case 2, 3:
                if isNoteSectionEmpty() {
                    let title = youRatedStr + " \(ratingCell.currentRating) " + starsStr
                    self.showAlertWithTitle(title, message: noteRequestStr)
                } else {
                    self.saveFeedback()
                }
                break
            default:
                self.saveFeedback()
                break
            }
        }
    }
    
    func isNoteSectionEmpty() -> Bool {
        if let noteCell = tableView.cellForRow(at: IndexPath(row: 0, section: FeedbackSectionType.noteSection.rawValue)) as? FeedbackNoteCell {
            if let note = noteCell.textView.text {
                if note.characters.count > 0 {
                    return false
                }
            }
        }
        return true
    }
    
    func isCategorySelected() -> Bool {
        for state in categoryStates where state.isSelected {
            return true
        }
        return false
    }
    
    func getNote() -> String? {
        if let noteCell = tableView.cellForRow(at: IndexPath(row: 0, section: FeedbackSectionType.noteSection.rawValue)) as? FeedbackNoteCell {
            if let note = noteCell.textView.text {
                if note.characters.count > 0 {
                    return note
                }
            }
        }
        return " "
    }
    
    func getRating() -> Int {
        if let ratingCell = tableView.cellForRow(at: IndexPath(row: 0, section: FeedbackSectionType.ratingSection.rawValue)) as? FeedbackRatingCell {
            return ratingCell.currentRating
        } else {
            return 0
        }
    }
    
    func getSelectedCategory() -> String? {
        for state in categoryStates where state.isSelected {
            return state.appName
        }
        return nil
    }
    
    func saveFeedback() {
        if !isCategorySelected() {
            self.showAlertWithTitle(categoryRequestStr, message: nil)
        } else {
//            if let message = Message.create(), let availableResponse = AvailableResponse.create() {
//                message.topic = getSelectedCategory()
//                availableResponse.inv_availableResponses_Message = message
//                availableResponse.feedbackNote = getNote()
//                availableResponse.descriptionText = "\(getRating())"
//                availableResponse.selectedResponse = true
//                
//                if let leg = SecureContext.shared.currentFlightLeg {
//                    leg.addToMessages(message)
//                }
//                
//                DAC.adapter?.saveLocal()
//                
//                self.dismissController()
//            }
        }
    }
    
    func showAlertWithTitle(_ title: String?, message: String?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: dismissStr, style: .cancel, handler: nil)
        alertView.addAction(okAction)
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismissController()
    }
    
    func dismissController() {
        if let noteCell = tableView.cellForRow(at: IndexPath(row: 0, section: FeedbackSectionType.noteSection.rawValue)) as? FeedbackNoteCell {
            noteCell.textView.resignFirstResponder()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FeedbackSectionType.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let feedbackSection = FeedbackSectionType(rawValue: section) {
            switch feedbackSection {
            case .categorySection:
                return categoryStates.count
            case .ratingSection:
                return 1
            case .noteSection:
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let section = FeedbackSectionType(rawValue: indexPath.section) {
            switch section {
            case .categorySection:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? FeedbackCategorySelectionCell {
                    cell.populate(categoryStates[indexPath.row])
                    return cell
                }
            case .ratingSection:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell") as? FeedbackRatingCell {
                    cell.selectionStyle = .none
                    return cell
                }
            case .noteSection:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? FeedbackNoteCell {
                    cell.tableView = tableView
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if FeedbackSectionType(rawValue: section) == .categorySection {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell")
            return cell
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if FeedbackSectionType(rawValue: section) == .categorySection {
            return estimatedSectionHeaderHeight
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let section = FeedbackSectionType(rawValue: indexPath.section) {
            switch section {
            case .categorySection:
                return estimatedCategoryRowHeight
            case .ratingSection:
                return estimatedRatingRowHeight
            case .noteSection:
                // fill the rest of the tableview with note cell
                let noteHeight = tableView.frame.height - estimatedSectionHeaderHeight - estimatedCategoryRowHeight * CGFloat(categoryStates.count) - estimatedRatingRowHeight
                return noteHeight
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if FeedbackSectionType(rawValue: indexPath.section) == .categorySection {
            setSelectionStateForIndex(indexPath.row)
            var indexPaths = [IndexPath]()
            for i in 0..<categoryStates.count {
                indexPaths.append(IndexPath(row: i, section: 0))
            }
            tableView.reloadRows(at: indexPaths, with: .none)
        }
    }
    
    func setSelectionStateForIndex(_ index: Int) {
        for i in 0..<categoryStates.count {
            categoryStates[i].isSelected = false
        }
        categoryStates[index].isSelected = true
    }
}
