import Algorithms
import Foundation

struct Day02: AdventDay {
  let reports: [[Int]]

  init(data: String) {
    self.reports = data.components(separatedBy: .newlines)
      .map { $0.components(separatedBy: .whitespaces).compactMap { Int($0) } }
  }

  func part1() -> Int {
    return reports.count(where: \.isSafe)
  }

  func part2() -> Int {
    return reports.count { levels in
      levels.indices.contains { index in
        levels.removing(at: index).isSafe
      }
    }
  }
}

extension Array where Element == Int {
  fileprivate func isValidDiff(_ diff: Int) -> Bool {
    return 1...3 ~= diff
  }

  fileprivate var isSafe: Bool {
    let pairs = adjacentPairs()
    return pairs.allSatisfy { isValidDiff($0.0 - $0.1) }
      || pairs.allSatisfy { isValidDiff($0.1 - $0.0) }
  }

  func removing(at index: Int) -> Array {
    var copy = self
    copy.remove(at: index)
    return copy
  }
}
