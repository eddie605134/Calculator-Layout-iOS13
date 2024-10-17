//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var culNum: UILabel!
			
	var currentNumber: String = "" // 用於儲存當前輸入的數字
	var previousNumber: Double = 0 // 用於儲存前一個數字
	var operation: String = "" // 用於儲存操作符號
	var performingOperation = false // 標記是否正在進行運算
	var displayText: String = "" // 用於即時顯示運算過程

	override func viewDidLoad() {
			super.viewDidLoad()
			culNum.text = "0"
	}
	
	// // 檢查是否是整數，如果是則移除 .0
	func formatResult(_ result: Double) -> String {
			if result.truncatingRemainder(dividingBy: 1) == 0 {
					return String(format: "%.0f", result)
			} else {
					return String(result)
			}
	}

	// 處理數字按鈕的點擊事件
	@IBAction func numberPressed(_ sender: UIButton) {
			let number = sender.currentTitle!
			
			if performingOperation {
					currentNumber = number
					performingOperation = false
			} else {
					currentNumber += number
			}
			
			displayText += number // 累加運算過程
			culNum.text = displayText // 即時顯示計算過程
	}

	// 處理操作符號的點擊事件
	@IBAction func operationPressed(_ sender: UIButton) {
			if !currentNumber.isEmpty {
					if operation != "" {
							// 如果已經有一個操作符號，先計算之前的結果
							let current = Double(currentNumber) ?? 0
							previousNumber = calculate(previousNumber, current, operation)
							culNum.text = String(previousNumber)
					} else {
							// 如果還沒有操作符號，將當前數字保存為 previousNumber
							previousNumber = Double(currentNumber) ?? 0
					}
			}
			
			operation = sender.currentTitle! // 更新操作符號
			displayText += " \(operation) " // 累加運算符號
			culNum.text = displayText
			performingOperation = true // 標記為進行運算
	}

	// 處理等號的點擊事件
	@IBAction func equalsPressed(_ sender: UIButton) {
			let current = Double(currentNumber) ?? 0
			let result = calculate(previousNumber, current, operation)
			let calText = String(formatResult(result))
			culNum.text = calText // 顯示最終結果
			displayText = calText
//			resetCalculator() // 重置狀態
	}

	// 處理清除按鈕的點擊事件
	@IBAction func clearPressed(_ sender: UIButton) {
			resetCalculator()
			culNum.text = "0"
	}

	// 計算的邏輯
	func calculate(_ num1: Double, _ num2: Double, _ operation: String) -> Double {
			switch operation {
			case "+":
					return num1 + num2
			case "-":
					return num1 - num2
			case "×":
					return num1 * num2
			case "÷":
					return num2 != 0 ? num1 / num2 : 0
			default:
					return num1
			}
	}

	// 重置計算器狀態
	func resetCalculator() {
			currentNumber = ""
			previousNumber = 0
			operation = ""
			displayText = ""
			performingOperation = false
	}

}

