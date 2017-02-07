import UIKit
import FLAnimatedImage
import SDWebImage

fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 50.0, right: 20.0)
fileprivate let itemsPerRow: CGFloat = 3

class PhotosViewController: UICollectionViewController {
    let giphy: GiphyApi = GiphyApi()
    var urls: [URL] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        giphy.getTrending({ urls in
            self.urls = urls
            DispatchQueue.main.async { self.collectionView?.reloadData() }
        })
    }
}

extension PhotosViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.urls.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath as IndexPath)

        if let cell = cell as? PhotoCollectionViewCell {
            cell.imageView.sd_setShowActivityIndicatorView(true)
            cell.imageView.sd_setIndicatorStyle(.gray)
            cell.imageView.sd_setImage(with: self.urls[indexPath.row])
            cell.imageView.contentMode = .scaleAspectFit
        }

        return cell
    }
}

extension PhotosViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
