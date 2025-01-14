
using Gtk;
using Gst;

namespace Goldsearch {

    public class Window : Adw.Window {
        private Button b_1;
        private Button b_2;
        private Button b_3;
        private Button b_4;
        private Button b_5;
        private Button b_6;
        private Button b_7;
        private Button b_8;
        private Button b_9;
        private Image i_1;
		private Image i_2;
		private Image i_3;
		private Image i_4;
		private Image i_5;
		private Image i_6;
        private Image i_7;
		private Image i_8;
		private Image i_9;
        private Bus bus;
        private Element pipeline_bomb;
        private Element pipeline_coins;
        private int[] mas;
        Gst.Bus bomb_bus;
        Gst.Bus coins_bus;

        public Window (Adw.Application application) {
            set_application(application);
            try {
                pipeline_bomb = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/goldsearch/sounds/bomb.mp3");
                pipeline_coins = Gst.parse_launch("playbin uri=resource:/com/github/alexkdeveloper/goldsearch/sounds/coins.mp3");
              } catch (Error e) {
                 stderr.printf ("Error: %s\n", e.message);
              }
              bus = new Bus (pipeline_bomb, pipeline_coins);
              connect_signals ();
        }

      construct {
       set_title("Gold Search");
       i_1 = new Image ();
       i_1.set_size_request(120,120);
       i_2 = new Image ();
       i_2.set_size_request(120,120);
       i_3 = new Image ();
       i_3.set_size_request(120,120);
       i_4 = new Image ();
       i_4.set_size_request(120,120);
       i_5 = new Image ();
       i_5.set_size_request(120,120);
       i_6 = new Image ();
       i_6.set_size_request(120,120);
       i_7 = new Image ();
       i_7.set_size_request(120,120);
       i_8 = new Image ();
       i_8.set_size_request(120,120);
       i_9 = new Image ();
       i_9.set_size_request(120,120);
       b_1 = new Button();
       b_1.set_child(i_1);
       b_2 = new Button();
       b_2.set_child(i_2);
       b_3 = new Button();
       b_3.set_child(i_3);
       b_4 = new Button();
       b_4.set_child(i_4);
       b_5 = new Button();
       b_5.set_child(i_5);
       b_6 = new Button();
       b_6.set_child(i_6);
       b_7 = new Button();
       b_7.set_child(i_7);
       b_8 = new Button();
       b_8.set_child(i_8);
       b_9 = new Button();
       b_9.set_child(i_9);
       b_1.clicked.connect(() =>{
          show_image(i_1, 1);
       });
       b_2.clicked.connect(() =>{
          show_image(i_2, 2);
       });
       b_3.clicked.connect(() =>{
          show_image(i_3, 3);
       });
       b_4.clicked.connect(() =>{
          show_image(i_4, 4);
       });
       b_5.clicked.connect(() =>{
          show_image(i_5, 5);
       });
       b_6.clicked.connect(() =>{
          show_image(i_6, 6);
       });
       b_7.clicked.connect(() =>{
          show_image(i_7, 7);
       });
       b_8.clicked.connect(() =>{
          show_image(i_8, 8);
       });
       b_9.clicked.connect(() =>{
          show_image(i_9, 9);
       });
        var grid = new Grid();
        grid.vexpand = true;
        grid.halign = Align.CENTER;
        grid.valign = Align.CENTER;
        grid.margin_bottom = 20;
        grid.margin_top = 20;
        grid.margin_end = 20;
        grid.margin_start = 20;
        grid.row_spacing = 5;
        grid.column_spacing = 5;
        grid.attach(b_1,0,0,1,1);
        grid.attach(b_2,1,0,1,1);
        grid.attach(b_3,2,0,1,1);
        grid.attach(b_4,0,1,1,1);
        grid.attach(b_5,1,1,1,1);
        grid.attach(b_6,2,1,1,1);
        grid.attach(b_7,0,2,1,1);
        grid.attach(b_8,1,2,1,1);
        grid.attach(b_9,2,2,1,1);
        var new_game_button = new Gtk.Button ();
        new_game_button.set_icon_name("input-gaming-symbolic");
        new_game_button.vexpand = false;
        new_game_button.set_tooltip_text(_("New game"));
        new_game_button.clicked.connect(on_new_game_clicked);
        var headerbar = new Adw.HeaderBar();
        headerbar.pack_start(new_game_button);
        var box = new Box(Orientation.VERTICAL, 0);
        box.append(headerbar);
        box.append(grid);
        set_content(box);
        show_barrels();
        generate();
        }
        public void connect_signals(){
            bomb_bus = pipeline_bomb.get_bus ();
            bomb_bus.add_signal_watch ();
            bomb_bus.message.connect (bus.parse_message);
  
            coins_bus = pipeline_coins.get_bus ();
            coins_bus.add_signal_watch ();
            coins_bus.message.connect (bus.parse_message);
        }
        private void on_new_game_clicked(){
        var dialog = new Adw.MessageDialog(this, _("Start a new game?"), "");
            dialog.add_response("cancel", _("_Cancel"));
            dialog.add_response("ok", _("_OK"));
            dialog.set_default_response("ok");
            dialog.set_close_response("cancel");
            dialog.set_response_appearance("ok", SUGGESTED);
            dialog.show();
            dialog.response.connect((response) => {
                if (response == "ok") {
                    buttons_activated(true);
                    show_barrels();
                    generate();
                }
                dialog.close();
            });
        }
        private void generate(){
            mas=new int[9];
            for (int i=0;i<9;i++){
                mas[i]=0;
            }
            int n=Random.int_range(0, 9);
            mas[n]=1;
            int m=0;
            do{
                m=Random.int_range(0, 9);
            }while(m==n);
            mas[m]=2;
            int k=Random.int_range(0, 2);
            int l=0;
            if(k==1){
                do{
                    l=Random.int_range(0, 9);
                }while(l==n||l==m);
                mas[l]=2;
            }
             for(int i=0;i<9;i++){
                if(mas[i]==0){
                    mas[i]=Random.int_range(0, 3)+3;
                }
             }
        }
        private void show_image(Image image, int i){
            image.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[i-1].to_string()+".png");
            if(mas[i-1]==1){
               play_sound("bomb");
               string heading = _("You found the bomb.\nThe game is over!");
               string body = "";
        var dialog_alert = new Adw.MessageDialog(this, heading, body);
            if (body != "") {
                dialog_alert.set_body(body);
            }
            dialog_alert.add_response("ok", _("_OK"));
            dialog_alert.set_response_appearance("ok", SUGGESTED);
            dialog_alert.response.connect((_) => {
	         show_all();
             buttons_activated(false);
	         dialog_alert.close();
	     });
                dialog_alert.show();
                return;
            }
            if(mas[i-1]==2){
                play_sound("coins");
            }
        }
        private void show_barrels(){
            i_1.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_2.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_3.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_4.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_5.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_6.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_7.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_8.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
            i_9.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/barrel.png");
        }
        private void show_all(){
            i_1.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[0].to_string()+".png");
            i_2.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[1].to_string()+".png");
            i_3.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[2].to_string()+".png");
            i_4.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[3].to_string()+".png");
            i_5.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[4].to_string()+".png");
            i_6.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[5].to_string()+".png");
            i_7.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[6].to_string()+".png");
            i_8.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[7].to_string()+".png");
            i_9.set_from_resource("/com/github/alexkdeveloper/goldsearch/images/"+mas[8].to_string()+".png");
        }
    private void buttons_activated(bool b){
          b_1.sensitive = b;
          b_2.sensitive = b;
          b_3.sensitive = b;
          b_4.sensitive = b;
          b_5.sensitive = b;
          b_6.sensitive = b;
          b_7.sensitive = b;
          b_8.sensitive = b;
          b_9.sensitive = b;
      }
      private void play_sound(string str){
        if (str == "bomb"){
            pipeline_bomb.set_state(State.PLAYING);
        }else{
            pipeline_coins.set_state(State.PLAYING);
        }
      }
    }
}
