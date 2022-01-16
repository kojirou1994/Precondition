extension Optional {

  @discardableResult
  @inlinable
  public func unwrap(_ message: @autoclosure () -> String = String(),
                     fileID: StaticString = #fileID, line: UInt = #line, column: UInt = #column) throws -> Wrapped {
    try unwrap(ErrorInCode(header: "Unwrap failed", message: message(), location: CodeLocation(fileID: fileID, line: line, column: column)))
  }

  @discardableResult
  @inlinable
  public func unwrap<E: Error>(_ error: @autoclosure () -> E) throws -> Wrapped {
    guard let value = self else {
      throw error()
    }
    return value
  }

}
