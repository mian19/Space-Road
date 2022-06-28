//
//  GameViewController.swift
//  Space Road
//
//  Created by Kyzu on 15.06.22.
//

import UIKit
import AudioToolbox

class GameViewController: UIViewController, GamePresenterDelegate, Storyboarded {

    private var viewForBackground: UIView!
    private var backgroundUIImageArray: [UIImageView] = []
    private var animationForBackground = UIViewPropertyAnimator()
    private var animationForTarget = UIViewPropertyAnimator()
    private var labelScore: UILabel!
    private var pauseButton: UIButton!
    private var pauseView: PauseUIView!
    private var shuttle: Shuttle!
    private var targets: [Target] = []
    private var targetOrigins: [CGPoint] = []
    private var presenter = GamePresenter()
    private var timerForPutTargers = Timer()
    private var timerForCheckIntersectionEnemyAndShuttle = Timer()
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
        presenter.setViewDelegate(delegate: self)
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
        pauseButton.addTarget(self, action: #selector(onPauseButton), for: .touchUpInside)
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
        let randomNum = Double.random(in: self.game.gameSpeed-1..<self.game.gameSpeed-0.5)
        timerForPutTargers = Timer.scheduledTimer(withTimeInterval: TimeInterval(randomNum), repeats: false) { _ in
            self.game.increaseSpeed()
            self.moveTarget(duration: self.game.gameSpeed)
            self.checkEndGame()
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
            for target in newTargets where target.frame.origin.y >= self.viewForBackground.frame.maxY {
                    target.removeFromSuperview()
            }
            self.game.currentScore += 1
            self.labelScore.text = "score.text".localizable() + ": \(self.game.currentScore)"
        })
    }
    
    // MARK: - check end game
    private func checkEndGame() {
        self.timerForCheckIntersectionEnemyAndShuttle = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            var tempFrameTargets: [CGRect] = []
            for target in self.targets {
                tempFrameTargets.append(target.layer.presentation()?.frame ?? CGRect(x: 0, y: 0, width: 0, height: 0) )
            }
            
            let tempFrameShuttle = self.shuttle.layer.presentation()!.frame
            
            for tempFrameTarget in tempFrameTargets {
                if tempFrameShuttle.intersects(tempFrameTarget) {
                    self.animationForTarget.stopAnimation(true)
                    self.viewForBackground.isUserInteractionEnabled = false
                    self.pauseButton.isUserInteractionEnabled = false
                    self.shuttle.movingAnimation.stopAnimation(true)
                    self.timerForPutTargers.invalidate()
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    self.animationForBackground.stopAnimation(true)
                    timer.invalidate()

                    self.showCrash()
                }
            }
        }
    }
    
    private func showCrash() {
        self.shuttle?.image = UIImage(named: "laserYellow_burst")
        let anima = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
            self.shuttle.transform = CGAffineTransform(scaleX: 5, y: 5)
        })
        anima.startAnimation()
        anima.addCompletion {_ in
            self.showResultView()
        }
    }
    
    // MARK: - Show Result
    
    private func showResultView() {
        let resultView = ResultView(frame: CGRect(x: 0, y: 0, width: 290, height: 255))
        viewForBackground.addSubview(resultView)
        resultView.widthAnchor.constraint(equalToConstant: 290).isActive = true
        resultView.heightAnchor.constraint(equalToConstant: 255).isActive = true
        resultView.centerXAnchor.constraint(equalTo: viewForBackground.centerXAnchor).isActive = true
        resultView.centerYAnchor.constraint(equalTo: viewForBackground.centerYAnchor).isActive = true
        
    }
    
    // MARK: - Pause button
    @objc func onPauseButton() {
        let pausedTime: CFTimeInterval = view.layer.convertTime(CACurrentMediaTime(), from: nil)
        view.layer.speed = 0.0
        view.layer.timeOffset = pausedTime
        timerForPutTargers.invalidate()
        self.timerForCheckIntersectionEnemyAndShuttle.invalidate()
        showPauseView()
        pauseButton.isHidden = true
    }

    @objc func resumeGame() {
        let pausedTime: CFTimeInterval = view.layer.timeOffset
        view.layer.speed = 1.0
        view.layer.timeOffset = 0.0
        view.layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = view.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        view.layer.beginTime = timeSincePause
        restartTimer()
        pauseButton.isHidden = false
        pauseView.removeFromSuperview()
    }
    
    // MARK: - pauseView
    func showPauseView() {
        setPauseView()
        let playButton = UIButton.systemButton(image: "playW")
        let homeButton = UIButton.systemButton(image: "home")
        
        pauseView.addSubview(playButton)
        pauseView.addSubview(homeButton)
        
        playButton.addTarget(self, action: #selector(resumeGame), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(onHomeButton), for: .touchUpInside)
        playButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        playButton.centerXAnchor.constraint(equalTo: pauseView.centerXAnchor).isActive = true
        playButton.topAnchor.constraint(equalTo: pauseView.topAnchor, constant: 5).isActive = true
        homeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        homeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        homeButton.centerXAnchor.constraint(equalTo: pauseView.centerXAnchor).isActive = true
        homeButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 5).isActive = true
    }
    
    private func setPauseView() {
        pauseView = PauseUIView()
        viewForBackground.addSubview(pauseView)
        pauseView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pauseView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        pauseView.centerXAnchor.constraint(equalTo: viewForBackground.centerXAnchor).isActive = true
        pauseView.centerYAnchor.constraint(equalTo: viewForBackground.centerYAnchor).isActive = true
    }
    
    @objc func onHomeButton() {
        self.appCoordinator?.back()
    }
    
    // MARK: - top panel constraints
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
