# uicollectionview-layouts-kit [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome)

[![Platform](https://img.shields.io/badge/platform-iOS-yellow.svg)]()
[![Language](https://img.shields.io/badge/language-Swift-orange.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()

**Last Update: 19/December/2018.**

![](cover-uickit.png)

### If you like the project, please give it a star ⭐ It will show the creator your appreciation and help others to discover the repo.

# ✍️ About
📐 A set of custom layouts for `UICollectionView` with examples. All the layouts support both `portrait` and `landscape` `UI` orientations as well as support for all `iOS`-related size classes (`iPhone` & `iPad`).

# ⚠️ Warning 
The assets used in this project were taken from the `Web`. Do not use them for commertial purposes and proprietary projects. They are used just for demostration only. 

# 🏗 Setup
In order to add layouts to your project, simply copy-paste corresponding `Layout` file (each of the targets has folder called `Layout` that contains all the related sources). `CocoaPods` will be added as a dependency manager.

# ✈️ Usage
The next step is to either `programmatically` or via `Storyboard`/`Nib` file connect the layout and override the default one. 

## Programmatic Setup
If you choose `programmatic` approach, all you need to do is to set the instance of a layout using the following scheme:

```swift
...
let verticalSnapCollectionFlowLayout = VerticalSnapCollectionFlowLayout()
// Use custom properties that are available for each layout
verticalSnapCollectionFlowLayout.minLineSpacing = 30
verticalSnapCollectionFlowLayout.spacingMultiplier = 8

collectionView.collectionViewLayout = verticalSnapCollectionFlowLayout

// or 

collectionView.setCollectionViewLayout(verticalSnapCollectionFlowLayout, animated: true)
```

## Storyboard/Nib Setup
Setting up the layouts via `Storyboard`/`Nib` is very easy as well. All you need to do is the following:

1. Find your `Collection View` in Xcode's visual editor
2. Select it
3. Open `Attributes Inspector`
4. Find and change UI menu called `Layout` to `Custom`
5. Set the class to the one that you wish to use

In your view controller you need to provide a valid reference to the `UIViewController` from `Storyboard`/`Nib` file where you overriden the default layout class.

For cases when you need to tell your custom layout what class is going to delegate the layout handling, use the following code:
```swift
...
if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
    layout.delegate = self
}
...
```

For cases when you simply need to change properties for custom layouts that were set via visual editor, use the following code:
```swift
...
if let layout = collectionView?.collectionViewLayout as? InstagridLayout {
    layout.itemSpacing = 10
    layout.fixedDivisionCount = 4
    layout.scrollDirection = .vertical
}
...
```

If you use `Storyboard`/`Nib` approach, consider creating an `IBOutlet` to the custom layout and directly set it up, instead of casting layout using the collection view reference:
```swift
...
@IBOutlet weak var instagridLayout: InstagridLayout!

override func viewDidLoad() {
    super.viewDidLoad()
    
    // InstagridLyout setup
    instagridLayout.delegate = self
    instagridLayout.itemSpacing = 10
    instagridLayout.fixedDivisionCount = 4
    instagridLayout.scrollDirection = .vertical
}
...
```

# 📚 Contents

## Vertical Snap 
Is a custom flow layout that adds `snapping` behavior to `single column` collection view. Supports both `portrait` and `landscape` layouts. `Landscape` layout changes the number of `columns` to `two` - in order to more ergonomically fill in the horizontal space. 

### Portrait 

<p align="center">
    <img src="readme-assets/snap-vertical.gif" alt="Drawing" style="width: 200px;"/>
</p>


### Landscape 

<p align="center">
    <img src="readme-assets/snap-horizontal.gif" alt="Drawing" style="width: 500px;"/>
</p>


## Pinterest 
Is a custom layout that mimics `Pinterest` layout. Can be customized with a variable `number of rows` and `custom cells`. Supports both `landscape` and `portrait` layouts.

<p align="center">
    <img src="readme-assets/pinterest.gif" alt="Drawing" style="width: 500px;"/>
</p>

## Spinner
Is a custom layout that places collection view cells in a circular fashion with a `snapping behaviour`. The spinning `circle radius`, `cell size` and `cell decoration view` can be customized. Supports both `landscape` and `portrait` layouts.

<p align="center">
    <img src="readme-assets/spinner.gif" alt="Drawing" style="width: 500px;"/>
</p>

## Instagrid
Is a custom layout similar to `Instagram`'s feed layout. Has several customization points and a `delegate` protocol for cell size runtime customization. Supports both `landscape` and `portrait` layouts.

### Horizontal 
<p align="center">
    <img src="readme-assets/insta-grid_horizontal.gif" alt="Drawing" style="width: 500px;"/>
</p>

### Vertical
<p align="center">
    <img src="readme-assets/insta-grid_vertical.gif" alt="Drawing" style="width: 500px;"/>
</p>

# 👨‍💻 Author 
[Astemir Eleev](https://github.com/jVirus)

# 🔖 Licence 
The project is available under [MIT Licence](https://github.com/jVirus/collection-flow-layout-ios/blob/master/LICENSE)

