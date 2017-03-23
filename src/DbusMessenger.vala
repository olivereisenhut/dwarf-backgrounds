[DBus (name = "org.freedesktop.Accounts.User")]
interface AccountsServiceUser : Object {
    public abstract void set_background_file (string filename) throws IOError;
}

class DbusMessenger : GLib.Object { 
    //Instance of the AccountsServices-Interface for this user
    private AccountsServiceUser accountsservice = null;

    public DbusMessenger() {
         try {
            string uid = "%d".printf ((int) Posix.getuid ());
            this.accountsservice = Bus.get_proxy_sync (BusType.SYSTEM,
                    "org.freedesktop.Accounts",
                    "/org/freedesktop/Accounts/User" + uid);
        } catch (Error e) {
            warning (e.message);
        }
    }

    ~DbusMessenger() {}

    public void set_lock_screen_background (string path) {
        try {
           this.accountsservice.set_background_file (path);
        } catch (Error e) {
            warning (e.message);
        }
    }
}