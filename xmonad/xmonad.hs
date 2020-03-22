
-- ("Right Alt"), Which Does Not Conflict With Emacs Keybindings. The
-- "Windows Key" Is Usually Mod4mask.
--
Mymodmask       = Mod1mask

-- The Mask For The Numlock Key. Numlock Status Is "Masked" From The
-- Current Modifier Status, So The Keybindings Will Work With Numlock On Or
-- Off. You May Need To Change This On Some Systems.
--
-- You Can Find The Numlock Modifier By Running "Xmodmap" And Looking For A
-- Modifier With Num_Lock Bound To It:
--
-- > $ Xmodmap | Grep Num
-- > Mod2        Num_Lock (0x4d)
--
-- Set Numlockmask = 0 If You Don'T Have A Numlock Key, Or Want To Treat
-- Numlock Status Separately.
--
Mynumlockmask   = Mod2mask

-- The Default Number Of Workspaces (Virtual Screens) And Their Names.
-- By Default We Use Numeric Strings, But Any String May Be Used As A
-- Workspace Name. The Number Of Workspaces Is Determined By The Length
-- Of This List.
--
-- A Tagging Example:
--
-- > Workspaces = ["Web", "Irc", "Code" ] ++ Map Show [4..9]
--
Myworkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border Colors For Unfocused And Focused Windows, Respectively.
--
Mynormalbordercolor  = "#Dddddd"
Myfocusedbordercolor = "#Ff0000"

------------------------------------------------------------------------
-- Key Bindings. Add, Modify Or Remove Key Bindings Here.
--
Mykeys Conf@(Xconfig {Xmonad.Modmask = Modm}) = M.Fromlist $

    -- Launch A Terminal
    [ ((Modm .|. Shiftmask, Xk_Return), Spawn $ Xmonad.Terminal Conf)

    -- Launch Dmenu
    , ((Modm,               Xk_P     ), Spawn "Exe=`Dmenu_Path | Dmenu` && Eval \"Exec $Exe\"")

    -- Launch Gmrun
    , ((Modm .|. Shiftmask, Xk_P     ), Spawn "Gmrun")

    -- Close Focused Window 
    , ((Modm .|. Shiftmask, Xk_C     ), Kill)

     -- Rotate Through The Available Layout Algorithms
    , ((Modm,               Xk_Space ), Sendmessage Nextlayout)

    --  Reset The Layouts On The Current Workspace To Default
    , ((Modm .|. Shiftmask, Xk_Space ), Setlayout $ Xmonad.Layouthook Conf)

    -- Resize Viewed Windows To The Correct Size
    , ((Modm,               Xk_N     ), Refresh)

    -- Move Focus To The Next Window
    , ((Modm,               Xk_Tab   ), Windows W.Focusdown)

    -- Move Focus To The Next Window
    , ((Modm,               Xk_J     ), Windows W.Focusdown)

    -- Move Focus To The Previous Window
    , ((Modm,               Xk_K     ), Windows W.Focusup  )

    -- Move Focus To The Master Window
    , ((Modm,               Xk_M     ), Windows W.Focusmaster  )

    -- Swap The Focused Window And The Master Window
    , ((Modm,               Xk_Return), Windows W.Swapmaster)

    -- Swap The Focused Window With The Next Window
    , ((Modm .|. Shiftmask, Xk_J     ), Windows W.Swapdown  )

    -- Swap The Focused Window With The Previous Window
    , ((Modm .|. Shiftmask, Xk_K     ), Windows W.Swapup    )

    -- Shrink The Master Area
    , ((Modm,               Xk_H     ), Sendmessage Shrink)

    -- Expand The Master Area
    , ((Modm,               Xk_L     ), Sendmessage Expand)

    -- Push Window Back Into Tiling
    , ((Modm,               Xk_T     ), Withfocused $ Windows . W.Sink)

    -- Increment The Number Of Windows In The Master Area
    , ((Modm              , Xk_Comma ), Sendmessage (Incmastern 1))

    -- Deincrement The Number Of Windows In The Master Area
    , ((Modm              , Xk_Period), Sendmessage (Incmastern (-1)))

    -- Toggle The Status Bar Gap (Used With Avoidstruts From Hooks.Managedocks)
    -- , ((Modm , Xk_B ), Sendmessage Togglestruts)

    -- Quit Xmonad
    , ((Modm .|. Shiftmask, Xk_Q     ), Io (Exitwith Exitsuccess))

    -- Restart Xmonad
    , ((Modm              , Xk_Q     ), Restart "Xmonad" True)
    ]
    ++

    --
    -- Mod-[1..9], Switch To Workspace N
    -- Mod-Shift-[1..9], Move Client To Workspace N
    --
    [((M .|. Modm, K), Windows $ F I)
        | (I, K) <- Zip (Xmonad.Workspaces Conf) [Xk_1 .. Xk_9]
        , (F, M) <- [(W.Greedyview, 0), (W.Shift, Shiftmask)]]
    ++

    --
    -- Mod-{W,E,R}, Switch To Physical/Xinerama Screens 1, 2, Or 3
    -- Mod-Shift-{W,E,R}, Move Client To Screen 1, 2, Or 3
    --
    [((M .|. Modm, Key), Screenworkspace Sc >>= Flip Whenjust (Windows . F))
        | (Key, Sc) <- Zip [Xk_W, Xk_E, Xk_R] [0..]
        , (F, M) <- [(W.View, 0), (W.Shift, Shiftmask)]]


