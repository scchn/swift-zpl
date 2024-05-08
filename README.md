# Swift ZPL

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fscchn%2Fswift-zpl%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/scchn/swift-zpl)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fscchn%2Fswift-zpl%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/scchn/swift-zpl)

**Swift ZPL** provides a declarative interface to write [ZPL](https://developer.zebra.com/products/printers/zpl) faster, easier and safer.

# Usage

```swift
import ZPLBuilder

let zpl = ZPL {
    LabelHome(x: 0, y: 0)
    ChangeAlphanumericDefaultFont(font: "A", height: 50)
    Field(x: 50, y: 50) {
        FieldData(text: "Swift ZPL")
    }
}

print(zpl.string()) // ^XA^LH0,0^CFA,50,0^FO50,50^FDSwift ZPL^FS^XZ
```

[Commands](https://github.com/scchn/swift-zpl/tree/main/Sources/ZPLBuilder/Commands)

[Utilities](https://github.com/scchn/swift-zpl/tree/main/Sources/ZPLBuilder/Utils)

# Commands

|swift-zpl|ZPL|
|-|-|
|[`BarcodeCode128`](/Sources/ZPLBuilder/Commands/BarcodeCode128.swift)|`^BC` and `^FD`|
|[`BarcodeDefault`](/Sources/ZPLBuilder/Commands/BarcodeDefault.swift)|`^BY`|
|[`BarcodeQR`](/Sources/ZPLBuilder/Commands/BarcodeQR.swift)|`^BQ` and `^FD`|
|[`ChangeAlphanumericDefaultFont`](/Sources/ZPLBuilder/Commands/ChangeAlphanumericDefaultFont.swift)|`^CF`|
|[`ChangeInternationalEncoding`](/Sources/ZPLBuilder/Commands/ChangeInternationalEncoding.swift)|`^CI`|
|[`Field`](/Sources/ZPLBuilder/Commands/Field.swift)|`^FO` and `^FS`|
|[`FieldBlock`](/Sources/ZPLBuilder/Commands/FieldBlock.swift)|`^FB`|
|[`FieldData`](/Sources/ZPLBuilder/Commands/FieldData.swift)|`^FD`|
|[`FieldHexadecimal`](/Sources/ZPLBuilder/Commands/FieldHexadecimal.swift)|N/A|
|[`FieldHexadecimalIndicator`](/Sources/ZPLBuilder/Commands/FieldHexadecimalIndicator.swift)|`^FH`|
|[`FieldOrientation`](/Sources/ZPLBuilder/Commands/FieldOrientation.swift)|`^FW`|
|[`FieldOrigin`](/Sources/ZPLBuilder/Commands/FieldOrigin.swift)|`^FO`|
|[`FieldParameter`](/Sources/ZPLBuilder/Commands/FieldParameter.swift)|`^FP`|
|[`FieldReversePrint`](/Sources/ZPLBuilder/Commands/FieldReversePrint.swift)|`^FR`|
|[`FieldSeparator`](/Sources/ZPLBuilder/Commands/FieldSeparator.swift)|`^FS`|
|[`FieldTypeset`](/Sources/ZPLBuilder/Commands/FieldTypeset.swift)|`^FT`|
|[`FontIdentifier`](/Sources/ZPLBuilder/Commands/FontIdentifier.swift)|`^CW`|
|[`GraphicBox`](/Sources/ZPLBuilder/Commands/GraphicBox.swift)|`^GB`|
|[`GraphicCircle`](/Sources/ZPLBuilder/Commands/GraphicCircle.swift)|`^GC`|
|[`GraphicDiagonalLine`](/Sources/ZPLBuilder/Commands/GraphicDiagonalLine.swift)|`^GD`|
|[`GraphicEllipse`](/Sources/ZPLBuilder/Commands/GraphicEllipse.swift)|`^GE`|
|[`GraphicField`](/Sources/ZPLBuilder/Commands/GraphicField.swift)|`^GF`|
|[`GraphicSymbol`](/Sources/ZPLBuilder/Commands/GraphicSymbol.swift)|`^GS` and `^FD`|
|[`HostDirectoryList`](/Sources/ZPLBuilder/Commands/HostDirectoryList.swift)|`^HW`|
|[`Hyphen`](/Sources/ZPLBuilder/Commands/Hyphen.swift)|N/A|
|[`LabelHome`](/Sources/ZPLBuilder/Commands/LabelHome.swift)|`^LH`|
|[`LabelLength`](/Sources/ZPLBuilder/Commands/LabelLength.swift)|`^LL`|
|[`LabelReversePrint`](/Sources/ZPLBuilder/Commands/LabelReversePrint.swift)|`^LR`|
|[`LabelShift`](/Sources/ZPLBuilder/Commands/LabelShift.swift)|`^LS`|
|[`PrintDirectoryLabel`](/Sources/ZPLBuilder/Commands/PrintDirectoryLabel.swift)|`^WD`|
|[`PrintWidth`](/Sources/ZPLBuilder/Commands/PrintWidth.swift)|`^PW`|
|[`ScalableBitmappedFont`](/Sources/ZPLBuilder/Commands/ScalableBitmappedFont.swift)|`^A`|
|[`SelectEncodingTable`](/Sources/ZPLBuilder/Commands/SelectEncodingTable.swift)|`^SE`|
|[`SetDarkness`](/Sources/ZPLBuilder/Commands/SetDarkness.swift)|`~SD`|
|[`TextBlock`](/Sources/ZPLBuilder/Commands/TextBlock.swift)|`^TB`|
|[`UseFontNameToCallFont`](/Sources/ZPLBuilder/Commands/UseFontNameToCallFont.swift)|`^A@`|

# Examples

## Boxes

```swift
ZPL {
    LabelHome(x: 0, y: 0)
    
    let width = 50
    let spacing = 30
    
    for row in 0..<3 {
        for col in 0..<3 {
            let x = width * col + spacing * (col + 1)
            let y = width * row + spacing * (row + 1)
            let lineWidth = col == row ? width / 2 : 1
            
            Field(x: x, y: y) {
                GraphicBox(width: width, height: width, lineWidth: lineWidth)
            }
        }
    }
}
```

![boxes](https://github.com/scchn/swift-zpl/blob/main/Images/boxes.png)

## Barcodes

### Code 128

```swift
ZPL {
    LabelHome(x: 0, y: 0)
    Field(x: 50, y: 50) {
        BarcodeCode128(data: "hello30678", height: 100, interpretation: .bottom)
    }
}
```

![boxes](https://github.com/scchn/swift-zpl/blob/main/Images/code128.png)

### QR code

```swift
ZPL {
    LabelHome(x: 0, y: 0)
    Field(x: 50, y: 50) {
        BarcodeQR(data: "hello", magnificationFactor: 10)
    }
}
```

![boxes](https://github.com/scchn/swift-zpl/blob/main/Images/qr.png)

## Text & Image

```swift
let image: UIImage = ...
let labelWidth = 4 * 203
let labelHeight = 6 * 203

ZPLImageEncoder.default.isCompressed = true

let zpl = ZPL {
    LabelHome(x: 0, y: 0)
    LabelReversePrint(enabled: true)
    
    let imageWidth = labelWidth / 2
    let imageSize = ZPLGeometryUtils.size(aspectRatio: image.size, fillWidth: imageWidth)
    
    Field(x: 0, y: 0) {
        GraphicField(image: image, size: imageSize)
    }
    Field(x: imageWidth, y: 0) {
        GraphicField(image: image, size: imageSize)
    }
    Field(x: imageWidth, y: 0) {
        GraphicBox(
            width: imageWidth,
            height: Int(imageSize.height),
            lineWidth: Int(min(imageSize.width, imageSize.height))
        )
    }
}
```

![image](https://github.com/scchn/swift-zpl/blob/main/Images/image.png)

```swift
let image: UIImage = ...
let labelWidth = 72 * 8
let labelHeight = 72 * 9
let settings = ZPL {
    LabelHome(x: 0, y: 0)
    LabelReversePrint(enabled: true)
    ChangeAlphanumericDefaultFont(font: "A", height: 35)
}
let body = ZPL {
    Field(x: labelWidth / 2, y: 0) {
        GraphicBox(width: labelWidth / 2, height: labelHeight, lineWidth: labelWidth / 2)
    }
    
    let imageSize = ZPLGeometryUtils.size(aspectRatio: image.size, fillWidth: labelWidth)
    
    Field(x: 0, y: 0) {
        GraphicField(image: image, size: imageSize)
    }
    
    Field(x: 0, y: Int(imageSize.height)) {
        FieldBlock(width: labelWidth, lines: 1, justification: .center)
        FieldData(text: "Swift")
        Hyphen.return
    }
}
let zpl = ZPL {
    settings
    body
}
```

![text&image](https://github.com/scchn/swift-zpl/blob/main/Images/text_image.png)

# More Commands

This package currently only contains a few commands, if you can't find what you need:

You can create a new command with just a few lines of code:

```swift
struct NewCommand: ZPLCommandConvertible {
    var command: String {
        // command...
    }
}

ZPL {
    NewCommand()
}
```

or create a pull request to add a new command or improve/fix existing ones.

# Preview

[Labelary Online ZPL Viewer](https://labelary.com/viewer.html)
