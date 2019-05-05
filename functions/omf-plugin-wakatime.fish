function _wt_current_directory
  if echo (pwd) | grep -qEi "^/Users/$USER/Dev/wf/dapi/"
      echo (pwd) | sed "s#^/Users/$USER/Dev/wf/dapi/\\([^/]*\\).*#\\1#"
  else
    echo (basename (git rev-parse --show-toplevel 2>/dev/null || echo "Terminal"))
  end
end


function _wt_last_command
    echo $history[1] | cut -d ' ' -f1
end

function wt_heartbeet --on-event fish_postexec
  wakatime --write --plugin "omf-wakatime/0.0.1" --entity-type app --project _wt_current_directory --entity _wt_last_command 2>&1 > /dev/null&
end
