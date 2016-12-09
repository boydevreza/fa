local function run(msg, matches, callback, extra)

local data = load_data(_config.moderation.data)

local group_welcome = data[tostring(msg.to.id)]['group_welcome']
-------------------------- Data Will be save on Moderetion.json
    
if matches[1] == 'delwlc' and not matches[2] and is_owner(msg) then 
    
   data[tostring(msg.to.id)]['group_welcome'] = nil --delete welcome
        save_data(_config.moderation.data, data)
        
        return '💫خوش آمدگویی گروه حذف شد💫'
end
if not is_owner(msg) then 
    return '💫تنها برای مالکان گروه💫'
end
--------------------Loading Group Rules
local rules = data[tostring(msg.to.id)]['rules']
    
if matches[1] == 'rules' and matches[2] and is_owner(msg) then
    if data[tostring(msg.to.id)]['rules'] == nil then --when no rules found....
        return '💫هیچ قانونی یافت نشد!\n\nابتدا قوانین رابا /setrules [متن قوانین]\nیا \nبااستفاده از خوش آمدگویی پیشفرض  /setwlc [متن خوش آمدگویی] ثبت کنید💫'
end
data[tostring(msg.to.id)]['group_welcome'] = matches[2]..'\n\n💫قوانین گروه💫 :\n'..rules
        save_data(_config.moderation.data, data)
        
        return '💫خوش آمدگویی گروه ثبت شد💫 :\n'..matches[2]
end
if not is_owner(msg) then 
    return '💫تنها برای مالکان💫!'
end

if matches[1] and is_owner(msg) then
    
data[tostring(msg.to.id)]['group_welcome'] = matches[1]
        save_data(_config.moderation.data, data)
        
        return '💫خوش آمدگویی گروه ثبت شد💫 : \n'..matches[1]
end
if not is_owner(msg) then 
    return '💫تنها برای مالکان💫!'
end


    
end
return {
  patterns = {
  "^[!/]setwlc (rules) +(.*)$",
  "^[!/]setwlc +(.*)$",
  "^[!/](delwlc)$",
  "^setwlc (rules) +(.*)$",
  "^setwlc +(.*)$",
  "^(delwlc)$"
  },
  run = run
}