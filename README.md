# Grappler
Grappler is a library containing tools and helpers for creating Godot editor plugins. It allows structured access to certain editor controls to make extending them easier. You can use this for custom menus, tool buttons, and more.
![Grappler1](https://github.com/Zerbu/Grappler/blob/main/.screenshots/Grappler1.png)
![Grappler2](https://github.com/Zerbu/Grappler/blob/main/.screenshots/Grappler2.png)
# Features
* Named variables that allow structured access to Godot editor controls. Example: You can access the FileSystem "filters" textbox using `GrapplerFileSystem.split_filter_files_line_edit`
* Utility functions for common features in editor plugins. Example: `GrapplerWindows.open_simple_accept_dialog` opens a message box with an "OK" button.
* Custom versions of `EditorResourcePicker`, `EditorInspector` and `EditorScriptPicker` that can be added directly to a scene without having to create them through code.
Grappler currently has helpers for the main editor area, the Scene dock and the FileSystem dock. More may be added in the future.
# Warning
* It is recommended that Grappler be loaded before any plugin that alters the editor UI, as otherwise it could cause a conflict. The default directory is deliberately named with two underscores (__grappler) to force it to load first.
