local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '"'..#result..'"<i>✨ پيام هاي اخير سوپر گروه حذف شد!✨</i>', ok_cb, false)
  else
    send_msg(extra.chatid, '✨تعداد پيام مورد نظر شما پاک شد!✨', ok_cb, false)
  end
end
local function run(msg, matches)
  if matches[1] == 'پاک کردن' and is_owner(msg) then
    if msg.to.type == 'channel' then
      if tonumber(matches[2]) > 10000 or tonumber(matches[2]) < 1 then
        return "<i>✨عدد بايد بالاتر از 1باشد!✨</i>"
      end
      get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
    else
      return "✨مخصوص سوپر گروه است✨"
    end
  else
    return "<i>✨دسترسي نداريد!✨</i>"
  end
end

return {
    patterns = {
        '^(پاک کردن) (%d*)$'
    },
    run = run
}

