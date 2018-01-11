import Foundation

extension DateFormatter {
    
    static func dateFormatter(format: String ) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
