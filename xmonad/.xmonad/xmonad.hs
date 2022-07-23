import Data.Maybe (fromJust)
import Data.Monoid
import Data.List (isSubsequenceOf, intercalate)
--import Data.IORef.MonadIO (liftIO)
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.Process
import XMonad
import XMonad.Actions.CycleWS -- cicle workspaces
import XMonad.Actions.NoBorders
import XMonad.Hooks.DynamicLog -- show output to xmobar
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#666666"
myFocusedBorderColor = "#47D4B9"


-- VARIABLES
myPlayer:: String
myPlayer = "vlc"

sink:: [[Char]]-- to change volume on a sink other than the default (for pamixer)
--sink = [] -- empty for default sink
sink = ["--sink", "alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo"]

--altgrMod = mod5Mask
altgrMod = mod3Mask
--altgrMod = 0x6c

params = sink ++ ["--get-mute"]

--toggleMute :: IO String
toggleMute  = do
  out <- runProcessWithInput "pamixer" params []
  --spawn $ "xmessage " ++ out
  if out == "true\n"
    then spawn $ "pamixer " ++ (intercalate " " sink) ++ " -u"
    else spawn $ "pamixer " ++ (intercalate " " sink) ++ " -m"
  --return out

toggleDark  = do
  out <- runProcessWithInput "systemctl" ["--user", "status", "redshift"] []
  if not $ isSubsequenceOf "●" out
    then spawn "killall redshift; systemctl --user restart redshift"
    else spawn "systemctl --user stop redshift; redshift -b 0.7:0.55"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_t), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_s     ), spawn "dmenu_run")

    -- close focused window
    , ((modm .|. shiftMask, xK_Delete ), kill)

     -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask, xK_BackSpace), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    --, ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
    --, ((modm,               xK_Down  ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
    --, ((modm,               xK_Up    ), windows W.focusUp  )

    -- Move focus to the master window
    --, ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    --, ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm .|. shiftMask, xK_h     ), sendMessage Shrink)
    , ((modm .|. shiftMask, xK_Left  ), sendMessage Shrink)

    -- Expand the master area
    , ((modm .|. shiftMask, xK_l     ), sendMessage Expand)
    , ((modm .|. shiftMask, xK_Right ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_w     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    --, ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    --, ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_BackSpace), sendMessage (MT.Toggle NBFULL))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    -----------------------------------------------
    -- My keys ----- find keys: cat /usr/include/X11/keysymdef.h
    -- Volume keys
    , ((0                 , xF86XK_AudioLowerVolume), spawn $ "pamixer " ++ (intercalate " " sink) ++ " -d 5")
    , ((0                 , xF86XK_AudioRaiseVolume), spawn $ "pamixer " ++ (intercalate " " sink) ++ " -i 5")
    , ((0                 , xF86XK_AudioMute), toggleMute)
    -- Open Programs
    , ((modm                , xK_f     ), spawn "firefox")
    , ((modm .|. shiftMask  , xK_f     ), spawn "firefox --private-window")
    , ((modm                , xK_e     ), spawn "emacs")
    , ((modm                , xK_r     ), spawn "alacritty --title=Ranger --command ranger")
    , ((modm                , xK_p     ), spawn "killall pavucontrol ; pavucontrol")
    --, ((modm                , xK_c     ), spawn "killall nm-connection-editor ; nm-connection-editor")
    , ((modm                , xK_c     ), spawn "killall networkmanager_dmenu ; networkmanager_dmenu")
    , ((modm                , xK_v     ), spawn "alacritty --option font.size=16.0 font.normal.style=Normal --title Neovim --command nvim")
    -- Suspend/shutdown
    , ((modm                , xK_F12   ), spawn "dm-tool lock" >> spawn "systemctl suspend")
    , ((modm .|. controlMask, xK_F12   ), spawn "systemctl poweroff")
    , ((modm .|. controlMask, xK_F11   ), spawn "systemctl reboot")
    -- Cycle workspaces
    --, ((modm                , xK_l ), nextWS)
    --, ((modm                , xK_h ), prevWS)
    --, ((modm .|. controlMask, xK_l ), shiftToNext >> nextWS)
    --, ((modm .|. controlMask, xK_h ), shiftToPrev >> prevWS)
    , ((modm                , xK_Right ), nextWS)
    , ((modm                , xK_Left  ), prevWS)
    , ((modm .|. controlMask, xK_Right ), shiftToNext >> nextWS)
    , ((modm .|. controlMask, xK_Left  ), shiftToPrev >> prevWS)
    -- Music player
    , ((altgrMod                , xK_Up    ), spawn $ "playerctl --player=" ++ myPlayer ++ " volume 0.05+")
    , ((altgrMod                , xK_Down  ), spawn $ "playerctl --player=" ++ myPlayer ++ " volume 0.05-")
    , ((altgrMod                , xK_Left  ), spawn $ "playerctl --player=" ++ myPlayer ++ " position 10-")
    , ((altgrMod                , xK_Right ), spawn $ "playerctl --player=" ++ myPlayer ++ " position 10+")
    , ((altgrMod .|. controlMask, xK_Left  ), spawn $ "playerctl --player=" ++ myPlayer ++ " previous")
    , ((altgrMod .|. controlMask, xK_Right ), spawn $ "playerctl --player=" ++ myPlayer ++ " next")
    --, ((altgrMod                , xK_space ), spawn $ "playerctl --player=" ++ myPlayer ++ " play-pause")
    , ((altgrMod                , xK_KP_Insert ), spawn $ "playerctl --player=" ++ myPlayer ++ " play-pause")
    , ((altgrMod                , xK_Return), spawn $ "playerctl --player=" ++ myPlayer ++ " loop Playlist")
    , ((altgrMod .|. controlMask, xK_Return), spawn $ "playerctl --player=" ++ myPlayer ++ " loop Track")
    , ((altgrMod .|. shiftMask  , xK_Return), spawn $ "playerctl --player=" ++ myPlayer ++ " loop None")
    -- Screen capture
    , ((0                       , xK_Print ), spawn "flameshot gui")
    -- Switch dark mode
    , ((modm .|. shiftMask      , xK_r     ), toggleDark)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    --[((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
-- myLayoutNoSpace = avoidStruts (tiled ||| Mirror tiled ||| Full)
myLayoutNoSpace = avoidStruts (tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


mySpacing i = spacingRaw True (Border 0 i i i) True (Border i i i i) True

myLayout = mkToggle (single NBFULL) $ smartBorders $ mySpacing 10 $ myLayoutNoSpace

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Gimp"           --> doFloat
    , className =? "zoom"           --> doFloat
    , className =? "matplotlib"     --> doFloat
    , resource  =? "desktop_window" --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom --experimental-backends &"
    --spawnOnce "redshift &"
    spawnOnce "systemctl --user restart redshift"
    --spawnOnce "setxkbmap -layout it"
    --spawnOnce "setxkbmap -option -layout us -model kinesis"
    spawnOnce "xsetroot -cursor_name left_ptr &"


------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--


windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset


main = do
  xmproc <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobarrc"
  xmonad $ docks $ def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = dynamicLogWithPP $ xmobarPP
          { ppOutput = hPutStrLn xmproc
          , ppCurrent = xmobarColor "#FFFFFF" "" . wrap "[" "]"           -- Current workspace
          , ppHidden = xmobarColor "#05A1F7" ""                           -- Hidden workspaces
          , ppHiddenNoWindows = xmobarColor "#8C42AB" ""                  -- Hidden workspaces (no windows) (if set shows them)
          , ppTitle = xmobarColor "#47D4B9" "" . shorten 40               -- Title of active window
          , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"                    -- Separator character
          , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace
          , ppExtras  = [windowCount]                                     -- # of windows current workspace
          , ppOrder  = \(ws:_:t:ex) -> [ws]++ex++[t]                    -- order of things in xmobar
          },
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
