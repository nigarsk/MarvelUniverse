import UIKit
import AlamofireImage

class MUImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override init(image: UIImage?) {
        super.init(image: image)
        setupUI()
    }

    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func setupUI() {
        layer.masksToBounds = true
        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }
    
    func setImageFromURL(url: URL?) {
        guard let imageURL = url else {
            return
        }
        self.af.setImage(withURL: imageURL)
    }
}
