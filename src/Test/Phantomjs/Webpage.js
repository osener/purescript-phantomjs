"use strict"

// module Test.Phantomjs.Webpage

exports.content = function (page) {
  return function () {
    return page.content
  }
}

exports._getClipRect = function (page) {
  return function () {
    return page.clipRect
  }
}

exports._setClipRect = function (page,top,left,width,height) {
  return function () {
    return page.clipRect = {
      top: top,
      left: left,
      width: width,
      height: height
    }
  }
}

exports.create = function () {
  return require('webpage').create()
}

exports.evaluate0 = function (page) {
  return function (proc) {
    return function () {
      return page.evaluate(eval(proc))
    }
  }
}

exports.evaluate1 = function (page) {
  return function (proc) {
    return function (_1) {
      return function () {
        return page.evaluate(eval(proc),_1)
      }
    }
  }
}

exports.evaluate2 = function (page) {
  return function (proc) {
    return function (_1) {
      return function (_2) {
        return function () {
          return page.evaluate(eval(proc),_1,_2)
        }
      }
    }
  }
}

exports.evaluate3 = function (page) {
  return function (proc) {
    return function (_1) {
      return function (_2) {
        return function (_3) {
          return function () {
            return page.evaluate(eval(proc),_1,_2,_3)
          }
        }
      }
    }
  }
}

exports.injectJs = function (page) {
  return function (file) {
    return function () {
      return page.injectJs(file)
    }
  }
}

exports._open = function (onError) {
  return function (onSuccess) {
    return function (page) {
      return function (url) {
        return function () {
          return page.open(url, function (status) {
            if (status === 'success') onSuccess()
            else onError(new Error("Connection failure"))()
          })
        }
      }
    }
  }
}

exports.plainText = function (page) {
  return function () {
    return page.plainText
  }
}

exports.render = function (page) {
  return function (file) {
    return function () {
      return page.render(file)
    }
  }
}

exports._getScrollPosition = function (page) {
  return function () {
    return page.scrollPosition
  }
}

exports._setScrollPosition = function (page) {
  return function (obj) {
    return function () {
      return page.scrollPosition = obj
    }
  }
}

exports.url = function (page) {
  return function () {
    return page.url
  }
}

exports._getViewportSize = function (page) {
  return function () {
    return page.viewportSize
  }
}

exports._setViewportSize = function (page) {
  return function (obj) {
    return function () {
      return page.viewportSize = obj
    }
  }
}

exports.getZoomFactor = function (page) {
  return function () {
    return page.zoomFactor
  }
}

exports._setZoomFactor = function (page, factor) {
  return function () {
    page.zoomFactor = factor
  }
}
