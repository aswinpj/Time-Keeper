function descriptor()
   return {
      title = "Time Keeper",
      version = "1.0",
      author = "Aswin P J",
      url = 'http://github.com/aswinpj',
      shortdesc =  "Time keeper",
      description = "Written as an answer to the Software recommendation stack exchange question http://softwarerecs.stackexchange.com/q/2602/23171",
      capabilities = {"menu", "input-listener", "meta-listener", "playing-listener"}
   }
end

function activate()
   -- this is where extension starts
   -- for example activation of extension opens custom dialog box:
   input=vlc.object.input()
   create_dialog()

end

function deactivate()
   -- what should be done on deactivation of extension
end

function close()
   -- function triggered on dialog box close event
   -- for example to deactivate extension on dialog box close:
   vlc.deactivate()
end

function input_changed()
   -- related to capabilities={"input-listener"} in descriptor()
   -- triggered by Start/Stop media input event
end

function playing_changed()
   -- related to capabilities={"playing-listener"} in descriptor()
   -- triggered by Pause/Play madia input event
end

function meta_changed()
   -- related to capabilities={"meta-listener"} in descriptor()
   -- triggered by available media input meta data?
end
function menu()
   -- related to capabilities={"menu"} in descriptor()
   -- menu occurs in VLC menu: View > Extension title > ...
   
end

function create_dialog()
   w = vlc.dialog("Time Keeper")
   w1 = w:add_text_input("", 1, 1, 3, 1)
   w2 = w:add_text_input("", 1, 2, 3, 1)
   w3 = w:add_button("Time Travel",click_Action, 1, 3, 1, 1)

end

function click_Action()

   duration  = vlc.input.item():duration()
   trackHour,trackMinutes,trackSeconds = durationCalculator(duration)
   startTime = w1:get_text()
   startTime = split(startTime,":")
   startHour,startMinute,startSeconds = startTime[1],startTime[2],startTime[3]
   endTime = w2:get_text()
   endTime = split(endTime,":")
   endHour,endMinute,endSecond = endTime[1],endTime[2],endTime[3]
   diffHour = endHour-startHour
   diffMinute = endMinute - startMinute
   --diffSeconds = endSeconds - startSeconds
   totalseekSeconds = diffMinute*60+diffHour*3600
   vlc.var.set(vlc.object.input(),"time",totalseekSeconds)

end



function durationCalculator(duration)
      -- Returns the result in hours minutes and seconds
      hours = math.floor(duration/3600)
      minutesResidue = duration - math.floor(duration/3600)*3600
      minutes = math.floor(minutesResidue/60)
      seconds = minutesResidue - math.floor(minutesResidue/60)*60
      return hours,minutes,seconds

end

function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end
