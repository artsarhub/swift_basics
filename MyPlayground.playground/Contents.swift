import UIKit

struct MyError: Error {
    let code: Int
    let description: String
}

class SomeClass {
    func getError404() throws -> String {
        throw MyError(code: 404, description: "No data")
    }
    
    func getError505() throws -> String {
        throw MyError(code: 505, description: "Internal server error")
    }
    
    func getOptional() -> String? {
        return nil
    }
}

let someElement = SomeClass()
var someVal = ""
do {
    try someVal = someElement.getError505()
} catch {
    print((error as! MyError).description)
}

if let val = someElement.getOptional() {
    print(val)
}
