; Vallion's Universal Anti-AFK
#Requires AutoHotKey v2.0
#SingleInstance Force

; If The Script Isn't Compiled
if A_LineFile = A_ScriptFullPath && !A_IsCompiled {
    Interface := Constructor()
    Interface.Show("w308 h123")
}

; Construtor
Constructor() {	
    ; Create The Interface
    Interface := Gui()

    ; Anti-AFK Section
    Interface.Add("GroupBox", "x8 y0 w136 h151", "Anti-AFK")
    AntiAfkEnable := Interface.Add("CheckBox", "x16 y18 w120 h23", "Enable")
	AntiAfkExit := Interface.Add("Hotkey", "x16 y88 w120 h21 +Disabled", "^!F1")
	Interface.Add("Text", "x16 y64 w120 h23 +0x200", "Exit Keybind")

	; Process Name Section
    Interface.Add("GroupBox", "x152 y0 w146 h77", "Process Name")
    ProcessNameText := Interface.Add("Edit", "x160 y24 w120 h21", "Roblox")
    Interface.Add("Text", "x160 y48 w120 h23 +0x200", "For advanced users.")

	; Credits Section
	Interface.SetFont("w600")
	Interface.Add("Text", "x152 y88 w53 h23 +0x200", "Made By:")
	Interface.SetFont("Norm")
	Interface.Add("Text", "x208 y88 w132 h23 +0x200", " VallionXD")

    ; On Event
    AntiAfkEnable.OnEvent("Click", ToggleAntiAfk)

    ; Interface Close Event & Interface Title
	Interface.OnEvent('Close', (*) => ExitApp())
	Interface.Title := "Vallion's Anti-AFK"
    
    ; Variable To Store If Anti-AFK Is Enabled
    IsEnabled := False

    ; Set A Timer To Press Space
    SetTimer(PressSpacebar, 1000)

    ; Function To Toggle Anti-AFK
    ToggleAntiAfk(*) {
        ; Toggle Anti-AFK based on checkbox state
        IsEnabled := AntiAfkEnable.Value
    }

    ; Funtion To Press Spacebar
    PressSpacebar() {
        ; Check If Anti-AFK Is Enabled
        if IsEnabled {
            ; Check If Roblox Is Active
            if WinActive(ProcessNameText.Value) {
                ; Random Delay 4-6 Seconds
                Delay := Random(4000, 6000)

                ; Wait The Delay
                Sleep(Delay)

                ; Hold Spacebar For A Half-Second
                Send("{Space down}")
                Sleep(500)
                Send("{Space up}")
            }
        }
    }
    
    ; Return The Interface
    return Interface
}

; Exit Event
^!F1:: {
    ; Exit App
    ExitApp()
} 