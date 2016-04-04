import XMonad 
import XMonad.Config.Bluetile
import XMonad.Util.Replace
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig
import XMonad.Actions.SwapWorkspaces

shellSpawn s = do
    spawn ("$SHELL -c '" ++ s ++ "'")

myStartupHook = do
    spawn "taffybar"
    spawn "launchy"
    setWMName "LG3D"

myManageHook = 
    manageDocks <+>
    composeAll
	[ className =? "Do" --> doFloat ]

modm = mod4Mask

myWorkspaces = workspaces bluetileConfig

main = xmonad $ bluetileConfig
    { modMask = mod4Mask
    , borderWidth = 2
    , startupHook = myStartupHook
    , manageHook = myManageHook
    }
    `additionalKeys`
     [((modm .|. controlMask, k), windows $ swapWithCurrent i)
         | (i, k) <- zip myWorkspaces [xK_1 ..]]
    `additionalKeysP`
    [ ("M-x", shellSpawn "rofi -show run")
    ]
