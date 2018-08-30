import Foundation
import Alamofire

public final class Test3 {
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else {
            print("Hello World")
            return
        }
        // The first argument is the execution path
        let fileName = arguments[1]
        
        print(fileName)
    }
}
