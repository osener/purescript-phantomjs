module Test.Phantomjs.Webpage (
  BrowserProc()
, Page()
, Rect(..)
, RectObj()
, ScrollPosition(..)
, ScrollPositionObj()
, ViewportSize(..)
, ViewportSizeObj()
, content
, setClipRect
, getClipRect
, create
, evaluate0
, evaluate1
, evaluate2
, evaluate3
, injectJs
, open
, openWithTimeout
, plainText
, render
, getScrollPosition
, setScrollPosition
, url
, getViewportSize
, setViewportSize
, getZoomFactor
, setZoomFactor
) where

import Prelude

import Data.Function

import Control.Alt
import Control.Monad.Eff.Exception
import Control.Monad.Eff
import Control.Monad.Aff
import Control.Monad.Aff.AVar
import Control.Monad.Aff.Par
import Control.Monad.Error.Class
import Test.Phantomjs

-- | Represents a NON-closure procedure that will be run in the
-- | browser environment.
-- |
foreign import data BrowserProc :: * -> *

-- | An instance of Phantom's `webpage`.
-- |
foreign import data Page :: *

-- | Rectangular area of the web page to be rasterized when rendered.
-- |
type RectObj = { top :: Int, left :: Int, width :: Int, height :: Int }
newtype Rect = Rect RectObj

type ScrollPositionObj = { top :: Int, left :: Int }
newtype ScrollPosition = ScrollPosition ScrollPositionObj

type ViewportSizeObj = { width :: Int, height :: Int }
newtype ViewportSize = ViewportSize ViewportSizeObj

-- | Gets the rectangular area of the web page to be rasterized when rendered.
-- |
getClipRect
  :: forall e.
     Page
  -> Eff (phantomjs :: PHANTOMJS | e) Rect
getClipRect page = _getClipRect page <#> Rect

foreign import _getClipRect
  :: forall e.
     Page
  -> Eff (phantomjs :: PHANTOMJS | e) RectObj

-- | Sets the rectangular area of the web page to be rasterized when rendered.
-- |
setClipRect
  :: forall e.
     Page
  -> Rect
  -> Eff (phantomjs :: PHANTOMJS | e) Unit
setClipRect page (Rect rect) = runFn5 _setClipRect page rect.top rect.left rect.width rect.height

foreign import _setClipRect
  :: forall e.
     Fn5
     Page
     Int
     Int
     Int
     Int
     (Eff (phantomjs :: PHANTOMJS | e) Unit)

foreign import content
  :: forall e.
     Page
  -> Eff (phantomjs :: PHANTOMJS | e) String

-- | Creates an instance of Phantom's `webpage`.
-- |
foreign import create
  :: forall e. Eff (phantomjs :: PHANTOMJS | e) Page

-- | Run a NON-closure procedure in the browser
-- | environment. `evaluateN` takes N arguments. Arguments must be
-- | JSON-serializable.
-- |
foreign import evaluate0
  :: forall e a.
     Page
  -> BrowserProc a
  -> Eff (phantomjs :: PHANTOMJS | e) a

-- | Run a NON-closure procedure in the browser
-- | environment. `evaluateN` takes N arguments. Arguments must be
-- | JSON-serializable.
-- |
foreign import evaluate1
  :: forall e a b.
     Page
  -> (a -> BrowserProc b)
  -> a
  -> Eff (phantomjs :: PHANTOMJS | e) b

-- | Run a NON-closure procedure in the browser
-- | environment. `evaluateN` takes N arguments. Arguments must be
-- | JSON-serializable.
-- |
foreign import evaluate2
  :: forall e a b c.
     Page
  -> (a -> b -> BrowserProc c)
  -> a
  -> b
  -> Eff (phantomjs :: PHANTOMJS | e) c

-- | Run a NON-closure procedure in the browser
-- | environment. `evaluateN` takes N arguments. Arguments must be
-- | JSON-serializable.
-- |
foreign import evaluate3
  :: forall e a b c d.
     Page
  -> (a -> b -> c -> BrowserProc d)
  -> a
  -> b
  -> c
  -> Eff (phantomjs :: PHANTOMJS | e) d

