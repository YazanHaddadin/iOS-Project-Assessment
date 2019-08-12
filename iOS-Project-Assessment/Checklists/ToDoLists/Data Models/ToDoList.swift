import UIKit

class ToDoList: NSObject, Codable {
    var title = ""
    var items = [ToDoItem]()
    
    init(name: String) {
        self.title = name
        super.init()
    }
}
