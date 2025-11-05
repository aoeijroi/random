@echo off
title ultimate batch of randomness - main
color 0a
rem make sure main window has unique title so loop_cmd doesn't kill it
rem main menu now has 25 options, lots of submenus and extras

:menu
cls
echo welcome to the most random batch file ever. warning: this script contains options that simulate system changes (rename windows folders, shutdown, taskkill, etc.) some are pranky but could be harmful if you run as admin.
echo --------------------------------------------------------------
echo 1.  clean temp files
echo 2.  check internet connection
echo 3.  display a random fact
echo 4.  insult your intelligence
echo 5.  generate a fake error
echo 6.  shutdown your pc (jk... or not?)
echo 7.  tell you a joke
echo 8.  play a sound (super epik)
echo 9.  make your pc say something embarrassing
echo 10. randomly rename your pc files (dont run as admin unless you mean it)
echo 11. eat all your system memory (jk, or am i?)
echo 12. exit this madness
echo 13. others (expanded submenu)
echo 14. utilities (real-ish tools)
echo 15. network toys
echo 16. system tweaks
echo 17. prank mode
echo 18. media & sounds
echo 19. secret easter eggs
echo 20. diagnostics & logs
echo 21. quick scripts (small useful scripts)
echo 22. mini-games
echo 23. forbidden zone (deep weirdness)
echo 24. developer mode (dev combos & hidden codes)
echo 25. restore defaults / cleanup (safe)
echo --------------------------------------------------------------
set /p choice=choose wisely: 

if "%choice%"=="1" goto clean_temp
if "%choice%"=="2" goto check_internet
if "%choice%"=="3" goto random_fact
if "%choice%"=="4" goto insult
if "%choice%"=="5" goto fake_error
if "%choice%"=="6" goto shutdown_pc
if "%choice%"=="7" goto joke
if "%choice%"=="8" goto play_sound
if "%choice%"=="9" goto embarrassing_speech
if "%choice%"=="10" goto rename_files
if "%choice%"=="11" goto eat_memory
if "%choice%"=="12" goto exit_script
if "%choice%"=="13" goto others_menu
if "%choice%"=="14" goto utilities_menu
if "%choice%"=="15" goto network_menu
if "%choice%"=="16" goto system_tweaks
if "%choice%"=="17" goto prank_mode
if "%choice%"=="18" goto media_menu
if "%choice%"=="19" goto easter_eggs
if "%choice%"=="20" goto diagnostics
if "%choice%"=="21" goto quick_scripts
if "%choice%"=="22" goto mini_games
if "%choice%"=="23" goto forbidden_zone
if "%choice%"=="24" goto dev_mode
if "%choice%"=="25" goto restore_defaults
if "%choice%"=="1039" goto secret_menu
goto menu

:: ---------------------------
:: others menu (expanded)
:: ---------------------------
:others_menu
cls
echo others dimension - expanded
echo -------------------------------------------------
echo 1. random number generator
echo 2. system info
echo 3. typing effect simulator
echo 4. open cmd in infinite loop (smart-safe version)
echo 5. play with colors
echo 6. random yes/no generator
echo 7. self destruct (totally fake)
echo 8. mini quiz
echo 9. sound beep symphony
echo 10. tiny stopwatch
echo 11. quick notepad memo
echo 12. back to main menu
echo 99. forbidden zone shortcut
echo -------------------------------------------------
set /p other_choice=choose your chaos: 

if "%other_choice%"=="1" goto random_number
if "%other_choice%"=="2" goto sys_info
if "%other_choice%"=="3" goto typing_effect
if "%other_choice%"=="4" goto loop_cmd
if "%other_choice%"=="5" goto color_play
if "%other_choice%"=="6" goto yesno
if "%other_choice%"=="7" goto fake_self_destruct
if "%other_choice%"=="8" goto mini_quiz
if "%other_choice%"=="9" goto beep_symphony
if "%other_choice%"=="10" goto tiny_stopwatch
if "%other_choice%"=="11" start notepad & goto others_menu
if "%other_choice%"=="12" goto menu
if "%other_choice%"=="99" goto forbidden_zone
goto others_menu

