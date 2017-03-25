class CommandExecuter : GLib.Object { 

    public static Object? execute_command (ICommand command) {
       return command.execute (command.argument);
    }
}