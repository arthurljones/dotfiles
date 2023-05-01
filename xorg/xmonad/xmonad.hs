import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO
import XMonad.Layout.Grid
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns

myLayouts = avoidStruts $
            layoutCol ||| layoutTall ||| layoutGrid ||| layoutFull
    where
      layoutCol = ThreeColMid 1 (3/100) (1/3)
      layoutTall = reflectHoriz $ Tall 1 (3/100) (3/5)
      layoutGrid = Grid
      layoutFull = Full

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ def
        { terminal    = "terminator"
        , borderWidth = 2
        , modMask     = mod4Mask
        , manageHook = manageDocks <+> manageHook def
        , layoutHook = myLayouts
        , handleEventHook = handleEventHook def <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "darkgreen" "" . shorten 120
            , ppHiddenNoWindows = xmobarColor "grey" ""
            }
        , startupHook = setWMName "LG3D"
        } `additionalKeysP` myKeys

myKeys = [ ("C-S-5", spawn "flameshot gui")
    , (("M-b"), sendMessage ToggleStruts)
    , (("M-C-s"), spawn "systemctl suspend") -- "/home/aj/dotfiles/xorg/sleep_screen.sh")
    ]
