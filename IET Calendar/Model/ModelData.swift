import Foundation
import UIKit

// Data which is connected to Month struct

var launchCount = UserDefaults.standard.integer(forKey: "launchCount")

var guideTextBlocks: [GuideTextBlock] = load("guideTextBlocksData.json")
var months: [String: Month] = dictLoad("monthsData.json")

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

func dictLoad(_ filename: String) -> [String: Month] {
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
    return try decoder.decode([String: Month].self, from: data)
  } catch {
    fatalError("Couldn't parse \(filename) as \([String: Month].self):\n\(error)")
  }
}
