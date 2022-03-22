import UIKit

var contentStackView: UIView = {
  let view = UIView()

  // MARK: - Content Stack View

  lazy var contentStack: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [infoImageView, ietView])

    NSLayoutConstraint.activate([
      infoImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      infoImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
      
      ietView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      ietView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
    ])

    stackView.axis = .vertical
    stackView.backgroundColor = .clear
    stackView.distribution = .fillEqually

    return stackView
  }()

  func setConstraints() {
    contentStack.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      contentStack.topAnchor.constraint(equalTo: view.topAnchor),
      contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  // MARK: - infoImageView

  lazy var infoImageView: UIView = {
    let view = UIView()
    view.backgroundColor = lightGray

    let imageView = UIImageView(image: UIImage(named: "infoIcon"))
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView)

    [
      infoImageTitleView,
      infoImageTextView,
    ].compactMap { $0 }
      .forEach {
        $0.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview($0)
      }

    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: 50),
      imageView.widthAnchor.constraint(equalToConstant: 50),
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

      infoImageTitleView.topAnchor.constraint(equalTo: view.topAnchor),
      infoImageTitleView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
      infoImageTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

      infoImageTextView.topAnchor.constraint(equalTo: infoImageTitleView.bottomAnchor),
      infoImageTextView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
      infoImageTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    ])

    return view
  }()

  view.translatesAutoresizingMaskIntoConstraints = false
  view.backgroundColor = lightGray
  view.addSubview(contentStack)
  setConstraints()

  return view
}()

var ietView: UIView = {
  let view = UIView()
  view.translatesAutoresizingMaskIntoConstraints = false
  view.backgroundColor = darkGray
  view.isHidden = true

  let ietImageView = UIImageView(image: UIImage(named: "IETIcon"))
  ietImageView.contentMode = .scaleAspectFit

  [
    ietImageView,
    ietTextView,
  ].compactMap { $0 }
    .forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }

  NSLayoutConstraint.activate([
    ietImageView.heightAnchor.constraint(equalToConstant: 50),
    ietImageView.widthAnchor.constraint(equalToConstant: 50),
    ietImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
    ietImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

    ietTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
    ietTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
    ietTextView.leadingAnchor.constraint(equalTo: ietImageView.trailingAnchor, constant: 5),
    ietTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
  ])

  return view
}()

var infoImageTitleView: UILabel = {
  let label = UILabel()
  label.numberOfLines = 0
  label.font = .boldSystemFont(ofSize: 18)
  label.textColor = darkGray
  return label
}()

var infoImageTextView: UITextView = {
  let view = UITextView()
  view.font = .systemFont(ofSize: 16)
  view.backgroundColor = .clear
  view.textColor = darkGray
  view.contentMode = .left
  view.showsVerticalScrollIndicator = false
  view.isEditable = false
  view.isScrollEnabled = false
  return view
}()

var ietTextView: UITextView = {
  let view = UITextView()
  view.textColor = lightGray
  view.font = .systemFont(ofSize: 16)
  view.backgroundColor = .clear
  view.contentMode = .left
  view.showsVerticalScrollIndicator = false
  view.isEditable = false
  return view
}()
