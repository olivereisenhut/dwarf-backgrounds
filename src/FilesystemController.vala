public class FilesystemController : GLib.Object { 

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
        return File.new_for_path (picture_directory.get_path () + "/unsplash.jpeg");
   }

   private static GLib.File get_picture_directory () {
       var home_dir = File.new_for_path (Environment.get_home_dir ());
       return home_dir.get_child("Pictures");
   }
}