import UIKit

// WelcomeBottomSheetView is related to "welcome message" to user which helps him/her what to do

var welcomeBottomSheetView: UIView = {
  let view = UIView()
  view.backgroundColor = lightGray
  view.translatesAutoresizingMaskIntoConstraints = false
  view.layer.cornerRadius = 25

  let label = UILabel()
  label.text = "Наведите камеру на изображение календаря"
  label.textAlignment = .center
  label.textColor = darkGray
  label.backgroundColor = .clear
  label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
  label.numberOfLines = 2
  label.translatesAutoresizingMaskIntoConstraints = false

  view.addSubview(label)

  NSLayoutConstraint.activate([
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  ])

  return view
}()
