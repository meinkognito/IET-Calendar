import UIKit

// GuideViewController is related to Guide page

class GuideViewController: UIViewController {
  @IBOutlet var stackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()
    configureStackView()
  }

  func configureStackView() {
    for guide in guideTextBlocks {
      let view = createTextBlock(from: guide)
      stackView.addArrangedSubview(view)

      NSLayoutConstraint.activate([
        view.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
        view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
      ])
    }
  }

  func createTextBlock(from block: GuideTextBlock) -> UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    let textView = UITextView()
    textView.text = String(block.id) + ". " + block.description

    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.isEditable = false
    textView.backgroundColor = .clear
    textView.isScrollEnabled = false
    textView.contentMode = .left
    textView.showsVerticalScrollIndicator = false

    textView.attributedText = NSAttributedString.makeHyperLink(for: GuideTextBlock.URL,
                                                               in: textView.text,
                                                               as: "по ссылке")
    
    textView.textColor = lightGray
    textView.font = .boldSystemFont(ofSize: 17)
    textView.tintColor = .link

    view.addSubview(textView)

    switch block.imageName {
    case let imageName?:
      let imageView = UIImageView(image: UIImage(named: imageName))
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFit
      view.addSubview(imageView)

      NSLayoutConstraint.activate([
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        imageView.widthAnchor.constraint(equalToConstant: 50),
        imageView.heightAnchor.constraint(equalToConstant: 50),
        imageView.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 20),
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      ])

    case nil:
      NSLayoutConstraint.activate([
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      ])
    }

    return view
  }
}
