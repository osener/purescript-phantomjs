## Module Test.Phantomjs.Webpage

#### `BrowserProc`

``` purescript
data BrowserProc :: * -> *
```

Represents a NON-closure procedure that will be run in the
browser environment.


#### `Page`

``` purescript
data Page :: *
```

An instance of Phantom's `webpage`.


#### `RectObj`

``` purescript
type RectObj = { top :: Int, left :: Int, width :: Int, height :: Int }
```

Rectangular area of the web page to be rasterized when rendered.


#### `Rect`

``` purescript
newtype Rect
  = Rect RectObj
```

#### `ScrollPositionObj`

``` purescript
type ScrollPositionObj = { top :: Int, left :: Int }
```

#### `ScrollPosition`

``` purescript
newtype ScrollPosition
  = ScrollPosition ScrollPositionObj
```

#### `ViewportSizeObj`

``` purescript
type ViewportSizeObj = { width :: Int, height :: Int }
```

#### `ViewportSize`

``` purescript
newtype ViewportSize
  = ViewportSize ViewportSizeObj
```

#### `getClipRect`

``` purescript
getClipRect :: forall e. Page -> Eff (phantomjs :: PHANTOMJS | e) Rect
```

Gets the rectangular area of the web page to be rasterized when rendered.


#### `setClipRect`

``` purescript
setClipRect :: forall e. Page -> Rect -> Eff (phantomjs :: PHANTOMJS | e) Unit
```

Sets the rectangular area of the web page to be rasterized when rendered.


#### `content`

``` purescript
content :: forall e. Page -> Eff (phantomjs :: PHANTOMJS | e) String
```

#### `create`

``` purescript
create :: forall e. Eff (phantomjs :: PHANTOMJS | e) Page
```

Creates an instance of Phantom's `webpage`.


#### `evaluate0`

``` purescript
evaluate0 :: forall e a. Page -> BrowserProc a -> Eff (phantomjs :: PHANTOMJS | e) a
```

Run a NON-closure procedure in the browser
environment. `evaluateN` takes N arguments. Arguments must be
JSON-serializable.


#### `evaluate1`

``` purescript
evaluate1 :: forall e a b. Page -> (a -> BrowserProc b) -> a -> Eff (phantomjs :: PHANTOMJS | e) b
```

Run a NON-closure procedure in the browser
environment. `evaluateN` takes N arguments. Arguments must be
JSON-serializable.


#### `evaluate2`

``` purescript
evaluate2 :: forall e a b c. Page -> (a -> b -> BrowserProc c) -> a -> b -> Eff (phantomjs :: PHANTOMJS | e) c
```

Run a NON-closure procedure in the browser
environment. `evaluateN` takes N arguments. Arguments must be
JSON-serializable.


#### `evaluate3`

``` purescript
evaluate3 :: forall e a b c d. Page -> (a -> b -> c -> BrowserProc d) -> a -> b -> c -> Eff (phantomjs :: PHANTOMJS | e) d
```

Run a NON-closure procedure in the browser
environment. `evaluateN` takes N arguments. Arguments must be
JSON-serializable.


#### `injectJs`

``` purescript
injectJs :: forall e. Page -> String -> Eff (phantomjs :: PHANTOMJS | e) Boolean
```

Injects external script code from the specified file into the page. (like
page.includeJs, except that the file does not need to be accessible from
the hosted page).

If the file cannot be found in the current directory, libraryPath is used
for additional look up. This function returns true if injection is
successful, otherwise it returns false.


#### `open`

``` purescript
open :: forall e. Page -> String -> Aff (phantomjs :: PHANTOMJS | e) Unit
```

Opens a connection to the given URL.


#### `openWithTimeout`

``` purescript
openWithTimeout :: forall e. Page -> String -> Timeout -> Aff (avar :: AVAR, phantomjs :: PHANTOMJS | e) Unit
```

Opens a connection to the given URL, but may fail with a timeout.


#### `plainText`

``` purescript
plainText :: forall e. Page -> Eff (phantomjs :: PHANTOMJS | e) String
```

#### `render`

``` purescript
render :: forall e. Page -> File -> Eff (phantomjs :: PHANTOMJS | e) Unit
```

Renders the page image to a file. File extension determines
format. Accepts: PNG, GIF, JPEG, PDF.


#### `getScrollPosition`

``` purescript
getScrollPosition :: forall e. Page -> Eff (phantomjs :: PHANTOMJS | e) ScrollPosition
```

#### `setScrollPosition`

``` purescript
setScrollPosition :: forall e. Page -> ScrollPosition -> Eff (phantomjs :: PHANTOMJS | e) Unit
```

#### `url`

``` purescript
url :: forall e. Page -> Eff (phantomjs :: PHANTOMJS | e) String
```

#### `getViewportSize`

``` purescript
getViewportSize :: forall e. Page -> Eff (phantomjs :: PHANTOMJS | e) ViewportSize
```

#### `setViewportSize`

``` purescript
setViewportSize :: forall e. Page -> ViewportSize -> Eff (phantomjs :: PHANTOMJS | e) Unit
```

#### `getZoomFactor`

``` purescript
getZoomFactor :: forall e. Page -> Eff (phantomjs :: PHANTOMJS | e) Number
```

Gets the zoom factor for the page.


#### `setZoomFactor`

``` purescript
setZoomFactor :: forall e. Page -> Number -> Eff (phantomjs :: PHANTOMJS | e) Unit
```

Sets the zoom factor for the page.
