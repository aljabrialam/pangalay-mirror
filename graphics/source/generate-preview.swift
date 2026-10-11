import AppKit
import Foundation

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let framesURL = URL(fileURLWithPath: "/private/tmp/pangalay-preview-frames", isDirectory: true)
try? FileManager.default.removeItem(at: framesURL)
try FileManager.default.createDirectory(at: framesURL, withIntermediateDirectories: true)
let W: CGFloat = 960, H: CGFloat = 540
let gold = NSColor(calibratedRed: 0.949, green: 0.757, blue: 0.306, alpha: 1)
let paper = NSColor(calibratedRed: 0.965, green: 0.937, blue: 0.875, alpha: 1)
let mist = NSColor(calibratedRed: 0.788, green: 0.847, blue: 0.839, alpha: 1)
let dark = NSColor(calibratedRed: 0.102, green: 0.031, blue: 0.125, alpha: 1)
let rose = NSColor(calibratedRed: 0.702, green: 0.18, blue: 0.388, alpha: 1)
let avatar = NSImage(contentsOf: root.appendingPathComponent("assets/avatar_girl.png"))!
let treasures = (0...3).compactMap { NSImage(contentsOf: root.appendingPathComponent("assets/tr\($0).png")) }

func text(_ value: String, x: CGFloat, y: CGFloat, width: CGFloat, size: CGFloat, color: NSColor, font: NSFont, tracking: CGFloat = 0) {
    let style = NSMutableParagraphStyle(); style.lineBreakMode = .byTruncatingTail
    let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .paragraphStyle: style, .kern: tracking]
    (value as NSString).draw(in: NSRect(x: x, y: y, width: width, height: size * 1.55), withAttributes: attrs)
}
func rounded(_ rect: NSRect, radius: CGFloat, color: NSColor, stroke: NSColor? = nil, line: CGFloat = 1) {
    let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
    color.setFill(); path.fill()
    if let stroke { stroke.setStroke(); path.lineWidth = line; path.stroke() }
}

