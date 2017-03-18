class FilesystemController : GLib.Object { 
    public FilesystemController() {

    }
    public static bool move_image_to_pictures_directory (GLib.File image) {
        var file_path = FilesystemController.get_local_unsplash_image_path ();
        try {
            image.copy(file_path, FileCopyFlags.OVERWRITE, null, null);
            return true;
        } catch(Error e) {
           return false;
        }
   }

   public static GLib.File get_local_unsplash_image_path () {
        var picture_directory = FilesystemController.get_picture_directory ();
        return File.new_for_path (picture_directory.get_path () + "/unsplash.jpg");
    }

    public static bool create_symlink_from_image_to_elementaryos_default () {
        var result = GLib.FileUtils.symlink ("/usr/share/backgrounds/elementaryos-default", FilesystemController.get_local_unsplash_image_path ().get_path ());
        return result != -1 ? true : false;
    }

    private static GLib.File get_picture_directory () {
        var home_dir = File.new_for_path (Environment.get_home_dir ());
        return home_dir.get_child("Pictures");
    }
}