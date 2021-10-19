[scripts]

#[mpv-gallery-view](https://github.com/occivink/mpv-gallery-view)


#[autosub](https://github.com/davidde/mpv-autosub)

alt+b to download english subtitle
alt+n to download secondary subtitle

auto = bool -- Automatically download subtitles if set to true
force = bool -- Force download; will override existing subtitle files

#[mpv-bookmarker](https://github.com/NurioHin/mpv-bookmarker)

When the Bookmarker menu is closed
B or whichever key you configured in input.conf: Pull up the Bookmarker menu
b or whichever key you configured in input.conf: Quickly add a new bookmark
ctrl+b or whichever key you configured in input.conf: Quickly load the latest bookmark
When the Bookmarker menu is open
B or whichever key you configured in input.conf: Close the Bookmarker menu
ESC: Close the Bookmarker menu
UP/DOWN: Navigate through the bookmarks on the current page (Hold to quickly scroll)
LEFT/RIGHT: Navigate through pages of bookmarks (Hold to quickly scroll)
ENTER: Load the currently selected bookmark
DELETE: Delete the currently selected bookmark
s: Save a bookmark of the current media file and position
shift+s: Save a bookmark of the current media file and position (shows a text input, allowing you to type)
p: Replace the currently selected bookmark with the current media file and position
r: Rename the currently selected bookmark (shows a text input, allowing you to type)
f: Change the filepath of the currently selected bookmark (shows a text input, allowing you to type)
m: Move the currently selected bookmark
Replacing a bookmark is intended for when you have a bookmark for your current progress in a TV series. When you've finished a new episode, you can select this bookmark and press p to instantly rewrite that bookmark with your current progress, leaving the name and its position in the list of bookmarks intact. Changing the filepath of a bookmark is intended to quickly change a bookmark in case you moved the media file to a different folder, or perhaps the drive letter of your external drive changed.

When allowing text input
The Typer (as I named it) allows you to type text for various ends, like renaming a bookmark or changing its filepath.

ESC: Cancel text input and return to the Bookmarker menu
ENTER: Confirm text input and save/rename the bookmark
LEFT/RIGHT: Move the cursor through the text, allowing you to input text in different places (Hold to quickly scroll)
BACKSPACE: Remove the character preceding the cursor (Hold to rapidly remove multiple)
DELETE: Remove the character after the cursor (Hold to rapidly remove multiple)
Any text character: Type for the text input. Allows special characters, spaces, numbers. Does not allow letters with accents (Hold to rapidly add characters)
During text input for a bookmark's name, you can write %t or %p to input a timestamp in the name. (Note: This does not work for a bookmark's filepath.)

%t is a timestamp in the format of hh:mm:ss.mmm
%p is a timestamp in the format of S.mmm
For example, Awesome moment @ %t will show up as Awesome moment @ 00:13:41.673 in the menu

When moving bookmarks
ESC: Cancel moving and return to the Bookmarker menu
ENTER: Confirm moving the bookmark
m: Confirm moving the bookmark
s: Save a bookmark of the current file and position
UP/DOWN: Navigate through the bookmarks on the current page (Hold to quickly scroll)
LEFT/RIGHT: Navigate through pages of bookmarks (Hold to quickly scroll)


