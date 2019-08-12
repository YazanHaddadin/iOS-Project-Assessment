import Foundation

class ToDoItem: NSObject, Codable {
    var text = ""
    var isChecked = false
    
    func toggleChecked() {
        isChecked = !isChecked
    }
}
