//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by XMS_JZhan on 1/30/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    var dueDateValue: Date?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
        updateViews()
    }
    
    func updateViews() {
        guard let task = task, let name = task.name else { return }
        nameTextField.text = name
        dueDateTextField.text = task.due?.stringValue()
        noteTextView.text = task.notes
    }
    
    func updateTask() {
        guard let name = nameTextField.text, name != "", let notes = noteTextView.text, notes != "", let due = dueDatePicker else { return }
        guard let task = task else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: due.date)
            return
        }
        TaskController.shared.update(task: task, name: name, notes: notes, due: due.date)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        updateTask()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = sender.date
        dueDateTextField.text = dueDateValue?.stringValue()
    }
    
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        noteTextView.resignFirstResponder()
    }
    
}
