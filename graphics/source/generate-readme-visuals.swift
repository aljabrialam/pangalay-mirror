import AppKit
import Foundation

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let output = root.appendingPathComponent("graphics")
let girl = NSImage(contentsOf: root.appendingPathComponent("assets/avatar_girl.png"))!
let boy = NSImage(contentsOf: root.appendingPathComponent("assets/avatar_boy.png"))!
let treasures = (0...3).compactMap { NSImage(contentsOf: root.appendingPathComponent("assets/tr\($0).png")) }
let night = NSColor(calibratedRed: 0.102, green: 0.031, blue: 0.125, alpha: 1)
let deep = NSColor(calibratedRed: 0.165, green: 0.047, blue: 0.18, alpha: 1)
let gold = NSColor(calibratedRed: 0.949, green: 0.757, blue: 0.306, alpha: 1)
let paper = NSColor(calibratedRed: 0.965, green: 0.937, blue: 0.875, alpha: 1)
let mist = NSColor(calibratedRed: 0.788, green: 0.847, blue: 0.839, alpha: 1)
let teal = NSColor(calibratedRed: 0.055, green: 0.298, blue: 0.333, alpha: 1)
let rose = NSColor(calibratedRed: 0.702, green: 0.18, blue: 0.388, alpha: 1)

