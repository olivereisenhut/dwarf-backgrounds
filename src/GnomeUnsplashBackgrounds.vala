class GnomeUnsplashBackgrounds {

    public static void main (string[] args) {
        var gsettings_configurator = new GsettingConfigurator ();
        var api = new UnsplashApi ();
        var random_image = api.download_random_image ();

        FilesystemController.move_image_to_pictures_directory (random_image);
        gsettings_configurator.wallpaper_uri = FilesystemController.get_local_unsplash_image_path ().get_uri();
        stdout.printf(gsettings_configurator.wallpaper_uri);
        FilesystemController.create_symlink_from_image_to_elementaryos_default ();
    }
}