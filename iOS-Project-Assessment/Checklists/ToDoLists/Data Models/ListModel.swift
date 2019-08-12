import Foundation

class ListsModel {
    var lists = [ToDoList]()
    
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
        }
    }
    
    init() {
        loadLists()
        initializeDefaults()
        resetDefaults()
    }
    
    func initializeDefaults() {
        let dictionary: [String:Any] = [ "ChecklistIndex": -1,
                           "FirstTime": true ]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    // First run experience
    func resetDefaults() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = ToDoList(name: "Default List")
            lists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        print("Documents folder is \(documentsDirectory())")
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    // Save data to a file
    func saveLists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(),
                           options: Data.WritingOptions.atomic)
        } catch {
            print("Error when encoding items array!")
        }
    }
    
    // Read data from a file
    func loadLists() {
        let path = dataFilePath()
        print("Data file path is \(dataFilePath())")
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([ToDoList].self, from: data)
            } catch {
                print("Error when decoding items array!")
            }
        }
    }
    
}
