class GnomeUnsplashBackgrounds {
    private static bool version = false;
    private static int? desktop_width = null;
    private static int? desktop_height = null;

    private const GLib.OptionEntry[] options = {
		// --version
		{ "version", 'v', 0, OptionArg.NONE, ref version, "Display version number", null },

		// --width
		{ "width", 0, 0, OptionArg.INT, ref desktop_width, "Width of the image", "INT" },

		// --height
		{ "height", 0, 0, OptionArg.INT, ref desktop_height, "Height of the image", "INT" },

		// list terminator
		{ null }
    };

    public static int main (string[] args) {

        try {
            var opt_context = new OptionContext ("[COMMAND] [ARG...]");
            opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
            opt_context.set_summary("shit happens every day");
			opt_context.parse (ref args);
        } catch (GLib.OptionError e) {
            stdout.printf ("error: %s\n", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 0;
        }

        if (version) {
            stdout.printf("0.1 \n");
            return 0;
        }

        var gsettings_configurator = new GsettingConfigurator ();
        if (desktop_width == null || desktop_height == null) {
            desktop_width = 1920;
            desktop_height = 1080;
        }
        var api = new UnsplashApi (desktop_width, desktop_height);
        var dbusMessenger = new DbusMessenger ();
        GLib.File image;

        if (!CommandParser.is_valid_command (args[1])) {
            stdout.printf("No valid command provided");
            return 0;
        }
        
        if (args[1] != "random" && args[2] == null) {
            stdout.printf("No value provided");
            return 0;
        }

        try {
            var command = CommandParser.get_right_command (args[1], args[2] ?? "", api);
            image = CommandExecuter.execute_command (command);
            if (image == null) {
                return 0;
            }
        } catch (BadArgumentError e) {
            stdout.printf("%s", e.message);
            return 0;
        }

        if (image.query_file_type (0) == FileType.UNKNOWN) { 
            stdout.printf("Image couldn't be downloaded");
            return 1;
        }

        FilesystemController.move_image_to_pictures_directory (image);

        var local_unspalsh_image = FilesystemController.get_local_unsplash_image_path ();

        gsettings_configurator.wallpaper_uri = local_unspalsh_image.get_path ();
        dbusMessenger.set_lock_screen_background(local_unspalsh_image.get_path ());

        return 0;
    }
}