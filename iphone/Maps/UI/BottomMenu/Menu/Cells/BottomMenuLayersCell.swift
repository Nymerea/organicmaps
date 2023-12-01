import UIKit

class BottomMenuLayersCell: UITableViewCell {
  @IBOutlet private var trafficButton: BottomMenuLayerButton! {
    didSet {
      updateTrafficButton()
    }
  }
  @IBOutlet private var subwayButton: BottomMenuLayerButton! {
    didSet {
      updateSubwayButton()
    }
  }
  @IBOutlet private var isoLinesButton: BottomMenuLayerButton! {
    didSet {
      updateIsoLinesButton()
    }
  }
  @IBOutlet private var outdoorButton: BottomMenuLayerButton! {
    didSet {
      updateOutdoorButton()
    }
  }

  var onClose: (()->())?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    MapOverlayManager.add(self)
  }
  
  deinit {
    MapOverlayManager.remove(self)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func updateTrafficButton() {
    // TODO: enable button back in xib.
    if trafficButton == nil { return }
    let enabled = MapOverlayManager.trafficEnabled()
    trafficButton.setStyleAndApply(enabled ? "MenuButtonEnabled" : "MenuButtonDisabled")
  }
  
  private func updateSubwayButton() {
    let enabled = MapOverlayManager.transitEnabled()
    subwayButton.setStyleAndApply(enabled ? "MenuButtonEnabled" : "MenuButtonDisabled")
  }
  
  private func updateIsoLinesButton() {
    let enabled = MapOverlayManager.isoLinesEnabled()
    isoLinesButton.setStyleAndApply(enabled ? "MenuButtonEnabled" : "MenuButtonDisabled")
  }
    
  private func updateOutdoorButton() {
    let enabled = MapOverlayManager.outdoorEnabled()
    outdoorButton.setStyleAndApply(enabled ? "MenuButtonEnabled" : "MenuButtonDisabled")
  }
  
  @IBAction func onCloseButtonPressed(_ sender: Any) {
    onClose?()
  }
  
  @IBAction func onTrafficButton(_ sender: Any) {
    let enable = !MapOverlayManager.trafficEnabled()
    MapOverlayManager.setTrafficEnabled(enable)
  }
  
  @IBAction func onSubwayButton(_ sender: Any) {
    let enable = !MapOverlayManager.transitEnabled()
    MapOverlayManager.setTransitEnabled(enable)
  }
  
  @IBAction func onIsoLinesButton(_ sender: Any) {
    let enable = !MapOverlayManager.isoLinesEnabled()
    MapOverlayManager.setIsoLinesEnabled(enable)
  }
    
  @IBAction func onOutdoorButton(_ sender: Any) {
    let enable = !MapOverlayManager.outdoorEnabled()
    MapOverlayManager.setOutdoorEnabled(enable)
  }
}

extension BottomMenuLayersCell: MapOverlayManagerObserver {
  func onTrafficStateUpdated() {
    updateTrafficButton()
  }
  
  func onTransitStateUpdated() {
    updateSubwayButton()
  }
  
  func onIsoLinesStateUpdated() {
    updateIsoLinesButton()
  }
    
  func onOutdoorStateUpdated() {
    updateOutdoorButton()
  }
}
