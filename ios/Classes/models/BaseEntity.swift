public class BaseEntity: Encodable, CustomStringConvertible {
    public var description: String {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting to JSON: \(error)")
        }
        return ""
    }
}
