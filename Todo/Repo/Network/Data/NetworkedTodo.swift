//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

struct NetworkedTodo: Codable  {

    let id: String?
    let title: String
    let note: String
    let completeBy: Date?
    let priority: String
    let completed: Bool
}

//extension NetworkedTodo: Codable {
//
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case title
//        case note
//        case completeBy
//        case priority
//        case completed
//    }
//
//    init(from decoder:Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let id = try values.decode(String.self, forKey: .id)
//        let title = try values.decode(String.self, forKey: .title)
//        let note = try values.decode(String.self, forKey: .note)
//        let completeBy = try values.decodeIfPresent(Date.self, forKey: .completeBy)
//        let priority = try values.decode(String.self, forKey: .priority)
//        let completed = try values.decode(Bool.self, forKey: .completed)
//        self.init(id: id, title: title, note: note, completeBy: completeBy, priority: priority, completed: completed)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(title, forKey: .title)
//        try container.encode(note, forKey: .note)
//        if let completeBy = completeBy {
//            try container.encode(completeBy, forKey: .completeBy)
//        }
//        try container.encode(priority, forKey: .priority)
//        try container.encode(completed, forKey: .completed)
//    }
//
//}
//
//
//
//