:random_number
cls
set /a num=%random%
echo your random number is: %num%
timeout /t 3 >nul
goto others_menu

:sys_info
cls
echo gathering system info...
systeminfo | findstr /B /C:"OS" /C:"System Type" /C:"Total Physical Memory"
echo.
wmic cpu get name,NumberOfCores,MaxClockSpeed 2>nul
timeout /t 5 >nul
goto others_menu

:typing_effect
cls
setlocal enabledelayedexpansion
set "text=you've entered the matrix... follow the white rabbit..."
echo.
for /l %%i in (0,1,49) do (
    set "char=!text:~%%i,1!"
    <nul set /p =!char!
    ping -n 1 localhost >nul
)
echo.
endlocal
timeout /t 2 >nul
goto others_menu

:loop_cmd
cls
rem smarter loop_cmd: spawn up to 30 child cmd windows titled chaos_child_##,
rem monitor child count, if >=30 then close only child windows and keep main alive
setlocal enabledelayedexpansion
echo spawning up to 30 child cmd windows...
set /a opened=0
:loop_cmd_spawn
set /a opened+=1
start "chaos_child_!opened!" cmd /c "title chaos_child_!opened! & echo chaos child !opened! running & timeout /t 9999 >nul"
if !opened! lss 30 goto loop_cmd_spawn

rem now monitor child count (by title matching) and if >=30, close them smartly
echo spawned 30 children. monitoring...
timeout /t 2 >nul

:loop_cmd_monitor
rem count child windows by searching tasklist verbose for title "chaos_child"
for /f "tokens=*" %%A in ('tasklist /v ^| findstr /i "chaos_child_" ^| find /c /v ""') do set childcount=%%A
if "%childcount%"=="" set childcount=0
echo current child cmd count: %childcount%
if %childcount% GEQ 30 (
    echo limit reached, closing child cmd windows now...
    rem parse PIDs and kill each child window (but not the main window)
    for /f "tokens=2,* delims= " %%P in ('tasklist /v ^| findstr /i "chaos_child_"') do (
        rem %%P should be pid column; ensure it's numeric
        taskkill /pid %%P /f >nul 2>&1
    )
    rem after killing children, print friendly message in main
    cls
    echo you thought i was going to crash your pc? nah im friendly dw.
    timeout /t 3 >nul
    endlocal
    goto others_menu
) else (
    rem if children are less than 30, offer to spawn more or return
    echo children are under limit.
    echo 1. spawn 5 more
    echo 2. return to others menu
    set /p lc=pick: 
    if "%lc%"=="1" (
        setlocal enabledelayedexpansion
        set /a spawn=0
        :spawn_loop
        set /a opened+=1
        set /a spawn+=1
        start "chaos_child_!opened!" cmd /c "title chaos_child_!opened! & echo chaos child !opened! running & timeout /t 9999 >nul"
        if !spawn! lss 5 goto spawn_loop
        endlocal
        goto loop_cmd_monitor
    )
    goto others_menu
)
goto others_menu

:color_play
cls
echo time to mess with your screen colors!
for %%a in (0 1 2 3 4 5 6 7 8 9 a b c d e f) do (
    color %%a
    timeout /t 1 >nul
)
color 0a
echo trippy huh?
timeout /t 3 >nul
goto others_menu

:yesno
cls
set /a answer=%random% %%2
if %answer%==0 (
    echo yes
) else (
    echo no
)
timeout /t 2 >nul
goto others_menu

:fake_self_destruct
cls
echo WARNING: self destruction initiated.
timeout /t 1 >nul
echo deleting files...
timeout /t 1 >nul
echo wiping drives...
timeout /t 1 >nul
echo boom! ...nah jk, ur pc's fine.
timeout /t 3 >nul
goto others_menu

