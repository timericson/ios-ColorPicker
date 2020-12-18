//
//  ViewController.swift
//  ColorPicker Experiment
//
//  Created by Tim Ericson on 18/12/20.
//

import UIKit

class ViewController: UIViewController {

    private var selectedColor = UIColor.systemBlue
    private var colorPicker = UIColorPickerViewController()
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.delegate = self
        view.backgroundColor = selectedColor
        setupBarButton()
        
        myLabel.textColor = selectedColor.isDarkColor == true ? .white : .black
    }

    private func selectColor() {
        colorPicker.supportsAlpha = true
        colorPicker.selectedColor = selectedColor
        present(colorPicker, animated: true)
    }

    private func setupBarButton() {
        let pickedColorAction = UIAction(title: "Pick Color") { _ in
            self.selectColor()
        }
        
        let pickColorBarButton = UIBarButtonItem(image: UIImage(systemName: "eyedropper"), primaryAction: pickedColorAction)
        navigationItem.rightBarButtonItem = pickColorBarButton
    }
    
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        print("Color Picker did select a color")
        selectedColor = viewController.selectedColor
        myLabel.textColor = selectedColor.isDarkColor == true ? .white : .black
        view.backgroundColor = selectedColor
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("Color Picker did finish")
    }
}

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.67
    }
}
