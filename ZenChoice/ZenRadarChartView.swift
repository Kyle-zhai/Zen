import SwiftUI

/// Terminal-styled radar chart showing score distribution across 9 AI personality types.
struct ZenRadarChartView: View {
    let scores: [String: Double]  // type id → normalized 0–1
    let types: [ZenType]
    let isChinese: Bool
    let highlightType: String?

    private let axes = 9
    private let rings = 4

    var body: some View {
        VStack(spacing: 14) {
            Text(isChinese ? "多维图谱" : "PROFILE MAP")
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(ZenTheme.gooseYellow.opacity(0.5))
                .tracking(1)

            GeometryReader { geo in
                let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
                let radius = min(geo.size.width, geo.size.height) / 2 - 36

                Canvas { ctx, size in
                    let c = CGPoint(x: size.width / 2, y: size.height / 2)

                    // Draw concentric rings
                    for ring in 1...rings {
                        let r = radius * CGFloat(ring) / CGFloat(rings)
                        let ringPath = polygonPath(center: c, radius: r, sides: axes)
                        ctx.stroke(
                            ringPath,
                            with: .color(ZenTheme.mist.opacity(ring == rings ? 0.15 : 0.06)),
                            lineWidth: ring == rings ? 0.8 : 0.5
                        )
                    }

                    // Draw axis lines
                    for i in 0..<axes {
                        let angle = angleFor(index: i)
                        let end = pointAt(center: c, radius: radius, angle: angle)
                        var axisPath = Path()
                        axisPath.move(to: c)
                        axisPath.addLine(to: end)
                        ctx.stroke(axisPath, with: .color(ZenTheme.mist.opacity(0.08)), lineWidth: 0.5)
                    }

                    // Draw filled score polygon
                    let orderedTypes = orderedTypeIds
                    let dataPath = scorePath(center: c, radius: radius, typeOrder: orderedTypes)
                    ctx.fill(dataPath, with: .color(ZenTheme.gooseYellow.opacity(0.12)))
                    ctx.stroke(dataPath, with: .color(ZenTheme.gooseYellow.opacity(0.6)), lineWidth: 1.5)

                    // Draw score dots
                    for (i, typeId) in orderedTypes.enumerated() {
                        let val = scores[typeId] ?? 0
                        let angle = angleFor(index: i)
                        let pt = pointAt(center: c, radius: radius * CGFloat(val), angle: angle)
                        let dotSize: CGFloat = typeId == highlightType ? 6 : 4
                        let dotColor = typeId == highlightType ? ZenTheme.gooseYellow : ZenTheme.gooseYellow.opacity(0.7)
                        let dotRect = CGRect(
                            x: pt.x - dotSize / 2,
                            y: pt.y - dotSize / 2,
                            width: dotSize,
                            height: dotSize
                        )
                        ctx.fill(Path(ellipseIn: dotRect), with: .color(dotColor))
                    }
                }

                // Type labels around the chart
                ForEach(Array(orderedTypeIds.enumerated()), id: \.offset) { i, typeId in
                    let angle = angleFor(index: i)
                    let labelRadius = radius + 24
                    let pt = pointAt(center: center, radius: labelRadius, angle: angle)
                    let isHighlight = typeId == highlightType

                    if let type = types.first(where: { $0.id == typeId }) {
                        let pct = Int((scores[typeId] ?? 0) * 100)
                        VStack(spacing: 1) {
                            Text(isChinese ? type.codeCN : type.codeEN)
                                .font(.system(size: isHighlight ? 9 : 8, weight: isHighlight ? .bold : .regular, design: .monospaced))
                                .foregroundStyle(isHighlight ? ZenTheme.gooseYellow : ZenTheme.mist.opacity(0.5))
                            Text("\(pct)%")
                                .font(.system(size: 7, weight: .medium, design: .monospaced))
                                .foregroundStyle(isHighlight ? ZenTheme.gooseYellow.opacity(0.7) : ZenTheme.mist.opacity(0.3))
                        }
                        .position(pt)
                    }
                }
            }
            .frame(height: 260)
        }
        .padding(16)
        .zenCard(elevated: false)
    }

    // MARK: - Geometry Helpers

    private var orderedTypeIds: [String] {
        ["chatgpt", "claude", "gemini", "grok", "deepseek", "kimi", "qwen", "llama", "glm"]
    }

    private func angleFor(index: Int) -> Double {
        let slice = 2 * .pi / Double(axes)
        return slice * Double(index) - .pi / 2  // start from top
    }

    private func pointAt(center: CGPoint, radius: CGFloat, angle: Double) -> CGPoint {
        CGPoint(
            x: center.x + radius * CGFloat(cos(angle)),
            y: center.y + radius * CGFloat(sin(angle))
        )
    }

    private func polygonPath(center: CGPoint, radius: CGFloat, sides: Int) -> Path {
        var path = Path()
        for i in 0...sides {
            let angle = angleFor(index: i % sides)
            let pt = pointAt(center: center, radius: radius, angle: angle)
            if i == 0 { path.move(to: pt) } else { path.addLine(to: pt) }
        }
        path.closeSubpath()
        return path
    }

    private func scorePath(center: CGPoint, radius: CGFloat, typeOrder: [String]) -> Path {
        var path = Path()
        for (i, typeId) in typeOrder.enumerated() {
            let val = max(scores[typeId] ?? 0, 0.05) // minimum visible
            let angle = angleFor(index: i)
            let pt = pointAt(center: center, radius: radius * CGFloat(val), angle: angle)
            if i == 0 { path.move(to: pt) } else { path.addLine(to: pt) }
        }
        path.closeSubpath()
        return path
    }
}
