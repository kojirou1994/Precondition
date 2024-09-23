@_alwaysEmitIntoClient
@inlinable @inline(__always)
public func preconditionOrThrow(_ condition: Bool, _ message: @autoclosure () -> String = String(), fileID: StaticString = #fileID, line: UInt = #line, column: UInt = #column) throws(ErrorInCode) {
  try preconditionOrThrow(condition, ErrorInCode(message: message(), location: CodeLocation(fileID: fileID, line: line, column: column)))
}

@_alwaysEmitIntoClient
@inlinable @inline(__always)
public func preconditionOrThrow<E: Error>(_ condition: Bool, _ error: @autoclosure () -> E) throws(E) {
  if !condition {
    throw error()
  }
}
