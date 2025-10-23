#Requires AutoHotkey v2.0
#SingleInstance Force

^l::ToggleTheme() ; Ctrl + L toggles dark/light mode

ToggleTheme() {
    key := "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    val := RegRead(key, "AppsUseLightTheme", 1)
    newVal := !val

    RegWrite(newVal, "REG_DWORD", key, "AppsUseLightTheme")
    RegWrite(newVal, "REG_DWORD", key, "SystemUsesLightTheme")

    ; Notify Windows of theme change globally
    DllCall("SendMessageTimeout", "Ptr", 0xFFFF, "UInt", 0x1A, "Ptr", 0, "Ptr", StrPtr("ImmersiveColorSet"), "UInt", 2, "UInt", 500, "Ptr", 0)
}
