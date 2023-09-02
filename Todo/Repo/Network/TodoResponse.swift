//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

struct TodoResponse  {

    let id: String
    let title: String
    let note: String
    let completeBy: Date?
    let priority: String
    let completed: Bool
}

extension TodoResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case note
        case completeBy
        case priority
        case completed
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(String.self, forKey: .id)
        let title = try values.decode(String.self, forKey: .title)
        let note = try values.decodeIfPresent(String.self, forKey: .note) ?? ""
        let completeBy = try values.decodeIfPresent(Date.self, forKey: .completeBy)
        let priority = try values.decode(String.self, forKey: .priority)
        let completed = try values.decode(Bool.self, forKey: .completed)
        
        self.init(id: id, title: title, note: note, completeBy: completeBy, priority: priority, completed: completed)
    }
}

