import ARKit
import UIKit

class MainViewController: UIViewController, ARSCNViewDelegate {
  @IBOutlet var sceneView: ARSCNView!

  override func viewDidLoad() {
    super.viewDidLoad()
    sceneView.delegate = self
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
    view.layoutIfNeeded()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    sceneView.session.pause()
  }

  func renderer(_: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    guard let imageAnchor = anchor as? ARImageAnchor else { return }
    guard let month = imageAnchor.referenceImage.name else { return }

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
}
