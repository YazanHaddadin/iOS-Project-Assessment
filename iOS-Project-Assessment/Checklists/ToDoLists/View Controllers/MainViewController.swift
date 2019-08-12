import UIKit

class MainViewController: UITableViewController, ListDetailViewDelegate, UINavigationControllerDelegate {
    
    var listModel: ListsModel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destination as! MyToDoListViewController
            controller.list = sender as! ToDoList
        } else if segue.identifier == "AddChecklist" {
            let controller = segue.destination as! ToDoItemDetailViewController
            controller.delegate = self
        }
    }
    
    // MARK: - List Detail View Controller Delegates
    func detailViewDidCancel(_ vc: ToDoItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func detailView(_ vc: ToDoItemDetailViewController, didFinishAdding checklist: ToDoList) {
        let newRowIndex = listModel.lists.count
        listModel.lists.append(checklist)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func detailView(_ vc: ToDoItemDetailViewController, didFinishEditing checklist: ToDoList) {
        if let index = listModel.lists.index(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.title
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController,
                              animated: Bool) {
        if viewController === self {
            listModel.indexOfSelectedChecklist = -1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        
        let index = listModel.indexOfSelectedChecklist
        
        if index >= 0 && index < listModel.lists.count {
            let checklist = listModel.lists[index]
            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return listModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = createCell(for: tableView)
        
        let checklist = listModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.title
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    func createCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default,
                                   reuseIdentifier: cellIdentifier)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        listModel.indexOfSelectedChecklist = indexPath.row
        let checklist = listModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        listModel.lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
}
