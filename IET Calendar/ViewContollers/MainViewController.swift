import ARKit
import UIKit

class MainViewController: UIViewController, ARSCNViewDelegate {
  @IBOutlet var sceneView: ARSCNView!

  override func viewDidLoad() {
    super.viewDidLoad()
    configureBottomSheet()
    configureWelcomeSheet()

    sceneView.delegate = self
  }

  func configureWelcomeSheet() {
    view.addSubview(welcomeBottomSheetView)

    NSLayoutConstraint.activate([
      welcomeBottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      welcomeBottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      welcomeBottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      welcomeBottomSheetView.heightAnchor.constraint(equalToConstant: 140),
    ])
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    let configuration = ARImageTrackingConfiguration()

    if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "months images",
                                                            bundle: Bundle.main)
    {
      configuration.trackingImages = trackedImages
      configuration.maximumNumberOfTrackedImages = 1
    }

    sceneView.session.run(configuration)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    dimmedView.alpha = 0
    bottomConstraint?.constant = 0
    view.layoutIfNeeded()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    sceneView.session.pause()
  }

  func renderer(_: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    guard let imageAnchor = anchor as? ARImageAnchor else { return }
    guard let month = imageAnchor.referenceImage.name else { return }

    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.4) {
        welcomeBottomSheetView.removeFromSuperview()
      }
      self.setupPanGesture()
      self.view.layoutIfNeeded()
    }
    
    

    let player = AVPlayer(playerItem: AVPlayerItem(url: Bundle.main.url(
      forResource: month, withExtension: "mp4", subdirectory: "months videos"
    )!))

    player.play()

    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                           object: player.currentItem, queue: nil)
    { _ in
      player.seek(to: CMTime.zero)
      player.play()
    }

    let videoNode = SKVideoNode(avPlayer: player)

    let videoScene = SKScene(size: CGSize(width: 2048, height: 1556))

    videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)

    videoNode.yScale = -1.0

    videoScene.addChild(videoNode)

    let physicalSize = imageAnchor.referenceImage.physicalSize

    let plane = SCNPlane(width: physicalSize.width, height: physicalSize.height)

    plane.firstMaterial?.diffuse.contents = videoScene

    let planeNode = SCNNode(geometry: plane)

    planeNode.eulerAngles.x = -Float.pi / 2

    node.addChildNode(planeNode)
  }

  func renderer(_: SCNSceneRenderer, didUpdate _: SCNNode, for anchor: ARAnchor) {
    guard let imageAnchor = anchor as? ARImageAnchor else { return }
    guard let month = imageAnchor.referenceImage.name else { return }
    guard let monthData = months[month] else { return }

    DispatchQueue.main.async {
      infoImageTitleView.text = monthData.title

      infoImageTextView.text = monthData.imageTextBlock

      ietTextView.text = monthData.mainTextBlock
      
      self.view.layoutIfNeeded()
    }
  }

  func configureBottomSheet() {
    view.addSubview(dimmedView)
    view.addSubview(bottomSheetView)
    dimmedView.translatesAutoresizingMaskIntoConstraints = false
    bottomSheetView.translatesAutoresizingMaskIntoConstraints = false

    bottomSheetView.addSubview(contentStackView)
    contentStackView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
      dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      contentStackView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 40),
      contentStackView.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor),
      contentStackView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
      contentStackView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
    ])

    heightConstraint = bottomSheetView.heightAnchor.constraint(equalToConstant: defaultHeight)

    bottomConstraint = bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)

    heightConstraint?.isActive = true
    bottomConstraint?.isActive = true
  }

  @objc func handleCloseAction() {
    animateDismissing()
  }

  func setupPanGesture() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
    panGesture.delaysTouchesBegan = false
    panGesture.delaysTouchesEnded = false
    view.addGestureRecognizer(panGesture)
  }

  @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: view)

    let isDraggingDown = translation.y > 0

    let newHeight = currentHeight - translation.y

    switch gesture.state {
    case .changed:
      if newHeight < maximumHeight {
        heightConstraint?.constant = newHeight
        ietView.isHidden = false
        view.layoutIfNeeded()
      }
    case .ended:
      if newHeight < defaultHeight {
        animateHeightChanging(defaultHeight)
      } else if newHeight < maximumHeight, isDraggingDown {
        animateHeightChanging(defaultHeight)
        animateDismissing()
      } else if newHeight > defaultHeight, !isDraggingDown {
        animateHeightChanging(maximumHeight)
        animateDimmedViewShowing()
      }
    default:
      break
    }
  }

  func animateDismissing() {
    dimmedView.alpha = 0.6
    UIView.animate(withDuration: 0.4) {
      dimmedView.alpha = 0
      ietView.isHidden = true
    }
  }

  func animateHeightChanging(_ height: CGFloat) {
    UIView.animate(withDuration: 0.4) {
      heightConstraint?.constant = height
      self.view.layoutIfNeeded()
    }
    currentHeight = height
  }

  func animateDimmedViewShowing() {
    dimmedView.alpha = 0
    UIView.animate(withDuration: 0.4) {
      dimmedView.alpha = 0.6
    }
  }
}
