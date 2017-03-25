class CommandParser : GLib.Object { 
    public const string[] VALID_COMMANDS = { "category", "user", "random"};
    public const string[] VALID_CATEGORIES = { "buildings", "food", "nature", "people", "technology", "objects"};


    public static bool is_valid_command (string command) {
        foreach (var valid_command in VALID_COMMANDS) {
            if (command == valid_command) return true;
        }
        return false;
    }

    public static bool is_valid_category (string category) {
        foreach (var valid_category in VALID_CATEGORIES) {
            if (valid_category == category) return true;
        }
        return false;
    }

    public static ICommand get_right_command (string command, string argument, UnsplashApi api) {
        switch (command) {
        case "category":
            if (!CommandParser.is_valid_category(argument))
                throw new BadArgumentError.BAD_ARGUMENT_VALUE("No valid category provided");
            return new CategoryCommand(argument, api);
        case "user":
            return new UserCommand(argument, api);
        case "random":
            return new RandomCommand(argument, api);
        default:
            throw new BadArgumentError.BAD_ARGUMENT("Unknown command");
        }
    }
}