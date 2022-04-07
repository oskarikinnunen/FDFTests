
tell application "Terminal"
   #set currentTab to do script ("cd FDF && gtimeout 100s ./FDF " & quoted form of (item 1 of argv) & " &")
   activate
   #set currentTab to do shell script "echo $!"
   #delay 4
   #set currentTab to do script("echo " & pid as text)
   #quit
end tell