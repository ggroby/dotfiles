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

# print_segment "update nvf"
# sudo nix flake update --flake ~/dotfiles/nvf/

print_segment "update flake"
sudo nix flake update --flake ~/dotfiles/flake/

print_segment "rebuilding system"
sudo nixos-rebuild switch --flake ~/dotfiles/flake/ 

mut output = $'($start_date - (date now))'
$output = ($output | str replace '-' '')
$output = $'finished in ($output)'

print ''
print_line '.' ($output | str length)
print $'(ansi green)($output)(ansi reset)'