-- | Injects external script code from the specified file into the page. (like
-- | page.includeJs, except that the file does not need to be accessible from
-- | the hosted page).
-- |
-- | If the file cannot be found in the current directory, libraryPath is used
-- | for additional look up. This function returns true if injection is
-- | successful, otherwise it returns false.
-- |
foreign import injectJs
  :: forall e.
     Page
  -> String
  -> Eff (phantomjs :: PHANTOMJS | e) Boolean

-- | Opens a connection to the given URL.
-- |
open :: forall e. Page -> String -> Aff (phantomjs :: PHANTOMJS | e) Unit
open page url = makeAff (\onError onSuccess -> _open
                                               onError
                                               (onSuccess unit)
                                               page
                                               url)

foreign import _open
  :: forall e.
     (Error -> Eff (phantomjs :: PHANTOMJS | e) Unit)
  -> Eff (phantomjs :: PHANTOMJS | e) Unit
  -> Page
  -> String
  -> Eff (phantomjs :: PHANTOMJS | e) Unit

-- | Opens a connection to the given URL, but may fail with a timeout.
-- |
openWithTimeout ::
  forall e. Page -> String -> Timeout -> Aff ( avar :: AVAR
                                             , phantomjs :: PHANTOMJS | e) Unit
openWithTimeout page url timeout =
  runPar $
  (Par $ pure unit) <|>
  (Par $ later' timeout (throwError $ timeoutError timeout))
  where
    timeoutError timeout = error $ "Timed out after " ++ show timeout ++ " seconds"

foreign import plainText
  :: forall e.
     Page
  -> Eff (phantomjs :: PHANTOMJS | e) String

-- | Renders the page image to a file. File extension determines
-- | format. Accepts: PNG, GIF, JPEG, PDF.
-- |
foreign import render
  :: forall e.
     Page
  -> File
  -> Eff (phantomjs :: PHANTOMJS | e) Unit

getScrollPosition
  :: forall e.
     Page
  -> Eff (phantomjs :: PHANTOMJS | e) ScrollPosition
getScrollPosition page = _getScrollPosition page <#> ScrollPosition

foreign import _getScrollPosition
  :: forall e.
     Page
  -> Eff (phantomjs :: PHANTOMJS | e) ScrollPositionObj

setScrollPosition
  :: forall e.
     Page
  -> ScrollPosition
  -> Eff (phantomjs :: PHANTOMJS | e) Unit
setScrollPosition page (ScrollPosition scrollPos) = _setScrollPosition page scrollPos

foreign import _setScrollPosition
  :: forall e.
     Page
  -> ScrollPositionObj
  -> Eff (phantomjs :: PHANTOMJS | e) Unit

foreign import url
  :: forall e.
     Page
  -> Eff (phantomjs :: PHANTOMJS | e) String

getViewportSize
  :: forall e.
     Page
  -> Eff (phantomjs :: PHANTOMJS | e) ViewportSize
getViewportSize page = _getViewportSize page <#> ViewportSize

foreign import _getViewportSize
  :: forall e.
     Page
  -> Eff (phantomjs :: PHANTOMJS | e) ViewportSizeObj

setViewportSize
  :: forall e.
     Page
  -> ViewportSize
  -> Eff (phantomjs :: PHANTOMJS | e) Unit
setViewportSize page (ViewportSize size) = _setViewportSize page size

foreign import _setViewportSize
  :: forall e.
     Page
  -> ViewportSizeObj
  -> Eff (phantomjs :: PHANTOMJS | e) Unit

-- | Gets the zoom factor for the page.
-- |
foreign import getZoomFactor :: forall e. Page -> Eff (phantomjs :: PHANTOMJS | e) Number

-- | Sets the zoom factor for the page.
-- |
setZoomFactor :: forall e. Page -> Number -> Eff (phantomjs :: PHANTOMJS | e) Unit
setZoomFactor page factor = runFn2 _setZoomFactor page factor

foreign import _setZoomFactor
  :: forall e.
     Fn2
     Page
     Number
     (Eff (phantomjs :: PHANTOMJS | e) Unit)
