extension Optional where Wrapped: ~Copyable {

  @discardableResult
  @_alwaysEmitIntoClient
  @inlinable @inline(__always)
  public consuming func unwrap(_ message: @autoclosure () -> String = String(),
                               fileID: StaticString = #fileID, line: UInt = #line, column: UInt = #column) throws(ErrorInCode) -> Wrapped {
    try unwrap(ErrorInCode(message: message(), location: CodeLocation(fileID: fileID, line: line, column: column)))
  }

  @discardableResult
  @_alwaysEmitIntoClient
  @inlinable @inline(__always)
  public consuming func unwrap<E: Error>(_ error: @autoclosure () -> E) throws(E) -> Wrapped {
    guard let value = self else {
      throw error()
    }
    return value
  }

}
