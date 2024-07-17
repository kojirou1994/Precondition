extension Collection {

  @discardableResult
  @_alwaysEmitIntoClient
  @inlinable @inline(__always)
  public func notEmpty(_ message: @autoclosure () -> String = String(),
                       fileID: StaticString = #fileID, line: UInt = #line, column: UInt = #column) throws -> Self {
    try notEmpty(ErrorInCode(message: message(), location: CodeLocation(fileID: fileID, line: line, column: column)))
  }

  @discardableResult
  @_alwaysEmitIntoClient
  @inlinable @inline(__always)
  public func notEmpty<E: Error>(_ error: @autoclosure () -> E) throws -> Self {
    if isEmpty {
      throw error()
    }
    return self
  }

}

extension Optional where Wrapped: Collection {
  @discardableResult
  @_alwaysEmitIntoClient
  @inlinable @inline(__always)
  public func notEmpty(_ message: @autoclosure () -> String = String(),
                       fileID: StaticString = #fileID, line: UInt = #line, column: UInt = #column) throws -> Wrapped {
    try notEmpty(ErrorInCode(message: message(), location: CodeLocation(fileID: fileID, line: line, column: column)))
  }

  @discardableResult
  @_alwaysEmitIntoClient
  @inlinable @inline(__always)
  public func notEmpty<E: Error>(_ error: @autoclosure () -> E) throws -> Wrapped {
    guard let unwrap = self, !unwrap.isEmpty else {
      throw error()
    }
    return unwrap
  }
}
