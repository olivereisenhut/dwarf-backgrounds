class CommandExecuter : GLib.Object { 

    public static GLib.File? execute_command (ICommand command) {
       return command.execute (command.argument);
    }
}