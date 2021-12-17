import UIKit

class FloatingLabelInput: UITextField {

    enum Direction {
        case Left
        case Right
    }

    var floatingLabel: UILabel!// = UILabel(frame: CGRect.zero)
    var floatingLabelHeight: CGFloat = 14
    var button = UIButton(type: .custom)
    var imageView = UIImageView(frame: CGRect.zero)
    var bLayer = CALayer()
    
    @IBInspectable
    var _placeholder: String?
    
    @IBInspectable
    var floatingLabelColor: UIColor = ProjectDefaults.DarkerPrimary {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var activeBorderColor: UIColor = ProjectDefaults.DarkerPrimary
    
    @IBInspectable
    var floatingLabelBackground: UIColor = UIColor.white.withAlphaComponent(0) {
        didSet {
            self.floatingLabel.backgroundColor = self.floatingLabelBackground
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var _backgroundColor: UIColor = UIColor.clear {
        didSet {
            self.bLayer.backgroundColor = self._backgroundColor.cgColor
        }
    }
    
    func resetLayer(margins: CGFloat = 0){
        self.layer.frame.size = CGSize(width: self.layer.frame.width.relativeToIphone8Width(margins: margins), height: self.layer.frame.height)
        self.bLayer.frame.size = self.layer.frame.size// = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.setNeedsDisplay()
    }
    
    func overlaySetup(){
        let size = self.layer.frame.size
        bLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bLayer.borderColor = ProjectDefaults.lightBorderColor.cgColor
        bLayer.borderWidth = 1
        bLayer.cornerRadius = 8
        self.layer.insertSublayer(bLayer, at: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder
        placeholder = self._placeholder
        self.floatingLabel = UILabel(frame: CGRect.zero)
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
        self.layer.cornerRadius = 8
        overlaySetup()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if self.text == ""{
            return bounds.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        }else{
            return bounds.inset(by: UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20))
        }
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20))
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 10, left: bounds.width*0.8, bottom: 10, right: -5))
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 10, right: bounds.width*0.8))
    }
    // Add a floating label to the view on becoming first responder
    @objc func addFloatingLabel() {
        self.bLayer.borderColor = self.activeBorderColor.cgColor
        if self.text == "" {
            self.floatingLabel.textColor = floatingLabelColor
            self.floatingLabel.font = floatingLabelFont
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.layer.backgroundColor = _backgroundColor.cgColor
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.clipsToBounds = true
            self.floatingLabel.frame = CGRect(x: 32, y: -12, width: floatingLabel.frame.width+4, height: floatingLabel.frame.height+2)
            self.floatingLabel.textAlignment = .center
            self.addSubview(self.floatingLabel)
            
            self.floatingLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
            self.floatingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
            self.placeholder = ""
        }
        // Floating label may be stuck behind text input. Bring it forward as it was the last item added to the view heirachy
        self.bringSubviewToFront(subviews.last!)
        self.setNeedsDisplay()
    }
    
    @objc func removeFloatingLabel() {
        if self.text == "" {
            UIView.animate(withDuration: 0.13) {
                self.subviews.forEach{ $0.removeFromSuperview() }
                self.setNeedsDisplay()
            }
            self.placeholder = self._placeholder
        }
        self.bLayer.borderColor = ProjectDefaults.lightBorderColor.cgColor
    }
    
    func addViewPasswordButton() {
        self.button.setImage(UIImage(named: "ic_reveal"), for: .normal)
        self.button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.button.frame = CGRect(x: 0, y: 16, width: 22, height: 16)
        self.button.clipsToBounds = true
        self.rightView = self.button
        self.rightViewMode = .always
        self.button.addTarget(self, action: #selector(self.enablePasswordVisibilityToggle), for: .touchUpInside)
    }
    
    func addImage(image: UIImage, side: Direction){
        
        self.imageView.image = image
        self.imageView.frame = CGRect(x: 22, y: 0, width: 20, height: 20)
        self.imageView.translatesAutoresizingMaskIntoConstraints = true
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        self.imageView.backgroundColor = .clear//_backgroundColor
        
        DispatchQueue.main.async {
            if(Direction.Left == side){
                self.leftView = self.imageView
                self.leftViewMode = .always
            } else {
                self.rightViewMode = .always
                self.rightView = self.imageView
            }
            
        }
        
    }
    
    @objc func enablePasswordVisibilityToggle() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            self.button.setImage(UIImage(named: "ic_show"), for: .normal)
        }else{
            self.button.setImage(UIImage(named: "ic_hide"), for: .normal)
        }
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: bounds.height))
        view.backgroundColor = .none
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        //view.layer.borderWidth = CGFloat(0.5)
        //view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 30.0, height: 30.0)
        imageView.backgroundColor = _backgroundColor
        view.addSubview(imageView)

        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)

        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: bounds.height)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: bounds.height)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
        addSubview(mainView)
    }

}


