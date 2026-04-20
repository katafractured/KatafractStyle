# KatafractStyle

Shared design-system Swift package for Katafract-family apps (Vaultyx, DocArmor, Wraith, ExifArmor, ParkArmor, SafeOpen, MeritMosaic, AeroMosaic, Praetor).

One palette, one typography scale, one haptic vocabulary — applied across every app so the family feels cohesive.

## Install

Swift Package Manager:
```swift
.package(url: "https://github.com/katafractured/KatafractStyle.git", from: "0.1.0")
```

## Use

```swift
import KatafractStyle

Text("Vaultyx Sovereign").font(.kataDisplay(32))
Color.kataSapphire
Color.kataGold
KataHaptic.unlocked.fire()
```

See `Sources/KatafractStyle/` for the full token list.
