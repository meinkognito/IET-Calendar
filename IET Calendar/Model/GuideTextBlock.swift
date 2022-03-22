import Foundation

// GuideTextBlock is a text block, which is shown on the Guide page

struct GuideTextBlock: Decodable, Identifiable {
  var id: Int
  var description: String
  var imageName: String?

  static let URL = "https://github.com/meinkognito/IET-Calendar/raw/master/calendar.pdf"
}
