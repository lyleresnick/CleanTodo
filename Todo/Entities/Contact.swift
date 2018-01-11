
import Foundation

struct Contact {
    let id: String
    let firstName: String?
    let lastName: String?
    let phone: String?
    let birthday: Date?
    let address: String?
    let address2: String?
    let city: String?
    let province: String?
    let postCode: String?
    
    private static let inboundDateFormatter = DateFormatter.dateFormatter( format:"yyyy'-'MM'-'dd")

    init(dictionary: [String:String]) {
        
        guard let id = dictionary["id"] else {
            fatalError("Missing id")
        }
        let firstName = dictionary["firstName"]
        let lastName = dictionary["lastName"]
        let phone = dictionary["phone"]
        let birthday = dictionary["birthday"]
        let address = dictionary["address"]
        let address2 = dictionary["address2"]
        let city = dictionary["city"]
        let province = dictionary["province"]
        let postCode = dictionary["postCode"]

        self.init(
            id: id,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            birthday: (birthday != nil) ? Contact.convert(birthday: birthday!) : nil,
            address: address,
            address2: address2,
            city: city,
            province: province,
            postCode: postCode)
    }
    
    private static func convert(birthday: String) -> Date {
        guard let birthday = Contact.inboundDateFormatter.date( from: birthday ) else {
            fatalError("Format of Birthday is incorrect")
        }
        return birthday
    }

    
    init(id: String,
         firstName: String? = nil,
         lastName: String? = nil,
         phone: String? = nil,
         birthday: Date? = nil,
         address: String? = nil,
         address2: String? = nil,
         city: String? = nil,
         province: String? = nil,
         postCode: String? = nil) {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.birthday = birthday
        self.address = address
        self.address2 = address2
        self.city = city
        self.province = province
        self.postCode = postCode
    }
}
