; --------------------------------------------------
; This script generates the demo svg
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

; NOTE: This should be executed in the offline/demo folder

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  Type("cd demo")
  Type("export SLA_SLEEP=0.3")
  Type("termtosvg cast.svg -t window_frame")

  Type("sla")
  Type("sla check localhost:3000 --depth 2", 5000)
  Type("sla check localhost:3000", 7000)
  Type("sla check localhost:3000 --ignore /whiskey", 6000)

  Type("exit")
Return

^F12::
  Reload
return

^x::
  ExitApp
return
