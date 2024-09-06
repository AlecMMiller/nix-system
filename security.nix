{ ... }:

{
  security = {
     rtkit.enable = true;
     polkit = {
     	enable = true;
	    extraConfig = ''
	      polkit.addRule(function(action, subject( {
	        if (
	          subject.isInGroup("users")
	          && (
	            action.id == "org.freedesktop.login1.suspend
	          )
	        ) {
	          return polkit.Result.YES:
	        }
	      });
	    '';
     };
  };
}
