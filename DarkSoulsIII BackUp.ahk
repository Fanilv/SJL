
; ...或一次执行多条命令并获取其输出:
MsgBox % RunWaitMany("
(
;存档位置	
@set SOURCR_PATH=C:\Users\Tea\AppData\Roaming\DarkSoulsIII 

;------------------------
@set yy=%date:~0,4%  
@set mm=%date:~5,2%  
@set dd=%date:~8,2%  
@set hh=%time:~0,2%  
@set mi=%time:~3,2%  
@set ss=%time:~6,2%   
@set da=%date:~,10%   
@set ti=%time:~,8% 
@set fu=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%  
;备份存档位置 
@set TARGET_PATH=F:\Gamebackup\DarkSoulsIII\%fu%\DarkSoulsIII

@echo 存档时间 %da%---%ti% 
;------------------------
if exist %SOURCR_PATH% (echo 存档 %SOURCR_PATH% 存在) else (echo 存档 %SOURCR_PATH% 不存在)
;------------------------
@echo 备份存储目录 %TARGET_PATH%  

@echo -------------------
;左括号要贴着旁边的代码

if exist %TARGET_PATH%(   
rd /q /s  %TARGET_PATH%   
echo 排除重复文件夹，将其删除重新备份
echo)

if not exist %TARGET_PATH%(
mkdir %TARGET_PATH%   
echo %fu%存档点 创建成功
echo)
@echo -------------------
;复制存档到备份文件夹
@xcopy  %SOURCR_PATH% %TARGET_PATH% /s /e /i

@echo ------------------- 

IF ERRORLEVEL 1 (ECHO 存档备份失败) else (ECHO 存档备份成功)

)")

RunWaitMany(commands) {
    shell := ComObjCreate("WScript.Shell")
    ; 打开 cmd.exe 禁用命令显示
    exec := shell.Exec(ComSpec " /Q /K echo off")
    ; 发送并执行命令,使用新行分隔
    exec.StdIn.WriteLine(commands "`nexit")  ; 保证执行完毕后退出!
    ; 读取并返回所有命令的输出
    return exec.StdOut.ReadAll()
}