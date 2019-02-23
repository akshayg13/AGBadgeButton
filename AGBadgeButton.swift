import UIKit

class AGBadgeButton : UIButton {
    
    //Properties
    private let badgeLabel = UILabel()
    private let backgroundView = UIView()
    private var value = 0
    private var badgeSize : CGFloat = 17
    
    @IBInspectable var badgeValue : Int {
        return value
    }
    
    @IBInspectable var badgeColor : UIColor  = UIColor.white {
        didSet {
            badgeLabel.textColor = badgeColor
        }
    }
    
    @IBInspectable var badgeBackgroundColor : UIColor = .blue {
        didSet {
            backgroundView.backgroundColor = badgeBackgroundColor
        }
    }
    
    @IBInspectable var isCountNumberHidden : Bool = false {
        didSet {
            badgeLabel.isHidden = isCountNumberHidden
            badgeSize = isCountNumberHidden ? 8 : 17
            layoutIfNeeded()
        }
    }
    
    var shouldShowNotificationBelowTitle : Bool = false {
        didSet {
            layoutIfNeeded()
        }
    }
    
    //Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIfNeeded()
        badgeLabel.layer.cornerRadius = badgeLabel.frame.height/2
        backgroundView.layer.cornerRadius = backgroundView.frame.height/2
        
        var x = frame.width - badgeSize
        var y = CGFloat(2)
        
        if shouldShowNotificationBelowTitle, let midX = titleLabel?.frame.midX, let maxY = titleLabel?.frame.maxY {
            x = midX - 5
            y = maxY + (isCountNumberHidden ? 5 : 1)
        }
        
        backgroundView.frame  = CGRect(x: x,
                                       y: y,
                                       width: badgeSize,
                                       height: badgeSize)

        badgeLabel.center = backgroundView.center
        badgeLabel.frame    = CGRect(x: 1,
                                     y: 0,
                                     width: badgeSize - 2,
                                     height: badgeSize - 2)
    }
    
    //Private functions
    private func initialSetup() {
        
        badgeLabel.textAlignment        = .center
//        badgeLabel.font                 = AppFonts.Barlow_Regular.withSize(10)
        badgeLabel.minimumScaleFactor   = 0.5
        badgeLabel.adjustsFontSizeToFitWidth = true
        badgeLabel.clipsToBounds        = true
        badgeLabel.backgroundColor      = UIColor.clear
        badgeLabel.textColor            = badgeColor
        badgeLabel.isUserInteractionEnabled = false
        badgeLabel.baselineAdjustment   = .alignCenters
        backgroundView.isUserInteractionEnabled = false
        backgroundView.backgroundColor = badgeBackgroundColor
        backgroundView.addSubview(badgeLabel)
        
        addSubview(backgroundView)
        
        setBadge(value: 0)
    }

    /** Sets the value of the notification label and hides the label if value is zero
    */
    func setBadge(value : Int) {
        self.value = value
        if value > 0 {
            badgeLabel.isHidden = isCountNumberHidden
            backgroundView.isHidden = false
            badgeLabel.text = value <= 99 ? "\(value)" : "99+"
            layoutIfNeeded()
        } else {
            self.value = 0
            hideBadge()
        }
    }
     
    /** Function that hides the notification label and the backgrounf of notification label
    */
    func hideBadge() {
        badgeLabel.isHidden = true
        backgroundView.isHidden = true
    }
}
