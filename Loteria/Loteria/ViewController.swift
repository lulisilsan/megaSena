//
//  ViewController.swift
//  Loteria
//
//  Created by Luciana on 23/09/20.
//  Copyright © 2020 Luciana Santana. All rights reserved.
//

import UIKit

//Controlar o titulo do topo quando o usuário selecionar no segmented control
enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

infix operator >-<
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    while result.count < total {
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(randomNumber) {
            result.append(randomNumber)
        }
    }
    return result.sorted()
}


class ViewController: UIViewController {
    
    @IBOutlet weak var labelGameType: UILabel!
    @IBOutlet weak var segmentedControlGameType: UISegmentedControl!
    @IBOutlet var outletCollectionBalls: [UIButton]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showNumbers(for: .megasena)

    }
    
    func showNumbers(for type: GameType) {
        labelGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
            case .megasena:
                game = 6>-<60
                outletCollectionBalls.last!.isHidden = false
            case .quina:
                game = 5>-<80
                outletCollectionBalls.last!.isHidden = true
        }
        for (index, game) in game.enumerated() {
            outletCollectionBalls[index].setTitle("\(game)", for: .normal)
        }
        
    }
    
    
    @IBAction func actionButtonGeneratedGame() {
        switch segmentedControlGameType.selectedSegmentIndex {
        case 0:
            showNumbers(for: .megasena)
        default:
            showNumbers(for: .quina)
        }
    }
    

}

