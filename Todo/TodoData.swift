import Foundation

let todoDictionary: [[String:String]] = [
    ["id": "rty", "firstName": "Schroeder", "phone": "9055551234" ],
    ["id": "f4gt", "firstName": "Lyle", "lastName": "Resnick", "birthday": "1982-10-05" ],
    ["id": "67yh", "firstName": "Linus", "birthday": "1984-05-30", "address": "688 Chrislea Ave.",
            "city": "Vaughan", "province": "ON", "postCode": "L3FT4R" ],
    ["id": "45fgg", "firstName": "Snoopy", "phone": "9055551234", "birthday": "1972-08-09" ],
    ["id": "abc1", "firstName": "Charlie", "lastName": "Brown", "phone": "4165551212",
            "birthday": "1985-03-23", "address": "123 First Street", "city": "Toronto", "province": "ON", "postCode": "M6F2E4" ]
]

let todoData = todoDictionary.map { Todo(dictionary: $0) }
