class GnomeUnsplashBackgrounds {
    private static bool version = false;
    private static string? category = null;
    private static int? desktop_width = null;
    private static int? desktop_height = null;

    private const GLib.OptionEntry[] options = {
		// --version
		{ "version", 'v', 0, OptionArg.NONE, ref version, "Display version number", null },

		// --category
		{ "category", 0, 0, OptionArg.STRING, ref category, "Choose category if empty random", "STRING" },

		// --width
		{ "width", 0, 0, OptionArg.INT, ref desktop_width, "Width of the image", "INT" },

		// --height
		{ "height", 0, 0, OptionArg.INT, ref desktop_height, "Height of the image", "INT" },

		// list terminator
		{ null }
    };

    public static int main (string[] args) {

        try {
            var opt_context = new OptionContext ("- change your background with an Unsplash image");
            opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
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
        var api = new UnsplashApi ();
        var dbusMessenger = new DbusMessenger ();
        GLib.File image;

        if (category != null && desktop_width != null && desktop_height != null) {
            image = api.download_image_with_options({"category", category}, desktop_width, desktop_height);
        } else if (category != null) {
            image = api.download_image_with_options({"category", category});
        } else {
            image = api.download_image_with_options ();
        }

        FilesystemController.move_image_to_pictures_directory (image);

        var local_unspalsh_image = FilesystemController.get_local_unsplash_image_path ();

        gsettings_configurator.wallpaper_uri = local_unspalsh_image.get_path ();
        dbusMessenger.set_lock_screen_background(local_unspalsh_image.get_path ());

        return 0;
    }
}