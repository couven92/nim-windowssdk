##
##
## | Microsoft Windows
## | Copyright (c) Microsoft Corporation. All rights reserved.
##
## :File:       combaseapi.h
##
## :Contents:   Base Component Object Model defintions.
##
##


import unknwn
import .. / shared / guiddef, .. / shared / wtypesbase, .. / shared / winerror

import dynlib

proc coCreateInstance*(
  rclsid: ptr ClsId,
  pUnkOuter: ptr IUnknown,
  dwClsContext: ClsCtx,
  riid: ptr Iid,
  ppv: var pointer
  ): HResult {.stdcall, importc: "CoCreateInstance", dynlib: "Ole32.dll".}