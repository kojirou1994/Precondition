import XCTest
import Precondition

/// example custom error type
struct CustomError: Error {}

final class PreconditionTests: XCTestCase {

  func testCollectionEmptyError() {
    let emptyCollection = EmptyCollection<Int>()

    // custom message
    let errorMessage = "Error message"
    XCTAssertThrowsError(try emptyCollection.notEmpty(errorMessage)) { error in
      XCTAssertTrue(error is ErrorInCode)
    }
    // no message
    XCTAssertThrowsError(try emptyCollection.notEmpty()) { error in
      XCTAssertTrue(error is ErrorInCode)
    }

    XCTAssertThrowsError(try emptyCollection.notEmpty(CustomError())) { error in
      XCTAssertTrue(error is CustomError)
    }

    func testNonEmptyCollection<T: Collection>(_ c: T) where T.Element: Equatable {
      XCTAssertNoThrow(try c.notEmpty())

      XCTAssertTrue(c.elementsEqual(try! c.notEmpty()))
      XCTAssertTrue(c.elementsEqual(try! c.notEmpty(CustomError())))
    }

    testNonEmptyCollection(CollectionOfOne(0))
    testNonEmptyCollection(["A", "B"])
  }

  func testOptionalNilError() {
    let nilValue: Int? = nil

    // custom message
    let errorMessage = "Error message"
    XCTAssertThrowsError(try nilValue.unwrap(errorMessage)) { error in
      XCTAssertTrue(error is ErrorInCode)
    }
    // no message
    XCTAssertThrowsError(try nilValue.unwrap()) { error in
      XCTAssertTrue(error is ErrorInCode)
    }

    XCTAssertThrowsError(try nilValue.unwrap(CustomError())) { error in
      XCTAssertTrue(error is CustomError)
    }

    let nonNilValue: Int? = 5
    XCTAssertNoThrow(try nonNilValue.unwrap())

    XCTAssertEqual(nonNilValue, try! nonNilValue.unwrap())
    XCTAssertEqual(nonNilValue, try! nonNilValue.unwrap(CustomError()))
  }

  func testPreconditionFailError() {
    let message = "Message"
    XCTAssertNoThrow(try preconditionOrThrow(true, message))
    XCTAssertThrowsError(try preconditionOrThrow(false, message)) { error in
      XCTAssertTrue(error is ErrorInCode)
    }
    XCTAssertThrowsError(try preconditionOrThrow(false)) { error in
      XCTAssertTrue(error is ErrorInCode)
    }
  }

}
