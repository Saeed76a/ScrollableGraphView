//
//  Simple example usage of ScrollableGraphView.swift
//  #################################################
//

import UIKit

class ViewController: UIViewController {

    var examples: Examples!
    var graphView: ScrollableGraphView!
    var currentGraphType = GraphType.multiOne
    var graphConstraints = [NSLayoutConstraint]()
    
    var label = UILabel()
    var reloadLabel = UILabel()
    
    // Init
    // ####
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        examples = Examples()
        graphView = examples.createMultiPlotGraphOne(self.view.frame)
        
        addReloadLabel(withText: "RELOAD")
        addLabel(withText: "MULTI 1 (TAP HERE)")
        
        self.view.insertSubview(graphView, belowSubview: reloadLabel)
        
        setupConstraints()
    }
    
    // Constraints and Helper Functions
    // ################################
    
    private func setupConstraints() {
        
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        graphConstraints.removeAll()
        
        let topConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        
        //let heightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        
        graphConstraints.append(topConstraint)
        graphConstraints.append(bottomConstraint)
        graphConstraints.append(leftConstraint)
        graphConstraints.append(rightConstraint)
        
        //graphConstraints.append(heightConstraint)
        
        self.view.addConstraints(graphConstraints)
    }
    
    // Adding and updating the graph switching label in the top right corner of the screen.
    private func addLabel(withText text: String) {
        
        label.removeFromSuperview()
        label = createLabel(withText: text)
        label.isUserInteractionEnabled = true
        
        let rightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -20)
        
        let topConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 20)
        
        let heightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 40)
        let widthConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: label.frame.width * 1.5)
        
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(didTap))
        label.addGestureRecognizer(tapGestureRecogniser)
        
        self.view.insertSubview(label, aboveSubview: reloadLabel)
        self.view.addConstraints([rightConstraint, topConstraint, heightConstraint, widthConstraint])
    }
    
    private func addReloadLabel(withText text: String) {
        
        reloadLabel.removeFromSuperview()
        reloadLabel = createLabel(withText: text)
        reloadLabel.isUserInteractionEnabled = true
        
        let leftConstraint = NSLayoutConstraint(item: reloadLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 20)
        
        let topConstraint = NSLayoutConstraint(item: reloadLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 20)
        
        let heightConstraint = NSLayoutConstraint(item: reloadLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 40)
        let widthConstraint = NSLayoutConstraint(item: reloadLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: reloadLabel.frame.width * 1.5)
        
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(reloadDidTap))
        reloadLabel.addGestureRecognizer(tapGestureRecogniser)
        
        self.view.insertSubview(reloadLabel, aboveSubview: graphView)
        self.view.addConstraints([leftConstraint, topConstraint, heightConstraint, widthConstraint])
    }
    
    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        label.text = text
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }
    
    // Button tap events
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        
        currentGraphType.next()
        
        self.view.removeConstraints(graphConstraints)
        graphView.removeFromSuperview()
        
        switch(currentGraphType) {
            
        case .simple: // Show simple graph, no adapting, single line.
            graphView = examples.createSimpleGraph(self.view.frame)
            addReloadLabel(withText: "RELOAD")
            addLabel(withText: "SIMPLE")
        case .multiOne: // Show graph with multiple plots, with adapting and using dot plots to decorate the line
            graphView = examples.createMultiPlotGraphOne(self.view.frame)
            addReloadLabel(withText: "RELOAD")
            addLabel(withText: "MULTI 1")
        case .multiTwo:
            graphView = examples.createMultiPlotGraphTwo(self.view.frame)
            addReloadLabel(withText: "RELOAD")
            addLabel(withText: "MULTI 2")
        case .dark:
            graphView = examples.createDarkGraph(self.view.frame)
            addReloadLabel(withText: "RELOAD")
            addLabel(withText: "DARK")
        case .dot:
            graphView = examples.createDotGraph(self.view.frame)
            addReloadLabel(withText: "RELOAD")
            addLabel(withText: "DOT")
        case .bar:
            graphView = examples.createBarGraph(self.view.frame)
            addReloadLabel(withText: "RELOAD")
            addLabel(withText: "BAR")
        case .pink:
            graphView = examples.createPinkGraph(self.view.frame)
            addReloadLabel(withText: "RELOAD")
            addLabel(withText: "PINK")
        }
        
        self.view.insertSubview(graphView, belowSubview: reloadLabel)
        
        setupConstraints()
    }
    
    @objc func reloadDidTap(_ gesture: UITapGestureRecognizer) {
        examples.reload()
        graphView.reload()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

