#set output as UTF8 for text
$PSDefaultParameterValues['Out-File:Encoding']='UTF8'
#setup loop
$TimeStart = Get-Date
#runs the script for 10 mins then relaunches
$TimeEnd = $timeStart.addminutes(10)
cls
Do {
$TimeNow = Get-Date
if ($TimeNow -ge $TimeEnd) {
.\GetDeckInfo.ps1
} else {
Write-Host "Running Now Playing Scipt Until $TimeEnd"
}
#Collect infomation from Prime 4
[string[]]$arrayFromFile = .\stagelinq-discover.exe 
sleep -Milliseconds 500
cls

#check info has been read then convert it into readable / usable format
if ($arrayFromFile.count -gt 0){

$filt = $arrayFromFile -replace '[\W]', ''
$truetest = "true"
#faderstate
$fad1 =[long]$filt[5].Substring(34)
$fad2 =[long]$filt[11].Substring(34)
$fad3 =[long]$filt[17].Substring(34)
$fad4 =[long]$filt[23].Substring(34)

#bpm value
$bpm1 =$arrayFromFile[2].Substring(42) -replace ']',''
$bpm2 =$arrayFromFile[8].Substring(42) -replace ']',''
$bpm3 =$arrayFromFile[14].Substring(42) -replace ']',''
$bpm4 =$arrayFromFile[20].Substring(42) -replace ']',''

$bpmdisp1=[math]::Round($bpm1,2)
$bpmdisp2=[math]::Round($bpm2,2)
$bpmdisp3=[math]::Round($bpm3,2)
$bpmdisp4=[math]::Round($bpm4,2)
#artist
$art1 =$arrayFromFile[3].Substring(42) -replace 'type:8]',''
$art2 =$arrayFromFile[9].Substring(42) -replace 'type:8]',''
$art3 =$arrayFromFile[15].Substring(42) -replace 'type:8]',''
$art4 =$arrayFromFile[21].Substring(42) -replace 'type:8]',''
#song name
$title1 =$arrayFromFile[4].Substring(40) -replace 'type:8]',''
$title2 =$arrayFromFile[10].Substring(40) -replace 'type:8]',''
$title3 =$arrayFromFile[16].Substring(40) -replace 'type:8]',''
$title4 =$arrayFromFile[22].Substring(40) -replace 'type:8]',''
#check for if deck is in a play state
$var1 = $filt.Substring(23,4)
$var2 = $filt.Substring(28,4)
}
#Deck1 Playing Test
#check fader is above 50%
if ($fad1 -gt 5600000023841857)
{
#check if playing a song
if ($var1[0] -match $var2[1])
{
if ($var1[0] -ne $truetest)
{
#notplaying anything - blank out the value of deck1
$deck1 = ""
}
else
{
#read playing song into variables for writing to file
$arta = 'Artist: ' + $art1
$titlea = 'Title: ' + $title1
$bpma = 'BPM: ' + $bpmdisp1
#below can be uncommented if you want the text file to have each value on a new line - comment out line 75
#$deck1 = @('Deck - 1: Now Playing: ',$arta,$titlea,$bpma)
$deck1 = '    Now Playing: '+ $art1 +'- ' + $title1 + 'BPM: ' + $bpmdisp1
}
}
}
else
#fader not above level for "playing" - blank output of file
{
$deck1 = ""
}

#Deck2 Playing Test
#check fader is above 50%
if ($fad2 -gt 5600000023841857)
{
#check if playing a song
if ($var1[6] -match $var2[7])
{
if ($var1[6] -ne $truetest)
{
#notplaying anything - blank out the value of deck2
$deck2 = ""
}
else
{
#read playing song into variables for writing to file
$artb = 'Artist: ' + $art2
$titleb = 'Title: ' + $title2
$bpmb = 'BPM: ' + $bpmdisp2
#below can be uncommented if you want the text file to have each value on a new line - comment out line 105
#$deck2 = @('Deck - 2: Now Playing: ',$artb,$titleb,$bpmb)
$deck2 = '    Now Playing: '+ $art2 +'- ' + $title2 + 'BPM: ' + $bpmdisp2
}
}
}
else
#fader not above level for "playing" - blank output of file
{
$deck2 = ""
}
 

#Deck3 Playing Test
#check fader is above 50%
if ($fad3 -gt 5600000023841857)
{
#check if playing a song
if ($var1[12] -match $var2[13])
{
if ($var1[12] -ne $truetest)
{
#notplaying anything - blank out the value of deck3
$deck3 = ""
}
else
{
#read playing song into variables for writing to file
$artc = 'Artist: ' + $art3
$titlec = 'Title: ' + $title3
$bpmc = 'BPM: ' + $bpmdisp3 
#below can be uncommented if you want the text file to have each value on a new line - comment out line 136
#$deck3 = @('Deck - 3: Now Playing: ',$artc,$titlec,$bpmc)
$deck3 = '    Now Playing: '+ $art3 +'- ' + $title3 + 'BPM: ' + $bpmdisp3
}
}
}
else
#fader not above level for "playing" - blank output of file
{
$deck3 = ""
}

#Deck4 Playing Test
#check fader is above 50%
if ($fad4 -gt 5600000023841857)
{
#check if playing a song
if ($var1[18] -match $var2[19])
{
if ($var1[18] -ne $truetest)
{
#notplaying anything - blank out the value of deck4
$deck4 = ""
}
else
{
#read playing song into variables for writing to file
$artd = 'Artist: ' + $art4
$titled = 'Title: ' + $title4 
$bpmd = 'BPM: ' + $bpmdisp4 
#below can be uncommented if you want the text file to have each value on a new line - comment out line 166
#$deck4 = @('Deck - 4: Now Playing: ',$artd,$titled,$bpmd)
$deck4 = '    Now Playing: '+ $art4 +'- ' + $title4 + 'BPM: ' + $bpmdisp4
}
}
}
else
#fader not above level for "playing" - blank output of file
{
$deck4 = ""
}
#show output in script window
write-host "Deck1:" $deck1
write-host "Deck2:" $deck2
write-host "Deck3:" $deck3
write-host "Deck4:" $deck4
#write output to files - one for each deck
$deck1 | Out-File .\Deck1.txt
$deck2 | Out-File .\Deck2.txt
$deck3 | Out-File .\Deck3.txt
$deck4 | Out-File .\Deck4.txt
}
Until ($TimeNow -ge $TimeEnd)
