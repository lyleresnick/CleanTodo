import Foundation

let todoDictionary: [[String:String]] = [
    ["id": "1", "title": "Get Milk", "notes": "lots", "priority": "low", "done": "true" ],
    ["id": "1", "title": "Get Going", "notes": "The sdFDS sd fdsfFSD  DSFds\nsdf sdf sd fsd f\nf sdf sd f", "date": "2018-12-12", "priority": "high", "done": "false" ],
    ["id": "1", "title": "Farm Tools", "notes": "hammer, nails, plow", "priority": "medium", "done": "false" ],
    ["id": "1", "title": "Get Milk", "notes": "lots", "done": "true" ],
    ["id": "1", "title": "Charlie Brown", "notes": "Get the album", "date": "2019-02-12", "priority": "high", "done": "false" ],
]

let todoData = todoDictionary.map { Todo(dictionary: $0) }
