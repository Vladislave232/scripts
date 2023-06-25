local inicfg = require 'inicfg'
local dlstatus = require('moonloader').download_status
local update_url = 'https://raw.githubusercontent.com/Vladislave232/scripts/main/updator.ini'
local update_path = getWorkingDirectory() .. '/EkbTool/updator.ini'
local script_url = 'https://raw.githubusercontent.com/Vladislave232/scripts/main/EkbTool.lua'
local script_path = getWorkingDirectory() .. '/EkbTool.lua'
local update_state = false
local obnova = inicfg.load({
    obnova = {
        vers = '',
        script_vers_text = '',
    }
}, "obnova.ini")

function main()
    while not isSampAvailable() do wait(100) end
    downloadUrlToFile(update_url, update_path, function(id, status)
        updateIni = inicfg.load(nil, update_path)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            if tonumber(updateIni.info.vers) > obnova.obnova.vers then
                sampAddChatMessage('{FF0000}[������� ��������: ����]{FF00FF} ���������� ����������! ��������: ' .. updateIni.info.vers_text, -1)
                update_state = true
            else
                return
            end
        end
    end)
    while true do
        wait(0)
        if update_state == true then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    update_state = false
                    sampAddChatMessage('{FF0000}[EkbTool] {00FFFF}����������! {00FF00}���������� -> /tool')
                end
            end)
        end
    end
end

function onSystemMessage(msg, type, script)
    if msg:find('EkbTool%.lua?:%d+:.+') and type == 3 then
        sampShowDialog(252,'���-�� ����� �� ���','{FFFFFF}��������� ����������������� ������ � ������� {00BFFF}EkbTool.luac{FFFFFF}.\n���� ������ ������ ����������� ��������� �������� ������� ���� � �� ��������� {00BFFF}vk.com/guninik{FFFFFF}\n\n'..msg,'�������',_,0)
    end
end