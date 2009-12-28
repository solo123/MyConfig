import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
 
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import qualified XMonad.StackSet as W
import Data.List
 
main = xmonad $ defaultConfig
              { manageHook = myManageHook <+> manageHook defaultConfig
              , logHook = ewmhDesktopsLogHook
              , layoutHook = avoidStruts $ layoutHook defaultConfig
              , modMask = mod4Mask
              , borderWidth = 4
              , normalBorderColor = "#333333"
              , focusedBorderColor = "#cd8b00"
              , focusFollowsMouse = False
              }
                `additionalKeysP`
             [
               ("M-a", spawn "xmessage 'Hello, boy!@'")
             , ("M-<Left>", prevWS )
             , ("M-<Right>", nextWS )
             , ("M-<Up>", windows W.focusUp )
             , ("M-<Down>", windows W.focusDown )
             , ("M-S-<Left>", sendMessage Shrink )
             , ("M-S-<Right>", sendMessage Expand )
             , ("M-S-<Up>", windows W.swapUp )
             , ("M-S-<Down>", windows W.swapDown )
             , ("M-S-q", spawn "gnome-session-save --gui --logout-dialog")
             ]
 
myManageHook = composeAll . concat $
   [
     [ resource =? "Dialog" --> doFloat ]
 
     -- using list comprehensions and partial matches
   , [ className =? c --> doFloat | c <- myFloatsC ]
   , [ fmap ( c `isInfixOf`) className --> doFloat | c <- myMatchAnywhereFloatsC ]
   , [ fmap ( c `isInfixOf`) title --> doFloat | c <- myMatchAnywhereFloatsT ]
   , [manageDocks]
   ]
   -- in a composeAll hook, you'd use: fmap ("VLC" `isInfixOf`) title --> doFloat
  where myFloatsC = ["Xmessage","Firefox","Google-chrome"]
        myMatchAnywhereFloatsC = ["Gimp", "Pidgin","Firefox","Google","chrome"]
        myMatchAnywhereFloatsT = ["QQ","chrome"]
 