for frame in 0..<20 {
    let image = NSImage(size: NSSize(width: W, height: H))
    image.lockFocus()
    NSColor(calibratedRed: 0.102, green: 0.031, blue: 0.125, alpha: 1).setFill()
    NSRect(x: 0, y: 0, width: W, height: H).fill()
    // Subtle Tausug-inspired geometric border.
    NSColor(calibratedRed: 0.22, green: 0.075, blue: 0.25, alpha: 1).setFill()
    NSRect(x: 0, y: H - 14, width: W, height: 14).fill()
    gold.withAlphaComponent(0.8).setFill(); NSRect(x: 0, y: H - 16, width: W, height: 2).fill()
    for x in stride(from: 18, to: 960, by: 42) {
        let diamond = NSBezierPath(); diamond.move(to: NSPoint(x: CGFloat(x), y: H - 7)); diamond.line(to: NSPoint(x: CGFloat(x + 6), y: H - 1)); diamond.line(to: NSPoint(x: CGFloat(x + 12), y: H - 7)); diamond.line(to: NSPoint(x: CGFloat(x + 6), y: H - 13)); diamond.close(); gold.withAlphaComponent(0.58).setFill(); diamond.fill()
    }
    text("PRODUCTION APP  ·  CAMERA + POSE TRACKING", x: 54, y: 460, width: 440, size: 14, color: mist, font: .boldSystemFont(ofSize: 13), tracking: 2.2)
    text("Pangalay Mirror", x: 50, y: 382, width: 455, size: 47, color: paper, font: NSFont(name: "Georgia", size: 46) ?? .boldSystemFont(ofSize: 46))
    text("Step in. Move. Meet the Tausug.", x: 54, y: 335, width: 430, size: 20, color: gold, font: .boldSystemFont(ofSize: 19))
    text("Follow the coach. Mirror each move.", x: 54, y: 264, width: 410, size: 19, color: paper, font: .systemFont(ofSize: 18))
    text("Catch a treasure and hear its story.", x: 54, y: 235, width: 410, size: 19, color: paper, font: .systemFont(ofSize: 18))
    rounded(NSRect(x: 52, y: 128, width: 402, height: 91), radius: 14, color: NSColor(calibratedRed: 0.17, green: 0.07, blue: 0.20, alpha: 1), stroke: gold.withAlphaComponent(0.48))
    text("NEXT MOVES", x: 70, y: 181, width: 180, size: 12, color: mist, font: .boldSystemFont(ofSize: 11), tracking: 1.6)
    let labels = ["OPEN", "OVERHEAD", "CROSS", "WRIST"]
    for (i, label) in labels.enumerated() {
        let x = CGFloat(70 + i * 91)
        let selected = min(3, frame / 5) == i
        let cueColor = selected ? gold : mist.withAlphaComponent(0.55)
        let cue = NSBezierPath(); cue.move(to: NSPoint(x: x + 12, y: 165)); cue.line(to: NSPoint(x: x + 24, y: 153)); cue.line(to: NSPoint(x: x + 12, y: 141)); cue.line(to: NSPoint(x: x, y: 153)); cue.close()
        cueColor.setFill(); cue.fill()
        if selected { gold.withAlphaComponent(0.30).setFill(); NSBezierPath(ovalIn: NSRect(x: x - 7, y: 134, width: 38, height: 38)).fill() }
        text(label, x: x - 5, y: 128, width: 80, size: 9, color: selected ? gold : mist, font: .boldSystemFont(ofSize: 8), tracking: 0.5)
    }
    text("WEBCAM GAME  ·  PLAY IN YOUR BROWSER", x: 56, y: 78, width: 420, size: 12, color: mist.withAlphaComponent(0.82), font: .boldSystemFont(ofSize: 11), tracking: 1.1)

    // Game stage with dusk, sea, coach avatar, treasure and score HUD.
    rounded(NSRect(x: 495, y: 65, width: 410, height: 405), radius: 24, color: NSColor(calibratedRed: 0.10, green: 0.12, blue: 0.20, alpha: 1), stroke: gold, line: 3)
    let sky = NSGradient(colors: [NSColor(calibratedRed: 0.96, green: 0.47, blue: 0.37, alpha: 1), NSColor(calibratedRed: 0.26, green: 0.15, blue: 0.35, alpha: 1)])!
    sky.draw(in: NSRect(x: 501, y: 250, width: 398, height: 214), angle: 90)
    NSColor(calibratedRed: 0.05, green: 0.30, blue: 0.33, alpha: 1).setFill(); NSRect(x: 501, y: 115, width: 398, height: 137).fill()
    gold.withAlphaComponent(0.96).setFill(); NSBezierPath(ovalIn: NSRect(x: 650, y: 311, width: 90, height: 90)).fill()
    for i in 0..<4 {
        let y = CGFloat(145 + i * 24); let wave = NSBezierPath(); wave.move(to: NSPoint(x: 510, y: y)); wave.curve(to: NSPoint(x: 894, y: y), controlPoint1: NSPoint(x: 620, y: y + 13), controlPoint2: NSPoint(x: 770, y: y - 13)); mist.withAlphaComponent(0.38).setStroke(); wave.lineWidth = 2; wave.stroke()
    }
    avatar.draw(in: NSRect(x: 570, y: 86, width: 235, height: 292), from: .zero, operation: .sourceOver, fraction: 1)
    // Floating treasure card.
    rounded(NSRect(x: 764, y: 263, width: 122, height: 177), radius: 15, color: dark.withAlphaComponent(0.92), stroke: gold.withAlphaComponent(0.75))
    text("TREASURE", x: 779, y: 404, width: 94, size: 10, color: mist, font: .boldSystemFont(ofSize: 9), tracking: 1)
    let treasureIndex = min(3, frame / 5)
    treasures[treasureIndex].draw(in: NSRect(x: 790, y: 325, width: 68, height: 68), from: .zero, operation: .sourceOver, fraction: 1)
    let treasureNames = ["Kulintangan", "Pis syabit", "Pearl shell", "Kalis"]
    text(treasureNames[treasureIndex], x: 777, y: 290, width: 100, size: 12, color: gold, font: .boldSystemFont(ofSize: 10))
    rounded(NSRect(x: 772, y: 129, width: 112, height: 91), radius: 12, color: dark.withAlphaComponent(0.92), stroke: mist.withAlphaComponent(0.35))
    text("SCORE", x: 786, y: 188, width: 85, size: 10, color: mist, font: .boldSystemFont(ofSize: 9), tracking: 1)
    text("\((treasureIndex + 1) * 250)", x: 786, y: 154, width: 86, size: 27, color: gold, font: NSFont(name: "Georgia", size: 25) ?? .boldSystemFont(ofSize: 25))
    image.unlockFocus()
    let out = framesURL.appendingPathComponent(String(format: "%03d.png", frame))
    guard let tiff = image.tiffRepresentation, let rep = NSBitmapImageRep(data: tiff), let data = rep.representation(using: .png, properties: [:]) else { fatalError("Could not encode frame") }
    try data.write(to: out)
}
print("Rendered 20 preview frames to \(framesURL.path)")
