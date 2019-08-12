import Foundation
import UIKit

protocol ListDetailViewDelegate: class {
    func detailViewDidCancel(_ vc: ToDoItemDetailViewController)
    func detailView( _ vc: ToDoItemDetailViewController, didFinishAdding list: ToDoList)
    func detailView( _ vc: ToDoItemDetailViewController, didFinishEditing list: ToDoList)
}

class ToDoItemDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    weak var delegate: ListDetailViewDelegate?
    var listToEdit: ToDoList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let checklist = listToEdit {
            title = "Edit List"
            textField.text = checklist.title
            doneButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK:- Actions
    @IBAction func cancel() {
        delegate?.detailViewDidCancel(self)
    }
    
    @IBAction func done() {
        if let list = listToEdit {
            list.title = textField.text!
            delegate?.detailView(self, didFinishEditing: list)
        } else {
            let list = ToDoList(name: textField.text!)
            delegate?.detailView(self, didFinishAdding: list)
        }
    }
    
    // MARK:- TableView Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK:- UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let old = textField.text!
        let stringRange = Range(range, in: old)!
        let new = old.replacingCharacters(in: stringRange, with: string)
        doneButton.isEnabled = !new.isEmpty
        return true
    }
}
