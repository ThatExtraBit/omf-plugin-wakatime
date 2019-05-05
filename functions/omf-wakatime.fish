function wakatimeproj --on-event fish_postexec

#  CMD_DURATION
  if echo (pwd) | grep -qEi "^/Users/$USER/Dev/wf/dapi/"
      set  project (echo (pwd) | sed "s#^/Users/$USER/Dev/wf/dapi/\\([^/]*\\).*#\\1#")
  else if echo (pwd) | grep -qEi "^/Users/$USER/Dev/"
      set  project (echo (pwd) | sed "s#^/Users/$USER/Dev/\\([^/]*\\).*#\\1#")
  else
      set project "Terminal"
  end

  wakatime --write --plugin "omf-wakatime/0.0.1" --entity-type app --project "$project" --entity (echo $history[1] | cut -d ' ' -f1) 2>&1 > /dev/null&
end
