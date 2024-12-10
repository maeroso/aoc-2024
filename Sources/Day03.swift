import Foundation

struct Day03: AdventDay {
  let data: String

  init(data: String) {
    self.data = data
  }

  func part1() -> Int {
    let search = /mul\((\d+),(\d+)\)/
    let matches = data.matches(of: search)
    return matches.compactMap { Int($0.output.1)! * Int($0.output.2)! }.reduce(0) {$0 + $1}
  }
  
  func part2() -> Int {
    let workingCopy = "do()" + data
    let searchDo = /do\(\)/
    let searchDont = /dont\(\)/
    let mul = /mul\((\d+),(\d+)\)/
    let matchesDo = workingCopy.matches(of: searchDo)
    let matchesDont = workingCopy.matches(of: searchDont)
    let matchesMul = workingCopy.matches(of: mul)
  }

}
