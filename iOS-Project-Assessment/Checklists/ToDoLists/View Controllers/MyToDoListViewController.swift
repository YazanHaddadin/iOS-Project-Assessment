import UIKit

class MyToDoListViewController: UITableViewController, EditingToDoListItemDelegate {
    var list: ToDoList!
    
    /*class ItemClass: UITableViewCell{
        @IBOutlet weak var checkLbl: UILabel?
        @IBOutlet weak var textLbl:  UILabel?
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = list.title
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let vc = segue.destination as! ToDoListItemDetailViewController
            vc.delegate = self
        } else if segue.identifier == "EditItem" {
            let vc = segue.destination as! ToDoListItemDetailViewController
            vc.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                vc.item = list.items[indexPath.row]
            }
        }
    }
    
    // TO-DO: Please update numberOfRowsInSection function to display the correct
    // number of items on a to-do list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count
    }
    
    // TO-DO: Please add necessary settings in cellForRowAt function to configure text
    // and checkmark for the to-do list items
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ItemClass
        
        let toDoListItem = list.items[indexPath.row]
        cell.textLabel!.text = toDoListItem.text
        cell.accessoryType = .detailDisclosureButton
        
        //cell.textLbl.text = toDoListItem.text
        //cell.checkLbl.isHidden = true
        
        return cell
    }
    
    // TO-DO: Please add feature for toggling the checkmark on a row on or off
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ItemClass
         
         let toDoListItem = list.items[indexPath.row]
         if toDoListItem.isChecked {
            cell.checkLbl.isHidden = false
         }
         else {
            cell.checkLbl.isHidden = true
         }
         */
    }
    
    // TO-DO: Please add feature for swipe to delete an item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        list.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // AddItemViewController Delegates
    func didCancelEditingItem(_ controller: ToDoListItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    // TO-DO: Please add necessary settings here to allow adding a new
    // item to the to-do list after the Done button is clicked.
    func listItemViewController(_ controller: ToDoListItemDetailViewController, didFinishAdding item: ToDoItem) {
        let newRowIndex = list.items.count
        list.items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    // TO-DO: Please add necessary settings here to allow the update of an
    // item's title after the Done button is clicked.
    func listItemViewController(_ controller: ToDoListItemDetailViewController, didFinishEditing item: ToDoItem) {
        if let index = list.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = item.text
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
