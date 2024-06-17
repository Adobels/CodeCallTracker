import XCTest
@testable import FunctionCallTracker

final class FunctionCallTrackerTests: XCTestCase {

    typealias SUT = SpyViewController
    private var spy: SUT!

    override func setUp() {
        super.setUp()
        spy = .init()
    }

    func testIsFirstTimeCallIsCalledOnlyOnFirstCall() throws {
        spy.viewDidLoad()
        XCTAssertEqual(spy.viewDidLoadCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, .zero)

        spy.viewWillAppear(false)
        XCTAssertEqual(spy.viewDidLoadCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)

        spy.viewDidLoad()
        XCTAssertEqual(spy.viewDidLoadCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)

        spy.viewWillAppear(false)
        XCTAssertEqual(spy.viewDidLoadCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)
    }

    func testIsFirstTimeCallArgumentValuesNoImpact() throws {
        spy.viewWillAppear(false)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)

        spy.viewWillAppear(true)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)
    }

    func testIsFirstTimeCallArgumentTypesNoInterference() throws {
        spy.viewWillAppear(false)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentStringCallCounter, .zero)

        spy.viewWillAppear("")
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentStringCallCounter, 1)
    }
}

extension FunctionCallTrackerTests {

    class BaseViewController {

        func viewDidLoad() {}

        func viewWillAppear(_ animated: Bool) {}
    }

    class ViewController: BaseViewController {

        var funcCallTracker = FunctionCallTracker()
    }

    class SpyViewController: ViewController {

        var viewDidLoadCallCounter = Int.zero
        var viewWillAppearArgumentBoolCallCounter = Int.zero
        var viewWillAppearArgumentStringCallCounter = Int.zero

        override func viewDidLoad() {
            super.viewDidLoad()
            if funcCallTracker.isFirstTimeCall() {
                viewDidLoadCallCounter += 1
            }
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if funcCallTracker.isFirstTimeCall() {
                viewWillAppearArgumentBoolCallCounter += 1
            }
        }

        func viewWillAppear(_ animated: String) {
            if funcCallTracker.isFirstTimeCall() {
                viewWillAppearArgumentStringCallCounter += 1
            }
        }
    }
}
