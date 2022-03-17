import Foundation
import UIKit

// custom color initialization

let lightGray = UIColor(red: 233 / 255, green: 233 / 255, blue: 233 / 255, alpha: 1)
let darkGray = UIColor(red: 97 / 255, green: 97 / 255, blue: 97 / 255, alpha: 1)

// NSAttributedString extension for creating hyperlinks

extension NSAttributedString {
  static func makeHyperLink(for path: String, in string: String, as substring: String) -> NSAttributedString {
    let result = NSMutableAttributedString(string: string)
    let tempString = NSString(string: string)
    let substringRange = tempString.range(of: substring)
    result.addAttribute(.link, value: path, range: substringRange)
    return result
  }
}
