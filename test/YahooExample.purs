module Example where

import Prelude

import Control.Apply
import Control.Bind
import Control.Monad.Aff
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Control.Monad.Eff.Exception
import Control.Monad.Eff.Console hiding (error)

import Data.Array
import Data.Maybe

import Test.Phantomjs
import Test.Phantomjs.System
import Test.Phantomjs.Object
import Test.Phantomjs.Webpage
import Test.Phantomjs.Filesystem
import Test.Phantomjs.ChildProcess
import Test.BrowserProcs

main :: forall e. Eff (phantomjs :: PHANTOMJS, console :: CONSOLE | e) Unit
main = do
  args <- args
  page <- create
  let outfile = "screenshot.jpg"
  let timeout = 5000
  maybe
    ((print $ error "No url given") *> exit 0)
    (\url -> (runAff
              (print >=> const (exit 1))
              ((const (log $ "Screenshot of " ++
                       url ++
                       " saved to " ++
                       outfile ++
                       ".")) >=> const (exit 0))
              (open page url *>
               (liftEff $ screenshot page outfile) *>
               (liftEff $ logDocumentTitle page)
              )))
    (index args 1)

screenshot ::
  forall e. Page -> File -> Eff (phantomjs :: PHANTOMJS, console :: CONSOLE | e) Unit
screenshot page outfile = do
  log "Successfully connected."
  render page outfile

logDocumentTitle ::
  forall e. Page -> Eff (phantomjs :: PHANTOMJS, console :: CONSOLE | e) Unit
logDocumentTitle page = do
  browser_docTitle <- evaluate0 page docTitle
  log $ "Browser document title: " ++ browser_docTitle