//
//  ViewController.swift
//  LinhKa_Paint
//
//  Created by macbook on 10/13/18.
//  Copyright © 2018 Viet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var pixel: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var baseImage = UIImage()
    
    // Draw
    var swiped = false
    
    let colorNames = ["Black", "Grey", "Red", "Blue", "LightBlue", "DarkGreen", "LightGreen", "Brown", "DarkOrange", "Yellow"]
    
    let colorCodes: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Navigation Bar Buttons
    @IBAction func barButtonAction(sender: UIBarButtonItem) {
        switch sender.title! {
        case "Undo":
            imageView.image = baseImage
        case "Save":
            UIImageWriteToSavedPhotosAlbum(imageView.image!, self, nil, nil)
        case "Album":
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(imgPicker, animated: true, completion: nil)
        default:
            break
        }
    }
    
    // Brushes action
    @IBAction func drawButtonAction(sender: UIButton) {
        let index = sender.tag
        switch index {
        case 0:
            pixel = 5
        case 1:
            pixel = 10
        case 2:
            pixel = 30
        case 3:
            (red,green,blue) = colorCodes[10]
        default:
            break
        }
    }
    
    // Start to draw
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touches = touches.first {
            lastPoint = touches.locationInView(imageView)
        }
    }
    
    // Drawing.
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.locationInView(imageView)
            drawLine(lastPoint, to: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    // Click 1 time
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !swiped {
            drawLine(lastPoint, to: lastPoint)
        }
    }
    
    func drawLine(from: CGPoint, to: CGPoint) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        let imageSize = imageView.frame.size
        imageView.image?.drawInRect(CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        CGContextMoveToPoint(context, from.x, from.y)
        CGContextAddLineToPoint(context, to.x, to.y)
        
        // Brush head shape
        CGContextSetLineCap(context, CGLineCap.Round)
        // Brush size
        CGContextSetLineWidth(context, pixel)
        // Brush color
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        // Brush style
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        CGContextStrokePath(context)
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        imageView.alpha = opacity
        //Close.
        UIGraphicsEndImageContext()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorCodes.count - 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: colorNames[indexPath.item])
        return cell
    }
    
    // Select color
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        (red,green,blue) = colorCodes[indexPath.item]
    }
    
    // Image Picker Controller Delegate + Undo
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            baseImage = pickedImage
            imageView.image = baseImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

