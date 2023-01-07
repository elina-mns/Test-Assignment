import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func downloadImage(from url: URL, placeholder: UIImage?) {
        DispatchQueue.global().async {
            let cache = URLCache.shared
            let request = URLRequest(url: url)
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                self.set(image: image)
            } else {
                self.set(image: placeholder)
                URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                        let data = data, error == nil,
                        let image = UIImage(data: data)
                    else {
                        return
                    }
                    DispatchQueue.main.async() {
                        self?.image = image
                    }
                }).resume()
            }
        }
    }
    private func set(image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
