//
//  Record.swift
//  MIEMApp
//
//  Created by Melanie Kofman on 13.01.2021.
//

import UIKit

class RecordScreenLoad: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ScreenPayload {
  private let bottomInset: Variable<CGFloat>
  private let requestRecord: (RecordModel, @escaping (Bool) -> Void) -> Void
  var controller: UIViewController {
    return self
  }
  var rooms = [String]()
  var selectedRoom: String?
  
  init(
    bottomInset: Variable<CGFloat>,
    requestRecord: @escaping (RecordModel, @escaping (Bool) -> Void) -> Void
  ) {
    self.bottomInset = bottomInset
    self.requestRecord = requestRecord
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let roomTextField: UITextField = {
    let textfield = UITextField()
    textfield.attributedPlaceholder = NSAttributedString(string: " Аудитория", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    textfield.addTarget(self, action: #selector(roomHandled), for: .touchDown)
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()

  let roomPicker: UIPickerView = {
    let roomPickier = UIPickerView()
    return roomPickier
  }()
  
  let startLabel: UILabel = {
    let label = UILabel()
    label.text = " Начало: "
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let stopLabel: UILabel = {
    let label = UILabel()
    label.text = " Конец: "
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.text = " Дата: "
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let startTextField: UITextField = {
    let textfield = UITextField()
    textfield.attributedPlaceholder = NSAttributedString(string: " Выберите время", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    textfield.addTarget(self, action: #selector(startHandled), for: .touchDown)
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()

  let startPicker: UIDatePicker = {
    let picker = UIDatePicker()
    picker.datePickerMode = .time
    if #available(iOS 14.0, *) {
      picker.preferredDatePickerStyle = UIDatePickerStyle.wheels
    }
    return picker
  }()
  
  let stopTextField: UITextField = {
    let textfield = UITextField()
    textfield.attributedPlaceholder = NSAttributedString(string: " Выберите время", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    textfield.addTarget(self, action: #selector(stopHandled), for: .touchDown)
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()

  let stopPicker: UIDatePicker = {
    let picker = UIDatePicker()
    picker.datePickerMode = .time
    if #available(iOS 14.0, *) {
      picker.preferredDatePickerStyle = UIDatePickerStyle.wheels
    }
    return picker
  }()
  
  let dateTextField: UITextField = {
    let textfield = UITextField()
    textfield.attributedPlaceholder = NSAttributedString(string: " Выберите дату", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    textfield.addTarget(self, action: #selector(dateHandled), for: .touchDown)
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()

  let datePicker: UIDatePicker = {
    let picker = UIDatePicker()
    picker.datePickerMode = .date
    if #available(iOS 14.0, *) {
      picker.preferredDatePickerStyle = UIDatePickerStyle.wheels
    }
    return picker
  }()
  
  let createButton: UIButton = {
    let button = UIButton()
    button.setTitle("Создать", for: .normal)
    button.backgroundColor = Brandbook.Colors.tint
    button.tintColor = .white
    button.layer.cornerRadius = 11
    button.layer.masksToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleCreate), for: .touchDown)
    return button
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = " Название записи: "
    label.textAlignment = NSTextAlignment.center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let nameTextField: UITextField = {
    let textfield = UITextField()
    textfield.attributedPlaceholder = NSAttributedString(string: " Введите навание", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    textfield.textAlignment = NSTextAlignment.center
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if touches.first != nil {
      self.view.endEditing(true)
    }
    super.touchesBegan(touches, with: event)
  }

  @objc
  func roomHandled() {
    let toolbar = UIToolbar();
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(donePicker));
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelPicker));
    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    roomTextField.inputAccessoryView = toolbar
    roomTextField.inputView = roomPicker
  }

  @objc
  func donePicker(){
    roomTextField.text = selectedRoom
    view.endEditing(true)
  }

  @objc
  func cancelPicker(){
    view.endEditing(true)
  }
  
  @objc
  func startHandled() {
    let toolbar = UIToolbar();
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(donetimePicker));
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker));
    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    startTextField.inputAccessoryView = toolbar
    startTextField.inputView = startPicker
  }
  
  @objc
  func stopHandled() {
    let toolbar = UIToolbar();
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(donetimeStopPicker));
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker));
    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    stopTextField.inputAccessoryView = toolbar
    stopTextField.inputView = stopPicker
  }

  @objc
  func donetimePicker(){
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    startTextField.text = formatter.string(from: startPicker.date)
    self.view.endEditing(true)
  }
      
  @objc
  func donetimeStopPicker(){
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    stopTextField.text = formatter.string(from: stopPicker.date)
    self.view.endEditing(true)
  }
  
  @objc
  func dateHandled() {
    let toolbar = UIToolbar();
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    dateTextField.inputAccessoryView = toolbar
    dateTextField.inputView = datePicker
  }

  @objc
  func donedatePicker(){
    dateTextField.text = datePicker.date.string(format: "dd/MM/yyyy")
    view.endEditing(true)
  }
  
  @objc
  func cancelDatePicker(){
    view.endEditing(true)
  }
  
  @objc
  func handleCreate() {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    requestRecord(
      RecordModel(
        room: roomTextField.text,
        startTime: formatter.string(from: startPicker.date),
        endTime: formatter.string(from: stopPicker.date),
        date: datePicker.date.string(format: "yyyy-MM-dd"),
        eventName: nameTextField.text
      ),
      { [weak self] isSuccessful in
        DispatchQueue.main.async {
          let alertController = UIAlertController(
            title: "",
            message: isSuccessful ? "Когда запись будет готова, придёт письмо на Вашу почту" : "Не удалось запросить запись",
            preferredStyle: .alert
          )
          let defaultAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
          )
          alertController.addAction(defaultAction)
          alertController.modalPresentationStyle = .popover
          self?.parent?.present(alertController, animated: true, completion: nil)
        }
      }
    )
    nameTextField.text = nil
    roomTextField.text = nil
    startTextField.text = nil
    stopTextField.text = nil
    dateTextField.text = nil
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
      
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return rooms.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return rooms[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedRoom = rooms[row]
  }
  
  func setupRecordComponents() {
    self.view.addSubview(containerView)
    containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -bottomInset.value).isActive = true
    containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  
    containerView.addSubview(nameLabel)
    nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
  
    containerView.addSubview(nameTextField)
    nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding).isActive = true
    nameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    nameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
  
    containerView.addSubview(roomTextField)
    roomTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding).isActive = true
    roomTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding).isActive = true
    roomTextField.widthAnchor.constraint(equalToConstant: 90).isActive = true
    roomTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
  
