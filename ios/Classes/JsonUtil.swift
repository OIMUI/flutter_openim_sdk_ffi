import Foundation

public struct JsonUtil {
    private static let jsonEncoder = JSONEncoder()
    private static let jsonDecoder = JSONDecoder()
    
    /**
     * 将object对象转成json字符串
     */
    public static func toString<T: Encodable>(_ object: T) -> String? {
        do {
            let jsonData = try jsonEncoder.encode(object)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Failed to convert object to JSON string: \(error)")
            return nil
        }
    }
    
    /**
     * 将json字符串转成泛型bean
     */
    public static func toObj<T: Decodable>(_ jsonString: String, to type: T.Type) -> T? {
        do {
            let jsonData = jsonString.data(using: .utf8)!
            return try jsonDecoder.decode(type, from: jsonData)
        } catch {
            print("Failed to convert JSON string to object: \(error)")
            return nil
        }
    }
    
    /**
     * 转成list
     */
    public static func toArray<T: Decodable>(_ jsonString: String, to type: T.Type) -> [T]? {
        do {
            let jsonData = jsonString.data(using: .utf8)!
            return try jsonDecoder.decode([T].self, from: jsonData)
        } catch {
            print("Failed to convert JSON array to list: \(error)")
            return nil
        }
    }
    
    /**
     * 转成list中有map的
     */
    public static func toListMaps<T: Decodable>(_ jsonString: String) -> [Dictionary<String, T>]? {
        do {
            let jsonData = jsonString.data(using: .utf8)!
            return try jsonDecoder.decode([Dictionary<String, T>].self, from: jsonData)
        } catch {
            print("Failed to convert JSON to list of maps: \(error)")
            return nil
        }
    }
    
    /**
     * 转成map的
     */
    public static func toMaps<T: Decodable>(_ jsonString: String) -> Dictionary<String, T>? {
        do {
            let jsonData = jsonString.data(using: .utf8)!
            return try jsonDecoder.decode(Dictionary<String, T>.self, from: jsonData)
        } catch {
            print("Failed to convert JSON to map: \(error)")
            return nil
        }
    }
}