:mini_quiz
cls
echo quick quiz: how many bits are in a byte?
set /p answer=
if "%answer%"=="8" (
    echo correct! you’re a genius!
) else (
    echo bruh it’s 8. even my toaster knew that.
)
timeout /t 3 >nul
goto others_menu

:beep_symphony
cls
echo beep symphony (press ctrl+c to stop)
for /l %%i in (1000,200,5000) do (
    rem windows beep - may not work on all systems
    powershell -c "[console]::beep(%%i,120)" >nul 2>&1
    timeout /t 0.2 >nul
)
goto others_menu

:tiny_stopwatch
cls
echo tiny stopwatch. press enter to start, enter to stop.
pause >nul
set start=%time%
echo started at %start%
pause >nul
set stop=%time%
echo stopped at %stop%
timeout /t 3 >nul
goto others_menu

:: ---------------------------
:: utilities menu (real-ish tools)
:: ---------------------------
:utilities_menu
cls
echo utilities - small useful tools
echo -------------------------------------------------
echo 1. disk usage summary (drive)
echo 2. list installed programs (basic)
echo 3. show ip config
echo 4. open task manager
echo 5. calculator
echo 6. notepad
echo 7. return to main menu
echo -------------------------------------------------
set /p util_choice=choose: 

if "%util_choice%"=="1" goto disk_usage
if "%util_choice%"=="2" goto list_programs
if "%util_choice%"=="3" goto ipconfig_show
if "%util_choice%"=="4" start taskmgr & goto utilities_menu
if "%util_choice%"=="5" start calc & goto utilities_menu
if "%util_choice%"=="6" start notepad & goto utilities_menu
if "%util_choice%"=="7" goto menu
goto utilities_menu

:disk_usage
cls
echo disk usage summary:
wmic logicaldisk get name,filesystem,size,freespace 2>nul
timeout /t 5 >nul
goto utilities_menu

:list_programs
cls
echo installed programs (may not show everything):
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /v DisplayName 2>nul | findstr /i "displayname"
timeout /t 5 >nul
goto utilities_menu

:ipconfig_show
cls
echo ip configuration:
ipconfig /all
timeout /t 6 >nul
goto utilities_menu

:: ---------------------------
:: network menu
:: ---------------------------
:network_menu
cls
echo network toys
echo -------------------------------------------------
echo 1. ping google
echo 2. traceroute to google
echo 3. open network connections
echo 4. random port scan (local quick)
echo 5. back
set /p net_choice=pick: 

if "%net_choice%"=="1" ping google.com -n 4 & goto network_menu
if "%net_choice%"=="2" tracert google.com & goto network_menu
if "%net_choice%"=="3" start ncpa.cpl & goto network_menu
if "%net_choice%"=="4" goto quick_port_scan
if "%net_choice%"=="5" goto menu
goto network_menu

:quick_port_scan
cls
echo quick local port scan (scans ports 20-1024 on target)
set /p target=enter target ip or hostname (eg 127.0.0.1): 
echo scanning %target% (this is a very tiny naive scan)...
for /l %%p in (20,1,1024) do (
    (echo >nul 2>&1) | telnet %target% %%p 2>nul
    if not errorlevel 1 echo port %%p open
)
echo done (telnet method; requires telnet client)
timeout /t 4 >nul
goto network_menu

:: ---------------------------
:: system tweaks
:: ---------------------------
:system_tweaks
cls
echo system tweaks (safe-ish)
echo -------------------------------------------------
echo 1. toggle aero (if supported)
echo 2. show running services (basic)
echo 3. show startup programs (basic)
echo 4. change title of main window (prank)
echo 5. return
set /p tweak=pick:

if "%tweak%"=="1" goto toggle_aero
if "%tweak%"=="2" tasklist | more & goto system_tweaks
if "%tweak%"=="3" reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /s & goto system_tweaks
if "%tweak%"=="4" set /p newtitle=enter new title: & title %newtitle% & goto system_tweaks
if "%tweak%"=="5" goto menu
goto system_tweaks

