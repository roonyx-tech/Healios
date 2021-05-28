import XCTest

class HealiosUITests: XCTestCase {
    override class func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }
    
    func homeTest() {
        let app = XCUIApplication()
        XCTAssertEqual(app.tables.count, 1)
        let table = app.tables.element(boundBy: 0)
        XCTAssertEqual(table.cells.count, 0)
        
    }
}
