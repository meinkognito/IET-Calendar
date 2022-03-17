import Foundation

struct GuideTextBlock: Decodable, Identifiable {
  var id: Int
  var description: String
  var imageName: String?

  static let URL = "https://github.com/meinkognito/IET-Calendar/raw/master/calendar.pdf"
}
