class GnomeUnsplashBackgrounds {

    public static void main (string[] args) {
        var gsettings_configurator = new GsettingConfigurator ();
        var api = new UnsplashApi ();
        var dbusMessenger = new DbusMessenger ();
        var random_image = api.download_random_image ();

        FilesystemController.move_image_to_pictures_directory (random_image);

        var local_unspalsh_image = FilesystemController.get_local_unsplash_image_path ();

        gsettings_configurator.wallpaper_uri = local_unspalsh_image.get_path ();
        dbusMessenger.set_lock_screen_background(local_unspalsh_image.get_path ());
    }
}