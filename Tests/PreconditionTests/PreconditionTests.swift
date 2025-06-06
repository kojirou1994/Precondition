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
    // custom error type
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

    // optional collection
    var optionalCollection: [UInt8]?
    XCTAssertThrowsError(try optionalCollection.notEmpty(errorMessage)) { error in
      XCTAssertTrue(error is ErrorInCode)
    }
    // no message
    XCTAssertThrowsError(try optionalCollection.notEmpty()) { error in
      XCTAssertTrue(error is ErrorInCode)
    }
    // custom error type
    XCTAssertThrowsError(try optionalCollection.notEmpty(CustomError())) { error in
      XCTAssertTrue(error is CustomError)
    }

    optionalCollection = [1, 2, 3, 4]
    XCTAssertNoThrow(try optionalCollection.notEmpty())
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

  func testNoncopyableNilError() {
    struct N: ~Copyable {}

    var value: N?

    do {
      try value.unwrap()
      XCTFail("should throws error")
    } catch { }

    value = .init()
    do {
      try value.unwrap()
    } catch {
      XCTFail("should not throws error")
    }
  }

  func testDescription() {
    XCTAssertThrowsError(try preconditionOrThrow(false)) { error in
      _ = String(describing: error)
    }
  }
}
