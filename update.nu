let start_date = date now

def print_line [delimeter, length] {
	mut line = "";
	for _ in 0..$length { 
		$line += $delimeter
	}
	print $line
}

def print_segment [message] {
	print ''
	print $'(ansi yellow)($message | str title-case)(ansi reset)'

	let length = ($message | str length) + 2
	print_line '.' $length

	print ''
}

print_segment "update nixvim"
sudo nix flake update --flake ~/dotfiles/nixvim/
git add .
git commit -m "updated nixvim flake."

print_segment "update flake"
sudo nix flake update --flake ~/dotfiles/flake/
git add .
git commit -m "updated system falke."

print_segment "rebuilding system"
sudo nixos-rebuild switch --flake ~/dotfiles/flake/ 
git add .
git commit -m "rebuild system."

mut output = $'($start_date - (date now))'
$output = ($output | str replace '-' '')
$output = $'finished in ($output)'

print ''
print_line '.' ($output | str length)
print $'(ansi green)($output)(ansi reset)'
