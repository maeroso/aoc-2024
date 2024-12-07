import Algorithms

struct Day01: AdventDay {
  typealias PairOfColumns = (left: [Int], right: [Int])
  let columns: PairOfColumns
  
  init(data: String) {
    self.columns = Day01.readColumns(from: data)
  }

  static func readColumns(from data: String) -> PairOfColumns {
    let splittedColumns = data.components(separatedBy: .newlines).map { $0.components(separatedBy: .whitespaces) }
    return (splittedColumns.map { Int($0.first!)! }, splittedColumns.map { Int($0.last!)! })
  }

  func part1() -> Int {
    let differences = zip(columns.left.sorted(), columns.right.sorted()).map { abs($1 - $0) }
    return differences.reduce(0, +)
  }
  
  func part2() -> Int {
    let rightFrequencies = columns.right.grouped(by: \.self).mapValues(\.count)
    return columns.left.reduce(0) { $0 + $1 * (rightFrequencies[$1] ?? 0) }
  }
}
