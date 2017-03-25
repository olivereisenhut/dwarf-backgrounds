class UnsplashApi : GLib.Object {
    private const string UNSPLASH_BASE_URL = "https://source.unsplash.com"; 
    private int width;
    private int height;
    public UnsplashApi (int width, int height) {
        this.width = width;
        this.height = height;
    }
    ~ UnsplashApi() {}
    
    public GLib.File download_image_with_options (string method, string[] arguments) {
        return this.download_image(width, height, UnsplashApi.build_arguments (method, arguments));
    }

    private GLib.File download_image (int width, int height, string arguments) {
        var dimension_string = UnsplashApi.build_dimensions (width, height);
        var picture_url = UnsplashApi.build_url (dimension_string, arguments);
        return File.new_for_uri (picture_url);
    }

    private static string build_arguments (string method, string[] arguments) {
        if (arguments.length == 0) return method;
        var argument_string = "";
        foreach (var argument in arguments) {
            if (argument == arguments[0]) {
                argument_string += argument;
                continue;
            }
           argument_string += "/" + argument;
        }
        return @"$method/$argument_string";
    }

    private static string build_url (string dimensions, string arguments) {
        return @"$UNSPLASH_BASE_URL/$arguments/$dimensions";
    }

    private static string build_dimensions (int width, int height) {
        return @"$(width)x$(height)";
    }

}