//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by XMS_JZhan on 1/30/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateButton(_ isComplete: Bool) {
        if isComplete {
            completeButton.setImage(UIImage(named: "complete"), for: .normal)
        } else {
            completeButton.setImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.buttonCellButtonTapped(cell: self)
    }
}

extension ButtonTableViewCell {
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}

protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(cell: ButtonTableViewCell)
}
