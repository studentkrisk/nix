{ pkgs, lib, config, ... }:
let
	cfg = config.ocf.stats;
in {
	options.ocf.stats = {
		enable = lib.mkEnableOption "OCF stats";
		password = lib.mkOption {
			type = lib.types.str;
			default = "tmp-key";
		};
	};

	systemd.timers."stats" = {
		wantedBy = [ "timers.target" ];
		timerConfig = {
			OnBootSec = "5m";
			OnUnitActiveSec = "5m";
			Unit = "stats.service";
		};
	};

	systemd.services."stats" = {
		script = ''
			${pkgs.coreutils}/bin/echo "test"
		'';
		servicesConfig = {
			Type = "oneshot";
		};
	};
};
