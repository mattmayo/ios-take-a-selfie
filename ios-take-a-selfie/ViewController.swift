import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func takeSelfieButtonTouchUpInside(sender: UIButton) {
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false) {
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        
        imagePickerController.mediaTypes = [kUTTypeImage]
        imagePickerController.allowsEditing = true
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDevice.Front
        imagePickerController.showsCameraControls = true
        imagePickerController.title = "Take a selfie!"
        imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
        //imagePickerController.cameraViewTransform = CGAffineTransformMakeRotation(1)
        imagePickerController.delegate = self
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func chooseFromGalleyTouchUpInside(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == false) {
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary

        imagePickerController.delegate = self
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.imageView.image = image
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        if (self.imageView.image == nil) {
            self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        println(info)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        println("Image picking canceled!")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}