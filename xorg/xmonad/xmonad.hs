import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ def
        { terminal    = "terminator"
        , borderWidth = 2
        , modMask     = mod4Mask
        , manageHook = manageDocks <+> manageHook def
        , layoutHook = avoidStruts $ layoutHook def
        , handleEventHook = handleEventHook def <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "darkgreen" "" . shorten 20
            , ppHiddenNoWindows = xmobarColor "grey" ""
            }
        , startupHook = setWMName "LG3D"
        } `additionalKeysP` myKeys

myKeys = [ ("C-S-5", spawn "flameshot gui")
    , (("M-b"), sendMessage ToggleStruts)
    ]
