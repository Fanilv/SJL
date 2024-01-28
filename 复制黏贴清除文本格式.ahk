;复制并清除格式ctrl+g
^g::
   ;复制选定文本到剪贴板
   Send, ^c
   ;清除剪贴板中的格式
   clipboard := clipboard
return

 ;清除格式并粘贴ctrl+shift+v
^+V::
   ;清除剪贴板中的格式
   clipboard := clipboard
   ;粘贴文本到目标应用
   SendInput, ^v
return