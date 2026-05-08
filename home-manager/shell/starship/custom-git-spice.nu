let current = gs ls --json
  | lines
  | each { from json }
  | where current? == true
  | get 0

let values = $current 
  | select change?.id? down?.needsRestack?
  | update 'down.needsRestack' {|row| if $row.'down.needsRestack' != null { 'needs restack' } else { null } }
  | values
  | compact

let strValue = $values | str join ' - '

if $strValue != '' {
  $strValue
} else {
  exit 1;
}