    containerView.addSubview(startLabel)
    startLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding).isActive = true
    startLabel.leftAnchor.constraint(equalTo: roomTextField.rightAnchor, constant: padding-10).isActive = true
    startLabel.widthAnchor.constraint(equalToConstant: 73).isActive = true
    startLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
  
    containerView.addSubview(stopLabel)
    stopLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: padding).isActive = true
    stopLabel.leftAnchor.constraint(equalTo: roomTextField.rightAnchor, constant: padding-10).isActive = true
    stopLabel.widthAnchor.constraint(equalToConstant: 73).isActive = true
    stopLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
  
    containerView.addSubview(dateLabel)
    dateLabel.topAnchor.constraint(equalTo: stopLabel.bottomAnchor, constant: padding).isActive = true
    dateLabel.leftAnchor.constraint(equalTo: roomTextField.rightAnchor, constant: padding-10).isActive = true
    dateLabel.widthAnchor.constraint(equalToConstant: 73).isActive = true
    dateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
  
    containerView.addSubview(startTextField)
    startTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding).isActive = true
    startTextField.leftAnchor.constraint(equalTo: startLabel.rightAnchor, constant: padding-20).isActive = true
    startTextField.widthAnchor.constraint(equalToConstant: 150).isActive = true
    startTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
  
    containerView.addSubview(stopTextField)
    stopTextField.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: padding).isActive = true
    stopTextField.leftAnchor.constraint(equalTo: stopLabel.rightAnchor, constant: padding-20).isActive = true
    stopTextField.widthAnchor.constraint(equalToConstant: 150).isActive = true
    stopTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
  
    containerView.addSubview(dateTextField)
    dateTextField.topAnchor.constraint(equalTo: stopTextField.bottomAnchor, constant: padding).isActive = true
    dateTextField.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: padding-20).isActive = true
    dateTextField.widthAnchor.constraint(equalToConstant: 150).isActive = true
    dateTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
  
    containerView.addSubview(createButton)
    createButton.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: padding).isActive = true
    createButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    createButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    createButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRecordComponents()
    roomPicker.delegate = self
    roomPicker.dataSource = self
  }
}
private let padding = Brandbook.Paddings.normal

