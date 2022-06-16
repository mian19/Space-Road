//
//  GameViewController.swift
//  Space Road
//
//  Created by Kyzu on 15.06.22.
//

import UIKit

class GameViewController: UIViewController, GamePresenterDelegate, Storyboarded {

    private var viewForBackground: UIView!
    private var backgroundUIImageArray: [UIImageView] = []
    private var animationForBackground = UIViewPropertyAnimator()
    private var animationForTarget = UIViewPropertyAnimator()
    private var labelScore: UILabel!
    private var pauseButton: UIButton!
    private var shuttle: Shuttle!
    private var targets: [Target] = []
    private var targetOrigins: [CGPoint] = []
    private var presenter = GamePresenter()
    private var timerForPutTargers = Timer()
    private var game = Game()
    weak var appCoordinator: AppCoordinator?

    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        view = customView
        setBackground()
        setTopPanel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgroundImage(duration: game.gameSpeed)
        setShuttle()
        movingShuttle()
        setElements()
        generateTargetsOrigin(size: shuttle.frame.size)
        restartTimer()
    }
    
    // MARK: - work with background
    private func setBackground() {
        viewForBackground = UIView(frame: view.frame)
        viewForBackground.clipsToBounds = true
        backgroundUIImageArray = [UIImageView.conformImage(originalImage: "gameScreen", size: view.bounds.size), UIImageView.conformImage(originalImage: "gameScreen", size: view.bounds.size)]
        backgroundUIImageArray[0].frame.origin = .zero
        backgroundUIImageArray[1].frame.origin = CGPoint(x: 0, y: 0-viewForBackground.bounds.height)
        view.addSubview(viewForBackground)
        viewForBackground.addSubview(backgroundUIImageArray[0])
        viewForBackground.addSubview(backgroundUIImageArray[1])
    }
    
    private func setTopPanel() {
        labelScore = UILabel.scoreLabel()
        pauseButton = UIButton.systemButton(image: "pause")
        view.addSubview(labelScore)
        view.addSubview(pauseButton)
    }
    
    private func setShuttle() {
        shuttle = Shuttle.init(frame: CGRect(x: view.frame.width / 5 * 2, y: viewForBackground.bounds.maxY - view.frame.width / 5 - 30, width: view.frame.width / 5, height: view.frame.width / 5 - 10))
        viewForBackground.addSubview(shuttle)
    }
    
    private func changeBackgroundImage(duration: TimeInterval) {
        animationForBackground = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {
            self.backgroundUIImageArray[0].frame.origin = CGPoint(x: 0, y: self.viewForBackground.bounds.maxY)
            self.backgroundUIImageArray[1].frame.origin = .zero
        })
        animationForBackground.startAnimation()
        animationForBackground.addCompletion({_ in
            self.workWithUIIM()
        })
    }
    
    private func workWithUIIM() {
        self.backgroundUIImageArray[0].frame.origin = .zero
        self.backgroundUIImageArray[1].frame.origin = CGPoint(x: 0, y: 0 - self.viewForBackground.bounds.maxY)
        changeBackgroundImage(duration: game.gameSpeed)
    }
    
    // MARK: - moving shuttle
    
    private func movingShuttle() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(moveShuttleTo))
        viewForBackground.addGestureRecognizer(tap)
    }
    
    @objc private func moveShuttleTo(touch: UITapGestureRecognizer) {
        let tapDirection = touch.location(in: viewForBackground).x

        if tapDirection < viewForBackground.bounds.midX && shuttle.frame.origin.x > 0 {
            shuttle.movingShuttle(direction: -1)
        }
        if tapDirection >= viewForBackground.bounds.midX && shuttle.frame.maxX <= view.bounds.maxX - shuttle.frame.width {
            shuttle.movingShuttle(direction: 1)
        }
    }
    
    // MARK: - work with targets
    func restartTimer() {
        print(game.gameSpeed)
        let randomNum = Double.random(in: self.game.gameSpeed-0.5..<self.game.gameSpeed)
        timerForPutTargers = Timer.scheduledTimer(withTimeInterval: TimeInterval(randomNum), repeats: false) { _ in
            self.game.increaseSpeed()
            self.moveTarget(duration: self.game.gameSpeed)
            
            self.restartTimer()
        }
    }
    
    private func generateTargetsOrigin(size: CGSize) {
        for iPoint in 0...4 {
            targetOrigins.append(CGPoint(x: 2 + size.width * CGFloat(iPoint), y: 0 - size.height))
        }
    }
    
    private func moveTarget(duration: TimeInterval) {
        
        let newTargets = Target.generateTargets(targetSize: shuttle.frame.size, targetPoints: targetOrigins)
        for target in newTargets {
            viewForBackground.addSubview(target)
        }
        targets += newTargets
        
        animationForTarget = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {
            
            for target in newTargets {
                target.transform = CGAffineTransform(translationX: 0, y: self.viewForBackground.bounds.maxY + target.frame.height)
            }
            
        })
        animationForTarget.startAnimation()
        animationForTarget.addCompletion({_ in
            for target in newTargets {
                if target.frame.origin.y >= self.viewForBackground.frame.maxY {
                    target.removeFromSuperview()
                }
            }
            self.game.currentScore += 1
            print(self.game.currentScore)
            self.labelScore.text = "Score: \(self.game.currentScore)"
        })
    }
    
    private func setElements() {
        NSLayoutConstraint.activate([
            
            pauseButton.heightAnchor.constraint(equalToConstant: 30),
            pauseButton.widthAnchor.constraint(equalToConstant: 30),
            pauseButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            pauseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
        
            labelScore.heightAnchor.constraint(equalToConstant: 20),
            labelScore.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            labelScore.widthAnchor.constraint(equalToConstant: 120),
            view.trailingAnchor.constraint(equalTo: labelScore.trailingAnchor, constant: 0)
            
        ])
    }

}