func rect(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> NSRect { NSRect(x: x, y: y, width: w, height: h) }
func box(_ r: NSRect, _ color: NSColor, radius: CGFloat = 18, stroke: NSColor? = nil, line: CGFloat = 1) {
    let p = NSBezierPath(roundedRect: r, xRadius: radius, yRadius: radius)
    color.setFill(); p.fill()
    if let stroke { stroke.setStroke(); p.lineWidth = line; p.stroke() }
}
func line(_ points: [NSPoint], _ color: NSColor, width: CGFloat = 2) {
    guard let first = points.first else { return }
    let p = NSBezierPath(); p.move(to: first)
    for point in points.dropFirst() { p.line(to: point) }
    color.setStroke(); p.lineWidth = width; p.stroke()
}
func text(_ s: String, _ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ size: CGFloat, _ color: NSColor, font: NSFont? = nil, align: NSTextAlignment = .left, tracking: CGFloat = 0) {
    let para = NSMutableParagraphStyle(); para.alignment = align; para.lineBreakMode = .byTruncatingTail
    let attrs: [NSAttributedString.Key: Any] = [.font: font ?? .systemFont(ofSize: size), .foregroundColor: color, .paragraphStyle: para, .kern: tracking]
    (s as NSString).draw(in: rect(x, y, w, size * 1.65), withAttributes: attrs)
}
func image(_ img: NSImage, _ r: NSRect) { img.draw(in: r, from: .zero, operation: .sourceOver, fraction: 1) }
func header(_ title: String, _ subtitle: String, width: CGFloat, top: CGFloat) {
    text(title.uppercased(), 60, top - 54, width - 120, 16, mist, font: .boldSystemFont(ofSize: 14), tracking: 2.8)
    text(subtitle, 60, top - 124, width - 120, 42, paper, font: NSFont(name: "Georgia", size: 39) ?? .boldSystemFont(ofSize: 39))
}
func render(_ size: NSSize, path: String, body: () -> Void) throws {
    let canvas = NSImage(size: size); canvas.lockFocus()
    night.setFill(); rect(0, 0, size.width, size.height).fill()
    body()
    canvas.unlockFocus()
    guard let tiff = canvas.tiffRepresentation, let bmp = NSBitmapImageRep(data: tiff), let data = bmp.representation(using: .png, properties: [:]) else { throw NSError(domain: "Pangalay", code: 1) }
    try data.write(to: output.appendingPathComponent(path))
}

// A fresh portrait post with the production app and actual Tausug avatar art.
try render(NSSize(width: 1080, height: 1350), path: "pangalay-mirror-marketing-post.png") {
    let bg = NSGradient(colors: [night, deep, NSColor(calibratedRed: 0.20, green: 0.08, blue: 0.21, alpha: 1)])!
    bg.draw(in: rect(0, 0, 1080, 1350), angle: 90)
    gold.withAlphaComponent(0.75).setFill(); rect(0, 1332, 1080, 3).fill()
    for x in stride(from: 20, to: 1080, by: 48) {
        let d = NSBezierPath(); d.move(to: NSPoint(x: CGFloat(x), y: 1342)); d.line(to: NSPoint(x: CGFloat(x + 7), y: 1349)); d.line(to: NSPoint(x: CGFloat(x + 14), y: 1342)); d.line(to: NSPoint(x: CGFloat(x + 7), y: 1335)); d.close(); gold.withAlphaComponent(0.7).setFill(); d.fill()
    }
    text("PRODUCTION APP  ·  CULTURE × TECH", 70, 1290, 940, 16, mist, font: .boldSystemFont(ofSize: 15), tracking: 3)
    text("Pangalay", 65, 1172, 950, 82, paper, font: NSFont(name: "Georgia", size: 82)!)
    text("Mirror", 65, 1078, 950, 82, paper, font: NSFont(name: "Georgia", size: 82)!)
    text("Step in. Move. Meet the Tausug.", 72, 1005, 930, 32, gold, font: .boldSystemFont(ofSize: 30))
    // Scenic game window.
    box(rect(64, 330, 952, 580), NSColor(calibratedRed: 0.06, green: 0.10, blue: 0.17, alpha: 1), radius: 28, stroke: gold, line: 4)
    let sky = NSGradient(colors: [NSColor(calibratedRed: 0.91, green: 0.38, blue: 0.36, alpha: 1), NSColor(calibratedRed: 0.99, green: 0.67, blue: 0.39, alpha: 1)])!
    sky.draw(in: rect(72, 570, 936, 330), angle: 90)
    teal.setFill(); rect(72, 370, 936, 205).fill()
    gold.withAlphaComponent(0.85).setFill(); NSBezierPath(ovalIn: rect(450, 735, 150, 150)).fill()
    for y in stride(from: 410, to: 560, by: 32) { line([NSPoint(x: 85, y: CGFloat(y)), NSPoint(x: 310, y: CGFloat(y + 6)), NSPoint(x: 505, y: CGFloat(y)), NSPoint(x: 725, y: CGFloat(y + 7)), NSPoint(x: 990, y: CGFloat(y))], mist.withAlphaComponent(0.45), width: 2) }
    image(girl, rect(350, 355, 380, 505))
    box(rect(790, 425, 184, 390), NSColor(calibratedRed: 0.055, green: 0.09, blue: 0.12, alpha: 0.88), radius: 20, stroke: gold.withAlphaComponent(0.75))
    text("SCORE", 818, 760, 135, 18, mist, font: .boldSystemFont(ofSize: 16), tracking: 1.8)
    text("1,000", 818, 710, 140, 34, gold, font: NSFont(name: "Georgia", size: 33)!)
    text("TREASURE CAUGHT", 818, 655, 140, 14, mist, font: .boldSystemFont(ofSize: 12), tracking: 1)
    for i in 0..<4 { image(treasures[i], rect(812 + CGFloat(i % 2) * 67, 555 - CGFloat(i / 2) * 78, 55, 55)) }
    box(rect(100, 395, 202, 100), night.withAlphaComponent(0.85), radius: 16)
    text("NEXT MOVES", 120, 455, 165, 13, mist, font: .boldSystemFont(ofSize: 12), tracking: 1.4)
    for i in 0..<4 {
        let x = CGFloat(132 + i * 40); let diamond = NSBezierPath(); diamond.move(to: NSPoint(x: x, y: 440)); diamond.line(to: NSPoint(x: x + 10, y: 450)); diamond.line(to: NSPoint(x: x + 20, y: 440)); diamond.line(to: NSPoint(x: x + 10, y: 430)); diamond.close(); (i == 0 ? gold : mist.withAlphaComponent(0.6)).setFill(); diamond.fill()
    }
    text("Learn pangalay by moving. Catch four cultural treasures and hear their stories.", 78, 225, 900, 27, paper, font: .systemFont(ofSize: 24))
    text("TRY IT IN YOUR BROWSER", 80, 142, 440, 16, gold, font: .boldSystemFont(ofSize: 15), tracking: 2)
    text("pangalay-mirror.vercel.app/app", 80, 98, 600, 20, mist, font: .systemFont(ofSize: 19))
    text("TAUSUG HERITAGE · SULU ARCHIPELAGO", 80, 50, 900, 13, mist.withAlphaComponent(0.8), font: .boldSystemFont(ofSize: 12), tracking: 1.8)
}

// Responsive product views. Browser and mobile reflect the deployed app; kiosk is explicitly a proposal.
try render(NSSize(width: 1800, height: 1120), path: "pangalay-mirror-platform-views.png") {
    header("One dance · different ways to join", "Web · mobile · event kiosk", width: 1800, top: 1080)
    // Desktop browser window.
    box(rect(52, 260, 1022, 650), NSColor(calibratedRed: 0.08, green: 0.07, blue: 0.12, alpha: 1), radius: 26, stroke: gold.withAlphaComponent(0.85), line: 3)
    NSColor(calibratedRed: 0.15, green: 0.11, blue: 0.18, alpha: 1).setFill(); rect(56, 862, 1014, 44).fill()
    for i in 0..<3 { NSColor(calibratedRed: 0.83, green: CGFloat(0.27 + Double(i) * 0.11), blue: 0.31, alpha: 1).setFill(); NSBezierPath(ovalIn: rect(78 + CGFloat(i) * 22, 878, 10, 10)).fill() }
    text("pangalay-mirror.vercel.app/app", 160, 873, 500, 18, mist, font: .systemFont(ofSize: 13))
    let sky = NSGradient(colors: [NSColor(calibratedRed: 0.79, green: 0.34, blue: 0.39, alpha: 1), NSColor(calibratedRed: 0.99, green: 0.68, blue: 0.42, alpha: 1)])!
    sky.draw(in: rect(72, 460, 983, 393), angle: 90)
    teal.setFill(); rect(72, 294, 983, 170).fill()
    gold.setFill(); NSBezierPath(ovalIn: rect(350, 680, 116, 116)).fill()
    image(girl, rect(305, 310, 390, 490))
    box(rect(760, 510, 265, 305), NSColor(calibratedRed: 0.04, green: 0.08, blue: 0.11, alpha: 0.88), radius: 18, stroke: gold.withAlphaComponent(0.45))
    text("SCORE  750", 782, 766, 220, 22, gold, font: .boldSystemFont(ofSize: 19))
    text("HOLD THE POSE AND LISTEN", 782, 711, 225, 13, mist, font: .boldSystemFont(ofSize: 12), tracking: 1)
    text("Pis syabit", 782, 665, 225, 26, paper, font: NSFont(name: "Georgia", size: 23)!)
    text("Your dance catches a treasure.", 782, 624, 225, 16, mist, font: .systemFont(ofSize: 14))
    for i in 0..<4 { image(treasures[i], rect(785 + CGFloat(i) * 52, 548, 44, 44)) }
    box(rect(90, 324, 200, 85), night.withAlphaComponent(0.88), radius: 12)
    text("NEXT MOVES", 108, 373, 160, 12, mist, font: .boldSystemFont(ofSize: 11), tracking: 1)
    for i in 0..<4 { let x = CGFloat(115 + i * 40); let p = NSBezierPath(); p.move(to: NSPoint(x: x, y: 351)); p.line(to: NSPoint(x: x + 10, y: 361)); p.line(to: NSPoint(x: x + 20, y: 351)); p.line(to: NSPoint(x: x + 10, y: 341)); p.close(); (i == 0 ? gold : mist.withAlphaComponent(0.55)).setFill(); p.fill() }
    text("RESPONSIVE WEB APP · LIVE", 72, 211, 1022, 18, gold, font: .boldSystemFont(ofSize: 15), tracking: 2)
    // Mobile phone, same web experience in portrait.
    box(rect(1130, 330, 260, 520), NSColor(calibratedRed: 0.015, green: 0.02, blue: 0.03, alpha: 1), radius: 38, stroke: mist.withAlphaComponent(0.7), line: 3)
    box(rect(1143, 346, 234, 488), night, radius: 28)
    NSColor(calibratedRed: 0.16, green: 0.08, blue: 0.20, alpha: 1).setFill(); rect(1144, 786, 232, 48).fill()
    text("PANGALAY MIRROR", 1160, 800, 200, 12, gold, font: .boldSystemFont(ofSize: 10), tracking: 0.5)
    sky.draw(in: rect(1150, 492, 220, 286), angle: 90); teal.setFill(); rect(1150, 425, 220, 70).fill()
    image(girl, rect(1177, 425, 150, 280))
    box(rect(1165, 362, 190, 57), deep, radius: 12, stroke: gold.withAlphaComponent(0.4))
    text("NEXT MOVES  ·  OPEN  ↗", 1175, 383, 175, 16, mist, font: .boldSystemFont(ofSize: 10))
    text("MOBILE WEB · CAMERA", 1125, 280, 270, 18, gold, font: .boldSystemFont(ofSize: 14), align: .center, tracking: 1.2)
    text("Current responsive app", 1125, 242, 270, 15, mist, font: .systemFont(ofSize: 13), align: .center)
    // Large-format event kiosk proposal.
    box(rect(1460, 300, 272, 620), NSColor(calibratedRed: 0.04, green: 0.05, blue: 0.07, alpha: 1), radius: 25, stroke: gold.withAlphaComponent(0.75), line: 3)
    sky.draw(in: rect(1475, 500, 242, 401), angle: 90); teal.setFill(); rect(1475, 392, 242, 110).fill()
    gold.setFill(); NSBezierPath(ovalIn: rect(1570, 770, 60, 60)).fill()
    image(boy, rect(1515, 400, 170, 370))
    box(rect(1493, 324, 206, 84), night.withAlphaComponent(0.93), radius: 14)
    text("STEP IN AND DANCE", 1503, 372, 186, 15, gold, font: .boldSystemFont(ofSize: 13), align: .center, tracking: 0.8)
    text("Staffed, large-screen setup", 1503, 343, 186, 13, mist, font: .systemFont(ofSize: 11), align: .center)
    NSColor(calibratedRed: 0.19, green: 0.16, blue: 0.20, alpha: 1).setFill(); NSBezierPath(roundedRect: rect(1548, 180, 100, 120), xRadius: 14, yRadius: 14).fill()
    NSColor(calibratedRed: 0.12, green: 0.11, blue: 0.14, alpha: 1).setFill(); NSBezierPath(roundedRect: rect(1498, 145, 200, 40), xRadius: 9, yRadius: 9).fill()
    text("EVENT KIOSK · CONCEPT", 1440, 110, 312, 18, gold, font: .boldSystemFont(ofSize: 14), align: .center, tracking: 1.1)
    text("Proposed venue mode", 1440, 78, 312, 14, mist, font: .systemFont(ofSize: 12), align: .center)
    text("Web + mobile show the current browser app. Kiosk hardware and a dedicated kiosk interface are future venue work.", 65, 48, 1670, 15, mist.withAlphaComponent(0.78), font: .systemFont(ofSize: 13), align: .center)
}

// Future 3D illusion concept using a clear pyramid, not a capability claim.
try render(NSSize(width: 1600, height: 1000), path: "pangalay-mirror-future-pyramid.png") {
    let sky = NSGradient(colors: [NSColor(calibratedRed: 0.18, green: 0.08, blue: 0.25, alpha: 1), night, NSColor(calibratedRed: 0.025, green: 0.12, blue: 0.17, alpha: 1)])!
    sky.draw(in: rect(0, 0, 1600, 1000), angle: 90)
    text("FUTURE VISION  ·  NOT BUILT", 80, 908, 1440, 17, gold, font: .boldSystemFont(ofSize: 15), tracking: 2.8)
    text("Pangalay in a clear pyramid", 78, 830, 1440, 48, paper, font: NSFont(name: "Georgia", size: 46)!)
    text("A stage installation concept for a floating, hologram-style dance guide.", 82, 784, 1430, 22, mist, font: .systemFont(ofSize: 19))
    // Ground plane and reflected light.
    NSColor(calibratedRed: 0.04, green: 0.17, blue: 0.20, alpha: 0.95).setFill(); rect(150, 100, 1300, 95).fill()
    for i in 0..<8 { line([NSPoint(x: 180, y: CGFloat(115 + i * 10)), NSPoint(x: 1420, y: CGFloat(115 + i * 10))], teal.withAlphaComponent(0.24), width: 1) }
    // The four clear acrylic faces converge at the top and reveal one dance figure.
    let apex = NSPoint(x: 800, y: 705), left = NSPoint(x: 385, y: 230), right = NSPoint(x: 1215, y: 230), front = NSPoint(x: 800, y: 175)
    let sides: [(NSPoint, NSPoint, NSColor)] = [(apex, left, NSColor(calibratedRed: 0.3, green: 0.87, blue: 0.89, alpha: 0.18)), (apex, right, NSColor(calibratedRed: 0.84, green: 0.55, blue: 0.94, alpha: 0.16)), (apex, front, NSColor(calibratedRed: 0.94, green: 0.75, blue: 0.30, alpha: 0.17))]
    for (top, corner, fill) in sides {
        let p = NSBezierPath(); p.move(to: top); p.line(to: corner); p.line(to: front); p.close(); fill.setFill(); p.fill();
        NSColor(calibratedRed: 0.54, green: 0.88, blue: 0.91, alpha: 0.82).setStroke(); p.lineWidth = 3; p.stroke()
    }
    line([left, front, right, apex, left], NSColor(calibratedRed: 0.68, green: 0.94, blue: 0.94, alpha: 0.9), width: 5)
    // Warm projected avatar inside the transparent volume.
    gold.withAlphaComponent(0.14).setFill(); NSBezierPath(ovalIn: rect(624, 270, 350, 440)).fill()
    image(girl, rect(665, 245, 270, 480))
    // Four angled light trails suggest the reflection-based illusion.
    for i in 0..<4 {
        let x = CGFloat(650 + i * 100)
        line([NSPoint(x: x, y: 350), NSPoint(x: 800, y: 610), NSPoint(x: 1600 - x, y: 350)], gold.withAlphaComponent(0.24), width: 2)
    }
    // Phone beneath the pyramid represents the display source.
    box(rect(700, 125, 200, 28), NSColor(calibratedRed: 0.04, green: 0.05, blue: 0.08, alpha: 1), radius: 8, stroke: mist.withAlphaComponent(0.4))
    text("PHONE / TABLET DISPLAY", 705, 129, 190, 12, mist, font: .boldSystemFont(ofSize: 9), align: .center, tracking: 1)
    // Right-hand note card.
    box(rect(1160, 340, 330, 310), NSColor(calibratedRed: 0.04, green: 0.055, blue: 0.08, alpha: 0.90), radius: 22, stroke: gold.withAlphaComponent(0.65), line: 2)
    text("POSSIBLE NEXT STEP", 1190, 602, 280, 14, gold, font: .boldSystemFont(ofSize: 12), tracking: 1.8)
    text("Use a clear acrylic pyramid", 1190, 548, 275, 17, paper, font: .systemFont(ofSize: 15))
    text("above a phone or tablet.", 1190, 520, 275, 17, paper, font: .systemFont(ofSize: 15))
    text("Reflections could create a", 1190, 472, 275, 17, paper, font: .systemFont(ofSize: 15))
    text("floating, multi-sided dancer.", 1190, 444, 275, 17, paper, font: .systemFont(ofSize: 15))
    text("A venue display experiment—", 1190, 390, 275, 15, mist, font: .systemFont(ofSize: 13))
    text("not a true hologram or current feature.", 1190, 368, 275, 15, mist, font: .systemFont(ofSize: 13))
    text("FUTURE INSTALLATION CONCEPT · SUBJECT TO PROTOTYPING", 80, 50, 1440, 13, mist.withAlphaComponent(0.78), font: .boldSystemFont(ofSize: 11), align: .center, tracking: 1.6)
}

print("Wrote marketing post, platform mockups, and future pyramid concept to graphics/.")