------------------------------------------------------------------------
-- Mouse Bindings: Default Actions Bound To Mouse Events
--
Mymousebindings (Xconfig {Xmonad.Modmask = Modmask}) = M.Fromlist $

    -- Mod-Button1, Set The Window To Floating Mode And Move By Dragging
    [ ((Modmask, Button1), (\W -> Focus W >> Mousemovewindow W))

    -- Mod-Button2, Raise The Window To The Top Of The Stack
    , ((Modmask, Button2), (\W -> Focus W >> Windows W.Swapmaster))

    -- Mod-Button3, Set The Window To Floating Mode And Resize By Dragging
    , ((Modmask, Button3), (\W -> Focus W >> Mouseresizewindow W))

    -- You May Also Bind Events To The Mouse Scroll Wheel (Button4 And Button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You Can Specify And Transform Your Layouts By Modifying These Values.
-- If You Change Layout Bindings Be Sure To Use 'Mod-Shift-Space' After
-- Restarting (With 'Mod-Q') To Reset Your Layout State To The New
-- Defaults, As Xmonad Preserves Your Old Layout Settings By Default.
--
-- The Available Layouts.  Note That Each Layout Is Separated By |||,
-- Which Denotes Layout Choice.
--
Mylayout = Tiled ||| Mirror Tiled ||| Full
  Where
     -- Default Tiling Algorithm Partitions The Screen Into Two Panes
     Tiled   = Tall Nmaster Delta Ratio

     -- The Default Number Of Windows In The Master Pane
     Nmaster = 1

     -- Default Proportion Of Screen Occupied By Master Pane
     Ratio   = 1/2

     -- Percent Of Screen To Increment By When Resizing Panes
     Delta   = 3/100

------------------------------------------------------------------------
-- Window Rules:

-- Execute Arbitrary Actions And Windowset Manipulations When Managing
-- A New Window. You Can Use This To, For Example, Always Float A
-- Particular Program, Or Have A Client Always Appear On A Particular
-- Workspace.
--
-- To Find The Property Name Associated With A Program, Use
-- > Xprop | Grep Wm_Class
-- And Click On The Client You'Re Interested In.
--
-- To Match On The Wm_Name, You Can Use 'Title' In The Same Way That
-- 'Classname' And 'Resource' Are Used Below.
--
Mymanagehook = Composeall
    [ Classname =? "Mplayer"        --> Dofloat
    , Classname =? "Gimp"           --> Dofloat
    , Resource  =? "Desktop_Window" --> Doignore
    , Resource  =? "Kdesktop"       --> Doignore ]

-- Whether Focus Follows The Mouse Pointer.
Myfocusfollowsmouse :: Bool
Myfocusfollowsmouse = True


------------------------------------------------------------------------
-- Status Bars And Logging

-- Perform An Arbitrary Action On Each Internal State Change Or X Event.
-- See The 'Dynamiclog' Extension For Examples.
--
-- To Emulate Dwm'S Status Bar
--
-- > Loghook = Dynamiclogdzen
--
Myloghook = Return ()

------------------------------------------------------------------------
-- Startup Hook

-- Perform An Arbitrary Action Each Time Xmonad Starts Or Is Restarted
-- With Mod-Q.  Used By, E.G., Xmonad.Layout.Perworkspace To Initialize
-- Per-Workspace Layout Choices.
--
-- By Default, Do Nothing.
Mystartuphook = Return ()

------------------------------------------------------------------------
-- Now Run Xmonad With All The Defaults We Set Up.

-- Run Xmonad With The Settings You Specify. No Need To Modify This.
--
Main = Xmonad Defaults

-- A Structure Containing Your Configuration Settings, Overriding
-- Fields In The Default Config. Any You Don'T Override, Will 
-- Use The Defaults Defined In Xmonad/Xmonad/Config.Hs
-- 
-- No Need To Modify This.
--
Defaults = Defaultconfig {
      -- Simple Stuff
        Terminal           = Myterminal,
        Focusfollowsmouse  = Myfocusfollowsmouse,
        Borderwidth        = Myborderwidth,
        Modmask            = Mymodmask,
        Numlockmask        = Mynumlockmask,
        Workspaces         = Myworkspaces,
        Normalbordercolor  = Mynormalbordercolor,
        Focusedbordercolor = Myfocusedbordercolor,

      -- Key Bindings
        Keys               = Mykeys,
        Mousebindings      = Mymousebindings,

      -- Hooks, Layouts
        Layouthook         = Mylayout,
        Managehook         = Mymanagehook,
        Loghook            = Myloghook,
        Startuphook        = Mystartuphook
    }g