:toggle_aero
cls
echo toggling aero (may not apply to modern windows)
powershell -c "Get-Service -Name Themes | Stop-Service -Force; Start-Sleep -Seconds 1; Start-Service -Name Themes" >nul 2>&1
echo done
timeout /t 2 >nul
goto system_tweaks

:: ---------------------------
:: prank mode
:: ---------------------------
:prank_mode
cls
echo prank mode
echo -------------------------------------------------
echo 1. fake blue screen (visual only)
echo 2. invert screen colors (simulation)
echo 3. random popup spam (not admin)
echo 4. fake windows update (loop)
echo 5. return
set /p prank=pick:

if "%prank%"=="1" goto fake_bsood
if "%prank%"=="2" goto invert_screen
if "%prank%"=="3" goto popup_spam
if "%prank%"=="4" goto fake_update
if "%prank%"=="5" goto menu
goto prank_mode

:fake_bsood
cls
color 17
mode con: cols=80 lines=25
echo a problem has been detected and windows has been shut down to prevent damage.
echo.
echo stop code: 0xDEADC0DE
timeout /t 5 >nul
color 0a
mode con: cols=80 lines=25
goto prank_mode

:invert_screen
cls
echo simulating invert screen (press any key to stop)
powershell -c "$s=[system.windows.forms.screen]::primarybounds; Add-Type -AssemblyName System.Windows.Forms; $f=New-Object System.Windows.Forms.Form; $f.WindowState='Maximized'; $f.BackColor='Black'; $f.ForeColor='White'; $f.TopMost=$true; $f.ShowDialog();" >nul 2>&1
goto prank_mode

:popup_spam
cls
echo popup spam (5 popups)
for /l %%i in (1,1,5) do (
    powershell -c "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('this is popup %%i','popup prank')" >nul 2>&1
    timeout /t 1 >nul
)
goto prank_mode

:fake_update
cls
echo windows is updating... do not power off your computer.
for /l %%i in (1,1,10) do (
    cls
    echo updating: %%i0%%
    timeout /t 1 >nul
)
echo update failed... try again later.
timeout /t 2 >nul
goto prank_mode

:: ---------------------------
:: media & sounds
:: ---------------------------
:media_menu
cls
echo media and sounds
echo -------------------------------------------------
echo 1. play beep tune (powershell)
echo 2. open media player
echo 3. text-to-speech (uses powershell)
echo 4. back
set /p media=pick:

if "%media%"=="1" goto beep_symphony
if "%media%"=="2" start wmplayer & goto media_menu
if "%media%"=="3" goto tts
if "%media%"=="4" goto menu
goto media_menu

:tts
cls
set /p tts_text=enter text to speak: 
powershell -c "Add-Type –AssemblyName System.speech; $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.Speak('%tts_text%')" >nul 2>&1
goto media_menu

:: ---------------------------
:: easter eggs
:: ---------------------------
:easter_eggs
cls
echo easter eggs & secrets
echo -------------------------------------------------
echo 1. the answer to everything (42)
echo 2. hidden quote
echo 3. random ascii
echo 4. secret handshake (ascii)
echo 5. back
set /p egg=pick:

if "%egg%"=="1" echo 42 >nul & echo 42 is the answer. & timeout /t 2 >nul & goto easter_eggs
if "%egg%"=="2" echo "stay weird." & timeout /t 2 >nul & goto easter_eggs
if "%egg%"=="3" goto ascii_art_big
if "%egg%"=="4" echo ( •_•) ( •_•)>⌐■-■ (⌐■_■) & timeout /t 3 >nul & goto easter_eggs
if "%egg%"=="5" goto menu
goto easter_eggs

:ascii_art_big
cls
echo big ascii incoming...
echo       /\_/\
echo      ( o.o )
echo       > ^ <
timeout /t 3 >nul
goto easter_eggs

:: ---------------------------
:: diagnostics & logs
:: ---------------------------
:diagnostics
cls
echo diagnostics & logs
echo -------------------------------------------------
echo 1. quick event viewer (opens)
echo 2. disk check (read-only summary)
echo 3. memory summary
echo 4. back
set /p diag=pick:

