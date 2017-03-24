class UnsplashApi : GLib.Object {
    private const string UNSPLASH_BASE_URL = "https://source.unsplash.com"; 

    public UnsplashApi () {}
    ~ UnsplashApi() {}
    
    public GLib.File download_image_with_options (string[] options = {"random", null}, int width = 1920, int height = 1080) {
        return this.download_image(width, height, UnsplashApi.build_arguments (options));
    }

    private GLib.File download_image (int width, int height, string arguments) {
        var dimension_string = UnsplashApi.build_dimensions (width, height);
        var picture_url = UnsplashApi.build_url (dimension_string, arguments);
        return File.new_for_uri (picture_url);
    }

    private static string build_arguments (string[] category) {
        var argument = category[0];
        if (category[1] == null)
            return argument;
        var value = category[1];
        return @"$argument/$value";
    }

    private static string build_url (string dimensions, string arguments) {
        return @"$UNSPLASH_BASE_URL/$arguments/$dimensions";
    }

    private static string build_dimensions (int width, int height) {
        return @"$(width)x$(height)";
    }

}