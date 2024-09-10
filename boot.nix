{ ... }:

{
  boot = {
    loader = {
    	systemd-boot.enable = true;
  	  efi.canTouchEfiVariables = true;
    };

    kernelParams = [
	    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

    supportedFilesystems = [ "ntfs" ];
  };

}