if "%diag%"=="1" start eventvwr & goto diagnostics
if "%diag%"=="2" chkdsk c: /scan 2>nul & goto diagnostics
if "%diag%"=="3" systeminfo | findstr /i "physical memory" & goto diagnostics
if "%diag%"=="4" goto menu
goto diagnostics

:: ---------------------------
:: quick scripts
:: ---------------------------
:quick_scripts
cls
echo quick useful scripts
echo -------------------------------------------------
echo 1. clear dns cache
echo 2. flush clipboard
echo 3. quick file search (by name)
echo 4. back
set /p qs=pick:

if "%qs%"=="1" ipconfig /flushdns & echo done & timeout /t 2 >nul & goto quick_scripts
if "%qs%"=="2" echo off | clip & echo clipboard cleared & timeout /t 2 >nul & goto quick_scripts
if "%qs%"=="3" set /p fname=enter filename to search (eg readme.txt): & dir /s /b %cd%\%fname% 2>nul & timeout /t 3 >nul & goto quick_scripts
if "%qs%"=="4" goto menu
goto quick_scripts

:: ---------------------------
:: mini-games
:: ---------------------------
:mini_games
cls
echo mini-games
echo -------------------------------------------------
echo 1. guess the number
echo 2. rock paper scissors
echo 3. snake (very tiny)
echo 4. back
set /p mg=pick:

if "%mg%"=="1" goto guess_number
if "%mg%"=="2" goto rps
if "%mg%"=="3" goto tiny_snake
if "%mg%"=="4" goto menu
goto mini_games

:guess_number
cls
set /a secret=%random% %%100 +1
echo guess number between 1 and 100
:gnloop
set /p g=your guess:
if "%g%"=="" goto gnloop
if %g%==%secret% (echo correct! & timeout /t 2 >nul & goto mini_games)
if %g% GTR %secret% (echo too high & goto gnloop)
if %g% LSS %secret% (echo too low & goto gnloop)
goto mini_games

:rps
cls
echo rock paper scissors - type rock, paper or scissors
set /p you=you:
set /a comp=%random% %%3
if %comp%==0 set compans=rock
if %comp%==1 set compans=paper
if %comp%==2 set compans=scissors
echo cpu chose %compans%
if "%you%"=="%compans%" echo tie & timeout /t 2 >nul & goto mini_games
if "%you%"=="rock" if "%compans%"=="scissors" (echo you win & timeout /t 2 >nul & goto mini_games)
if "%you%"=="paper" if "%compans%"=="rock" (echo you win & timeout /t 2 >nul & goto mini_games)
if "%you%"=="scissors" if "%compans%"=="paper" (echo you win & timeout /t 2 >nul & goto mini_games)
echo you lose
timeout /t 2 >nul
goto mini_games

:tiny_snake
cls
echo tiny snake (very basic). press any key to return.
echo use your imagination.
pause >nul
goto mini_games

:: ---------------------------
:: forbidden zone (expanded)
:: ---------------------------
:forbidden_zone
cls
echo welcome to the forbidden zone... you asked for deep weirdness
echo -------------------------------------------------
echo 1. fake hack simulation (advanced)
echo 2. ascii art madness (bigger)
echo 3. create fake junk files
echo 4. launch mini ai convo (basic)
echo 5. matrix rain (safe)
echo 6. spawn annoying windows (small)
echo 7. back
echo -------------------------------------------------
set /p fzchoice=your forbidden action: 

if "%fzchoice%"=="1" goto fake_hack
if "%fzchoice%"=="2" goto ascii_art
if "%fzchoice%"=="3" goto fake_files
if "%fzchoice%"=="4" goto ai_convo
if "%fzchoice%"=="5" goto matrix_rain
if "%fzchoice%"=="6" goto spawn_annoying_windows
if "%fzchoice%"=="7" goto menu
goto forbidden_zone

