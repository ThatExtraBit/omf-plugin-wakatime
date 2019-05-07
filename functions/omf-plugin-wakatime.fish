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
#
function wt_heartbeet --on-event fish_postexec
  set --local current_dir (_wt_current_directory)
  set --local last_cmd (_wt_last_command)
  set --local fish_version (fish --version | cut -d ' ' -f3)
  wakatime --write --plugin "Fish/$fish_version Fish-omf-wakatime-plugin/1.0.1" --category "building" --language "shell" --entity-type "app" --project "$current_dir" --entity "$last_cmd" 2>&1 > /dev/null&
end
