import Test3Core

let tool = Test3()

do {
    try tool.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}
