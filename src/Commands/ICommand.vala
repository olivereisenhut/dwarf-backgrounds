interface ICommand : Object {
    public abstract GLib.File? execute (string args);
    public abstract string argument { get; }
}