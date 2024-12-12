# please change 'hostname' to your hostname
deploy:
	nix build .#darwinConfigurations.LeoAdl-M3.system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#LeoAdl-M3
