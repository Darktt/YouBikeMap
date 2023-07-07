//
//  Line.swift
//
//  Created by Darktt on 21/8/9.
//  Copyright © 2021 Darktt. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Line: View 
{
    // MARK: - Properties -
    
    private let style: LineStyle
    
    private var lineWidth: CGFloat = 1.0
    
    private var color: Color = Color.primary
    
    private var strokeStyle: StrokeStyle {
        
        var style = StrokeStyle(lineWidth: self.lineWidth, lineCap: .butt, lineJoin: .round)
        
        if self.style == .patternDot {
            
            style.dash = [self.lineWidth]
        }
        
        if self.style == .patternDash {
            
            style.dash = [self.lineWidth * 2.0, self.lineWidth]
        }
        
        if self.style == .patternDashDotDot {
            
            style.dash = [self.lineWidth * 2.0, self.lineWidth, self.lineWidth, self.lineWidth, self.lineWidth, self.lineWidth]
        }
        
        if case .custom(let pattern) = self.style {
            
            style.dash = pattern
        }
        
        return style
    }
    
    public var body: some View {
        
        GeometryReader {
            
            proxy in
            
            Path {
                
                $0.move(to: .zero)
                $0.addLine(to: CGPoint(x: proxy.size.width, y: 0.0))
                
                if self.style == .double {
                    
                    let y: CGFloat = self.lineWidth * 2.0
                    var point = CGPoint(x: 0.0, y: y)
                    
                    $0.move(to: point)
                    
                    point.x = proxy.size.width
                    
                    $0.addLine(to: point)
                }
                
            }.stroke(self.color, style: self.strokeStyle)
        }
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(style: LineStyle)
    {
        self.style = style
    }
    
    public func lineWidth(_ lineWidth: CGFloat = 1.0, color: Color = .primary) -> Line
    {
        var line: Line = self
        line.lineWidth = lineWidth
        line.color = color
        
        return line
    }
}

// MARK: - LineStyle -

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum LineStyle
{
    case single
    
    case double
    
    case patternDot
    
    case patternDash
    
    case patternDashDotDot
    
    case custom(_ pattern: Array<CGFloat>)
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension LineStyle: Equatable
{
    static public func == (lhs: LineStyle, rhs: LineStyle) -> Bool
    {
        var result: Bool = false
        
        switch (lhs, rhs) {
            
        case (.single, .single), (.double, .double), (.patternDot, .patternDot), (.patternDash, .patternDash), (.patternDashDotDot, .patternDashDotDot):
            result = true
            
        case (.custom(let left), .custom(let right)) where left == right:
            result = true
            
        default:
            break
        }
        
        return result
    }
}

// MARK: - Preiview -

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct Line_Previews: PreviewProvider 
{
    static var previews: some View {
        
        VStack {
            
            Spacer()
            
            SwiftUI.Group {
                
                Text("Sigle")
                Line(style: .single)
                    .lineWidth(2.0)
                
                Text("Double")
                Line(style: .double)
                    .lineWidth(2.0)
                
                Text("Dot")
                Line(style: .patternDot)
                    .lineWidth(2.0)
                
                Text("Dash")
                Line(style: .patternDash)
                    .lineWidth(2.0)
                
                Text("Dash dot dot")
                Line(style: .patternDashDotDot)
                    .lineWidth(2.0)
            }
            
            SwiftUI.Group {
                
                Text("Custom")
                Line(style: .custom([2.0, 1.0, 1.0, 1.0, 1.0, 1.0]))
                    .lineWidth(2.0)
            }
        }
    }
}
