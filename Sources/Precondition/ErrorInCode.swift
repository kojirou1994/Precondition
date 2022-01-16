public struct CodeLocation {

  public let fileID: StaticString
  public let line: UInt
  public let column: UInt

  public init(fileID: StaticString = #fileID, line: UInt = #line, column: UInt = #column) {
    self.fileID = fileID
    self.line = line
    self.column = column
  }
}

public struct ErrorInCode: Error, CustomStringConvertible {

  public let message: String
  public let location: CodeLocation

  @usableFromInline
  internal init(message: String, location: CodeLocation) {
    self.message = message
    self.location = location
  }

  public var description: String {
    "Error in code, message: \(message), file \(location.fileID), line \(location.line), column \(location.column)"
  }
}
