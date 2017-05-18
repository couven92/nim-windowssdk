# Package

version       = "10.0.10240"
author        = "Fredrik H\x9Bis\x91ther Rasch"
description   = "Windows SDK nimble package"
license       = "MIT"
srcDir        = "src"

# Dependencies

requires "nim >= 0.17.0"

import strutils

# Setup
before build:
  mkDir "bin"
before buildWithSdk:
  mkDir "bin"

before test:
  mkDir "bin"
before testWithSdk:
  mkDir "bin"

task docall, "Document srcDir recursively":
  proc recurseDir(srcDir, docDir: string, nimOpts: string = "") =
    for srcFile in listFiles(srcDir):
      if not srcFile.endsWith(".nim"):
        echo "skipping non nim file: $#" % [srcFile]
      let docFile = docDir & srcFile[srcDir.len..^5] & ".html"
      echo "file: $# -> $#" % [srcFile, docFile]
      exec "nim doc $# -o:\"$#\" \"$#\"" % [nimOpts, docFile, srcFile]
    for srcSubDir in listDirs(srcDir):
      let docSubDir = docDir & srcSubDir[srcDir.len..^1]
      # echo "dir: $# -> $#" % [srcSubDir, docSubDir]
      mkDir docSubDir
      recurseDir(srcSubDir, docSubDir)

  let docDir = "doc"
  recurseDir(srcDir, docDir)

task build, "Builds the Windows SDK bundle":
  exec "nim compile -o:bin/windowssdk --nimcache:obj src/windowssdk"

task buildWithSdk, "Builds the Windows SDK bundle":
  exec "nim compile -o:bin/windowssdk --nimcache:obj -d:useWinSdk --dynlibOverride:Secur32.dll --dynlibOverride:SspiCli.dll --dynlibOverride:CredUi.dll --passL:Secur32.lib src/windowssdk"

task test, "Runs the test module":
  exec "nim compile -r -o:bin/twindowssdk --nimcache:obj test/twindowssdk"

task testWithSdk, "Runs the test module":
  exec "nim compile -r -o:bin/twindowssdk --nimcache:obj -d:useWinSdk --dynlibOverride:Secur32.dll --dynlibOverride:SspiCli.dll --dynlibOverride:CredUi.dll --passL:Secur32.lib test/twindowssdk"
