import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var customOverlayView: UIView!
    @IBOutlet var imageView: UIImageView!
    
    let myShapeLayer = CAShapeLayer()
    
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
        
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.allowsEditing = true
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDevice.Front
        imagePickerController.showsCameraControls = true
        imagePickerController.title = "Take a selfie with custom overlay!"
        imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
        //imagePickerController.cameraViewTransform = CGAffineTransformMakeRotation(1)
        imagePickerController.delegate = self
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func takeSelfieCustomOverlayButtonTouchUpInside(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false) {
            return
        }
        
        let imagePickerController = UIImagePickerController()
        //imagePickerController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.delegate = self
        
        //imagePickerController.mediaTypes = [kUTTypeImage as String]
        //imagePickerController.allowsEditing = true
        //imagePickerController.cameraDevice = UIImagePickerControllerCameraDevice.Front
        imagePickerController.showsCameraControls = true
        //imagePickerController.title = "Take a selfie!"
        //imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
        //imagePickerController.cameraViewTransform = CGAffineTransformMakeRotation(1)
        NSBundle.mainBundle().loadNibNamed("CustomOverlayView", owner: self, options: nil)
        //self.customOverlayView.backgroundColor = UIColor.clearColor()
        //self.customOverlayView.opaque = false
        self.customOverlayView.frame = (imagePickerController.cameraOverlayView?.frame)!

        var rad: CGFloat = 300
        let size = self.view.frame.size
        
        let path = UIBezierPath(roundedRect: CGRectMake(0, 44, size.width, size.height - 166), cornerRadius: 0.0)
        let circlePath = UIBezierPath(roundedRect: CGRectMake(size.width / 2.0 - rad / 2.0, 80, rad, rad), cornerRadius: rad)
        path.appendPath(circlePath)
        path.usesEvenOddFillRule = true
        
        self.myShapeLayer.path = path.CGPath
        self.myShapeLayer.opaque = false
        self.myShapeLayer.fillColor = UIColor(white: 1, alpha: 0.8).CGColor
        self.myShapeLayer.fillRule = kCAFillRuleEvenOdd
        
        //The line below creates a frame around the view.
        //TODO: Remove the line below if you don't want a frame around your image view.
        self.myShapeLayer.borderWidth = 1.0
        
        //add our shape layer as a sublayer of the image view's layer.
        self.customOverlayView.layer.addSublayer(myShapeLayer)
        imagePickerController.cameraOverlayView = customOverlayView
        //self.customOverlayView = nil
        
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        if (self.imageView.image == nil) {
            self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        print(info)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("Image picking canceled!")
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}