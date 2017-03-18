class UnsplashApi : GLib.Object {
    private const string UNSPLASH_BASE_URL = "https://source.unsplash.com"; 
    public UnsplashApi () {
        
    }
    public GLib.File download_random_image (int width = 1920, int height = 1080) {
       return this.download_image(width, height, "random");   
    }
    private GLib.File download_image (int width, int height, string method) {
        var dimension_string = this.build_dimensions (width, height);
        var picture_url = this.build_url (dimension_string, method);
        return File.new_for_uri (picture_url);
    }
    private string build_url (string dimensions, string method) {
        return @"$UNSPLASH_BASE_URL/$method/$dimensions";
    }
    private string build_dimensions (int width, int height) {
        return @"$(width)x$(height)";
    }

}