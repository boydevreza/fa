local function check_member_superrem2(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result) do
    local member_id = v.id
    if member_id ~= our_id then
	  -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
	  chat_del_user(get_receiver(msg), 'user#id'..234724442, ok_cb, false)
	  leave_channel(get_receiver(msg), ok_cb, false)
    end
  end
end

local function superrem2(msg)
	local data = load_data(_config.moderation.data)
    local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_superrem2,{receiver = receiver, data = data, msg = msg})
end

local function pre_process(msg)
	local timetoexpire = 'unknown'
	local expiretime = redis:hget ('expiretime', get_receiver(msg))
	local now = tonumber(os.time())
	if expiretime then    
		timetoexpire = math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
		if tonumber("0") > tonumber(timetoexpire) and not is_sudo(msg) then
		if msg.text:match('/') then
		rem_mutes(msg.to.id)
		superrem2(msg)
		return send_large_msg(get_receiver(msg), '<i>✨تاریخ اتقضای گروه به پایان رسید.✨</i>\nبرای تمدید از سایت http://Tarfand.pro یا ربات @NECCBOT اقدام کنید✨')
		else
			return
		end
	end
	if tonumber(timetoexpire) == 0 then
		if redis:hget('expires0',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '<i>✨0 روز تا پایان تاریخ انقضای گروه باقی مانده است✨\n✨نسبت به تمدید اقدام کنید✨\n✨ربات جهت تمدید: @NECCBOT✨\n✨سایت جهت تمدید: Tarfand.pro✨</i>')
		redis:hset('expires0',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 1 then
		if redis:hget('expires1',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '<i>✨1 روز تا پایان تاریخ انقضای گروه باقی مانده است✨\n✨نسبت به تمدید اقدام کنید✨\n✨ربات جهت تمدید: @NECCBOT✨\n✨سایت جهت تمدید: Tarfand.pro✨t</i>')
		redis:hset('expires1',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 2 then
		if redis:hget('expires2',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '<i>✨2 روز تا پایان تاریخ انقضای گروه باقی مانده است✨\n✨نسبت به تمدید اقدام کنید✨\n✨ربات جهت تمدید: @NECCBOT✨\n✨سایت جهت تمدید: Tarfand.pro✨</i>')
		redis:hset('expires2',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 3 then
		if redis:hget('expires3',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '<i>✨3 روز تا پایان تاریخ انقضای گروه باقی مانده است✨\n✨نسبت به تمدید اقدام کنید✨\n✨ربات جهت تمدید: @NECCBOT✨\n✨سایت جهت تمدید: Tarfand.pro✨</i>')
		redis:hset('expires3',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 4 then
		if redis:hget('expires4',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '<i>✨4 روز تا پایان تاریخ انقضای گروه باقی مانده است✨\n✨نسبت به تمدید اقدام کنید✨\n✨ربات جهت تمدید: @NECCBOT✨\n✨سایت جهت تمدید: Tarfand.pro✨</i>')
		redis:hset('expires4',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 5 then
		if redis:hget('expires5',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '<i>✨5 روز تا پایان تاریخ انقضای گروه باقی مانده است✨\n✨نسبت به تمدید اقدام کنید✨\n✨ربات جهت تمدید: @NECCBOT✨\n✨سایت جهت تمدید: Tarfand.pro✨</i>')
		redis:hset('expires5',msg.to.id,'5')
	end
end
return msg
end
function run(msg, matches)
	if matches[1]:lower() == 'setexpire' then
		if not is_sudo(msg) then return end
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[2]) * 86400)
		redis:hset('expiretime',get_receiver(msg),timeexpire)
		return "<i>✨تاریخ انقضای گروه✨:\n✨به "..matches[2].. " روز دیگر تنظیم شد.\nسایت رسمی:Tarfand.pro✨</i>"
	end
	if matches[1]:lower() == 'expire' then
		local expiretime = redis:hget ('expiretime', get_receiver(msg))
		if not expiretime then return 'تاریخ ست نشده است' else
			local now = tonumber(os.time())
			return (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1) .. " روز دیگر✨"
		end
	end

end
return {
  patterns = {
    "^([Ss]etexpire) (.*)$",
	"^([Ee]xpire)$",
		    "^[/!#]([Ss]etexpire) (.*)$",
	"^[/!#]([Ee]xpire)$",
  },
  run = run,
  pre_process = pre_process
}
