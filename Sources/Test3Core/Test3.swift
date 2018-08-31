import Foundation
import Alamofire
import SwiftyJSON

public final class Test3 {
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    var shouldKeepRunning = true
    let runLoop = RunLoop.current
    let distantFuture = Date.distantFuture
    
    public func run() throws {
 
        print("Type username")
        let userName = getInput()
        if userName.isEmpty || userName.containsWhitespace {
            print("userName is wrong")
            return
        }
        
//        var shouldQuit = false
//        while !shouldQuit {
//            let first = getInput()
//            if first == "q" {
//                shouldQuit = true
//            }
//        }
        
        downloadUserRepos(userName: userName) { (resultsTags) in
            guard let resultsTags = resultsTags else {
                print("Result is empty")
                self.shouldKeepRunning = false
                return;
            }
            for item in resultsTags {
                print(item)
            }
            self.shouldKeepRunning = false
        }

        while shouldKeepRunning == true &&
            runLoop.run(mode: .defaultRunLoopMode, before: distantFuture) {}
    }
    
    func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    func downloadUserRepos(userName: String, completion: @escaping ([String]?) -> Void) {
        Alamofire.request("https://api.github.com/users/\(userName)/repos")
            .responseJSON { response in
                
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching users repos: \(String(describing: response.result.error))")
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

extension String {
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
}