:fake_hack
cls
echo initializing hack.exe (very convincingly)...
for /l %%a in (1,1,15) do (
    set /a bytes=%random% * %%a
    echo [%%a/15] scanning system... %bytes% bytes processed
    timeout /t 1 >nul
)
echo dictionary attack... login: root
timeout /t 1 >nul
echo access granted... (all fake)
timeout /t 2 >nul
goto forbidden_zone

:ascii_art
cls
echo generating cursed ascii...
echo          .-=========-.
echo          \'-=======-'/ 
echo          _|   .=.   |_
echo         ((|  ((1))  |))
echo          \|   /|\   |/
echo           \__ '`' __/
echo             _`) (`_
echo           _/_______\_
timeout /t 3 >nul
goto forbidden_zone

:fake_files
cls
echo creating fake files in %temp% ...
for /l %%a in (1,1,30) do (
    echo random junk %%a > "%temp%\useless_%%a.txt"
)
echo 30 useless files created. congrats.
timeout /t 3 >nul
goto forbidden_zone

:ai_convo
cls
echo ai: hello human. why did you come here?
set /p user=you: 
if "%user%"=="" set user=curious human
echo ai: interesting. you said "%user%". tell me a secret:
set /p secret=you: 
echo ai: wow. keep that between us and this batch file.
timeout /t 2 >nul
goto forbidden_zone

:matrix_rain
cls
color 0a
echo welcome to the matrix. press ctrl+c to escape.
:matrixloop
set /a r=%random% %%100000
echo %r%%r%%r%%r%%r%
goto matrixloop

:spawn_annoying_windows
cls
echo spawning some tiny messageboxes (5)...
for /l %%i in (1,1,5) do (
    powershell -c "[System.Windows.Forms.MessageBox]::Show('u got pranked','annoying')" >nul 2>&1
    timeout /t 1 >nul
)
goto forbidden_zone

:: ---------------------------
:: developer mode
:: ---------------------------
:dev_mode
cls
echo developer mode - hidden combos
echo -------------------------------------------------
echo enter secret codes or commands:
echo type "devmode" for a small dev menu
echo type "combo42" for a surprise
echo type "back" to return
set /p devcmd=enter command:

if /i "%devcmd%"=="devmode" goto dev_menu
if /i "%devcmd%"=="combo42" goto combo42
if /i "%devcmd%"=="back" goto menu
goto dev_mode

:dev_menu
cls
echo dev menu:
echo 1. show environment variables
echo 2. open powershell
echo 3. toggle verbose logging (stores a temp flag)
echo 4. back
set /p d=pick:
if "%d%"=="1" set > "%temp%\env_dump.txt" & notepad "%temp%\env_dump.txt" & goto dev_menu
if "%d%"=="2" start powershell & goto dev_menu
if "%d%"=="3" if exist "%temp%\ub_verbose.flag" (del "%temp%\ub_verbose.flag" & echo verbose off) else (echo on>"%temp%\ub_verbose.flag" & echo verbose on) & timeout /t 1 >nul & goto dev_menu
if "%d%"=="4" goto dev_mode
goto dev_menu

:combo42
cls
echo 42... initiating pleasant surprise.
echo loading...
timeout /t 2 >nul
echo surprise: you are awesome.
timeout /t 3 >nul
goto dev_mode

:: ---------------------------
:: restore defaults / cleanup
:: ---------------------------
:restore_defaults
cls
echo cleaning up temp junk we created...
if exist "%temp%\useless_1.txt" del "%temp%\useless_*.txt" >nul 2>&1
if exist "%temp%\env_dump.txt" del "%temp%\env_dump.txt" >nul 2>&1
if exist "%temp%\ub_verbose.flag" del "%temp%\ub_verbose.flag" >nul 2>&1
echo cleanup done.
timeout /t 2 >nul
goto menu

