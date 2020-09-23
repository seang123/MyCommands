let doc = """
ls - list computer files

Usage: ls
       ls -s
       ls -r

Options:
 -h --help     Show this screen.
 --version     Show version.
 -s            Echo filesize in bytes.
 -r            Recursively echo files in subfolders.
"""

import os
import docopt  # used for cmd line args
import strutils  # used for repeat


let args = docopt(doc, version = "ls 0.2")

let baseDir = getCurrentDir()

proc printFiles(path: string, space: int) =
  var indent = repeat(" ", space)

  for kind, path in walkDir path:
    let (dir, name, ext) = splitFile(path)

    if ext == "": # if object is a folder
      if args["-r"]:
        echo indent, name, "/"
        var nspace = space + 1
        printFiles(path, nspace)
      else:
        echo name, "/"
    elif args["-s"]:
      echo name, ext, " -- ", getFileSize(path)
    else:
      echo indent, name, ext


printFiles(baseDir, 0)
