var main = {
  setupMainMenu: function(){
    	var myMenu = new SDMenu("my_menu");
        myMenu.init();
  }
};

 $(document).ready(function(){
                     main.setupMainMenu();
                  });