:: ---------------------------
:: secret menu (kept original from your earlier versions)
:: ---------------------------
:secret_menu
cls
echo you found the secret menu! congrats, you're now part of the elite.
echo -------------------------------------------------
echo 1. launch calculator (because math is fun, right?)
echo 2. open notepad (write your deepest secrets)
echo 3. flip a coin (heads or tails, choose wisely)
echo 4. enable caps lock (because shouting is fun)
echo 5. infinite loop of pain (or just an endless menu)
echo -------------------------------------------------
set /p secret_choice=choose a secret action: 

if "%secret_choice%"=="1" start calc
if "%secret_choice%"=="2" start notepad
if "%secret_choice%"=="3" goto flip_coin
if "%secret_choice%"=="4" goto caps_lock
if "%secret_choice%"=="5" goto infinite_loop
goto secret_menu

:flip_coin
cls
echo flipping a coin...
timeout /t 2 >nul
set /a result=%random% %%2
if %result%==0 (
    echo Heads!
) else (
    echo Tails!
)
timeout /t 3 >nul
goto secret_menu

:caps_lock
cls
echo enabling caps lock... or just telling you to do it manually.
echo (there's no real way to toggle it via batch, but imagine it's on.)
timeout /t 3 >nul
goto secret_menu

:infinite_loop
cls
echo welcome to the infinite loop... have fun escaping.
timeout /t 3 >nul
goto infinite_loop

:clean_temp
cls
echo deleting temp files... it might break your pc, but who knows?
del /s /q %temp%\*.* >nul 2>&1
echo temp files deleted (or not, seriously, i'm not sure)
timeout /t 3 >nul
goto menu

:check_internet
cls
echo checking internet connection... (please don't be in 1995)
ping google.com -n 2 >nul
if %errorlevel%==0 (
    echo internet is working, congrats, you are not living in the stone age
) else (
    echo no internet detected, go touch some grass, seriously
)
timeout /t 4 >nul
goto menu

:random_fact
cls
echo random fact: did you know that pressing the power button turns off your pc? shocking, right?
timeout /t 4 >nul
goto menu

:insult
cls
echo error: user detected with iq levels lower than 2
echo please upgrade brain firmware and try again
timeout /t 4 >nul
goto menu

:fake_error
cls
echo generating critical system failure... oh no, your pc is exploding!
timeout /t 4 >nul
echo just kidding, calm down, its all good
timeout /t 4 >nul
goto menu

:shutdown_pc
cls
echo this will actually shut down your pc, not a joke. proceed with caution.
echo warning: shutting down your pc... are you sure about this?
set /p confirm_shutdown=are you absolutely sure? (y/n): 
if /i "%confirm_shutdown%"=="y" (
    echo shutting down your pc... hope you saved your work.
    shutdown /s /f /t 5
) else (
    echo phew, close call. you're safe... for now
)
timeout /t 4 >nul
goto menu

:joke
cls
echo joke time! why did the computer go to therapy? 
echo because it had too many problems. hahahahahaha :)
timeout /t 4 >nul
goto menu

:play_sound
cls
echo playing the most epic sound ever... prepare your ears.
echo (actually, just pretend you hear it, okay?)
timeout /t 4 >nul
goto menu

:embarrassing_speech
cls
echo speaking embarrassing truth: "i've been stuck in this batch file all day, pls help"
echo just kidding, it’s actually a lot of fun
timeout /t 4 >nul
goto menu

:rename_files
cls
echo randomly renaming your files... dont worry, your computer will survive
ren "C:\Program Files" "Program Files (do not touch)"
ren "C:\Windows" "Windows (please dont break)"
echo your files have been renamed. or i hope access is denied, its a mystery.
timeout /t 4 >nul
goto menu

:eat_memory
cls
echo attempting to eat all your system memory... jk, don’t panic
echo (actually, your memory is safe. mostly.. "MOSTLY")
timeout /t 4 >nul
goto menu

:exit_script
cls
echo are you sure you want to leave this masterpiece? (y/n)
set /p exit_choice= 
if /i "%exit_choice%"=="y" exit
if /i "%exit_choice%"=="n" goto menu
goto exit_script
