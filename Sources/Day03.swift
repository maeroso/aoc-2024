import Foundation

struct Day03: AdventDay {
  var data: String

  init(data: String) {
    self.data = "do()" + data
  }

  func part1() -> Int {
    let search = /mul\((\d+),(\d+)\)/
    let matches = data.matches(of: search)
    return matches.compactMap { Int($0.output.1)! * Int($0.output.2)! }.reduce(0) { $0 + $1 }
  }

  func part2() -> Int {
    let searchDo = /do\(\)/
    let searchDont = /don\'t\(\)/
    let mul = /mul\((\d+),(\d+)\)/

    let doStmts = data.matches(of: searchDo).map {
      Statement.Do(range: $0.range)
    }
    let dontStmts = data.matches(of: searchDont).map {
      Statement.Dont(range: $0.range)
    }
    let mulStmts = data.matches(of: mul).map {
      Statement.Mul(
        firstOperand: Int($0.output.1)!, secondOperand: Int($0.output.2)!,
        range: $0.range)
    }

    let stmts = doStmts + dontStmts + mulStmts
    let sortedStmts = stmts.sorted { $0.range.lowerBound < $1.range.lowerBound }
    return multiplyOnlyEnabledStmts(sortedStmts)
  }

  func multiplyOnlyEnabledStmts(_ stmts: [Statement]) -> Int {
    var isBlockOpen = false
    var total = 0
    for stmt in stmts {
      switch stmt {
      case .Do:
        isBlockOpen = true
      case .Dont:
        isBlockOpen = false
      case .Mul:
        if isBlockOpen {
          total += stmt.firstOperand! * stmt.secondOperand!
        }
      }
    }
    return total
  }

  enum Statement {
    case Do(range: Range<String.Index>)
    case Dont(range: Range<String.Index>)
    case Mul(firstOperand: Int, secondOperand: Int, range: Range<String.Index>)

    var range: Range<String.Index> {
      switch self {
      case .Do(let range): return range
      case .Dont(let range): return range
      case .Mul(firstOperand: _, secondOperand: _, let range): return range
      }
    }

    var firstOperand: Int? {
      switch self {
      case .Do(range: _): return nil
      case .Dont(range: _): return nil
      case .Mul(let firstOperand, secondOperand: _, range: _):
        return firstOperand
      }
    }

    var secondOperand: Int? {
      switch self {
      case .Do(range: _): return nil
      case .Dont(range: _): return nil
      case .Mul(firstOperand: _, let secondOperand, range: _):
        return secondOperand
      }
    }
  }

}
