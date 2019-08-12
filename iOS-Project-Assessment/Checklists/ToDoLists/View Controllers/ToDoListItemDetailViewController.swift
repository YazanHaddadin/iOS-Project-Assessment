import UIKit

protocol EditingToDoListItemDelegate: class {
    func didCancelEditingItem(_ vc: ToDoListItemDetailViewController)
    func listItemViewController(_ vc: ToDoListItemDetailViewController, didFinishAdding item: ToDoItem)
    func listItemViewController(_ vc: ToDoListItemDetailViewController, didFinishEditing item: ToDoItem)
}

class ToDoListItemDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    weak var delegate: EditingToDoListItemDelegate?
    var item: ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = item {
            title = "Edit Item"
            textField.text = item.text
            doneButton.isEnabled = true
        }
    }
    
    // Give the text field focus on screen opening
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.didCancelEditingItem(self)
    }
    
    @IBAction func done() {
        if let itemToEdit = item {
            itemToEdit.text = textField.text!
            delegate?.listItemViewController(self, didFinishEditing: itemToEdit)
        } else {
            let item = ToDoItem()
            item.text = textField.text!
            item.isChecked = false
            delegate?.listItemViewController(self, didFinishAdding: item)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneButton.isEnabled = !newText.isEmpty
        return true
    }

}
