import Foundation
import Alamofire
import SwiftyJSON

public final class Test3 {
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
//        guard arguments.count > 1 else {
//            print("Hello World")
//            return
//        }
        // The first argument is the execution path
//        let fileName = arguments[1]
        
//        print(fileName)
 
        print("Hello World")
        
        downloadTags(contentID: "2") { (resultsTags) in
            guard let resultsTags = resultsTags else {
                print("Error while downloadTags")
                return;
            }
            for item in resultsTags {
                print(item)
            }
        }
//        var shouldQuit = false
//        while !shouldQuit {
//            let first = getInput()
//            if first == "q" {
//                shouldQuit = true
//            }
//        }
        RunLoop.main.run()
    }
    
    func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    func downloadTags(contentID: String, completion: @escaping ([String]?) -> Void) {
        Alamofire.request("https://api.github.com/users/Demmy27/repos")
            .responseJSON { response in
                
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching tags: \(String(describing: response.result.error))")
                        completion(nil)
                        return
                }
//                print(response.result.value!)
                let tags = JSON(value).array?.map { json in
                    json["name"].stringValue
                }
                
                completion(tags)
        }
    }
}
