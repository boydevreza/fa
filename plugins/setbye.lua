local function run(msg, matches, callback, extra)

local data = load_data(_config.moderation.data)

local group_bye = data[tostring(msg.to.id)]['group_bye']
-------------------------- Data Will be save on Moderetion.json
    
if matches[1] == 'delbye' and not matches[2] and is_owner(msg) then 
    
   data[tostring(msg.to.id)]['group_bye'] = nil --delete bye
        save_data(_config.moderation.data, data)
        
        return '💫خداحافظی گروه حذف شد💫!'
end
if not is_owner(msg) then 
    return '💫تنها برای مالکان💫!'
end
--------------------Loading Group Rules
local rules = data[tostring(msg.to.id)]['rules']
    
if matches[1] == 'rules' and matches[2] and is_owner(msg) then
    if data[tostring(msg.to.id)]['rules'] == nil then --when no rules found....
        return ''
end
data[tostring(msg.to.id)]['group_tbye'] = matches[2]..'\n\n💫قوانین گروه💫 :\n'..rules
        save_data(_config.moderation.data, data)
        
        return '💫خداحافظی گروه ثبت شد💫 :\n'..matches[2]
end
if not is_owner(msg) then 
    return '💫تنها برای مالکان💫!'
end

if matches[1] and is_owner(msg) then
    
data[tostring(msg.to.id)]['group_bye'] = matches[1]
        save_data(_config.moderation.data, data)
        
        return '💫خداحافظی گروه ثبت شد💫 : \n'..matches[1]
end
if not is_owner(msg) then 
    return '💫تنها برای مالکان💫!'
end


    
end
return {
  patterns = {
  "^[!#/]setbye +(.*)$",
  "^[!#/](delbye)$",
    "^setbye +(.*)$",
  "^(delbye)$"
  },
  run = run
}