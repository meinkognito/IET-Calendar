import Foundation

struct GuideTextBlock: Decodable, Identifiable {
  var id: Int
  var description: String
  var imageName: String?
}
