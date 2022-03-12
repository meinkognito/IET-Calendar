import Foundation
import UIKit

let lightGray = UIColor(red: 233 / 255, green: 233 / 255, blue: 233 / 255, alpha: 1)
let darkGray = UIColor(red: 97 / 255, green: 97 / 255, blue: 97 / 255, alpha: 1)

var guideTextBlocks: [GuideTextBlock] = load("guideTextBlocksData.json")
var months: [Month] = load("monthsData.json")

func load<T: Decodable>(_ filename: String) -> T {
  let data: Data

  guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
  else {
    fatalError("Couldn't find \(filename) in main bundle.")
  }

  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
  }

  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
  }
}
