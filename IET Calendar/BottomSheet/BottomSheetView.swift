import UIKit

var bottomSheetView: UIView = {
  let view = UIView()
  view.backgroundColor = lightGray
  view.layer.cornerRadius = 25
  view.clipsToBounds = true
  return view
}()

let defaultHeight: CGFloat = 140
let maximumHeight: CGFloat = UIScreen.main.bounds.height - 50
var currentHeight: CGFloat = 300

var heightConstraint: NSLayoutConstraint?
var bottomConstraint: NSLayoutConstraint?

var dimmedView: UIView = {
  let view = UIView()
  view.backgroundColor = .black
  view.alpha = 0.6
  return view
}()
